From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 06/23] send-pack: refactor decision to send update per ref
Date: Mon, 15 Sep 2014 15:24:07 -0700
Message-ID: <1410819864-22967-7-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:24:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehb-0006LV-Jz
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758704AbaIOWYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:24:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54856 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755603AbaIOWYj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3B603B187;
	Mon, 15 Sep 2014 18:24:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=v8AP
	HJXO+A/1QLQ5Hfc3pI74k+c=; b=GTiv4cUgyKS+mPAPQwptj26b6tGdb/VWL46W
	cnMDUmDfdyKeLMziBAzhDP2wwuQRCC2SqNhZUIuN3fh51uIUp5ZuPanoxZjkTEy3
	dhbtY1XdUfkOlKuLx9ij2cv8YtzbWNFuG9TwNXHApKiM7+VcbERAkOY1bMOHreWT
	5UmIJc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HMDqOj
	qFtnuvdbSr3IldU4LbboCGna8DqKfd6+Q4phhKMMn+Oma7SkQLPAdY1Y6MSX9WFf
	/DvQvzLeTIJ2+iV6sXrefNJguWvuQceBs2HW8fLvkBkiAr0JEL63XHdgktRXQuA6
	CyYW/G8jM+AhRNRcT/QJZ8tRnEi2/Wuwp1fsM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CAC7B3B186;
	Mon, 15 Sep 2014 18:24:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E8403B185;
	Mon, 15 Sep 2014 18:24:38 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 14676052-3D27-11E4-89D5-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257093>

A new helper function ref_update_to_be_sent() decides for each ref
if the update is to be sent based on the status previously set by
set_ref_status_for_push() and also if this is a mirrored push.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
2.1.0-410-gd72dacd
