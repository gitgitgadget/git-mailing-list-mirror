From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/21] send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
Date: Thu,  4 Sep 2014 13:04:41 -0700
Message-ID: <1409861097-19151-6-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:05:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdHr-0000jh-RS
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbaIDUFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50989 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbaIDUFX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87DC63816D;
	Thu,  4 Sep 2014 16:05:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7la2
	TU64b4jMdz0/sFPMSSQ6cts=; b=AjZcRK2QVydzKU5clTT5RP2ChFpyIWe1kHzT
	QpyPZOYZvde74rHvo5DPr4vt7Jacl0ou/35vi+KLBUh1qEGbM85Av49lM4FGZBEz
	GqmeoFyGhOYJocLLXQ/EJpMGZ2GlEI1F4xSAP7N7sxc/HPS+kDfo5t0bqJj+UQfL
	Qa3szAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=RFcqJs
	yms8dcNgzeYqQpjLN4SHqVvMJ05XYkfcR4Rn5twXAHPv9Ufuyc256Q9Qab2XKogg
	3Tsh2aNTkxcqLakBmLalwkf+EGo5h1AKHW9KW9aDIzVG45BR97AS10KkCpJbU/yj
	lUr9POJWkJjEXrZZdxpbyJCkFlU354g6vlpLU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 457893816C;
	Thu,  4 Sep 2014 16:05:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 29AB538160;
	Thu,  4 Sep 2014 16:05:15 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C9A3361A-346E-11E4-86BA-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256463>

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
 send-pack.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6129b0f..7428ae6 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -231,6 +231,15 @@ int send_pack(struct send_pack_args *args,
 		return 0;
 	}
 
+	/*
+	 * NEEDSWORK: why is delete-refs so specific to send-pack
+	 * machinery that set_ref_status_for_push() cannot set this
+	 * bit for us???
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
2.1.0-399-g1364b4d
