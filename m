From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] branch --track: code cleanup and saner handling of local
 branches
Date: Tue, 10 Jul 2007 04:05:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707100403550.4131@racer.site>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
 <7vhcoexqeh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707091228290.5546@racer.site>
 <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707092203100.5546@racer.site>
 <7vzm25tex6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 05:14:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I86B0-00029N-7N
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 05:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762726AbXGJDNi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 23:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762722AbXGJDNi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 23:13:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:39395 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761830AbXGJDNg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 23:13:36 -0400
Received: (qmail invoked by alias); 10 Jul 2007 03:13:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 10 Jul 2007 05:13:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1ijYUVX/1PgUWCyx/LEbX7vFp9VsDjo8kYlvaLE
	v5mTz0YRLY6HEL
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm25tex6.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52036>


This patch cleans up some complicated code, and replaces it with a
cleaner version, using code from remote.[ch], which got extended a
little in the process.  This also enables us to fix two cases:

The earlier "fix" to setup tracking only when the original ref started
with "refs/remotes" is wrong.  You are absolutely allowed to use a
separate layout for your tracking branches.  The correct fix, of course,
is to set up tracking information only when there is a matching
remote.<nick>.fetch line containing a colon.

Another corner case was not handled properly.  If two remotes write to
the original ref, just warn the user and do not set up tracking.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	... and again I was bitten by the minimality of the script. The
	original diff was _unreadable_, because it matched some empty 
	lines here and there, or some lonely curly brackets.

	Therefore I manually tweaked it to show first the cruft that was 
	removed, and then the rewrite using remote.[ch]. As a consequence, 
	the diffstat is not the one of this patch, but the one "git show 
	--stat" showed.

 builtin-branch.c  |  167 ++++++++++++++++------------------------------------
 t/t3200-branch.sh |   21 ++++---
 2 files changed, 63 insertions(+), 125 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 49195a1..0dbd6d7 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -10,6 +10,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "builtin.h"
+#include "remote.h"
 
 static const char builtin_branch_usage[] =
   "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]] [--sort-by-date]";
@@ -22,7 +23,7 @@ static const char builtin_branch_usage[] =
 static const char *head;
 static unsigned char head_sha1[20];
 
-static int branch_track = 1; /* 0 = none, 1 = remotes, 2 = all */
+static int branch_track = 1;
 
 static int branch_use_color;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -66,12 +67,8 @@ static int git_branch_config(const char *var, const char *value)
 		color_parse(value, var, branch_colors[slot]);
 		return 0;
 	}
-	if (!strcmp(var, "branch.autosetupmerge")) {
-		if (!strcmp(value, "all"))
-			branch_track = 2;
-		else
+	if (!strcmp(var, "branch.autosetupmerge"))
 			branch_track = git_config_bool(var, value);
-	}
 
 	return git_default_config(var, value);
 }
@@ -349,125 +346,67 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev,
 	free_ref_list(&ref_list);
 }
 
-static char *config_repo;
-static char *config_remote;
-static const char *start_ref;
-
-static int get_remote_branch_name(const char *value)
-{
-	const char *colon;
-	const char *end;
-
-	if (*value == '+')
-		value++;
-
-	colon = strchr(value, ':');
-	if (!colon)
-		return 0;
-
-	end = value + strlen(value);
-
-	/*
-	 * Try an exact match first.  I.e. handle the case where the
-	 * value is "$anything:refs/foo/bar/baz" and start_ref is exactly
-	 * "refs/foo/bar/baz". Then the name at the remote is $anything.
-	 */
-	if (!strcmp(colon + 1, start_ref)) {
-		/* Truncate the value before the colon. */
-		nfasprintf(&config_repo, "%.*s", colon - value, value);
-		return 1;
-	}
-
-	/*
-	 * Is this a wildcard match?
-	 */
-	if ((end - 2 <= value) || end[-2] != '/' || end[-1] != '*' ||
-	    (colon - 2 <= value) || colon[-2] != '/' || colon[-1] != '*')
-		return 0;
-
-	/*
-	 * Value is "refs/foo/bar/<asterisk>:refs/baz/boa/<asterisk>"
-	 * and start_ref begins with "refs/baz/boa/"; the name at the
-	 * remote is refs/foo/bar/ with the remaining part of the
-	 * start_ref.  The length of the prefix on the RHS is (end -
-	 * colon - 2), including the slash immediately before the
-	 * asterisk.
-	 */
-	if ((strlen(start_ref) < end - colon - 2) ||
-	    memcmp(start_ref, colon + 1, end - colon - 2))
-		return 0; /* does not match prefix */
-
-	/* Replace the asterisk with the remote branch name.  */
-	nfasprintf(&config_repo, "%.*s%s",
-		   (colon - 1) - value, value,
-		   start_ref + (end - colon - 2));
-	return 1;
-}
-
-static int get_remote_config(const char *key, const char *value)
-{
-	const char *var;
-	if (prefixcmp(key, "remote."))
-		return 0;
-
-	var = strrchr(key, '.');
-	if (var == key + 6 || strcmp(var, ".fetch"))
-		return 0;
-	/*
-	 * Ok, we are looking at key == "remote.$foo.fetch";
-	 */
-	if (get_remote_branch_name(value))
-		nfasprintf(&config_remote, "%.*s", var - (key + 7), key + 7);
-
-	return 0;
-}
-
-static void set_branch_merge(const char *name, const char *config_remote,
-			     const char *config_repo)
-{
-	char key[1024];
-	if (sizeof(key) <=
-	    snprintf(key, sizeof(key), "branch.%s.remote", name))
-		die("what a long branch name you have!");
-	git_config_set(key, config_remote);
-
-	/*
-	 * We do not have to check if we have enough space for
-	 * the 'merge' key, since it's shorter than the
-	 * previous 'remote' key, which we already checked.
-	 */
-	snprintf(key, sizeof(key), "branch.%s.merge", name);
-	git_config_set(key, config_repo);
-}
-
-static void set_branch_defaults(const char *name, const char *real_ref)
-{
-	/*
-	 * name is the name of new branch under refs/heads;
-	 * real_ref is typically refs/remotes/$foo/$bar, where
-	 * $foo is the remote name (there typically are no slashes)
-	 * and $bar is the branch name we map from the remote
-	 * (it could have slashes).
-	 */
-	start_ref = real_ref;
-	git_config(get_remote_config);
-	if (!config_repo && !config_remote &&
-	    !prefixcmp(real_ref, "refs/heads/")) {
-		set_branch_merge(name, ".", real_ref);
-		printf("Branch %s set up to track local branch %s.\n",
-		       name, real_ref);
-	}
-
-	if (config_repo && config_remote) {
-		set_branch_merge(name, config_remote, config_repo);
-		printf("Branch %s set up to track remote branch %s.\n",
-		       name, real_ref);
-	}
-
-	if (config_repo)
-		free(config_repo);
-	if (config_remote)
-		free(config_remote);
+struct tracking {
+	struct refspec spec;
+	char *dst;
+	const char *remote;
+	int matches;
+};
+
+static int find_tracked_branch(struct remote *remote, void *priv)
+{
+	struct tracking *tracking = priv;
+
+	if (!remote_find_tracking(remote, &tracking->spec, 1)) {
+		if (++tracking->matches == 1) {
+			tracking->dst = tracking->spec.dst;
+			tracking->remote = remote->name;
+		} else {
+			free(tracking->spec.dst);
+			free(tracking->dst);
+			tracking->dst = NULL;
+		}
+	}
+
+	return 0;
+}
+
+
+/*
+ * This is called when new_ref is branched off of orig_ref, and tries
+ * to infer the settings for branch.<new_ref>.{remote,merge} from the
+ * config.
+ */
+static int setup_tracking(const char *new_ref, const char *orig_ref)
+{
+	char key[1024];
+	struct tracking tracking;
+
+	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
+		return error("Tracking not set up: name too long: %s",
+				new_ref);
+
+	memset(&tracking, 0, sizeof(tracking));
+	tracking.spec.src = orig_ref;
+	if (for_each_remote(find_tracked_branch, &tracking) ||
+			!tracking.matches)
+		return 1;
+
+	if (tracking.matches > 1)
+		return error("Not tracking: ambiguous information for ref %s",
+				orig_ref);
+
+	if (tracking.matches == 1) {
+		sprintf(key, "branch.%s.remote", new_ref);
+		git_config_set(key, tracking.remote ?  tracking.remote : ".");
+		sprintf(key, "branch.%s.merge", new_ref);
+		git_config_set(key, tracking.dst);
+		free(tracking.dst);
+		printf("Branch %s set up to track remote branch %s.\n",
+			       new_ref, orig_ref);
+	}
+
+	return 0;
 }
 
 static void create_branch(const char *name, const char *start_name,
@@ -529,10 +468,8 @@ static void create_branch(const char *name, const char *start_name,
 	/* When branching off a remote branch, set up so that git-pull
 	   automatically merges from there.  So far, this is only done for
 	   remotes registered via .git/config.  */
-	if (real_ref && (track == 2 ||
-				(track == 1 &&
-				 !prefixcmp(real_ref, "refs/remotes/"))))
-		set_branch_defaults(name, real_ref);
+	if (real_ref && track)
+		setup_tracking(name, real_ref);
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
@@ -604,7 +541,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			break;
 		}
 		if (!strcmp(arg, "--track")) {
-			track = 2;
+			track = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--no-track")) {
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a19e961..ef1eeb7 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -148,13 +148,14 @@ test_expect_success 'test tracking setup via config' \
      test $(git config branch.my3.remote) = local &&
      test $(git config branch.my3.merge) = refs/heads/master'
 
-test_expect_success 'autosetupmerge = all' '
+test_expect_success 'avoid ambiguous track' '
 	git config branch.autosetupmerge true &&
+	git config remote.ambi1.url = lalala &&
+	git config remote.ambi1.fetch = refs/heads/lalala:refs/heads/master &&
+	git config remote.ambi2.url = lilili &&
+	git config remote.ambi2.fetch = refs/heads/lilili:refs/heads/master &&
 	git branch all1 master &&
-	test -z "$(git config branch.all1.merge)" &&
-	git config branch.autosetupmerge all &&
-	git branch all2 master &&
-	test $(git config branch.all2.merge) = refs/heads/master
+	test -z "$(git config branch.all1.merge)"
 '
 
 test_expect_success 'test overriding tracking setup via --no-track' \
@@ -167,10 +168,10 @@ test_expect_success 'test overriding tracking setup via --no-track' \
      ! test "$(git config branch.my2.remote)" = local &&
      ! test "$(git config branch.my2.merge)" = refs/heads/master'
 
-test_expect_success 'test local tracking setup' \
+test_expect_success 'no tracking without .fetch entries' \
     'git branch --track my6 s &&
-     test $(git config branch.my6.remote) = . &&
-     test $(git config branch.my6.merge) = refs/heads/s'
+     test -z "$(git config branch.my6.remote)" &&
+     test -z "$(git config branch.my6.merge)"'
 
 test_expect_success 'test tracking setup via --track but deeper' \
     'git config remote.local.url . &&
@@ -182,8 +183,8 @@ test_expect_success 'test tracking setup via --track but deeper' \
 
 test_expect_success 'test deleting branch deletes branch config' \
     'git branch -d my7 &&
-     test "$(git config branch.my7.remote)" = "" &&
-     test "$(git config branch.my7.merge)" = ""'
+     test -z "$(git config branch.my7.remote)" &&
+     test -z "$(git config branch.my7.merge)"'
 
 test_expect_success 'test deleting branch without config' \
     'git branch my7 s &&
-- 
1.5.3.rc0.2769.gd9be2
