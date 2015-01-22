From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] apply: count the size of postimage correctly
Date: Thu, 22 Jan 2015 14:58:24 -0800
Message-ID: <1421967505-16879-4-git-send-email-gitster@pobox.com>
References: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
 <1421967505-16879-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 23:58:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQiA-0007u0-5L
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 23:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbbAVW6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 17:58:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753608AbbAVW6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 17:58:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30C413135D;
	Thu, 22 Jan 2015 17:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=94r3
	BMrx8zhwMhpWF4v8Il0ZwB8=; b=UXuJ1O9s+PpEOBnC0ZH0nML/J33pJ2qiIkaG
	8x9INjdF4aNNMzAkKiLQ3rp/4F/xIV9t/l28EgAedNV9wXsn7wvM9LUns7iHrlaw
	gs22RWSLdupVZvvcsKU96GQ+Cj9IahHZiAxvER9znLkql9rGH9BFYBG2qMHh7ck9
	iMs8xuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=n6qdzA
	PgERiXUG9Kp692nS9DR3ffvFfi0AxhoblkTVCOUyDX9eujFih5mA3ue6bkhSx4uC
	jUXpwlz3A/EybkVhpQhOvSWGeKJUZDhB2JhjsWl5sLi6/iDfpZIBghOhlnoFj0G5
	ll1udAfgua5/bepsWOyOgDl9Ku0r/yj++2yik=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 292253135C;
	Thu, 22 Jan 2015 17:58:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5780631347;
	Thu, 22 Jan 2015 17:58:31 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc1-150-gaf32ea2
In-Reply-To: <1421967505-16879-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2F7A0444-A28A-11E4-9842-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262882>

Under --whitespace=fix option, match_fragment() function examines
the preimage (the common context and the removed lines in the patch)
and the file being patched and checks if they match after correcting
all whitespace errors.  When they are found to match, the common
context lines in the preimage is replaced with the fixed copy,
because these lines will then be copied to the corresponding place
in the postimage by a later call to update_pre_post_images().  Lines
that are added in the postimage, under --whitespace=fix, have their
whitespace errors already fixed when apply_one_fragment() prepares
the preimage and the postimage, so in the end, application of the
patch can be done by replacing the block of text in the file being
patched that matched the preimage with what is in the postimage that
was updated by update_pre_post_images().

In the earlier days, fixing whitespace errors always resulted in
reduction of size, either collapsing runs of spaces in the indent to
a tab or removing the trailing whitespaces.  These days, however,
some whitespace error fix results in extending the size.

250b3c6c (apply --whitespace=fix: avoid running over the postimage
buffer, 2013-03-22) tried to compute the final postimage size but
its math was flawed.  It counted the size of the block of text in
the original being patched after fixing the whitespace errors on its
lines that correspond to the preimage.  That number does not have
much to do with how big the final postimage would be.

Instead count (1) the added lines in the postimage, whose size is
the same as in the final patch result because their whitespace
errors have already been corrected, and (2) the fixed size of the
lines that are common.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index da6fb35..e895340 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2336,6 +2336,23 @@ static int match_fragment(struct image *img,
 	 * ignore whitespace, we were asked to correct whitespace
 	 * errors, so let's try matching after whitespace correction.
 	 *
+	 * While checking the preimage against the target, whitespace
+	 * errors in both fixed, we count how large the corresponding
+	 * postimage needs to be.  The postimage prepared by
+	 * apply_one_fragment() has whitespace errors fixed on added
+	 * lines already, but the common lines were propagated as-is,
+	 * which may become longer when their whitespace errors are
+	 * fixed.
+	 */
+
+	/* First count added lines in postimage */
+	postlen = 0;
+	for (i = 0; i < postimage->nr; i++) {
+		if (!(postimage->line[i].flag & LINE_COMMON))
+			postlen += postimage->line[i].len;
+	}
+
+	/*
 	 * The preimage may extend beyond the end of the file,
 	 * but in this loop we will only handle the part of the
 	 * preimage that falls within the file.
@@ -2343,7 +2360,6 @@ static int match_fragment(struct image *img,
 	strbuf_init(&fixed, preimage->len + 1);
 	orig = preimage->buf;
 	target = img->buf + try;
-	postlen = 0;
 	for (i = 0; i < preimage_limit; i++) {
 		size_t oldlen = preimage->line[i].len;
 		size_t tgtlen = img->line[try_lno + i].len;
@@ -2371,7 +2387,10 @@ static int match_fragment(struct image *img,
 		match = (tgtfix.len == fixed.len - fixstart &&
 			 !memcmp(tgtfix.buf, fixed.buf + fixstart,
 					     fixed.len - fixstart));
-		postlen += tgtfix.len;
+
+		/* Add the length if this is common with the postimage */
+		if (preimage->line[i].flag & LINE_COMMON)
+			postlen += tgtfix.len;
 
 		strbuf_release(&tgtfix);
 		if (!match)
-- 
2.3.0-rc1-116-g84c5016
