From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 11/22] send-pack: refactor inspecting and resetting status and sending commands
Date: Fri,  5 Sep 2014 13:54:59 -0700
Message-ID: <1409950510-10209-12-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xx-0005bR-CJ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbaIEUzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55376 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513AbaIEUzk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0F643669D;
	Fri,  5 Sep 2014 16:55:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QmUv
	rNtJiTDmCgxuIWtDCpyscNg=; b=TWkvvzK9Bifu/1Qid98jHJEydA8rZ6ga34Fx
	fSJHCy6pKljmLXFiuBOGIPZhc/ST2S4cHarEg8ocoXh17jQNJsswirfMdj/RxUT3
	I6TDeXoGCBWSq7+caxaljDhslAtTs/a9JF0C6bz8YVuUrhG+lxInizt5U0+lk5L4
	ZnPfsf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wmZGkE
	rqjvdDO4foxJ6ePHAD1HYI73yzEO3JOb4GB+n1dRGutpp+yqPvITSg1EtCf+L8Il
	C0+1kqYF4IJkAlmvSGFXUyRdWWS/PgGkQl9pFDcpfzzQiPOKVRw6yxj4RU0KkT1z
	MANtfHfFwJXaTgTP+psemaqegKJ2jaKy1GQyM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7D0A3669B;
	Fri,  5 Sep 2014 16:55:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 61AB33669A;
	Fri,  5 Sep 2014 16:55:39 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FE070A78-353E-11E4-B1A6-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256521>

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
2.1.0-399-g2df620b
