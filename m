From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/19] send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
Date: Fri, 22 Aug 2014 13:30:10 -0700
Message-ID: <1408739424-31429-6-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:31:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvUl-0007Zo-Qt
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbaHVUbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:31:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60247 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaHVUbb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:31:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 433503316A;
	Fri, 22 Aug 2014 16:31:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Emv7
	BAH0oBKb9gZfHpbutKy/k0s=; b=Wqr3TC/IrjB5V5BLPr2leqP5eX3u5vhitOWl
	6eLBwrkvORdfGpKGlat8fBLLf2MIjH0iVnxXqMqrRRXNl/kkPnUJXewuhViIbnLU
	0A+szj+4RK8Llbfo88sW1casBJSbNA8hea5+CzhLhTH+/0Q/R8IzovudrjBCh/Ec
	uNuFnJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gqHmCB
	24Zxa//BxMkP38ax/xBf2zpGfrKktseztN6Jy1ibGBlvXoDdV0msh0Jb8rvYD6Hz
	y/eaiOnnJ55t2dDcmlj5Qx2bFoG0jSjipdrhrjiujf7XcK0yX1h4qUDT57UCdT95
	JKY6PThVr5/a8tjZTtRl4l5LkvTv+ALGYXzDM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38ACC33169;
	Fri, 22 Aug 2014 16:31:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 750B233149;
	Fri, 22 Aug 2014 16:31:19 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4610726E-2A3B-11E4-9F89-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255706>

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
2.1.0-304-g950f846
