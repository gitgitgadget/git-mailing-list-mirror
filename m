From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] ls-files: fix pathspec display on error
Date: Mon, 1 Aug 2011 23:19:58 +0200
Message-ID: <20110801211958.GA23238@toss>
References: <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
 <b535c21e1becdf8aeeb1d3f8ddaa7f5415830844.1311767679.git.git@drmicha.warpmail.net>
 <20110729130330.GA31941@toss.lan>
 <7vipqiknjh.fsf@alter.siamese.dyndns.org>
 <20110801180320.GA17556@toss>
 <7vhb60j3e1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	rrt@sc3d.org, john@szakmeister.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 23:20:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnzuO-0002qm-SK
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 23:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab1HAVUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 17:20:18 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:47167 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752464Ab1HAVUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 17:20:05 -0400
Received: from localhost (p5B22CD28.dip.t-dialin.net [91.34.205.40])
	by bsmtp.bon.at (Postfix) with ESMTP id BD433130044;
	Mon,  1 Aug 2011 23:19:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhb60j3e1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178416>

The following sequence of commands reveals an issue with error
reporting of relative paths:

 $ mkdir sub
 $ cd sub
 $ git ls-files --error-unmatch ../bbbbb
 error: pathspec 'b' did not match any file(s) known to git.
 $ git commit --error-unmatch ../bbbbb
 error: pathspec 'b' did not match any file(s) known to git.

This bug is visible only if the normalized path (i.e., the relative
path from the repository root) is longer than the prefix.
Otherwise, the code skips over the normalized path and reads from
an unused memory location which still contains a leftover of the
original command line argument.

So instead, use the existing facilities to deal with relative paths
correctly.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
On Mon, Aug 01, 2011 at 01:14:14PM -0700, Junio C Hamano wrote:
> 
> Thanks.  This should be a part of the primary patch, not a
> standalone patch.

Guilty on all counts! No changes except to address your comments.
Thanks for reviewing.

Clemens

 builtin/checkout.c           |    2 +-
 builtin/commit.c             |    2 +-
 builtin/ls-files.c           |   11 +++++--
 cache.h                      |    2 +-
 quote.c                      |    8 +++-
 t/t3005-ls-files-relative.sh |   70 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 8 deletions(-)
 create mode 100755 t/t3005-ls-files-relative.sh

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d647a31..a3380d9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -231,7 +231,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, ps_matched);
 	}
 
-	if (report_path_error(ps_matched, pathspec, 0))
+	if (report_path_error(ps_matched, pathspec, NULL, -1))
 		return 1;
 
 	/* "checkout -m path" to recreate conflicted state */
diff --git a/builtin/commit.c b/builtin/commit.c
index cb73857..c2db12a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -274,7 +274,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 			item->util = item; /* better a valid pointer than a fake one */
 	}
 
-	return report_path_error(m, pattern, prefix ? strlen(prefix) : 0);
+	return report_path_error(m, pattern, prefix, -1);
 }
 
 static void add_remove_files(struct string_list *list)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 0e98bff..fef5642 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -353,11 +353,14 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 	}
 }
 
-int report_path_error(const char *ps_matched, const char **pathspec, int prefix_len)
+int report_path_error(const char *ps_matched, const char **pathspec,
+		const char *prefix, int prefix_len)
 {
 	/*
 	 * Make sure all pathspec matched; otherwise it is an error.
 	 */
+	struct strbuf sb = STRBUF_INIT;
+	const char *name;
 	int num, errors = 0;
 	for (num = 0; pathspec[num]; num++) {
 		int other, found_dup;
@@ -382,10 +385,12 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 		if (found_dup)
 			continue;
 
+		name = quote_path_relative(pathspec[num], -1, &sb, prefix);
 		error("pathspec '%s' did not match any file(s) known to git.",
-		      pathspec[num] + prefix_len);
+		      name);
 		errors++;
 	}
+	strbuf_release(&sb);
 	return errors;
 }
 
@@ -577,7 +582,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	if (ps_matched) {
 		int bad;
-		bad = report_path_error(ps_matched, pathspec, prefix_len);
+		bad = report_path_error(ps_matched, pathspec, prefix, prefix_len);
 		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
 
diff --git a/cache.h b/cache.h
index 1b5d861..dd3edaa 100644
--- a/cache.h
+++ b/cache.h
@@ -1189,7 +1189,7 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 #define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
 
 /* ls-files */
-int report_path_error(const char *ps_matched, const char **pathspec, int prefix_offset);
+int report_path_error(const char *ps_matched, const char **pathspec, const char *prefix, int prefix_len);
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
diff --git a/quote.c b/quote.c
index 63d3b01..532fd3b 100644
--- a/quote.c
+++ b/quote.c
@@ -325,8 +325,12 @@ static const char *path_relative(const char *in, int len,
 
 	if (len < 0)
 		len = strlen(in);
-	if (prefix && prefix_len < 0)
-		prefix_len = strlen(prefix);
+	if (prefix_len < 0) {
+		if (prefix)
+			prefix_len = strlen(prefix);
+		else
+			prefix_len = 0;
+	}
 
 	off = 0;
 	i = 0;
diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
new file mode 100755
index 0000000..3c3ff5e
--- /dev/null
+++ b/t/t3005-ls-files-relative.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='ls-files tests with relative paths
+
+This test runs git ls-files with various relative path arguments.
+'
+
+. ./test-lib.sh
+
+new_line='
+'
+sq=\'
+
+test_expect_success 'prepare' '
+	: >never-mind-me &&
+	git add never-mind-me &&
+	mkdir top &&
+	(
+		cd top &&
+		mkdir sub &&
+		x="x xa xbc xdef xghij xklmno" &&
+		y=$(echo "$x" | tr x y) &&
+		touch $x &&
+		touch $y &&
+		cd sub &&
+		git add ../x*
+	)
+'
+
+test_expect_success 'ls-files with mixed levels' '
+	(
+		cd top/sub &&
+		cat >expect <<-EOF &&
+		../../never-mind-me
+		../x
+		EOF
+		git ls-files $(cat expect) >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ls-files -c' '
+	(
+		cd top/sub &&
+		for f in ../y*
+		do
+			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
+		done >expect &&
+		echo "Did you forget to ${sq}git add${sq}?" >>expect &&
+		ls ../x* >>expect &&
+		(git ls-files -c --error-unmatch ../[xy]* || true) >actual 2>&1 &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'ls-files -o' '
+	(
+		cd top/sub &&
+		for f in ../x*
+		do
+			echo "error: pathspec ${sq}${f}${sq} did not match any file(s) known to git."
+		done >expect &&
+		echo "Did you forget to ${sq}git add${sq}?" >>expect &&
+		ls ../y* >>expect &&
+		(git ls-files -o --error-unmatch ../[xy]* || true) >actual 2>&1 &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
1.7.3.1.105.g84915
