From: Zefram <zefram@fysh.org>
Subject: [PATCH] Support "git remote --quiet update"
Date: Thu, 15 Apr 2010 23:11:16 +0100
Message-ID: <E1O2fKp-0004d9-Na@lake.fysh.org>
References: <o2xbe6fef0d1004151959h6dd0405bhc669fe6284a66044@mail.gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 08:47:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2fL2-00087z-Rl
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 08:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845Ab0DPGre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 02:47:34 -0400
Received: from lake.fysh.org ([81.94.195.195]:52379 "EHLO lake.fysh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756749Ab0DPGrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 02:47:33 -0400
Received: from zefram by lake.fysh.org with local (Exim 4.69 #1 (Debian))
	id 1O2fKp-0004d9-Na; Fri, 16 Apr 2010 07:47:27 +0100
In-Reply-To: <o2xbe6fef0d1004151959h6dd0405bhc669fe6284a66044@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145053>

Add --quiet option for git-remote, which it will pass on to git-fetch.

Signed-off-by: Zefram <zefram@fysh.org>
---

Tay Ray Chuan <rctay89@gmail.com> wrote:
>Signed-off-by?
>
>  http://github.com/git/git/blob/master/Documentation/SubmittingPatches

Bah, sorry, I hadn't noticed that document.  That's what I get for
jumping in quickly.

Since I'm writing an epigram now, I might as well throw in some context.
I'm a new git user, only been using it seriously for the past few days,
so I've been inhaling a lot of documentation.  I found just a handful of
small annoyances.  Upon checking out git.git, it turned out that most
of them had already been fixed, such as "git fetch --quiet" not really
being quiet.  (I was using git 1.5.6.5, via Debian lenny.)  The only
one that was left was "git remote update" not having a --quiet option.
Hence the patch.

 Documentation/git-remote.txt |    9 ++++++++-
 builtin/remote.c             |   16 ++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 3fc599c..25f6c05 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -19,7 +19,8 @@ SYNOPSIS
 'git remote set-url --delete' [--push] <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
-'git remote' [-v | --verbose] 'update' [-p | --prune] [group | remote]...
+'git remote' [-v | --verbose] [-q | --quiet] 'update'
+	     [-p | --prune] [group | remote]...
 
 DESCRIPTION
 -----------
@@ -30,6 +31,12 @@ Manage the set of repositories ("remotes") whose branches you track.
 OPTIONS
 -------
 
+-q::
+--quiet::
+	Pass --quiet to git-fetch.  Progress is not reported to the
+	standard error stream.
+	NOTE: This must be placed between `remote` and `subcommand`.
+
 -v::
 --verbose::
 	Be a little more verbose and show remote url after name.
diff --git a/builtin/remote.c b/builtin/remote.c
index 277765b..5447780 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -15,7 +15,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote set-head <name> (-a | -d | <branch>)",
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [-p | --prune] [group | remote]",
+	"git remote [-v | --verbose] [-q | --quiet] update [-p | --prune] [group | remote]",
 	"git remote set-url <name> <newurl> [<oldurl>]",
 	"git remote set-url --add <name> <newurl>",
 	"git remote set-url --delete <name> <url>",
@@ -68,7 +68,7 @@ static const char * const builtin_remote_seturl_usage[] = {
 #define GET_HEAD_NAMES (1<<1)
 #define GET_PUSH_REF_STATES (1<<2)
 
-static int verbose;
+static int verbosity;
 
 static int show_all(void);
 static int prune_remote(const char *remote, int dry_run);
@@ -94,8 +94,8 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
 static int fetch_remote(const char *name)
 {
 	const char *argv[] = { "fetch", name, NULL, NULL };
-	if (verbose) {
-		argv[1] = "-v";
+	if (verbosity != 0) {
+		argv[1] = verbosity > 0 ? "-v" : "-q";
 		argv[2] = name;
 	}
 	printf("Updating %s\n", name);
@@ -1246,8 +1246,8 @@ static int update(int argc, const char **argv)
 
 	if (prune)
 		fetch_argv[fetch_argc++] = "--prune";
-	if (verbose)
-		fetch_argv[fetch_argc++] = "-v";
+	if (verbosity != 0)
+		fetch_argv[fetch_argc++] = verbosity > 0 ? "-v" : "-q";
 	fetch_argv[fetch_argc++] = "--multiple";
 	if (argc < 2)
 		fetch_argv[fetch_argc++] = "default";
@@ -1395,7 +1395,7 @@ static int show_all(void)
 		sort_string_list(&list);
 		for (i = 0; i < list.nr; i++) {
 			struct string_list_item *item = list.items + i;
-			if (verbose)
+			if (verbosity > 0)
 				printf("%s\t%s\n", item->string,
 					item->util ? (const char *)item->util : "");
 			else {
@@ -1412,7 +1412,7 @@ static int show_all(void)
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
-		OPT_BOOLEAN('v', "verbose", &verbose, "be verbose; must be placed before a subcommand"),
+		OPT__VERBOSITY(&verbosity),
 		OPT_END()
 	};
 	int result;
-- 
1.5.6.5
