From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 2/3] Move pathspec validation into interactive_add
Date: Sat, 24 Nov 2007 13:55:21 +0100
Message-ID: <1195908922-88023-3-git-send-email-win@wincent.com>
References: <7vk5o8smaf.fsf@gitster.siamese.dyndns.org>
 <1195908922-88023-1-git-send-email-win@wincent.com>
 <1195908922-88023-2-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 13:56:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvuYf-0000yr-CM
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 13:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbXKXM4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 07:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbXKXM4F
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 07:56:05 -0500
Received: from wincent.com ([72.3.236.74]:34080 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630AbXKXM4D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 07:56:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAOCtOoq008418;
	Sat, 24 Nov 2007 06:55:31 -0600
X-Mailer: git-send-email 1.5.3.6.1994.g315c0c
In-Reply-To: <1195908922-88023-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65947>

Simplify git-add--interactive by moving the pathspec validation into the
interactive_add() function of builtin-add. We can do this because
builtin-add is the only caller of git-add--interactive.

The validate_pathspec() function added by this commit is based on a
sample posted to the mailing list by Junio Hamano.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

Note that I made a couple of changes to the code posted by Junio on the
mailing list to make the behaviour a little more convenient. At this
stage it's just a proposal, and there are some issues that I'd like to
see ironed out.

Instead of throwing away the return status of pathspec_match() I am
keeping it, and any successful match breaks out of the loop early. I
observed that passing in a file parameter like "commit.h" in the Git
repo the loop would execute over a thousand times, with pathspec_match
returning 0 some of the time and 1 at others. Evidently any time it
returns 1 that's enough to indicate that it's a valid pathspec.

One issue is that performance is very slow. If you do something like
"git-add -i *.c" then there is a very noticeable delay.

Another issue is that simple shell shortcuts don't work, so something
as simple as "git-add -i ." will report:

  error: pathspec '.' did not match any file(s) known to git.

It would be nice if that could be detected as valid because it does
work when you pass it to git-add--interactive.

Likewise it's not possible to validate pathspecs like "\*.sh" either,
but seeing as these won't work when passed to git-add--interactive
guess it doesn't matter (because they don't work with git-diff-files
either, which is what git-add--interactive is using).

 builtin-add.c             |   38 ++++++++++++++++++++++++++++++++++----
 builtin-commit.c          |    2 +-
 commit.h                  |    2 +-
 git-add--interactive.perl |   12 ++----------
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index dd895df..06212c3 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -135,10 +135,40 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-int interactive_add(int argc, const char **argv)
+static int validate_pathspec(const char *prefix, const char **pattern)
 {
-	int status;
-	const char **args = xmalloc(sizeof(const char *) * (argc + 1));
+	int i, ret = 0;
+	char *m;
+
+	if (!pattern || !*pattern)
+		return 0;
+
+	for (i = 0; pattern[i]; i++)
+		;
+	m = xcalloc(1, i);
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if ((ret = pathspec_match(pattern, m, ce->name, 0)))
+			break;
+	}
+	if (!ret)
+		report_path_error(m, pattern, prefix ? strlen(prefix) : 0);
+	free(m);
+	return ret;
+}
+
+int interactive_add(const char *prefix, int argc, const char **argv)
+{
+	int i, status;
+	const char **args;
+	if (read_cache() < 0)
+		die("index file corrupt");
+	for (i = 0; i < argc; i++) {
+		if (!(status = validate_pathspec(prefix, &argv[i])))
+			return 1;
+	}
+
+	args = xmalloc(sizeof(const char *) * (argc + 2));
 	args[0] = "add--interactive";
 	memcpy((void *)args + sizeof(const char *), argv, sizeof(const char *) * argc);
 	args[argc + 1] = NULL;
@@ -176,7 +206,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
1.5.3.6.1992.gd646-dirty
