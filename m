Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8DF1F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757535AbcIHHbf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:31:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:62892 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbcIHHbc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:31:32 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MFdDB-1bn90c3RvJ-00EeM1; Thu, 08 Sep 2016 09:31:19
 +0200
Date:   Thu, 8 Sep 2016 09:31:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] Use the newly-introduced regexec_buf() function
In-Reply-To: <cover.1473319844.git.johannes.schindelin@gmx.de>
Message-ID: <324ecba64eb0436988aca846fb444eafda290d13.1473319844.git.johannes.schindelin@gmx.de>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <cover.1473319844.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UCd/lw1R/BU63UjdQpx12OKYaXOoxALyu/SLOMX79jcIpTjqkwC
 33RqZHVu8Nh7UDsqZgUHO31TcrxwvlKY1RK80Y8ty7im7XQcNyPR9CZC1LR0hUsNubQqaWP
 pn3DuspyNxJJb1hngJBrWiHF31SMBxJSabcJ5oxbJY5wNF8ADHZb2ZVzhQ2T9B6vbS1BUct
 qQwwKLzmLPpOyZHBSL77w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AbhkCyuvG1M=:GS3e34UQsR8Aas/0G35ljJ
 rRSbm/ec2W1pIBw9mvpU3TdbAW+abYAhLMSNHtQC9Fl35JsmzeoChHzK5YVHCFApDyWPau7kD
 JGVsizxGPkleXEm6qF5k+oAD+NI56b05YeqzcUV+reM+ZRzffME7RtkmMT1Z0Er088S1Ji5Zo
 GMtdsboRriYVVRx6yZDX/Vf9s7w5+TvcaJr2giZJpvJS2KJEF1kZDe52eILn1yGdEHEBFfVh4
 7BA+Ti9Ie8+Q1W5IXEhWIleooSaQ5XzXMrmTQAOoAtsTKg9I20ci3+PqylSFtEgy6koJQOhZO
 Y+004ZmW1tfYadMDuunuZLtPK6qcyELV3IpvnNFjZk3eTHVuDIHxdaZHdAKn8w69DB0v/2jvo
 HOS/QcAsLVMTn8A6baLZTHYUbB3c2tnCvKEjrY4U5+NPK1Z6IHQ2BXWmLlMOw3XjiC/Dbl95o
 tn3n8JGb/OcjW6AJDz2CZdUf2OjfDzBCL/8BzvSBuJnQAMlcgo8Sq7zh5SBj0aM3DP4c9jUAg
 iAHoSOq/1jJcFvBkGCWh4wPEGZoi270JYBqXrzkONLJVNSarDEd45xqaqa7tBhrIVlVtgfEMB
 4C7UjFq4dNrnWH3jJmV4xth9VBtxhq2XX93XBfgV1r9zuvAh7voSDWAmPkfWV5yd3lbJHpXGn
 VFzD78rVtuEFsjNobjXra/HQQZ/rfScqu93oB9rUij1W/zetMazrH3diPRm+3ghKPCBbLjIjj
 udQ2/5Ti1ok6gDYXVQl4+uU2cXTphnuJnn+uCy9tiewgLhBAaDfIn3EdLas48Sz1T64kX7fg6
 ciGXflj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new regexec_buf() function operates on buffers with an explicitly
specified length, rather than NUL-terminated strings.

We need to use this function whenever the buffer we want to pass to
regexec() may have been mmap()ed (and is hence not NUL-terminated).

Note: the original motivation for this patch was to fix a bug where
`git diff -G <regex>` would crash. This patch converts more callers,
though, some of which explicitly allocated and constructed
NUL-terminated strings (or worse: modified read-only buffers to insert
NULs).

Some of the buffers actually may be NUL-terminated. As regexec_buf()
uses REG_STARTEND where available, but has to fall back to allocating
and constructing NUL-terminated strings where REG_STARTEND is not
available, this makes the code less efficient in the latter case.

However, given the widespread support for REG_STARTEND, combined with
the improved ease of code maintenance, we strike the balance in favor
of REG_STARTEND.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c             |  3 ++-
 diffcore-pickaxe.c | 18 ++++++++----------
 xdiff-interface.c  | 13 ++++---------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 534c12e..526775a 100644
--- a/diff.c
+++ b/diff.c
@@ -951,7 +951,8 @@ static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
 {
 	if (word_regex && *begin < buffer->size) {
 		regmatch_t match[1];
-		if (!regexec(word_regex, buffer->ptr + *begin, 1, match, 0)) {
+		if (!regexec_buf(word_regex, buffer->ptr + *begin,
+				 buffer->size - *begin, 1, match, 0)) {
 			char *p = memchr(buffer->ptr + *begin + match[0].rm_so,
 					'\n', match[0].rm_eo - match[0].rm_so);
 			*end = p ? p - buffer->ptr : match[0].rm_eo + *begin;
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 55067ca..9795ca1 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -23,7 +23,6 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffgrep_cb *data = priv;
 	regmatch_t regmatch;
-	int hold;
 
 	if (line[0] != '+' && line[0] != '-')
 		return;
@@ -33,11 +32,8 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 		 * caller early.
 		 */
 		return;
-	/* Yuck -- line ought to be "const char *"! */
-	hold = line[len];
-	line[len] = '\0';
-	data->hit = !regexec(data->regexp, line + 1, 1, &regmatch, 0);
-	line[len] = hold;
+	data->hit = !regexec_buf(data->regexp, line + 1, len - 1, 1,
+				 &regmatch, 0);
 }
 
 static int diff_grep(mmfile_t *one, mmfile_t *two,
@@ -50,9 +46,11 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	xdemitconf_t xecfg;
 
 	if (!one)
-		return !regexec(regexp, two->ptr, 1, &regmatch, 0);
+		return !regexec_buf(regexp, two->ptr, two->size,
+				    1, &regmatch, 0);
 	if (!two)
-		return !regexec(regexp, one->ptr, 1, &regmatch, 0);
+		return !regexec_buf(regexp, one->ptr, one->size,
+				    1, &regmatch, 0);
 
 	/*
 	 * We have both sides; need to run textual diff and see if
@@ -83,8 +81,8 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 		regmatch_t regmatch;
 		int flags = 0;
 
-		assert(data[sz] == '\0');
-		while (*data && !regexec(regexp, data, 1, &regmatch, flags)) {
+		while (*data &&
+		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
 			flags |= REG_NOTBOL;
 			data += regmatch.rm_eo;
 			if (*data && regmatch.rm_so == regmatch.rm_eo)
diff --git a/xdiff-interface.c b/xdiff-interface.c
index f34ea76..50702a2 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -214,11 +214,10 @@ struct ff_regs {
 static long ff_regexp(const char *line, long len,
 		char *buffer, long buffer_size, void *priv)
 {
-	char *line_buffer;
 	struct ff_regs *regs = priv;
 	regmatch_t pmatch[2];
 	int i;
-	int result = -1;
+	int result;
 
 	/* Exclude terminating newline (and cr) from matching */
 	if (len > 0 && line[len-1] == '\n') {
@@ -228,18 +227,16 @@ static long ff_regexp(const char *line, long len,
 			len--;
 	}
 
-	line_buffer = xstrndup(line, len); /* make NUL terminated */
-
 	for (i = 0; i < regs->nr; i++) {
 		struct ff_reg *reg = regs->array + i;
-		if (!regexec(&reg->re, line_buffer, 2, pmatch, 0)) {
+		if (!regexec_buf(&reg->re, line, len, 2, pmatch, 0)) {
 			if (reg->negate)
-				goto fail;
+				return -1;
 			break;
 		}
 	}
 	if (regs->nr <= i)
-		goto fail;
+		return -1;
 	i = pmatch[1].rm_so >= 0 ? 1 : 0;
 	line += pmatch[i].rm_so;
 	result = pmatch[i].rm_eo - pmatch[i].rm_so;
@@ -248,8 +245,6 @@ static long ff_regexp(const char *line, long len,
 	while (result > 0 && (isspace(line[result - 1])))
 		result--;
 	memcpy(buffer, line, result);
- fail:
-	free(line_buffer);
 	return result;
 }
 
-- 
2.10.0.windows.1.10.g803177d
