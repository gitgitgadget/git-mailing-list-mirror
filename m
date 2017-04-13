Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5937C20960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755320AbdDMTWR (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:22:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:55380 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbdDMTWP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:22:15 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI5rO-1cushK0kow-003rjd; Thu, 13
 Apr 2017 21:22:00 +0200
Date:   Thu, 13 Apr 2017 21:21:58 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Gergely Nagy <ngg@tresorit.com>,
        Aaron Teague <ateague@apple.com>, jeremyhu@apple.com
Subject: [PATCH 1/1] difftool: fix use-after-free
In-Reply-To: <cover.1492111288.git.johannes.schindelin@gmx.de>
Message-ID: <c8a5e41b77f132272eb9a1dc4142279499a54641.1492111288.git.johannes.schindelin@gmx.de>
References: <cover.1492111288.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kEGVW/xGRc8p/w6uaCBSLxmmBuMAhnEfCmDEbkB3o7zv7VBY1oE
 hQ+S9PXNZhjBwgbd010zcwJh3uwoUtplONgGhIhCReVZ8KTSktuD6tbCqoF/5kcnz/bITgT
 ftrc/JPoLfUeo0GUwKgFrNFDy6yIwIW5IZCpby9AwbxcsNrnC++PxXWJbip//An8PSyzOD+
 h2R5Fwjez/cYd8WA+99iA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jsqMNk/3dWs=:nvD9VsPO3aeiPP73Rm+Sow
 E++shXtGvLnJBSkzXaENHus1EYmDSrhmMRo2GpKuJY6OYTVz16NnzM/5YBCfcwfihVMvVYbXR
 y4u2GgPRpCNeOwYH3Hmwh8jhmBXl4iin2xI2Io1GQU9hVIi8fts5JEAD+LohteqUXSDAHFLWE
 23ZGuIttue2rkrcPXVd6nCLFWY7okNNa4cN+ZcxqymOwXoXPljfRef2Itky0gXIZakO9Ee27q
 QrKOXvmuBqtCUdBaF6bYOZRQIRuLnktkFA5pbtRIBfaBd2c3fP9xz0Rk0bFSWdIaRA8IKOfla
 lho9a1woY3O8ZHhDsT4KQNys1+HDSWmVopImFd3qSYejYBIWB4gzswGsdHXh0ogGTVFtZsbY+
 NCYSYGAcqwW6mr0ycbc3PWxozfXlr0oj8nn7opVucyu249AcNEB7gv9xjWBPDj1Oz+senCmnH
 WrlK8zkiLrs8oMAIjrU04NjTHNjIHa3N7k/qKNMznGLoOP6SYY0033PSHDRI1FUkclzy1pICk
 //uX/IghdDw+hlirPqOdSnSsN92Thl4Bj29i2vvFMAPawHS+Tl73SeE9XLZcXfQFTEwahbSgD
 H6YZI0rPvPvsgQWJHR5AAPWQHFJRnx7+OI2FBFOmBVVmZh8yIMs2VYAfBD6r5q+eoARiIS/Ny
 RMD48W5GsoCFwyCMPa+goxLL5AcN4Tl4mDldnMzFSaCZe7XZySLm8XMTR9AAMW5Hb5R8BqZ9i
 lsQXWok+pu216c4LGiyw0irz0G2NBeUOPjYKQImJJA08t2n+Ktes3qOYk9UxUx13w9GEBCxCr
 xlKku2o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The left and right base directories were pointed to the buf field of
two strbufs, which were subject to change.

A contrived test case shows the problem where a file with a long enough
name to force the strbuf to grow is up-to-date (hence the code path is
used where the work tree's version of the file is reused), and then a
file that is not up-to-date needs to be written (hence the code path is
used where checkout_entry() uses the previously recorded base_dir that
is invalid by now).

Let's just copy the base_dir strings for use with checkout_entry(),
never touch them until the end, and release them then. This is an easily
verifiable fix (as opposed to the next-obvious alternative: to re-set
base_dir after every loop iteration).

This fixes https://github.com/git-for-windows/git/issues/1124

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/difftool.c  |  7 +++++--
 t/t7800-difftool.sh | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 25e54ad3edb..568294aac01 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -305,6 +305,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct strbuf rpath = STRBUF_INIT, buf = STRBUF_INIT;
 	struct strbuf ldir = STRBUF_INIT, rdir = STRBUF_INIT;
 	struct strbuf wtdir = STRBUF_INIT;
+	char *lbase_dir, *rbase_dir;
 	size_t ldir_len, rdir_len, wtdir_len;
 	struct cache_entry *ce = xcalloc(1, sizeof(ce) + PATH_MAX + 1);
 	const char *workdir, *tmp;
@@ -339,11 +340,11 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	memset(&wtindex, 0, sizeof(wtindex));
 
 	memset(&lstate, 0, sizeof(lstate));
-	lstate.base_dir = ldir.buf;
+	lstate.base_dir = lbase_dir = xstrdup(ldir.buf);
 	lstate.base_dir_len = ldir.len;
 	lstate.force = 1;
 	memset(&rstate, 0, sizeof(rstate));
-	rstate.base_dir = rdir.buf;
+	rstate.base_dir = rbase_dir = xstrdup(rdir.buf);
 	rstate.base_dir_len = rdir.len;
 	rstate.force = 1;
 
@@ -626,6 +627,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 
 finish:
 	free(ce);
+	free(lbase_dir);
+	free(rbase_dir);
 	strbuf_release(&ldir);
 	strbuf_release(&rdir);
 	strbuf_release(&wtdir);
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 0e7f30db2d9..7f09867478c 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -393,6 +393,25 @@ test_expect_success 'setup change in subdirectory' '
 	git commit -m "modified both"
 '
 
+test_expect_success 'difftool -d with growing paths' '
+	a=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
+	git init growing &&
+	(
+		cd growing &&
+		echo "test -f \"\$2/b\"" | write_script .git/test-for-b.sh &&
+		one=$(printf 1 | git hash-object -w --stdin) &&
+		two=$(printf 2 | git hash-object -w --stdin) &&
+		git update-index --add \
+			--cacheinfo 100644,$one,$a --cacheinfo 100644,$two,b &&
+		tree1=$(git write-tree) &&
+		git update-index --add \
+			--cacheinfo 100644,$two,$a --cacheinfo 100644,$one,b &&
+		tree2=$(git write-tree) &&
+		git checkout -- $a &&
+		git difftool -d --extcmd .git/test-for-b.sh $tree1 $tree2
+	)
+'
+
 run_dir_diff_test () {
 	test_expect_success "$1 --no-symlinks" "
 		symlinks=--no-symlinks &&
-- 
2.12.2.windows.2.1.g7df5db8d31e
