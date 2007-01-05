From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 14:39:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701051439060.3661@woody.osdl.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
 <20070105193958.GE8753@spearce.org> <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701051354590.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Chris Lee <chris133@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 05 23:40:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2xjN-0003It-IC
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 23:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbXAEWkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 17:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbXAEWkF
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 17:40:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38542 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbXAEWkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 17:40:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l05MdtWi011982
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Jan 2007 14:39:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l05MdsDf004693;
	Fri, 5 Jan 2007 14:39:54 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0701051354590.3661@woody.osdl.org>
X-Spam-Status: No, hits=-3.67 required=5 tests=AWL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36034>



On Fri, 5 Jan 2007, Linus Torvalds wrote:
> 
> Heh. Maybe we should just make the default the other way? It's probably 
> pretty easy to find any users that suddenly start segfaulting ;)

This seems to pass all the tests, at least.

(But I didn't test the SVN stuff, since I don't have perl::SVN installed)

		Linus
---
diff --git a/builtin-branch.c b/builtin-branch.c
index d3df5a5..0b662a8 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -441,6 +441,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	    (rename && force_create))
 		usage(builtin_branch_usage);
 
+	if (verbose)
+		save_commit_buffer = 1;
+
 	head = xstrdup(resolve_ref("HEAD", head_sha1, 0, NULL));
 	if (!head)
 		die("Failed to resolve HEAD as a valid ref.");
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 24cb2d7..212ad59 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -67,6 +67,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	static struct rev_info *opt = &log_tree_opt;
 	int read_stdin = 0;
 
+	save_commit_buffer = 1;
 	init_revisions(opt, prefix);
 	git_config(git_default_config); /* no "diff" UI options */
 	nr_sha1 = 0;
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 87d3d63..4053651 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -251,6 +251,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	unsigned char head_sha1[20];
 	const char *current_branch;
 
+	save_commit_buffer = 1;
 	git_config(fmt_merge_msg_config);
 
 	while (argc > 1) {
diff --git a/builtin-log.c b/builtin-log.c
index a59b4ac..ac95921 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -22,6 +22,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 {
 	int i;
 
+	save_commit_buffer = 1;
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	rev->verbose_header = 1;
@@ -372,6 +373,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.ignore_merges = 1;
 	rev.diffopt.msg_sep = "";
 	rev.diffopt.recursive = 1;
+	save_commit_buffer = 1;
 
 	rev.extra_headers = extra_headers;
 
@@ -569,6 +571,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	const char *limit = NULL;
 	int verbose = 0;
 
+	save_commit_buffer = 1;
 	if (argc > 1 && !strcmp(argv[1], "-v")) {
 		verbose = 1;
 		argc--;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index c67f2fa..53d1b29 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -586,6 +586,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int dense = 1;
 	int reflog = 0;
 
+	save_commit_buffer = 1;
 	git_config(git_show_branch_config);
 
 	/* If nothing is specified, try the default first */
diff --git a/commit.c b/commit.c
index 2a58175..660d365 100644
--- a/commit.c
+++ b/commit.c
@@ -4,7 +4,7 @@
 #include "pkt-line.h"
 #include "utf8.h"
 
-int save_commit_buffer = 1;
+int save_commit_buffer = 0;
 
 struct sort_node
 {
diff --git a/merge-recursive.c b/merge-recursive.c
index bac16f5..b98ed1a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1286,6 +1286,7 @@ int main(int argc, char *argv[])
 	const char *branch1, *branch2;
 	struct commit *result, *h1, *h2;
 
+	save_commit_buffer = 1;
 	git_config(git_default_config); /* core.filemode */
 	original_index_file = getenv(INDEX_ENVIRONMENT);
 
diff --git a/revision.c b/revision.c
index 6e4ec46..aa10088 100644
--- a/revision.c
+++ b/revision.c
@@ -737,6 +737,7 @@ static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token
 		opt->pattern_tail = &(opt->pattern_list);
 		opt->regflags = REG_NEWLINE;
 		revs->grep_filter = opt;
+		save_commit_buffer = 1;
 	}
 	append_grep_pattern(revs->grep_filter, ptn,
 			    "command line", 0, what);
