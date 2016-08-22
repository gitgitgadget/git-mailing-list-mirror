Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0971F2018E
	for <e@80x24.org>; Mon, 22 Aug 2016 11:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754604AbcHVLYT (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 07:24:19 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45291 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754176AbcHVLYN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Aug 2016 07:24:13 -0400
X-AuditID: 12074413-aa3ff70000000955-fc-57bae09804ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 01.4C.02389.890EAB75; Mon, 22 Aug 2016 07:23:04 -0400 (EDT)
Received: from bagpipes.fritz.box (p5790719A.dip0.t-ipconnect.de [87.144.113.154])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7MBMnQV027076
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 Aug 2016 07:23:03 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/7] blame: actually use the diff opts parsed from the command line
Date:   Mon, 22 Aug 2016 13:22:46 +0200
Message-Id: <8192012a6bf725e0460522f9e67bab83b613127a.1471864378.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1471864378.git.mhagger@alum.mit.edu>
References: <cover.1471864378.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqLvmwa5wg4sbJC26rnQzWTT0XmG2
        2L24n9lixdU5zBa3V8xntvjR0sNssXlzO4sDu8ff9x+YPHbOusvusWBTqcez3j2MHhcvKXt8
        3iQXwBbFZZOSmpNZllqkb5fAlbH0RhtrwVm9inMNmg2Md1S6GDk5JARMJPpe3WbtYuTiEBLY
        yigx8fkyNgjnFJPE3RPXWUCq2AR0JRb1NDOB2CIC4hJvj89kByliFuhnkvjR0cXYxcjBISwQ
        JtG8PBWkhkVAVeLBpAlgvbwCURKNb7axQGyTk7i07QszSDmngIXE1hZlkLCQgLnEsx0n2Scw
        8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJERJSwjsYd52UO8QowMGo
        xMP74eDOcCHWxLLiytxDjJIcTEqivGatQCG+pPyUyozE4oz4otKc1OJDjBIczEoivKX3d4UL
        8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeB1AGgWLUtNTK9Iyc0oQ
        0kwcnCDDeYCGH7sHMry4IDG3ODMdIn+KUVFKnDcfJCEAksgozYPrhcX8K0ZxoFeEeWNBVvAA
        0wVc9yugwUxAg6//3w4yuCQRISXVwJjmx59icHvVP139JRpMKyeXmKls4d7W3zpPStnTfvN5
        qYk61k6Cb8J1XHdkqdZJRLzI76746HQ20cvd6Z/Ilmlfqjqm/N+hlrVs7dVnB3s/pMnu816/
        sPb8ndX8ya+kuZ7JTXOrtenonrPcIKZr73XbN++P3Mz82lbR7fNulrLlMdMbkQfn1ymxFGck
        GmoxFxUnAgDJYvsT1AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git blame" already parsed generic diff options from the command line
via diff_opt_parse(), but instead of passing the resulting xdl_opts to
xdi_diff(), it sent its own xdl_opts, which only reflected the values of
the self-parsed options "-w" and "--minimal". Instead, rely on
diff_opt_parse() to parse all of the diff options, including "-w" and
"--minimal", and pass the resulting xdl_opts to xdi_diff().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Somebody who knows more about how diff operations are configured
should please review this. I'm not certain that the change as
implemented won't have other unwanted side-effects, though of course
I checked that the test suite runs correctly.

 builtin/blame.c        |  11 ++--
 t/t4059-diff-indent.sh | 160 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+), 6 deletions(-)
 create mode 100755 t/t4059-diff-indent.sh

diff --git a/builtin/blame.c b/builtin/blame.c
index 7ec7823..cde2d15 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -48,11 +48,12 @@ static int show_root;
 static int reverse;
 static int blank_boundary;
 static int incremental;
-static int xdl_opts;
 static int abbrev = -1;
 static int no_whole_file_rename;
 static int show_progress;
 
+static struct rev_info revs;
+
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
 
@@ -137,11 +138,12 @@ struct progress_info {
 static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
 		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
 {
-	xpparam_t xpp = {0};
+	xpparam_t xpp;
 	xdemitconf_t xecfg = {0};
 	xdemitcb_t ecb = {NULL};
 
-	xpp.flags = xdl_opts;
+	memset(&xpp, 0, sizeof(xpp));
+	xpp.flags = revs.diffopt.xdl_opts;
 	xecfg.hunk_func = hunk_func;
 	ecb.priv = cb_data;
 	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
@@ -2517,7 +2519,6 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
-	struct rev_info revs;
 	const char *path;
 	struct scoreboard sb;
 	struct origin *o;
@@ -2548,8 +2549,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('l', NULL, &output_option, N_("Show long commit SHA1 (Default: off)"), OUTPUT_LONG_OBJECT_NAME),
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
-		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
-		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
 		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from <file> instead of calling git-rev-list")),
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
diff --git a/t/t4059-diff-indent.sh b/t/t4059-diff-indent.sh
new file mode 100755
index 0000000..8b6c7ef
--- /dev/null
+++ b/t/t4059-diff-indent.sh
@@ -0,0 +1,160 @@
+#!/bin/sh
+
+test_description='Test diff indent heuristic.
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+# Compare two diff outputs. Ignore "index" lines, because we don't
+# care about SHA-1s or file modes.
+compare_diff () {
+	sed -e "/^index /d" <"$1" >.tmp-1
+	sed -e "/^index /d" <"$2" >.tmp-2
+	test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
+test_expect_success 'diff: favor trailing blank lines' '
+	cat <<-\EOF >old &&
+	1
+	2
+	a
+
+	b
+	3
+	4
+	EOF
+
+	cat <<-\EOF >new &&
+	1
+	2
+	a
+
+	b
+	a
+
+	b
+	3
+	4
+	EOF
+
+	tr "_" " " <<-\EOF >expect &&
+	diff --git a/old b/new
+	--- a/old
+	+++ b/new
+	@@ -3,5 +3,8 @@
+	 a
+	_
+	 b
+	+a
+	+
+	+b
+	 3
+	 4
+	EOF
+
+	tr "_" " " <<-\EOF >expect-compacted &&
+	diff --git a/old b/new
+	--- a/old
+	+++ b/new
+	@@ -2,6 +2,9 @@
+	 2
+	 a
+	_
+	+b
+	+a
+	+
+	 b
+	 3
+	 4
+	EOF
+
+	test_must_fail git diff --no-index old new >out &&
+	compare_diff expect out &&
+
+	test_must_fail git diff --no-index --indent-heuristic old new >out-compacted &&
+	compare_diff expect-compacted out-compacted &&
+
+	test_must_fail git -c diff.indentHeuristic=true diff --no-index old new >out-compacted2 &&
+	compare_diff expect-compacted out-compacted2 &&
+
+	test_must_fail git diff --indent-heuristic --patience --no-index old new >out-compacted3 &&
+	compare_diff expect-compacted out-compacted3 &&
+
+	test_must_fail git diff --indent-heuristic --histogram --no-index old new >out-compacted4 &&
+	compare_diff expect-compacted out-compacted4
+'
+
+test_expect_success 'diff: keep functions together' '
+	cat <<-\EOF >old &&
+	1
+	2
+	/* function */
+	foo() {
+	    foo
+	}
+
+	3
+	4
+	EOF
+
+	cat <<-\EOF >new &&
+	1
+	2
+	/* function */
+	bar() {
+	    foo
+	}
+
+	/* function */
+	foo() {
+	    foo
+	}
+
+	3
+	4
+	EOF
+
+	tr "_" " " <<-\EOF >expect &&
+	diff --git a/old b/new
+	--- a/old
+	+++ b/new
+	@@ -1,6 +1,11 @@
+	 1
+	 2
+	 /* function */
+	+bar() {
+	+    foo
+	+}
+	+
+	+/* function */
+	 foo() {
+	     foo
+	 }
+	EOF
+
+	tr "_" " " <<-\EOF >expect-compacted &&
+	diff --git a/old b/new
+	--- a/old
+	+++ b/new
+	@@ -1,5 +1,10 @@
+	 1
+	 2
+	+/* function */
+	+bar() {
+	+    foo
+	+}
+	+
+	 /* function */
+	 foo() {
+	     foo
+	EOF
+
+	test_must_fail git diff --no-index old new >out &&
+	compare_diff expect out &&
+
+	test_must_fail git diff --no-index --indent-heuristic old new >out-compacted &&
+	compare_diff expect-compacted out-compacted
+'
+
+test_done
-- 
2.9.3

