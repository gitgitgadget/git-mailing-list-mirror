From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 11/23] send-pack: refactor inspecting and resetting status and sending commands
Date: Mon, 15 Sep 2014 15:24:12 -0700
Message-ID: <1410819864-22967-12-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:24:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehd-0006LV-5I
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758717AbaIOWYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:24:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53346 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836AbaIOWYt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB31D3B19F;
	Mon, 15 Sep 2014 18:24:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3GWw
	mvwFNd1wchHYHWfOjr4zo5M=; b=vD8MK70H6/Hmengex31G75mN9paB1B7egt+B
	fOkcedPVvpJWNPJLq3yYtjAS3ofdkzyKx5LcBxH5Tki7t85H2BWZ+iyg3l4vUAHU
	aLB4AGC6mL7kEdZw9y7u+W0i0juX3x4QqRFJRrtHL1nnZqqseOAnN/9UWxc5Urvl
	3FXGxIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=XkbOXE
	uqFYXrhyucYj/QhhqcOoRwYew5c4hHnJIo/R2HYP6XEe9DFvY1NL78IpllTVOlon
	27Z5V/Te0lcD6el37pktTmKcFEnnRE5j4Kh4FR7aRpihKo4xdHXSZoul64Ro1+5P
	TxYTUHlykWc8wFFy03RbmJNBKsbRDqJ+jlqYE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2B433B19E;
	Mon, 15 Sep 2014 18:24:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C74733B19A;
	Mon, 15 Sep 2014 18:24:47 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1A102912-3D27-11E4-81AF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257095>

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
index 716c11b..6dc8a46 100644
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
2.1.0-410-gd72dacd
