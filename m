Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5EF1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756249AbcIUSY0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:24:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:57145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756067AbcIUSYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:24:25 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MeP5b-1bcX2E1Sf9-00QAil; Wed, 21 Sep 2016 20:24:18
 +0200
Date:   Wed, 21 Sep 2016 20:24:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 3/3] regex: use regexec_buf()
In-Reply-To: <cover.1474482164.git.johannes.schindelin@gmx.de>
Message-ID: <53f3609d99c865d59d7bfd8219a5334339e9e6bc.1474482164.git.johannes.schindelin@gmx.de>
References: <cover.1473321437.git.johannes.schindelin@gmx.de> <cover.1474482164.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rwDPdxdSx6tUenh+2/SArbVTElu5oAeGEPBvTP5FgvOH0z+IN18
 BL7cT6EAtdVTjiRWxQNQ/K4mnqoqXZlaMA1PXIk0VIuE1lFnGuw4i23Vd40vzAMsyUcwyaa
 NHKwHhBL9foyA4OrGp6zER9lFkCiAGPAL8B4o77pBYxrwEpPE1GiElVROaWQltGIbs6brUb
 QYW2WkLn0gRzqFrAjauOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:58wVQTLjYNE=:Wxgm3jXrQtHGaH9OTWRY3i
 +z9wbKRY9Cf3EXd2U+uD6fcc0pwPgU/Uew7WeA/uQw8/64sbBbShaYwzMeo3hM9BuTiqY9Wt6
 CC6QfKnzESjUwKil1DhvCNM2kFNUvkkq7v1SPx9PrGuMwOQaczlisu/knNJfoOEmZnHEXFGeJ
 m3TCGg3q4bMflORqm1ry/6LsDDV81mtGDkTrP2Js870DvtvfFrgiqhV63yYEYuIy05VULnlia
 +cRR9F7yv6e9LCjzXHN9scqQhdw43H5uJWeinMupIYTHI9Axk82rFMDa75NDQ2H7Do2L3CmTw
 0VCBQlbjtrRcevy0SXR/4CuVuBcpVAl6gDI8pE9xj+aTTL1DFrs/U3PndkhitLzYxf7bF9Ppw
 8MANYbswd6s7I5GSKZ08V5W+6FG5EvPB//pLjjxrlf70W59QQuUqkvEMfAK/nIuylv4mg/bQt
 mv7b1Dj+coBBgmSmc4lJp7XdB7TQsSDuXqkSJnNBA1mxHCkMmqe0yi8FzB48NIDXfOXi/A5Z7
 LENGrlO9y+uYoxNQ3xfDe37dFQIdPLaoTxLQOl41t0HebZjI+VnfpBzorAy7TfvWnnBNZUPAO
 C5SuqEqBPkx5Zf8Ow3ixXeHPxJXQVWs0M72O7ZMsUGJ5thSl1Qm71qCR9i1Ja+V8qafGD2gRD
 GcRipKzFqTcdxdzljHFdqnBU7+eWvVQvQzCOroyUy6dzal9iFtr26SfQKCpZxvUcv8dRC8ndv
 wZBvdcs+uQxyqkQpUnAtAjIv7U1FDUZ/62mWn696bhkSKZ3s9cJ61Kx/nDm3l8IAYEhmROt38
 J1ksk8Z
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
 diff.c                  |  3 ++-
 diffcore-pickaxe.c      | 18 ++++++++----------
 grep.c                  | 14 ++------------
 t/t4061-diff-pickaxe.sh |  2 +-
 xdiff-interface.c       | 13 ++++---------
 5 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/diff.c b/diff.c
index c6da383..fb99235 100644
--- a/diff.c
+++ b/diff.c
@@ -952,7 +952,8 @@ static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
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
diff --git a/grep.c b/grep.c
index d7d00b8..1194d35 100644
--- a/grep.c
+++ b/grep.c
@@ -898,17 +898,6 @@ static int fixmatch(struct grep_pat *p, char *line, char *eol,
 	}
 }
 
-static int regmatch(const regex_t *preg, char *line, char *eol,
-		    regmatch_t *match, int eflags)
-{
-#ifdef REG_STARTEND
-	match->rm_so = 0;
-	match->rm_eo = eol - line;
-	eflags |= REG_STARTEND;
-#endif
-	return regexec(preg, line, 1, match, eflags);
-}
-
 static int patmatch(struct grep_pat *p, char *line, char *eol,
 		    regmatch_t *match, int eflags)
 {
@@ -919,7 +908,8 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 	else if (p->pcre_regexp)
 		hit = !pcrematch(p, line, eol, match, eflags);
 	else
-		hit = !regmatch(&p->regexp, line, eol, match, eflags);
+		hit = !regexec_buf(&p->regexp, line, eol - line, 1, match,
+				   eflags);
 
 	return hit;
 }
diff --git a/t/t4061-diff-pickaxe.sh b/t/t4061-diff-pickaxe.sh
index 5929f2e..f0bf50b 100755
--- a/t/t4061-diff-pickaxe.sh
+++ b/t/t4061-diff-pickaxe.sh
@@ -14,7 +14,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m "A 4k file"
 '
-test_expect_failure '-G matches' '
+test_expect_success '-G matches' '
 	git diff --name-only -G "^0{4096}$" HEAD^ >out &&
 	test 4096-zeroes.txt = "$(cat out)"
 '
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 3bfc69c..060038c 100644
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
