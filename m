From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 10/23] send-pack: rename "new_refs" to "need_pack_data"
Date: Mon, 15 Sep 2014 15:24:11 -0700
Message-ID: <1410819864-22967-11-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:25:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeiY-0006kK-IB
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbaIOWZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:25:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54220 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755555AbaIOWYq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BB5E3B196;
	Mon, 15 Sep 2014 18:24:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hrad
	YWzeqAcmTW5CzjcnL1QxI9U=; b=fePG6U49DzJKFlxRDW55w6wjzPZFQ8iMBCgf
	D+05LNeo7C7nmqX+K08l2KTZ3X6kZHOYStzKGEMCu3fulgBer2B3+S3sIfEo5rvU
	tn0VngDrJeXtp++YLRiX1Y+fFLq7hAe/auI/JsZvKWJn1M4WetwyC7TZeSDZryJm
	LUxUzrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gTxBtR
	x8X2AnWaZnDyISePq70CHuZCCX5v7TI1iFkGp3qE4xJnQkiTeCgRfPhpeWvudi6x
	Z3Y7VaMBNxmVcKMNBDNS1zDM6ubVyiBOMIO2NvCTvK/E6G61xC8zeMGj3hiCIcG3
	6470YuGBn60m1/GPpawOEXdkLmal2tcvzC84g=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42D343B195;
	Mon, 15 Sep 2014 18:24:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BC68A3B194;
	Mon, 15 Sep 2014 18:24:45 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 18D81C94-3D27-11E4-BDB4-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257109>

The variable counts how many non-deleting command is being sent, but
is only checked with 0-ness to decide if we need to send the pack
data.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 0cb44ab..716c11b 100644
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
2.1.0-410-gd72dacd
