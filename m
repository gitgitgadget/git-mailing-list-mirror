From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Let 'git <command> -h' show usage without a git dir
Date: Sun, 8 Nov 2009 01:11:52 -0600
Message-ID: <20091108071152.GA20741@progeny.tock>
References: <20080125173149.GA10287@edna.gwendoline.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerfried Fuchs <rhonda@debian.at>, 462557@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 08:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N71n3-0005jv-UV
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 08:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbZKHHCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 02:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbZKHHCG
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 02:02:06 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:55294 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZKHHCF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 02:02:05 -0500
Received: by gxk4 with SMTP id 4so2260562gxk.8
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 23:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ozhB4u90BvN0y1ubKJGGoP8cb9OE2swSxxqNOs8Vkqc=;
        b=iPX/rbQfIJpSoL4Zwh3yLSZs44oHOBU6yuTLqsi4COtOZJaZyDbGdhaHVgSYjUPPYy
         MB31Vp1feemVf1PFeA9y1DfNzROLXvkoCGQ4w3me9dU5E0B0H2mUnBiTy6xv+U4jqHBj
         jf7SpQ6EpkB8jMUGWB1FWab60CqOzvm16dZzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mK/q0PdW0g3PY+FZf+uTmUqkyujvwPxQ3jDds9808UTUp+5qOdtJx3FWZp2qtYGOGX
         tam/TB8ZoZ0w8f8sVneRAPA5cyusf5FL6SIgESHPKFTXrUT7hSANPwsEsi0lCvHGnCpL
         ruJj0xY57v+MTfEn2e2ED5ZBnQhuRG0qiCglk=
Received: by 10.150.234.30 with SMTP id g30mr10816954ybh.205.1257663729693;
        Sat, 07 Nov 2009 23:02:09 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm851666gxk.12.2009.11.07.23.02.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 23:02:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080125173149.GA10287@edna.gwendoline.at>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132386>

Hi,

Gerfried Fuchs wrote:

>  I really wonder why "git <command> -h" depends on being inside a
> repository. I noticed it with "git diff -h" (add, branch does that, too):
> 
> #v+
> ~/git> git tag -h
> usage: git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg> | -F <file>] <tagname> [<head>]
> ~/git> cd
> ~> git tag -h
> fatal: Not a git repository
> ~>
> #v-
 
This is a nuisance, I agree.

So how about something like this patch?  This just avoids looking for
a .git directory if the only option to a subcommand is '-h'.

-- %< --
Subject: [PATCH] Let 'git <command> -h' show usage without a git dir

There is no need for "git <command> -h" to depend on being inside
a repository.

Reported by Gerfried Fuchs through http://bugs.debian.org/462557

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Tested with all builtins and non-builtins written in C.  Some commands
do not show usage with '-h' and have been left unchanged.

 git.c            |   48 ++++++++++++++++++++++++++++++------------------
 http-fetch.c     |   13 ++++++++++++-
 index-pack.c     |    5 +++++
 pack-redundant.c |    5 +++++
 4 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/git.c b/git.c
index bd2c5fe..bfa9518 100644
--- a/git.c
+++ b/git.c
@@ -220,6 +220,11 @@ const char git_version_string[] = GIT_VERSION;
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE	(1<<2)
+/*
+ * Let RUN_SETUP, USE_PAGER, and NEED_WORK_TREE take effect even if
+ * passed the -h option.
+ */
+#define H_IS_NOT_HELP	(1<<3)
 
 struct cmd_struct {
 	const char *cmd;
@@ -229,21 +234,25 @@ struct cmd_struct {
 
 static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
-	int status;
+	int status, help;
 	struct stat st;
 	const char *prefix;
 
 	prefix = NULL;
-	if (p->option & RUN_SETUP)
-		prefix = setup_git_directory();
-
-	if (use_pager == -1 && p->option & RUN_SETUP)
-		use_pager = check_pager_config(p->cmd);
-	if (use_pager == -1 && p->option & USE_PAGER)
-		use_pager = 1;
+	help = argc == 2 && !(p->option & H_IS_NOT_HELP) &&
+		!strcmp(argv[1], "-h");
+	if (!help) {
+		if (p->option & RUN_SETUP && !help)
+			prefix = setup_git_directory();
+
+		if (use_pager == -1 && p->option & RUN_SETUP)
+			use_pager = check_pager_config(p->cmd);
+		if (use_pager == -1 && p->option & USE_PAGER)
+			use_pager = 1;
+	}
 	commit_pager_choice();
 
-	if (p->option & NEED_WORK_TREE)
+	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
 	trace_argv_printf(argv, "trace: built-in: git");
@@ -278,7 +287,8 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
-		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE },
+		{ "bisect--helper", cmd_bisect__helper,
+			RUN_SETUP | NEED_WORK_TREE },
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle },
@@ -288,12 +298,12 @@ static void handle_internal_command(int argc, const char **argv)
 			RUN_SETUP | NEED_WORK_TREE},
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "check-attr", cmd_check_attr, RUN_SETUP },
-		{ "cherry", cmd_cherry, RUN_SETUP },
+		{ "cherry", cmd_cherry, RUN_SETUP | H_IS_NOT_HELP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 		{ "clone", cmd_clone },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
-		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
+		{ "commit-tree", cmd_commit_tree, RUN_SETUP | H_IS_NOT_HELP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
@@ -304,7 +314,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "fast-export", cmd_fast_export, RUN_SETUP },
 		{ "fetch", cmd_fetch, RUN_SETUP },
 		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
-		{ "fetch--tool", cmd_fetch__tool, RUN_SETUP },
+		{ "fetch--tool", cmd_fetch__tool, RUN_SETUP | H_IS_NOT_HELP },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
 		{ "format-patch", cmd_format_patch, RUN_SETUP },
@@ -312,7 +322,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
+		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER | H_IS_NOT_HELP },
 		{ "help", cmd_help },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
@@ -325,9 +335,11 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file },
-		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
-		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "merge-ours", cmd_merge_ours, RUN_SETUP | H_IS_NOT_HELP },
+		{ "merge-recursive", cmd_merge_recursive,
+			RUN_SETUP | NEED_WORK_TREE | H_IS_NOT_HELP },
+		{ "merge-subtree", cmd_merge_recursive,
+			RUN_SETUP | NEED_WORK_TREE | H_IS_NOT_HELP },
 		{ "mktree", cmd_mktree, RUN_SETUP },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
@@ -368,7 +380,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
 		{ "verify-pack", cmd_verify_pack },
-		{ "show-ref", cmd_show_ref, RUN_SETUP },
+		{ "show-ref", cmd_show_ref, RUN_SETUP | H_IS_NOT_HELP },
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	};
 	int i;
diff --git a/http-fetch.c b/http-fetch.c
index e8f44ba..85f5338 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,6 +1,10 @@
 #include "cache.h"
+#include "exec_cmd.h"
 #include "walker.h"
 
+static const char http_fetch_usage[] = "git http-fetch "
+	"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
+
 int main(int argc, const char **argv)
 {
 	const char *prefix;
@@ -19,6 +23,13 @@ int main(int argc, const char **argv)
 	int get_verbosely = 0;
 	int get_recover = 0;
 
+	git_extract_argv0_path(argv[0]);
+
+	if (argc == 2 && !strcmp(argv[1], "-h")) {
+		fprintf(stderr, "%s\n", http_fetch_usage);
+		return 0;
+	}
+
 	prefix = setup_git_directory();
 
 	git_config(git_default_config, NULL);
@@ -45,7 +56,7 @@ int main(int argc, const char **argv)
 		arg++;
 	}
 	if (argc < arg + 2 - commits_on_stdin) {
-		usage("git http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url");
+		usage(http_fetch_usage);
 		return 1;
 	}
 	if (commits_on_stdin) {
diff --git a/index-pack.c b/index-pack.c
index b4f8278..4a7d405 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -882,6 +882,11 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
+	if (argc == 2 && !strcmp(argv[1], "-h")) {
+		fprintf(stderr, "usage: %s\n", index_pack_usage);
+		return 0;
+	}
+
 	/*
 	 * We wish to read the repository's config file if any, and
 	 * for that it is necessary to call setup_git_directory_gently().
diff --git a/pack-redundant.c b/pack-redundant.c
index 69a7ab2..24d59f9 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -603,6 +603,11 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
+	if (argc == 2 && !strcmp(argv[1], "-h")) {
+		fprintf(stderr, "usage: %s\n", pack_redundant_usage);
+		return 0;
+	}
+
 	setup_git_directory();
 
 	for (i = 1; i < argc; i++) {
-- 
1.6.5.2
