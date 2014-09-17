From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 05/23] send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
Date: Wed, 17 Sep 2014 15:45:40 -0700
Message-ID: <1410993958-32394-6-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUNzQ-000236-9Q
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049AbaIQWqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59245 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757010AbaIQWqN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8791539DED;
	Wed, 17 Sep 2014 18:46:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=8Rfb
	r3VgEQGWQEWYzt3JmygYckQ=; b=N+ISOga8H1QSPbBL7iL2z8EGE1nt6h1KtRdW
	70GGS6t0kgr0sYSJYfICTqm11AjjqKCrdtJLREul9Laq9cHXkyXuAV0rtIvc7OuP
	3SgZAYR0Qe327UvTTRGlEoE+VE+WJW44+RLFOyWx65Hfkx/D+y6kVfFxcGoXMfMk
	md5G0TE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MA9abR
	Wdx1eDAHJXD97kdtJX9xzwMj759KUKMwqJ/fJZmi+SGm+eChyE/jW5Ak5EKkwRf1
	SDWEEBVioT2IzF5uimgmnMVABikzvUfJtTdf7ajSkAgsmz5ORzzcrd5lbYMBEhkL
	JsId0PoFdrytydxY0Qja3L4xPe9jKb0bxwpS8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7EB1339DEB;
	Wed, 17 Sep 2014 18:46:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0B82139DDA;
	Wed, 17 Sep 2014 18:46:10 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6BC131F2-3EBC-11E4-90F1-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257230>

20e8b465 (refactor ref status logic for pushing, 2010-01-08)
restructured the code to set status for each ref to be pushed, but
did not quite go far enough.  We inspect the status set earlier by
set_refs_status_for_push() and then perform yet another update to
the status of a ref with an otherwise OK status to be deleted to
mark it with REF_STATUS_REJECT_NODELETE when the protocol tells us
never to delete.

Split the latter into a separate loop that comes before we enter the
per-ref loop.  This way we would have one less condition to check in
the main loop.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Unchanged since v5.

 send-pack.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6129b0f..22a1709 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -231,6 +231,15 @@ int send_pack(struct send_pack_args *args,
 		return 0;
 	}
 
+	/*
+	 * NEEDSWORK: why does delete-refs have to be so specific to
+	 * send-pack machinery that set_ref_status_for_push() cannot
+	 * set this bit for us???
+	 */
+	for (ref = remote_refs; ref; ref = ref->next)
+		if (ref->deletion && !allow_deleting_refs)
+			ref->status = REF_STATUS_REJECT_NODELETE;
+
 	if (!args->dry_run)
 		advertise_shallow_grafts_buf(&req_buf);
 
@@ -249,17 +258,13 @@ int send_pack(struct send_pack_args *args,
 		case REF_STATUS_REJECT_FETCH_FIRST:
 		case REF_STATUS_REJECT_NEEDS_FORCE:
 		case REF_STATUS_REJECT_STALE:
+		case REF_STATUS_REJECT_NODELETE:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
 			; /* do nothing */
 		}
 
-		if (ref->deletion && !allow_deleting_refs) {
-			ref->status = REF_STATUS_REJECT_NODELETE;
-			continue;
-		}
-
 		if (!ref->deletion)
 			new_refs++;
 
-- 
2.1.0-403-g099cf47
