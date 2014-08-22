From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/19] send-pack: refactor decision to send update per ref
Date: Fri, 22 Aug 2014 13:30:11 -0700
Message-ID: <1408739424-31429-7-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:31:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvUv-0007ei-28
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbaHVUbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:31:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65071 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaHVUbk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:31:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B94B33186;
	Fri, 22 Aug 2014 16:31:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QeZ5
	G2s/JRwqt+qTV7RNioMH3K0=; b=owbwWqqtqW9o5rteLh7OpB336QGAOE0adoF9
	q6HUCW0Km+hHsw6YneuliqcvgTIrm4x1GjwQOHkpf3BeBfLiVca6Rg0ffCAMC7m1
	AlLSqu9XdEGeZG1OA5z+W5kWWtbAExWLTFVxqILFfGLbcvZp68hHu34KyrBO5pWI
	6VJz34A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Hkl/9r
	e/AGP2ZZMbkJ08HkZv3itAkW7MFTKXBA2QsebUt0Z35yHoxkn8GLV7Z+cLlw1S5O
	urvtymMt5DgwFUc7pij5I8A9C39IFPATShfAMouGwt2v/zdZ73ec4mb3nuyVr4id
	jNGkBH7VS0XHaMciLPb+64FEhhvkwwlNFeYWo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70C6933185;
	Fri, 22 Aug 2014 16:31:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9F6313316C;
	Fri, 22 Aug 2014 16:31:32 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4DEAC552-2A3B-11E4-B89D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255707>

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
2.1.0-304-g950f846
