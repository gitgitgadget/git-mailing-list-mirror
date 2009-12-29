From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/9] rerere: remove silly 1024-byte line limit
Date: Tue, 29 Dec 2009 13:42:36 -0800
Message-ID: <1262122958-9378-8-git-send-email-gitster@pobox.com>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:43:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjqW-0003SS-1t
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbZL2VnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbZL2VnH
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:43:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbZL2Vmz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:42:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BDDB2ABFC0
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=GOiV
	3GnYBohzDiVrY1+vuI9oJQg=; b=JgyJOpj4NJWg/wh4kQFvulyv/kHZy/d/9XBR
	w/mRDwr1KQywpUmEPXjt6ByKPJO0lo/otLuSNtPGG1koO5bgec+mc2VDhaknCt8q
	4yIjtyyWrkMstuxYHcTVen8niBGk0IJ2d8FEx5tYXCs5uREHYjcNzzC+/ndAAELs
	DCc/TPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vPd0we
	turOSUZH/5zwilqrjzcXEPdHHwdRugelMhIKprf4Ch24cCBb6Mq34ZBInRYpEe1s
	xWheL99PlLcp5s8Zq6PXY36JQomt9CJpzZ5dOKbZLhck2p/cUgNAiHvkgmpOlb6H
	XxJHj0SdA6L7g1Dw7KJ4JrQs5Zjga4zTfvzrc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA557ABFBF
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 337E6ABFBE for
 <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:53 -0500 (EST)
X-Mailer: git-send-email 1.6.6.60.gc2ff1
In-Reply-To: <1262122958-9378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1F37E4F4-F4C3-11DE-86C2-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135825>

Ever since 658f365 (Make git-rerere a builtin, 2006-12-20) rewrote it, it
kept this line-length limit regression, even after we started using strbuf
in the same function in 19b358e (Use strbuf API in buitin-rerere.c,
2007-09-06).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/rerere.c b/rerere.c
index 29f95f6..88bb4f1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -87,12 +87,12 @@ static int handle_file(const char *path,
 	 unsigned char *sha1, const char *output)
 {
 	git_SHA_CTX ctx;
-	char buf[1024];
 	int hunk_no = 0;
 	enum {
 		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL,
 	} hunk = RR_CONTEXT;
 	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen(path, "r");
 	FILE *out = NULL;
 	int wrerror = 0;
@@ -111,20 +111,20 @@ static int handle_file(const char *path,
 	if (sha1)
 		git_SHA1_Init(&ctx);
 
-	while (fgets(buf, sizeof(buf), f)) {
-		if (!prefixcmp(buf, "<<<<<<< ")) {
+	while (!strbuf_getwholeline(&buf, f, '\n')) {
+		if (!prefixcmp(buf.buf, "<<<<<<< ")) {
 			if (hunk != RR_CONTEXT)
 				goto bad;
 			hunk = RR_SIDE_1;
-		} else if (!prefixcmp(buf, "|||||||") && isspace(buf[7])) {
+		} else if (!prefixcmp(buf.buf, "|||||||") && isspace(buf.buf[7])) {
 			if (hunk != RR_SIDE_1)
 				goto bad;
 			hunk = RR_ORIGINAL;
-		} else if (!prefixcmp(buf, "=======") && isspace(buf[7])) {
+		} else if (!prefixcmp(buf.buf, "=======") && isspace(buf.buf[7])) {
 			if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
 				goto bad;
 			hunk = RR_SIDE_2;
-		} else if (!prefixcmp(buf, ">>>>>>> ")) {
+		} else if (!prefixcmp(buf.buf, ">>>>>>> ")) {
 			if (hunk != RR_SIDE_2)
 				goto bad;
 			if (strbuf_cmp(&one, &two) > 0)
@@ -147,13 +147,13 @@ static int handle_file(const char *path,
 			strbuf_reset(&one);
 			strbuf_reset(&two);
 		} else if (hunk == RR_SIDE_1)
-			strbuf_addstr(&one, buf);
+			strbuf_addstr(&one, buf.buf);
 		else if (hunk == RR_ORIGINAL)
 			; /* discard */
 		else if (hunk == RR_SIDE_2)
-			strbuf_addstr(&two, buf);
+			strbuf_addstr(&two, buf.buf);
 		else if (out)
-			ferr_puts(buf, out, &wrerror);
+			ferr_puts(buf.buf, out, &wrerror);
 		continue;
 	bad:
 		hunk = 99; /* force error exit */
@@ -161,6 +161,7 @@ static int handle_file(const char *path,
 	}
 	strbuf_release(&one);
 	strbuf_release(&two);
+	strbuf_release(&buf);
 
 	fclose(f);
 	if (wrerror)
-- 
1.6.6
