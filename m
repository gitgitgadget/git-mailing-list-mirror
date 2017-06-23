Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3F820401
	for <e@80x24.org>; Fri, 23 Jun 2017 10:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbdFWKoc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 06:44:32 -0400
Received: from hahler.de ([188.40.33.212]:41161 "EHLO elfe.thequod.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754354AbdFWKoc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 06:44:32 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jun 2017 06:44:31 EDT
Received: from localhost (amavis [10.122.1.24])
        by elfe.thequod.de (Postfix) with ESMTP id B845E62149
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
        x-mailer:message-id:date:date:subject:subject:from:from:received
        :received:received; s=postfix2; t=1498214188; bh=wDK5KmwZBEy7RWe
        JF4+eaK+WKRAxwWoh4nJ+BDwS118=; b=eDCgGU5EuqrQ7b8lGW4s65eCV16dksm
        qV2UGVgiJC0aIunc0YFfO+1dD/w6CARIaFudTM+TE9wBHWufVjTaWk1U8PbqPp2D
        5Eod/DEkrTXoewDpUBLdXr70SHkqpgNLAEBncDSlOsDlzlJaKN3Gp5oOpjB1yYuj
        7cg/UZF9mkcE=
Received: from elfe.thequod.de ([10.122.1.25])
        by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
        with ESMTP id 0tkjs5tQVWuq for <git@vger.kernel.org>;
        Fri, 23 Jun 2017 12:36:28 +0200 (CEST)
From:   Daniel Hahler <git@thequod.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Daniel Hahler <git@thequod.de>
Subject: [PATCH] xdiff: trim common tail with -U0 after diff
Date:   Fri, 23 Jun 2017 12:36:12 +0200
Message-Id: <20170623103612.4694-1-git@thequod.de>
X-Mailer: git-send-email 2.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When -U0 is used, trim_common_tail should be called after `xdl_diff`, so
that `--indent-heuristic` (and other diff processing) works as expected.

It also removes the check for `!(xecfg->flags & XDL_EMIT_FUNCCONTEXT)`
added in e0876bca4, which does not appear to be necessary anymore after
moving the trimming down.

This only adds a test to t4061-diff-indent.sh, but should also have one for
normal (i.e. non-experimental) diff mode probably?!

Ref: https://github.com/tomtom/quickfixsigns_vim/issues/74#issue-237900460
---
 t/t4061-diff-indent.sh | 15 +++++++++++++++
 xdiff-interface.c      |  7 ++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 2affd7a10..df3151393 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -116,6 +116,16 @@ test_expect_success 'prepare' '
 	 4
 	EOF
 
+	cat <<-\EOF >spaces-compacted-U0-expect &&
+	diff --git a/spaces.txt b/spaces.txt
+	--- a/spaces.txt
+	+++ b/spaces.txt
+	@@ -4,0 +5,3 @@ a
+	+b
+	+a
+	+
+	EOF
+
 	tr "_" " " <<-\EOF >functions-expect &&
 	diff --git a/functions.c b/functions.c
 	--- a/functions.c
@@ -184,6 +194,11 @@ test_expect_success 'diff: --indent-heuristic with --histogram' '
 	compare_diff spaces-compacted-expect out-compacted4
 '
 
+test_expect_success 'diff: --indent-heuristic with -U0' '
+	git diff -U0 --indent-heuristic old new -- spaces.txt >out-compacted5 &&
+	compare_diff spaces-compacted-U0-expect out-compacted5
+'
+
 test_expect_success 'diff: ugly functions' '
 	git diff --no-indent-heuristic old new -- functions.c >out &&
 	compare_diff functions-expect out
diff --git a/xdiff-interface.c b/xdiff-interface.c
index d3f78ca2a..a7e0e3583 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -125,16 +125,17 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b)
 
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *xecb)
 {
+	int ret;
 	mmfile_t a = *mf1;
 	mmfile_t b = *mf2;
 
 	if (mf1->size > MAX_XDIFF_SIZE || mf2->size > MAX_XDIFF_SIZE)
 		return -1;
 
-	if (!xecfg->ctxlen && !(xecfg->flags & XDL_EMIT_FUNCCONTEXT))
+	ret = xdl_diff(&a, &b, xpp, xecfg, xecb);
+	if (ret && !xecfg->ctxlen)
 		trim_common_tail(&a, &b);
-
-	return xdl_diff(&a, &b, xpp, xecfg, xecb);
+	return ret;
 }
 
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
-- 
2.13.1

