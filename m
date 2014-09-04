From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/21] send-pack: refactor decision to send update per ref
Date: Thu,  4 Sep 2014 13:04:42 -0700
Message-ID: <1409861097-19151-7-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:05:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdHs-0000jh-CQ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388AbaIDUF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52288 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385AbaIDUFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3E6838177;
	Thu,  4 Sep 2014 16:05:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zJOs
	tz2ug9Fm4GZ31Xu+D2V6V/k=; b=lf2/rxzy4tqqnPA/uNw3QrPDtiM0hiwpq+rC
	+FPYEzYy0Wn4CIDXwgEzagLmyUsbMQPB1FYskDR7d88rWd6wzoZ0OKRIC5KyXh8G
	/qZhJznbOvKDkkL0Oa+ipjf2mVPCeOvvXo4OgafYCRZj658BbuQVTbAHl2jpKlTi
	sEv6KBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=dtgyNv
	lLs/14DAt3jImMV3kf/3Px4m4tNQ9L8vavaEApl5YunmYooLF46Pbm6ZjuyGzkBh
	fs4/t5RDguetjII3aC3V/AlvgbrTsUIb2vZS/fSUML/Oax7tj/AJsTS8Q4dkJzyD
	MV4UAauqgCXPmaS+JpgywZ8Wst34/9/RliB6o=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 753F638173;
	Thu,  4 Sep 2014 16:05:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5DAD53816B;
	Thu,  4 Sep 2014 16:05:21 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CCC4776E-346E-11E4-B7AA-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256465>

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
2.1.0-399-g1364b4d
