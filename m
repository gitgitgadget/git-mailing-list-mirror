From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 06/23] send-pack: refactor decision to send update per ref
Date: Wed, 17 Sep 2014 15:45:41 -0700
Message-ID: <1410993958-32394-7-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:46:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUNzV-00026Y-If
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757067AbaIQWqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58470 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757010AbaIQWqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 544B439DF3;
	Wed, 17 Sep 2014 18:46:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=eNfp
	IZ/6/VyP5yAbLEv+4zk8Z/M=; b=Mu8L8dW56ENh5iDSHuPVLd1NuyLArZvLxJeC
	nn9Vjx46Amy2mhgd57blffWAOdf4sheUWQU2ndWuOi4CagZI5TedNmChKMt2/yvZ
	i/9Tqpnsw5bjqrutSfjaWIMknj68eTvA0rDy7/YfQMHQlN20LUno1/QV4B4pwTXW
	ugTmviQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=T7OF8h
	XT6aRlz3d6ReE4oA9oDNVNXIoj8PbiXK5PyiybKi6e0z0wFJ2iA/Moe/Uvm5mGVv
	pPM0LiU878988kCYWu/PqEsi9tss/o1Tb+C27eMQDfnGB5X3iLMoiZJ2ATmMvCOv
	XxVbU1UwGxpPXmQXkmaOp28Muqo7xoMaiVT4A=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B91E39DF2;
	Wed, 17 Sep 2014 18:46:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F1E5E39DEE;
	Wed, 17 Sep 2014 18:46:12 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6CE9A24E-3EBC-11E4-A5CF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257232>

A new helper function ref_update_to_be_sent() decides for each ref
if the update is to be sent based on the status previously set by
set_ref_status_for_push() and also if this is a mirrored push.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Unchanged since v5.

 send-pack.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 22a1709..43e98fa 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -190,6 +190,26 @@ static void advertise_shallow_grafts_buf(struct strbuf *sb)
 	for_each_commit_graft(advertise_shallow_grafts_cb, sb);
 }
 
+static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_args *args)
+{
+	if (!ref->peer_ref && !args->send_mirror)
+		return 0;
+
+	/* Check for statuses set by set_ref_status_for_push() */
+	switch (ref->status) {
+	case REF_STATUS_REJECT_NONFASTFORWARD:
+	case REF_STATUS_REJECT_ALREADY_EXISTS:
+	case REF_STATUS_REJECT_FETCH_FIRST:
+	case REF_STATUS_REJECT_NEEDS_FORCE:
+	case REF_STATUS_REJECT_STALE:
+	case REF_STATUS_REJECT_NODELETE:
+	case REF_STATUS_UPTODATE:
+		return 0;
+	default:
+		return 1;
+	}
+}
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
@@ -248,23 +268,9 @@ int send_pack(struct send_pack_args *args,
 	 */
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
-		if (!ref->peer_ref && !args->send_mirror)
+		if (!ref_update_to_be_sent(ref, args))
 			continue;
 
-		/* Check for statuses set by set_ref_status_for_push() */
-		switch (ref->status) {
-		case REF_STATUS_REJECT_NONFASTFORWARD:
-		case REF_STATUS_REJECT_ALREADY_EXISTS:
-		case REF_STATUS_REJECT_FETCH_FIRST:
-		case REF_STATUS_REJECT_NEEDS_FORCE:
-		case REF_STATUS_REJECT_STALE:
-		case REF_STATUS_REJECT_NODELETE:
-		case REF_STATUS_UPTODATE:
-			continue;
-		default:
-			; /* do nothing */
-		}
-
 		if (!ref->deletion)
 			new_refs++;
 
-- 
2.1.0-403-g099cf47
