From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] remote: separate the concept of push and fetch mirrors
Date: Wed, 30 Mar 2011 15:53:19 -0400
Message-ID: <20110330195318.GB30624@sigill.intra.peff.net>
References: <20110330195139.GA814@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:53:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q51SJ-00006S-EW
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316Ab1C3TxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:53:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44335
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755158Ab1C3TxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:53:21 -0400
Received: (qmail 21060 invoked by uid 107); 30 Mar 2011 19:54:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 15:54:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 15:53:19 -0400
Content-Disposition: inline
In-Reply-To: <20110330195139.GA814@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170418>

git-remote currently has one option, "--mirror", which sets
up mirror configuration which can be used for either
fetching or pushing. It looks like this:

  [remote "mirror"]
    url = wherever
    fetch = +refs/*:refs/*
    mirror = true

However, a remote like this can be dangerous and confusing.
Specifically:

  1. If you issue the wrong command, it can be devastating.
     You are not likely to "push" when you meant to "fetch",
     but "git remote update" will try to fetch it, even if
     you intended the remote only for pushing. In either
     case, the results can be quite destructive. An
     unintended push will overwrite or delete remote refs,
     and an unintended fetch can overwrite local branches.

  2. The tracking setup code can produce confusing results.
     The fetch refspec above means that "git checkout -b new
     master" will consider refs/heads/master to come from
     the remote "mirror", even if you only ever intend to
     push to the mirror. It will set up the "new" branch to
     track mirror's refs/heads/master.

  3. The push code tries to opportunistically update
     tracking branches. If you "git push mirror foo:bar",
     it will see that we are updating mirror's
     refs/heads/bar, which corresponds to our local
     refs/heads/bar, and will update our local branch.

To solve this, we split the concept into "push mirrors" and
"fetch mirrors". Push mirrors set only remote.*.mirror,
solving (2) and (3), and making an accidental fetch write
only into FETCH_HEAD. Fetch mirrors set only the fetch
refspec, meaning an accidental push will not force-overwrite
or delete refs on the remote end.

The new syntax is "--mirror=<fetch|push>". For
compatibility, we keep "--mirror" as-is, setting up both
types simultaneously.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-remote.txt |   19 +++++++---
 builtin/remote.c             |   51 ++++++++++++++++++++-------
 t/t5505-remote.sh            |   78 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 37bd3e5..28724a9 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote set-head' <name> (-a | -d | <branch>)
@@ -67,11 +67,18 @@ multiple branches without grabbing all branches.
 With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
-In mirror mode, enabled with `\--mirror`, the refs will not be stored
-in the 'refs/remotes/' namespace, but in 'refs/heads/'.  This option
-only makes sense in bare repositories.  If a remote uses mirror
-mode, furthermore, `git push` will always behave as if `\--mirror`
-was passed.
+When a fetch mirror is created with `\--mirror=fetch`, the refs will not
+be stored in the 'refs/remotes/' namespace, but rather everything in
+'refs/' on the remote will be directly mirrored into 'refs/' in the
+local repository. This option only makes sense in bare repositories,
+because a fetch would overwrite any local commits.
++
+When a push mirror is created with `\--mirror=push`, then `git push`
+will always behave as if `\--mirror` was passed.
++
+The option `\--mirror` (with no type) sets up both push and fetch
+mirror configuration. It is kept for historical purposes, and is
+probably not what you want.
 
 'rename'::
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 2e25c6a..570407f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -9,7 +9,7 @@
 
 static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose]",
-	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
+	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror=<fetch|push>] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
 	"git remote set-head <name> (-a | -d | <branch>)",
@@ -117,6 +117,11 @@ enum {
 	TAGS_SET = 2
 };
 
+#define MIRROR_NONE 0
+#define MIRROR_FETCH 1
+#define MIRROR_PUSH 2
+#define MIRROR_BOTH (MIRROR_FETCH|MIRROR_PUSH)
+
 static int add_branch(const char *key, const char *branchname,
 		const char *remotename, int mirror, struct strbuf *tmp)
 {
@@ -131,9 +136,26 @@ static int add_branch(const char *key, const char *branchname,
 	return git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
+static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
+{
+	unsigned *mirror = opt->value;
+	if (not)
+		*mirror = MIRROR_NONE;
+	else if (!arg)
+		*mirror = MIRROR_BOTH;
+	else if (!strcmp(arg, "fetch"))
+		*mirror = MIRROR_FETCH;
+	else if (!strcmp(arg, "push"))
+		*mirror = MIRROR_PUSH;
+	else
+		return error("unknown mirror argument: %s", arg);
+	return 0;
+}
+
 static int add(int argc, const char **argv)
 {
-	int fetch = 0, mirror = 0, fetch_tags = TAGS_DEFAULT;
+	int fetch = 0, fetch_tags = TAGS_DEFAULT;
+	unsigned mirror = MIRROR_NONE;
 	struct string_list track = STRING_LIST_INIT_NODUP;
 	const char *master = NULL;
 	struct remote *remote;
@@ -151,7 +173,9 @@ static int add(int argc, const char **argv)
 		OPT_CALLBACK('t', "track", &track, "branch",
 			"branch(es) to track", opt_parse_track),
 		OPT_STRING('m', "master", &master, "branch", "master branch"),
-		OPT_BOOLEAN(0, "mirror", &mirror, "no separate remotes"),
+		{ OPTION_CALLBACK, 0, "mirror", &mirror, "push|fetch",
+			"set up remote as a mirror to push to or fetch from",
+			PARSE_OPT_OPTARG, parse_mirror_opt },
 		OPT_END()
 	};
 
@@ -182,18 +206,19 @@ static int add(int argc, const char **argv)
 	if (git_config_set(buf.buf, url))
 		return 1;
 
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s.fetch", name);
-
-	if (track.nr == 0)
-		string_list_append(&track, "*");
-	for (i = 0; i < track.nr; i++) {
-		if (add_branch(buf.buf, track.items[i].string,
-				name, mirror, &buf2))
-			return 1;
+	if (!mirror || mirror & MIRROR_FETCH) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.fetch", name);
+		if (track.nr == 0)
+			string_list_append(&track, "*");
+		for (i = 0; i < track.nr; i++) {
+			if (add_branch(buf.buf, track.items[i].string,
+				       name, mirror, &buf2))
+				return 1;
+		}
 	}
 
-	if (mirror) {
+	if (mirror & MIRROR_PUSH) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.mirror", name);
 		if (git_config_set(buf.buf, "true"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index d189add..4e69c90 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -304,6 +304,84 @@ test_expect_success 'add --mirror && prune' '
 	 git rev-parse --verify refs/heads/side)
 '
 
+test_expect_success 'add --mirror=fetch' '
+	mkdir mirror-fetch &&
+	git init mirror-fetch/parent &&
+	(cd mirror-fetch/parent &&
+	 test_commit one) &&
+	git init --bare mirror-fetch/child &&
+	(cd mirror-fetch/child &&
+	 git remote add --mirror=fetch -f parent ../parent)
+'
+
+test_expect_success 'fetch mirrors act as mirrors during fetch' '
+	(cd mirror-fetch/parent &&
+	 git branch new &&
+	 git branch -m master renamed
+	) &&
+	(cd mirror-fetch/child &&
+	 git fetch parent &&
+	 git rev-parse --verify refs/heads/new &&
+	 git rev-parse --verify refs/heads/renamed
+	)
+'
+
+test_expect_success 'fetch mirrors can prune' '
+	(cd mirror-fetch/child &&
+	 git remote prune parent &&
+	 test_must_fail git rev-parse --verify refs/heads/master
+	)
+'
+
+test_expect_success 'fetch mirrors do not act as mirrors during push' '
+	(cd mirror-fetch/parent &&
+	 git checkout HEAD^0
+	) &&
+	(cd mirror-fetch/child &&
+	 git branch -m renamed renamed2 &&
+	 git push parent
+	) &&
+	(cd mirror-fetch/parent &&
+	 git rev-parse --verify renamed &&
+	 test_must_fail git rev-parse --verify refs/heads/renamed2
+	)
+'
+
+test_expect_success 'add --mirror=push' '
+	mkdir mirror-push &&
+	git init --bare mirror-push/public &&
+	git init mirror-push/private &&
+	(cd mirror-push/private &&
+	 test_commit one &&
+	 git remote add --mirror=push public ../public
+	)
+'
+
+test_expect_success 'push mirrors act as mirrors during push' '
+	(cd mirror-push/private &&
+	 git branch new &&
+	 git branch -m master renamed &&
+	 git push public
+	) &&
+	(cd mirror-push/private &&
+	 git rev-parse --verify refs/heads/new &&
+	 git rev-parse --verify refs/heads/renamed &&
+	 test_must_fail git rev-parse --verify refs/heads/master
+	)
+'
+
+test_expect_success 'push mirrors do not act as mirrors during fetch' '
+	(cd mirror-push/public &&
+	 git branch -m renamed renamed2 &&
+	 git symbolic-ref HEAD refs/heads/renamed2
+	) &&
+	(cd mirror-push/private &&
+	 git fetch public &&
+	 git rev-parse --verify refs/heads/renamed &&
+	 test_must_fail git rev-parse --verify refs/heads/renamed2
+	)
+'
+
 test_expect_success 'add alt && prune' '
 	(mkdir alttst &&
 	 cd alttst &&
-- 
1.7.4.2.8.g3ccd6
