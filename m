From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 11/23] send-pack: refactor inspecting and resetting status and sending commands
Date: Wed, 17 Sep 2014 15:45:46 -0700
Message-ID: <1410993958-32394-12-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:46:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUNzh-0002BS-58
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbaIQWqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64722 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757182AbaIQWq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F47C39E12;
	Wed, 17 Sep 2014 18:46:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lTYW
	MIkxgVaSIoDDjDuoAN/zJg8=; b=mWB7mrrPp/pZeEFrweoQpThnlLvBejy1IIkW
	O5ZRgkrVEi1WkxeX72bvsej5lYw/08XJyjccWsYGA2jOsYiB6F1flwN+TmPmZIvP
	NJlNpU5QW9zZCC8E8hIV1MG6A+BZWKHlgrQoF/aFoIICLzetKmYtQ4EJpy68vgRA
	WXPBmck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=n2/JBL
	DUriPPfhnRA15BjHhByKkYQjg1W2Mtvhks/jRQSrEUuyfUeK1BfnQX3gb/H0DM9y
	FFHg4u6xm7sin+Zfw55A8ABCkvfzj6imnMyfIcViYMm9xRxS9UYXmp5t8/bI8fhd
	7d6AQPQ41tAM67s63RiZOhvGGYL404om/FQco=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1784139E11;
	Wed, 17 Sep 2014 18:46:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2046639E08;
	Wed, 17 Sep 2014 18:46:23 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 72F59C60-3EBC-11E4-A387-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257236>

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
 Unchanged since v5.

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
2.1.0-403-g099cf47
