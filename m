From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 2/3] Move pathspec validation into interactive_add
Date: Sun, 25 Nov 2007 14:15:41 +0100
Message-ID: <1195996542-86074-3-git-send-email-win@wincent.com>
References: <1195996542-86074-1-git-send-email-win@wincent.com>
 <1195996542-86074-2-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 14:16:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwHLM-0004BD-Kx
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 14:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbXKYNP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 08:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbXKYNP7
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 08:15:59 -0500
Received: from wincent.com ([72.3.236.74]:36256 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbXKYNP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 08:15:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAPDFhQU012499;
	Sun, 25 Nov 2007 07:15:48 -0600
X-Mailer: git-send-email 1.5.3.6.1994.g0a56
In-Reply-To: <1195996542-86074-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65969>

Simplify git-add--interactive by moving the pathspec validation into the
interactive_add() function of builtin-add. We can do this because
builtin-add is the only caller of git-add--interactive.

The validate_pathspec() function added by this commit is based on a
sample posted to the mailing list by Junio Hamano.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 builtin-add.c             |   33 +++++++++++++++++++++++++++++----
 builtin-commit.c          |    2 +-
 commit.h                  |    2 +-
 git-add--interactive.perl |   12 ++----------
 4 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index dd895df..870f4a1 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -135,12 +135,37 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-int interactive_add(int argc, const char **argv)
+static int validate_pathspec(const char *prefix, const char **patterns)
+{
+	int i, ret = 0;
+	char *m;
+	if (!patterns || !*patterns)
+		return 0;
+	if (read_cache() < 0)
+		die("index file corrupt");
+	(void)get_pathspec(prefix, patterns);
+	for (i = 0; patterns[i]; i++)
+		;
+	m = xcalloc(1, i);
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		(void)pathspec_match(patterns, m, ce->name, 0);
+	}
+	ret = report_path_error(m, patterns, prefix ? strlen(prefix) : 0);
+	free(m);
+	return ret;
+}
+
+int interactive_add(const char *prefix, int argc, const char **argv)
 {
 	int status;
-	const char **args = xmalloc(sizeof(const char *) * (argc + 1));
+	const char **args;
+	if ((status = validate_pathspec(prefix, argv)))
+		return status;
+	args = xmalloc(sizeof(const char *) * (argc + 2));
 	args[0] = "add--interactive";
-	memcpy((void *)args + sizeof(const char *), argv, sizeof(const char *) * argc);
+	memcpy((void *)args + sizeof(const char *),
+	    argv, sizeof(const char *) * argc);
 	args[argc + 1] = NULL;
 
 	status = run_command_v_opt(args, RUN_GIT_CMD);
@@ -176,7 +201,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
 	if (add_interactive)
-		exit(interactive_add(argc, argv));
+		exit(interactive_add(prefix, argc, argv));
 
 	git_config(git_default_config);
 
diff --git a/builtin-commit.c b/builtin-commit.c
index 5d27102..95d1c0d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -165,7 +165,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	const char **pathspec = NULL;
 
 	if (interactive) {
-		interactive_add(argc, argv);
+		interactive_add(prefix, argc, argv);
 		commit_style = COMMIT_AS_IS;
 		return get_index_file();
 	}
diff --git a/commit.h b/commit.h
index 9f0765b..dc6fe31 100644
--- a/commit.h
+++ b/commit.h
@@ -113,7 +113,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 
 int in_merge_bases(struct commit *, struct commit **, int);
 
-extern int interactive_add(int argc, const char **argv);
+extern int interactive_add(const char *prefix, int argc, const char **argv);
 extern int rerere(void);
 
 static inline int single_parent(struct commit *commit)
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 15b2c9f..381bcbe 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -56,17 +56,9 @@ sub list_modified {
 	my ($only) = @_;
 	my (%data, @return);
 	my ($add, $del, $adddel, $file);
-	my @tracked = ();
-
-	if (@ARGV) {
-		@tracked = map {
-			chomp $_; $_;
-		} run_cmd_pipe(qw(git ls-files --exclude-standard --), @ARGV);
-		return if (!@tracked);
-	}
 
 	for (run_cmd_pipe(qw(git diff-index --cached
-			     --numstat --summary HEAD --), @tracked)) {
+			     --numstat --summary HEAD --), @ARGV)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			my ($change, $bin);
@@ -89,7 +81,7 @@ sub list_modified {
 		}
 	}
 
-	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @tracked)) {
+	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @ARGV)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			if (!exists $data{$file}) {
-- 
1.5.3.6.1994.g38001
