From: Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH] remote add: add a --no-tags (-n) option
Date: Mon, 19 Apr 2010 15:50:14 +0200
Message-ID: <20100419135014.1077.28627.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 15:50:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3rMn-0003d7-J4
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 15:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab0DSNuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 09:50:18 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:44580 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab0DSNuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 09:50:17 -0400
Received: from localhost.localdomain (unknown [192.168.9.2])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id B8FAE653A
	for <git@vger.kernel.org>; Mon, 19 Apr 2010 15:50:14 +0200 (CEST)
User-Agent: StGit/0.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145297>

Add a '--no-tags' option to 'git remote add' which adds a
'remote.REMOTE.tagopt = --no-tags' to the configuration file.

'git add -f -n REMOTE' will create a new remote and fetch from it
without importing the tags. Subsequent 'git fetch REMOTE' will also
not import the tags.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 Documentation/git-remote.txt |    5 ++++-
 builtin/remote.c             |   11 ++++++++++-
 t/t5505-remote.sh            |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 3fc599c..9db3c35 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [-n] [--mirror] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote set-head' <name> (-a | -d | <branch>)
@@ -51,6 +51,9 @@ update remote-tracking branches <name>/<branch>.
 With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
+With `-n` option, `git fetch <name>` does not import tags from
+the remote repository.
++
 With `-t <branch>` option, instead of the default glob
 refspec for the remote to track all branches under
 `$GIT_DIR/remotes/<name>/`, a refspec to track only `<branch>`
diff --git a/builtin/remote.c b/builtin/remote.c
index 277765b..bb5606b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -106,7 +106,7 @@ static int fetch_remote(const char *name)
 
 static int add(int argc, const char **argv)
 {
-	int fetch = 0, mirror = 0;
+	int fetch = 0, mirror = 0, notags = 0;
 	struct string_list track = { NULL, 0, 0 };
 	const char *master = NULL;
 	struct remote *remote;
@@ -116,6 +116,8 @@ static int add(int argc, const char **argv)
 
 	struct option options[] = {
 		OPT_BOOLEAN('f', "fetch", &fetch, "fetch the remote branches"),
+		OPT_BOOLEAN('n', "no-tags", &notags,
+			"do not import remote tags when fetching"),
 		OPT_CALLBACK('t', "track", &track, "branch",
 			"branch(es) to track", opt_parse_track),
 		OPT_STRING('m', "master", &master, "branch", "master branch"),
@@ -172,6 +174,13 @@ static int add(int argc, const char **argv)
 			return 1;
 	}
 
+	if (notags) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.tagopt", name);
+		if (git_config_set(buf.buf, "--no-tags"))
+			return 1;
+	}
+
 	if (fetch && fetch_remote(name))
 		return 1;
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 230c0cd..d4ed7ea 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -320,6 +320,42 @@ test_expect_success 'add alt && prune' '
 	 git rev-parse --verify refs/remotes/origin/side2)
 '
 
+cat > test/expect << EOF
+some-tag
+EOF
+
+test_expect_success 'add with tags (default)' '
+	(cd one &&
+	 git tag -a -m "Some tag" some-tag) &&
+	(mkdir add-tags &&
+	 cd add-tags &&
+	 git init &&
+	 git remote add -f origin ../one &&
+	 git tag -l some-tag > ../test/output &&
+	 test_must_fail git config remote.origin.tagopt) &&
+	(cd one &&
+	 git tag -d some-tag) &&
+	test_cmp test/expect test/output
+'
+
+cat > test/expect << EOF
+--no-tags
+EOF
+
+test_expect_success 'add --no-tags' '
+	(cd one &&
+	 git tag -a -m "Some tag" some-tag) &&
+	(mkdir add-no-tags &&
+	 cd add-no-tags &&
+	 git init &&
+	 git remote add -f -n origin ../one &&
+	 git tag -l some-tag > ../test/output &&
+	 git config remote.origin.tagopt >> ../test/output) &&
+	(cd one &&
+	 git tag -d some-tag) &&
+	test_cmp test/expect test/output
+'
+
 cat > one/expect << EOF
   apis/master
   apis/side
