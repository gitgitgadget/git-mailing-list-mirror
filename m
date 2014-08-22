From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/19] send-pack: rename "new_refs" to "need_pack_data"
Date: Fri, 22 Aug 2014 13:30:14 -0700
Message-ID: <1408739424-31429-10-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:32:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvVO-0007wx-1Y
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbaHVUcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:32:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55840 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbaHVUcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:32:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF0D6331B1;
	Fri, 22 Aug 2014 16:32:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=20of
	LRI4h8cxbvhfc0UAGq0IacU=; b=KfpkNgKS4KF/2aHUkdvaBtXcG9F83QKly0Kp
	wrYy7CyIHzD5MrgN7CduqXfDhl4V3U13bRMVj8z5Q5wRMe2a/qdXn2u27T8y1yx4
	UivTmC5pL91GmJ39ApxBnsyL36WUkBxBd3Xjtf0Ur0FRqNP/ms84gM57t+CNEz+3
	Ds4vDdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=KD06So
	Zhbh6QJUfVtTN1kG4Nmm+AYyL2iWckzoLTN0Ig7q/kRuCkFl/aYH1nBjXRUTedXu
	c24WuYGiEPrvOx9KmiMqIke32cwjj0ZTu+egm6aPtybLsKUHLLQeBj8emmzyY8uO
	lwblvQyv1gtUJBvdUc39GbmGL4m1/IPutZlJM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5130331B0;
	Fri, 22 Aug 2014 16:32:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 31294331A2;
	Fri, 22 Aug 2014 16:32:00 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5E598572-2A3B-11E4-B4A5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255710>

The variable counts how many non-deleting command is being sent, but
is only checked with 0-ness to decide if we need to send the pack
data.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index c1c64ee..590eb0a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -220,7 +220,7 @@ int send_pack(struct send_pack_args *args,
 	struct strbuf req_buf = STRBUF_INIT;
 	struct strbuf cap_buf = STRBUF_INIT;
 	struct ref *ref;
-	int new_refs;
+	int need_pack_data = 0;
 	int allow_deleting_refs = 0;
 	int status_report = 0;
 	int use_sideband = 0;
@@ -276,13 +276,12 @@ int send_pack(struct send_pack_args *args,
 	/*
 	 * Finally, tell the other end!
 	 */
-	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (!ref_update_to_be_sent(ref, args))
 			continue;
 
 		if (!ref->deletion)
-			new_refs++;
+			need_pack_data = 1;
 
 		if (args->dry_run) {
 			ref->status = REF_STATUS_OK;
@@ -327,7 +326,7 @@ int send_pack(struct send_pack_args *args,
 		in = demux.out;
 	}
 
-	if (new_refs && cmds_sent) {
+	if (need_pack_data && cmds_sent) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
 			for (ref = remote_refs; ref; ref = ref->next)
 				ref->status = REF_STATUS_NONE;
-- 
2.1.0-304-g950f846
