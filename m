From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/18] send-pack: refactor inspecting and resetting status and sending commands
Date: Tue, 19 Aug 2014 15:06:19 -0700
Message-ID: <1408485987-3590-11-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrah-0006jD-G2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbaHSWIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:08:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62033 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaHSWIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:08:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 53D0733128;
	Tue, 19 Aug 2014 18:08:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2PRx
	G3iTlIMLT+Yt+jxMC9o39JU=; b=Slng3//zSq8214iTWj64g0TmnbAGIMHVZw6p
	XRRAcQONif33O/3ffoGc6T59NKnmJjqN7OvE974p426m06MVO0EeR7UWNj8WGLz5
	ktYiWIFYvNMuJwbyiM1Y9BNqmIfCxX/BWnT+iykspKKmMd/JWRMCVs98r7hZttAT
	WGBDYR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=tnGMnh
	jtV32PBHwglWB5MH3muAelHeFFYMwXrKkbi10zoy0pMWXZfnovEaFrQMACPc5g1t
	9lBMduy42P1+TnAm6cUYTR4PMi+o9o7IJDCbZd4YnQnLTfyJ0FgFtxmd9+gRYfH/
	Wo5XXoBbnbF9O4IgcnV4SJEpCvPU2POkgJc8w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B6B633127;
	Tue, 19 Aug 2014 18:08:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F9B23311B;
	Tue, 19 Aug 2014 18:08:07 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4C9C486A-27ED-11E4-8D0D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255532>

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
2.1.0-301-g54593e2
