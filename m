From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/21] send-pack: refactor inspecting and resetting status and sending commands
Date: Thu,  4 Sep 2014 13:04:47 -0700
Message-ID: <1409861097-19151-12-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:07:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdJ0-0001FP-KA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401AbaIDUFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60152 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755329AbaIDUFq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B4A6381CC;
	Thu,  4 Sep 2014 16:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tHEj
	FMeXepHITwYdcA5fFK0qMxc=; b=bKpOaSf/DseTz0fxVuFfg3ud6kpCUv7hWASB
	r1bhjBXv3oXdaRQ8bUF6hbiZKtf8fYx5k9BI27T/W5MI+ss6nCI7WcWZ8cSyPvhT
	v1Q22pujoedFbxZ8l+Wofbpe5k2R8M3eHmwUN9AhXIj9l6jZ/D/8P3rqvTBlNeej
	8pV0sHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=KI5WQH
	YwUX6QpCcmPUMssYobk7aIcFuzoR02UV2uUPLqj32jGFNcnMB7EdqJD0IOOn56kR
	IdZ36UpBpC6KIsQCXtd93+8U2UkYxRuttRadiApGhRP+Yq403zp/KBBcwz2L6oPr
	YJQ72hCc4FZvf7Ee699F6CKL6lNmKBVSwfyZc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFD60381CA;
	Thu,  4 Sep 2014 16:05:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 44C06381B5;
	Thu,  4 Sep 2014 16:05:38 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D6CF1A7A-346E-11E4-9433-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256472>

The main loop over remote_refs list inspects the ref status
to see if we need to generate pack data (i.e. a delete-only push
does not need to send any additional data), resets it to "expecting
the status report" state, and formats the actual update commands
to be sent.

Split the former two out of the main loop, as it will become
conditional in later steps.

Besides, we should have code that does real thing here, before the
"Finally, tell the other end!" part ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 590eb0a..f3262f2 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -274,7 +274,8 @@ int send_pack(struct send_pack_args *args,
 		advertise_shallow_grafts_buf(&req_buf);
 
 	/*
-	 * Finally, tell the other end!
+	 * Clear the status for each ref and see if we need to send
+	 * the pack data.
 	 */
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (!ref_update_to_be_sent(ref, args))
@@ -283,25 +284,35 @@ int send_pack(struct send_pack_args *args,
 		if (!ref->deletion)
 			need_pack_data = 1;
 
-		if (args->dry_run) {
+		if (args->dry_run || !status_report)
 			ref->status = REF_STATUS_OK;
-		} else {
-			char *old_hex = sha1_to_hex(ref->old_sha1);
-			char *new_hex = sha1_to_hex(ref->new_sha1);
-
-			if (!cmds_sent)
-				packet_buf_write(&req_buf,
-						 "%s %s %s%c%s",
-						 old_hex, new_hex, ref->name, 0,
-						 cap_buf.buf);
-			else
-				packet_buf_write(&req_buf, "%s %s %s",
-						 old_hex, new_hex, ref->name);
-			ref->status = status_report ?
-				REF_STATUS_EXPECTING_REPORT :
-				REF_STATUS_OK;
-			cmds_sent++;
-		}
+		else
+			ref->status = REF_STATUS_EXPECTING_REPORT;
+	}
+
+	/*
+	 * Finally, tell the other end!
+	 */
+	for (ref = remote_refs; ref; ref = ref->next) {
+		char *old_hex, *new_hex;
+
+		if (args->dry_run)
+			continue;
+
+		if (!ref_update_to_be_sent(ref, args))
+			continue;
+
+		old_hex = sha1_to_hex(ref->old_sha1);
+		new_hex = sha1_to_hex(ref->new_sha1);
+		if (!cmds_sent)
+			packet_buf_write(&req_buf,
+					 "%s %s %s%c%s",
+					 old_hex, new_hex, ref->name, 0,
+					 cap_buf.buf);
+		else
+			packet_buf_write(&req_buf, "%s %s %s",
+					 old_hex, new_hex, ref->name);
+		cmds_sent++;
 	}
 
 	if (args->stateless_rpc) {
-- 
2.1.0-399-g1364b4d
