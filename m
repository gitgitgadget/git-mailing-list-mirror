Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6E21F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757426AbcIHH72 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:59:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:58109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbcIHH71 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:59:27 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MC4y8-1bqjwe3rcm-008t4V; Thu, 08 Sep 2016 09:59:21
 +0200
Date:   Thu, 8 Sep 2016 09:59:06 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 3/3] Use the newly-introduced regexec_buf() function
In-Reply-To: <cover.1473321437.git.johannes.schindelin@gmx.de>
Message-ID: <d0537819a3676fda6928e7ad3282aa71643f0755.1473321437.git.johannes.schindelin@gmx.de>
References: <cover.1473319844.git.johannes.schindelin@gmx.de> <cover.1473321437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lrGhkMdn/S3gFoCcXeUFkhPKCVXmye/7kR/30jCIAsLqdsFVFrb
 eMLkaQURuiG/levbazcrs8Zm9CEEcUHNAHUCIuv373j1Mr8hBzrEq8rV0ui+FtW9mlKZlm1
 PBpn5pwctP2Sl5SeryArwJysiJ4pvJEjvYCOEwU+epAqyXNhd1sB62tt0pqgcRCkLuAd+ZV
 2ZjYogG2wcGScmnDbcWaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i9alsOQ/Yoc=:ntaJxwtZMw+fS11QG0i1J5
 +YPTAjOBtE+Aw4ZtSZjYMsuxafzgAYMjxDFDOWTjCG+JMEr76XMa9Mq50RkB2ky1V+eipvroc
 LFve/kwBnoxTIaFUBqS2S8u96vABYZvl/UpY0UrKY8lN0ez6Y/qpvannnFG1okdx8X1+JJod2
 meJgwsGD3SXAC1key+RTc5AgcQ5SexvE0Rum1Oi83jCtld6Y0/9wBkLqpW/KsJTsSaHBo/Nyz
 KfV07eAAHdu3gvxBoJgQF/3xZps1SHq68OHBJq6NQjN1oC0YEcgKvBv1wOu0u6A4LWBTk7OTZ
 5dKrJKJmJwsFSvB/2XIXjw5g88zMFW3cRYn6/nhg9/MF3aen+Uq1lTJv+6UmdcWHYaLPJ3qoS
 LYBvGkjts3ckdFSozvROC4iThiB+kau6gmGY5myFPsfFbnPs/O1Caj3AZLYXBZbPgNtTNLYe6
 dTF5kEygBgBkW1z41vaS7cvYU7EVp+TxelyC62bAlj78Nr0giQm04RFbsYgloKoJcW7SM1TCV
 gjEOJxsSwd8D289ZDkPISjdIv57oviIFoe44H1dPE4KPE9i+yTWJJo6pF2vs3zGu8IR3fhstL
 dkmuxGYSfQIejhm/u2QLcejKiNNySnjT15Ymh+tB/SYgkujFu3g7M3lvvyjiqT6beGpb/bg1Z
 /cOMzWWaSkDgMJH/jnWKjK2Ac0Vl++S5jPuyJtxPPqhwNMsindWO3d7kcf0EYHcP62lps5lmY
 NV4VkfJpCj2Z16fntwjFgP/l9kJ5zcY2PdVBHTRMdlJ60fd6KdOpPz3U7sYroZesC75QLBye0
 poOIZcL
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
 t/t4061-diff-pickaxe.sh |  2 +-
 xdiff-interface.c       | 13 ++++---------
 4 files changed, 15 insertions(+), 21 deletions(-)

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
