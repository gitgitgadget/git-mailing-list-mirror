From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH RFC 4/8] git remote add: add --push option
Date: Mon, 20 Jul 2009 19:49:51 +0200
Message-ID: <1248112195-3761-5-git-send-email-bonzini@gnu.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:51:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSx0x-0005yL-24
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 19:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbZGTRuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 13:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277AbZGTRuO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 13:50:14 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56553 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbZGTRuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 13:50:11 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSx05-00033B-Mj
	for git@vger.kernel.org; Mon, 20 Jul 2009 13:50:10 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123629>

This patch makes `git remote add' able to setup push refspecs,
as well as options controlling the behavior of git-push.  Remotes
created with this option will not be subject to the "push.default"
configuration setting, because they have a push refspec.

This plans ahead for a future transition to "push.default = nothing"
being the default, while being a worthwhile addition in case the
transition never materializes.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-remote.txt |   13 +++--
 builtin-remote.c             |  119 +++++++++++++++++++++++++++++++++++++++--
 cache.h                      |    4 +-
 config.c                     |   39 ++++++++------
 t/t5505-remote.sh            |   73 ++++++++++++++++++++++++++
 t/t5517-push-mirror.sh       |   22 +++++++-
 6 files changed, 240 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 9e2b4ea..5f1bda3 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror | --push=<strategy>] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote set-head' <name> [-a | -d | <branch>]
@@ -56,11 +56,12 @@ multiple branches without grabbing all branches.
 With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
-In mirror mode, enabled with `\--mirror`, the refs will not be stored
-in the 'refs/remotes/' namespace, but in 'refs/heads/'.  This option
-only makes sense in bare repositories.  If a remote uses mirror
-mode, furthermore, `git push` will always behave as if `\--mirror`
-was passed.
+The remote's behavior upon `git push` can also be set up by
+`git remote add`.  Valid values for `\--push` are 'matching', 'mirror,
+'tracking', 'current', and `nothing'.  Their meanings are the same as
+for the `push.default` configuration key.  `\--mirror` is a synonym for
+`\--push=mirror`.
+
 
 'rename'::
 
diff --git a/builtin-remote.c b/builtin-remote.c
index c30fbb7..23ab24b 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -9,7 +9,7 @@
 
 static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose]",
-	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
+	"git remote add [-t <branch>] [-m <master>] [-f] [--push=<strategy>] [--mirror] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
 	"git remote set-head <name> [-a | -d | <branch>]",
@@ -36,17 +36,92 @@ static inline int postfixcmp(const char *string, const char *postfix)
 	return strcmp(string + len1 - len2, postfix);
 }
 
-static int setup_remote_config(const char *name, const char *url, int mirror, struct string_list *track)
+static const char *warn_unconfigured_push_msg[] = {
+	"You did not specify any argument to --push, and 'push.default'",
+	"is not defined in your configuration. The default action in this",
+	"case will be to push all matching refspecs, that is, all branches",
+	"that exist both locally and remotely will be updated.  This may",
+	"not necessarily be what you want to happen.",
+	"",
+	"You can specify what action you want to take in this case, and",
+	"avoid seeing this message again, by configuring 'push.default' to:",
+	"  'matching' : Push all matching branches (default)",
+	"  'mirror'   : Push all branches and delete non-existing ones",
+	"  'tracking' : Push the current branch to whatever it is tracking",
+	"  'current'  : Push the current branch"
+};
+
+static void warn_unconfigured_push()
 {
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	int i;
+	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_push_msg); i++)
+		warning("%s", warn_unconfigured_push_msg[i]);
+}
+
+
+static int setup_default_remote_config(const char *name, const char *url, int push, struct string_list *track)
+{
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
+	const char *refspec = NULL;
+	int mirror = 0;
+	int current = 0;
+	int autosetuppush = 0;
+	int setup_push_refspecs = 0;
+	int i;
+
+	switch (push) {
+	case PUSH_DEFAULT_UNSPECIFIED:
+		warn_unconfigured_push();
+		/* fallthrough */
+
+	case PUSH_DEFAULT_MATCHING:
+		refspec = ":";
+		break;
+
+	case PUSH_DEFAULT_MIRROR:
+		refspec = "+refs/*:refs/*";
+		mirror = 1;
+		break;
+
+	case PUSH_DEFAULT_TRACKING:
+		current = 1;
+		autosetuppush = 1;
+		setup_push_refspecs = (track->nr > 0);
+		break;
+
+	case PUSH_DEFAULT_CURRENT:
+		refspec = "HEAD";
+		current = 1;
+		break;
+
+	case PUSH_DEFAULT_NOTHING:
+		break;
+	}
 
+	if (refspec) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.push", name);
+		if (git_config_set(buf.buf, refspec))
+			return 1;
+	}
+	if (autosetuppush) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.autosetuppush", name);
+		if (git_config_set(buf.buf, "true"))
+			return 1;
+	}
 	if (mirror) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.mirror", name);
 		if (git_config_set(buf.buf, "true"))
 			return 1;
 	}
+	if (current) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.pushHeadOnly", name);
+		if (git_config_set(buf.buf, "true"))
+			return 1;
+	}
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.url", name);
@@ -55,6 +130,8 @@ static int setup_remote_config(const char *name, const char *url, int mirror, st
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", name);
+	strbuf_reset(&buf3);
+	strbuf_addf(&buf3, "remote.%s.push", name);
 
 	if (track->nr == 0)
 		string_list_append("*", track);
@@ -62,8 +139,16 @@ static int setup_remote_config(const char *name, const char *url, int mirror, st
 	for (i = 0; i < track->nr; i++) {
 		struct string_list_item *item = track->items + i;
 
+		if (setup_push_refspecs) {
+			strbuf_reset(&buf2);
+			strbuf_addf(&buf2, "refs/heads/%s:refs/heads/%s",
+				    item->string, item->string);
+			if (git_config_set_multivar(buf3.buf, buf2.buf, "^$", 0))
+				return 1;
+		}
+
 		strbuf_reset(&buf2);
-		if (mirror)
+		if (push == PUSH_DEFAULT_MIRROR)
 			strbuf_addf(&buf2, "+refs/%s:refs/%s",
 					item->string, item->string);
 		else
@@ -75,10 +160,24 @@ static int setup_remote_config(const char *name, const char *url, int mirror, st
 
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
+	strbuf_release(&buf3);
 	return 0;
 }
 
 
+static int opt_parse_push(const struct option *opt, const char *arg, int not)
+{
+	int *value = opt->value;
+	if (not)
+		*value = PUSH_DEFAULT_NOTHING;
+	else if (!arg)
+		*value = push_default;
+	else
+		return git_parse_push_default("--push", arg, value);
+
+	return 0;
+}
+
 static int opt_parse_track(const struct option *opt, const char *arg, int not)
 {
 	struct string_list *list = opt->value;
@@ -104,7 +203,7 @@ static int fetch_remote(const char *name)
 
 static int add(int argc, const char **argv)
 {
-	int fetch = 0, mirror = 0;
+	int fetch = 0, push = PUSH_DEFAULT_UNKNOWN, mirror = 0;
 	struct string_list track = { NULL, 0, 0 };
 	const char *master = NULL;
 	struct remote *remote;
@@ -117,10 +216,13 @@ static int add(int argc, const char **argv)
 		OPT_CALLBACK('t', "track", &track, "branch",
 			"branch(es) to track", opt_parse_track),
 		OPT_STRING('m', "master", &master, "branch", "master branch"),
+		{ OPTION_CALLBACK, 0, "push", &push, "strategy",
+			"how to setup pushing", PARSE_OPT_OPTARG, opt_parse_push },
 		OPT_BOOLEAN(0, "mirror", &mirror, "no separate remotes"),
 		OPT_END()
 	};
 
+	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
 			     0);
 
@@ -130,6 +232,11 @@ static int add(int argc, const char **argv)
 	name = argv[0];
 	url = argv[1];
 
+	if (push == PUSH_DEFAULT_UNKNOWN)
+		push = mirror ? PUSH_DEFAULT_MIRROR : PUSH_DEFAULT_NOTHING;
+	else if (mirror && push != PUSH_DEFAULT_MIRROR)
+			die ("--mirror and --push are incompatible");
+
 	remote = remote_get(name);
 	if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) ||
 			remote->fetch_refspec_nr))
@@ -139,7 +246,7 @@ static int add(int argc, const char **argv)
 	if (!valid_fetch_refspec(buf2.buf))
 		die("'%s' is not a valid remote name", name);
 
-	if (setup_remote_config(name, url, mirror, &track))
+	if (setup_remote_config(name, url, push, &track))
 		return 1;
 
 	if (fetch && fetch_remote(name))
diff --git a/cache.h b/cache.h
index 172d36c..a46bfe6 100644
--- a/cache.h
+++ b/cache.h
@@ -544,7 +544,8 @@ enum rebase_setup_type {
 };
 
 enum push_default_type {
-	PUSH_DEFAULT_UNSPECIFIED = -1,
+	PUSH_DEFAULT_UNKNOWN = -2,	/* command line: use push.default */
+	PUSH_DEFAULT_UNSPECIFIED = -1,	/* config key absent */
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_TRACKING,
@@ -640,6 +641,7 @@ enum sharedrepo {
 };
 int git_config_perm(const char *var, const char *value);
 int git_config_tracking(const char *var, const char *value, struct tracking_config *cfg);
+int git_parse_push_default(const char *var, const char *value, int *result);
 int set_shared_perm(const char *path, int mode);
 #define adjust_shared_perm(path) set_shared_perm((path), 0)
 int safe_create_leading_directories(char *path);
diff --git a/config.c b/config.c
index 4db5c6d..37d95a4 100644
--- a/config.c
+++ b/config.c
@@ -580,6 +580,27 @@ int git_tracking_config(const char *var, const char *value, struct tracking_conf
 	return 0;
 }
 
+int git_parse_push_default(const char *var, const char *value, int *result)
+{
+	if (!strcmp(value, "nothing"))
+		*result = PUSH_DEFAULT_NOTHING;
+	else if (!strcmp(value, "matching"))
+		*result = PUSH_DEFAULT_MATCHING;
+	else if (!strcmp(value, "mirror"))
+		*result = PUSH_DEFAULT_MIRROR;
+	else if (!strcmp(value, "tracking"))
+		*result = PUSH_DEFAULT_TRACKING;
+	else if (!strcmp(value, "current"))
+		*result = PUSH_DEFAULT_CURRENT;
+	else {
+		error("Malformed value for %s: %s", var, value);
+		return error("Must be one of nothing, matching, "
+			     "mirror, tracking or current.");
+	}
+
+	return 0;
+}
+
 static int git_default_branch_config(const char *var, const char *value)
 {
 	int result;
@@ -600,22 +621,8 @@ static int git_default_push_config(const char *var, const char *value)
 	if (!strcmp(var, "push.default")) {
 		if (!value)
 			return config_error_nonbool(var);
-		else if (!strcmp(value, "nothing"))
-			push_default = PUSH_DEFAULT_NOTHING;
-		else if (!strcmp(value, "matching"))
-			push_default = PUSH_DEFAULT_MATCHING;
-		else if (!strcmp(value, "mirror"))
-			push_default = PUSH_DEFAULT_MIRROR;
-		else if (!strcmp(value, "tracking"))
-			push_default = PUSH_DEFAULT_TRACKING;
-		else if (!strcmp(value, "current"))
-			push_default = PUSH_DEFAULT_CURRENT;
-		else {
-			error("Malformed value for %s: %s", var, value);
-			return error("Must be one of nothing, matching, "
-				     "mirror, tracking or current.");
-		}
-		return 0;
+		else
+			return git_parse_push_default (var, value, &push_default);
 	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 852ccb5..a411eef 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -77,6 +77,79 @@ test_expect_success 'add another remote' '
 )
 '
 
+test_expect_success 'configuration for --push=mirror' '
+(
+	git clone one test2 &&
+	cd test2 &&
+	git remote add push-mirror --push=mirror ../two &&
+	git config --bool remote.push-mirror.mirror &&
+	! git config --bool remote.push-mirror.pushHeadOnly &&
+	! git config --bool remote.push-mirror.autosetuppush &&
+	test $(git config remote.push-mirror.push) = "+refs/*:refs/*"
+)
+'
+
+test_expect_success 'configuration for --push=current' '
+(
+	cd test2 &&
+	git remote add push-current --push=current ../two &&
+	! git config --bool remote.push-current.mirror &&
+	git config --bool remote.push-current.pushHeadOnly &&
+	! git config --bool remote.push-current.autosetuppush &&
+	test $(git config remote.push-current.push) = HEAD
+)
+'
+
+test_expect_success 'configuration for --push=matching' '
+(
+	cd test2 &&
+	git remote add -f push-matching --push=matching ../two &&
+	! git config --bool remote.push-matching.mirror &&
+	! git config --bool remote.push-matching.pushHeadOnly &&
+	! git config --bool remote.push-matching.autosetuppush &&
+	test $(git config remote.push-matching.push) = :
+)
+'
+
+test_expect_success 'configuration for --push=tracking' '
+(
+	git clone one test3 &&
+	cd test3 &&
+	git remote add -f push-tracking --push=tracking ../two &&
+	! git config --bool remote.push-tracking.tracking &&
+	git config --bool remote.push-tracking.pushHeadOnly &&
+	git config --bool remote.push-tracking.autosetuppush &&
+	! test $(git config remote.push-tracking.push) &&
+	git checkout -b myother push-tracking/another &&
+	test $(git config remote.push-tracking.push) = "refs/heads/myother:refs/heads/another"
+)
+'
+
+test_expect_success 'configuration for --push -t (push.default = tracking)' '
+(
+	git clone one test4 &&
+	cd test4 &&
+	git config push.default tracking &&
+	git remote add -f push-tracking2 -t another --push ../two &&
+	! git config --bool remote.push-tracking2.mirror &&
+	git config --bool remote.push-tracking2.pushHeadOnly &&
+	git config --bool remote.push-tracking2.autosetuppush &&
+	test $(git config remote.push-tracking2.push) = "refs/heads/another:refs/heads/another"
+)
+'
+
+test_expect_success 'configuration for --push -t (push.default = matching)' '
+(
+	cd test4 &&
+	git config push.default matching
+	git remote add -f push-matching2 -t side --push ../two &&
+	! git config --bool remote.push-matching2.mirror &&
+	! git config --bool remote.push-matching2.pushHeadOnly &&
+	! git config --bool remote.push-matching2.autosetuppush &&
+	test $(git config remote.push-matching2.push) = :
+)
+'
+
 test_expect_success 'remote forces tracking branches' '
 (
 	cd test &&
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index ea49ded..7a0ff99 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -225,7 +225,7 @@ test_expect_success 'push mirror adds, updates and removes tags together' '
 
 '
 
-test_expect_success 'remote.foo.mirror adds and removes branches' '
+test_expect_success 'git remote add --mirror adds and removes branches' '
 
 	mk_repo_pair --mirror &&
 	(
@@ -245,6 +245,26 @@ test_expect_success 'remote.foo.mirror adds and removes branches' '
 
 '
 
+test_expect_success 'git remote add --push=mirror adds and removes branches' '
+
+	mk_repo_pair --push=mirror &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch keep master &&
+		git branch remove master &&
+		git push up &&
+		git branch -D remove
+		git push up
+	) &&
+	(
+		cd mirror &&
+		git show-ref -s --verify refs/heads/keep &&
+		invert git show-ref -s --verify refs/heads/remove
+	)
+
+'
+
 test_expect_success 'remote.foo.mirror=no has no effect' '
 
 	mk_repo_pair &&
-- 
1.6.2.5
