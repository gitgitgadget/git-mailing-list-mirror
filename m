Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC5C20193
	for <e@80x24.org>; Thu, 11 Aug 2016 22:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbcHKW7v (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 18:59:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:51539 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbcHKW7t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 18:59:49 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP; 11 Aug 2016 15:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,507,1464678000"; 
   d="scan'208";a="1034123560"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2016 15:59:49 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v5 2/3] diff: add --diff-line-prefix option for passing in a prefix
Date:	Thu, 11 Aug 2016 15:59:45 -0700
Message-Id: <20160811225946.18381-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.9.2.872.g367ebef.dirty
In-Reply-To: <20160811225946.18381-1-jacob.e.keller@intel.com>
References: <20160811225946.18381-1-jacob.e.keller@intel.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Add an option to pass additional prefix to be displayed before diff
output. This feature will be used in a following patch to output correct
--graph prefix when using a child_process/run_command interface for
submodules.

The prefix shall come first prior to any other prefix associated with
the --graph option or other source.

Add tests for the same.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
- v5
* Changed name to --diff-line-prefix since --line-prefix might indicate
  for other commands such as log, when it only modifies diff output

 Documentation/diff-options.txt                     |  3 +++
 diff.c                                             | 16 ++++++++++--
 diff.h                                             |  1 +
 t/t4013-diff-various.sh                            |  6 +++++
 ...diff_--diff-line-prefix=-->_master_master^_side | 29 ++++++++++++++++++++++
 .../diff.diff_--diff-line-prefix_--cached_--_file0 | 15 +++++++++++
 6 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 t/t4013/diff.diff_--diff-line-prefix=-->_master_master^_side
 create mode 100644 t/t4013/diff.diff_--diff-line-prefix_--cached_--_file0

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 705a87394200..f924f57d4f62 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -569,5 +569,8 @@ endif::git-format-patch[]
 --no-prefix::
 	Do not show any source or destination prefix.
 
+--diff-line-prefix=<prefix>::
+	Prepend an additional prefix to every line of diff output.
+
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
diff --git a/diff.c b/diff.c
index ae069c303077..73dda58c440c 100644
--- a/diff.c
+++ b/diff.c
@@ -1167,10 +1167,18 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
 const char *diff_line_prefix(struct diff_options *opt)
 {
 	struct strbuf *msgbuf;
-	if (!opt->output_prefix)
-		return "";
+
+	if (!opt->output_prefix) {
+		if (opt->line_prefix)
+			return opt->line_prefix;
+		else
+			return "";
+	}
 
 	msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+	/* line prefix must be printed before the output_prefix() */
+	if (opt->line_prefix)
+		strbuf_insert(msgbuf, 0, opt->line_prefix, strlen(opt->line_prefix));
 	return msgbuf->buf;
 }
 
@@ -3966,6 +3974,10 @@ int diff_opt_parse(struct diff_options *options,
 		options->a_prefix = optarg;
 		return argcount;
 	}
+	else if ((argcount = parse_long_opt("diff-line-prefix", av, &optarg))) {
+		options->line_prefix = optarg;
+		return argcount;
+	}
 	else if ((argcount = parse_long_opt("dst-prefix", av, &optarg))) {
 		options->b_prefix = optarg;
 		return argcount;
diff --git a/diff.h b/diff.h
index 49e4aaafb2da..83d0b1ae8580 100644
--- a/diff.h
+++ b/diff.h
@@ -115,6 +115,7 @@ struct diff_options {
 	const char *pickaxe;
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
+	const char *line_prefix;
 	unsigned flags;
 	unsigned touched_flags;
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 94ef5000e787..5204645eb92b 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -306,6 +306,8 @@ diff --no-index --name-status dir2 dir
 diff --no-index --name-status -- dir2 dir
 diff --no-index dir dir3
 diff master master^ side
+# Can't use spaces...
+diff --diff-line-prefix=--> master master^ side
 diff --dirstat master~1 master~2
 diff --dirstat initial rearrange
 diff --dirstat-by-file initial rearrange
@@ -325,6 +327,10 @@ test_expect_success 'diff --cached -- file on unborn branch' '
 	git diff --cached -- file0 >result &&
 	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached_--_file0" result
 '
+test_expect_success 'diff --diff-line-prefix with spaces' '
+	git diff --diff-line-prefix="| | | " --cached -- file0 >result &&
+	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--diff-line-prefix_--cached_--_file0" result
+'
 
 test_expect_success 'diff-tree --stdin with log formatting' '
 	cat >expect <<-\EOF &&
diff --git a/t/t4013/diff.diff_--diff-line-prefix=-->_master_master^_side b/t/t4013/diff.diff_--diff-line-prefix=-->_master_master^_side
new file mode 100644
index 000000000000..5cc90f27c2d9
--- /dev/null
+++ b/t/t4013/diff.diff_--diff-line-prefix=-->_master_master^_side
@@ -0,0 +1,29 @@
+$ git diff --diff-line-prefix=--> master master^ side
+-->diff --cc dir/sub
+-->index cead32e,7289e35..992913c
+-->--- a/dir/sub
+-->+++ b/dir/sub
+-->@@@ -1,6 -1,4 +1,8 @@@
+-->  A
+-->  B
+--> +C
+--> +D
+--> +E
+--> +F
+-->+ 1
+-->+ 2
+-->diff --cc file0
+-->index b414108,f4615da..10a8a9f
+-->--- a/file0
+-->+++ b/file0
+-->@@@ -1,6 -1,6 +1,9 @@@
+-->  1
+-->  2
+-->  3
+--> +4
+--> +5
+--> +6
+-->+ A
+-->+ B
+-->+ C
+$
diff --git a/t/t4013/diff.diff_--diff-line-prefix_--cached_--_file0 b/t/t4013/diff.diff_--diff-line-prefix_--cached_--_file0
new file mode 100644
index 000000000000..f41ba4d36aa1
--- /dev/null
+++ b/t/t4013/diff.diff_--diff-line-prefix_--cached_--_file0
@@ -0,0 +1,15 @@
+| | | diff --git a/file0 b/file0
+| | | new file mode 100644
+| | | index 0000000..10a8a9f
+| | | --- /dev/null
+| | | +++ b/file0
+| | | @@ -0,0 +1,9 @@
+| | | +1
+| | | +2
+| | | +3
+| | | +4
+| | | +5
+| | | +6
+| | | +A
+| | | +B
+| | | +C
-- 
2.9.2.872.g367ebef.dirty

