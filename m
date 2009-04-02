From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 2 Apr 2009 14:38:24 +0200
Message-ID: <20090402123823.GA1756@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 02 14:40:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpMDD-0001DA-Tl
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 14:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbZDBMi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 08:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754399AbZDBMi3
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 08:38:29 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:56771 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbZDBMi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 08:38:28 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LpMBc-00057f-4j; Thu, 02 Apr 2009 14:38:24 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115461>

With the --prune (or -p) option, git remote update will also prune
all the remotes that it fetches.  Previously, you had to do a manual git
remote prune <remote> for each of the remotes you wanted to prune, and this
could be tedious with many remotes.

A single command will now update all remotes, and remove all stale
branches: git remote update -p

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/git-remote.txt |    4 ++-
 builtin-remote.c             |   73 ++++++++++++++++++++++++++----------------
 2 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index c9c0e6f..0b6e67d 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git remote set-head' <name> [-a | -d | <branch>]
 'git remote show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
-'git remote update' [group]
+'git remote update' [-p | --prune] [group]
 
 DESCRIPTION
 -----------
@@ -125,6 +125,8 @@ the configuration parameter remotes.default will get used; if
 remotes.default is not defined, all remotes which do not have the
 configuration parameter remote.<name>.skipDefaultUpdate set to true will
 be updated.  (See linkgit:git-config[1]).
++
+With `--prune` option, prune all the remotes that are updated.
 
 
 DISCUSSION
diff --git a/builtin-remote.c b/builtin-remote.c
index 9ef846f..da46b5f 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -15,7 +15,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote set-head <name> [-a | -d | <branch>]",
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [group]",
+	"git remote [-v | --verbose] update [-p | --prune] [group]",
 	NULL
 };
 
@@ -26,6 +26,7 @@ static const char * const builtin_remote_usage[] = {
 static int verbose;
 
 static int show_all(void);
+static int prune_remote(const char *remote, int dry_run);
 
 static inline int postfixcmp(const char *string, const char *postfix)
 {
@@ -1128,46 +1129,51 @@ static int prune(int argc, const char **argv)
 		OPT__DRY_RUN(&dry_run),
 		OPT_END()
 	};
-	struct ref_states states;
-	const char *dangling_msg;
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
 	if (argc < 1)
 		usage_with_options(builtin_remote_usage, options);
 
-	dangling_msg = (dry_run
-			? " %s will become dangling!\n"
-			: " %s has become dangling!\n");
-
-	memset(&states, 0, sizeof(states));
 	for (; argc; argc--, argv++) {
-		int i;
+		result |= prune_remote(*argv, dry_run);
+	}
+	return result;
+}
 
-		get_remote_ref_states(*argv, &states, GET_REF_STATES);
+static int prune_remote(const char *remote, int dry_run)
+{
+	int result = 0;
+	struct ref_states states;
+	const char *dangling_msg = dry_run
+		? " %s will become dangling!\n"
+		: " %s has become dangling!\n";
 
-		if (states.stale.nr) {
-			printf("Pruning %s\n", *argv);
-			printf("URL: %s\n",
-			       states.remote->url_nr
-			       ? states.remote->url[0]
-			       : "(no URL)");
-		}
+	memset(&states, 0, sizeof(states));
+	int i;
 
-		for (i = 0; i < states.stale.nr; i++) {
-			const char *refname = states.stale.items[i].util;
+	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
-			if (!dry_run)
-				result |= delete_ref(refname, NULL, 0);
+	if (states.stale.nr) {
+		printf("Pruning %s\n", remote);
+		printf("URL: %s\n",
+		       states.remote->url_nr
+		       ? states.remote->url[0]
+		       : "(no URL)");
+	}
 
-			printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
-			       abbrev_ref(refname, "refs/remotes/"));
-			warn_dangling_symref(dangling_msg, refname);
-		}
+	for (i = 0; i < states.stale.nr; i++) {
+		const char *refname = states.stale.items[i].util;
 
-		free_remote_ref_states(&states);
+		if (!dry_run)
+			result |= delete_ref(refname, NULL, 0);
+
+		printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
+		       abbrev_ref(refname, "refs/remotes/"));
+		warn_dangling_symref(dangling_msg, refname);
 	}
 
+	free_remote_ref_states(&states);
 	return result;
 }
 
@@ -1204,10 +1210,18 @@ static int get_remote_group(const char *key, const char *value, void *cb)
 
 static int update(int argc, const char **argv)
 {
-	int i, result = 0;
+	int i, result = 0, prune = 0;
 	struct string_list list = { NULL, 0, 0, 0 };
 	static const char *default_argv[] = { NULL, "default", NULL };
+	struct option options[] = {
+		OPT_GROUP("update specific options"),
+		OPT_BOOLEAN('p', "prune", &prune,
+			    "prune remotes after fecthing"),
+		OPT_END()
+	};
 
+	argc = parse_options(argc, argv, options, builtin_remote_usage,
+			     PARSE_OPT_KEEP_ARGV0);
 	if (argc < 2) {
 		argc = 2;
 		argv = default_argv;
@@ -1222,8 +1236,11 @@ static int update(int argc, const char **argv)
 	if (!result && !list.nr  && argc == 2 && !strcmp(argv[1], "default"))
 		result = for_each_remote(get_one_remote_for_update, &list);
 
-	for (i = 0; i < list.nr; i++)
+	for (i = 0; i < list.nr; i++) {
 		result |= fetch_remote(list.items[i].string);
+		if (prune)
+			prune_remote(list.items[i].string, 0);
+	}
 
 	/* all names were strdup()ed or strndup()ed */
 	list.strdup_strings = 1;
-- 
1.6.2.1.470.gd21ca.dirty
