From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/18] send-pack: refactor decision to send update per ref
Date: Tue, 19 Aug 2014 15:06:15 -0700
Message-ID: <1408485987-3590-7-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:07:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrZ7-0005rT-0H
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbaHSWHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:07:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59161 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbaHSWHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:07:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5F75330DA;
	Tue, 19 Aug 2014 18:07:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/W1A
	yMTPVte1Uwb001fzNpWJPBw=; b=WZRHph2/Whm6lRvW82+pf9JCnrUJ32PpMyp3
	XqsG/lzXJkpAO0tVkVGSgWp59/4Y/4xCnnEmXUYAfDUZXPszEJtky9Ho10m0bLQN
	wI0gVV3HLe+rqGpRpXP8ZVHyiLcZ9I4G8OtUFUQ/PzxtN/Vi42p0ONzZunJI0CXj
	vZH586Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=SAEub2
	JmFDa3JRvYvOCuYqwDfABiJQpUdQ+maivlo3s4fB4A0Q4mk76FZLsmfYLlEy4PTh
	57mPMXFpZuATzG91++NnT1E/asxyP2kNJ+SF7mcQZfMJ/YkKQEq9N2QUia0DKBRd
	H9uuvzYkL8bypehFMDGkNUtf6oit4dQwIs6PI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD75D330D9;
	Tue, 19 Aug 2014 18:07:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E918330C8;
	Tue, 19 Aug 2014 18:07:26 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3421B5C2-27ED-11E4-AFDD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255526>

A new helper function ref_update_to_be_sent() decides for each ref
if the update is to be sent based on the status previously set by
set_ref_status_for_push() and also if this is a mirrored push.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 7428ae6..f3c5ebe 100644
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
2.1.0-301-g54593e2
