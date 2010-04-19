From: Samuel Tardieu <sam@rfc1149.net>
Subject: [v3 PATCH 2/2] remote add: add a --no-tags (-n) option
Date: Tue, 20 Apr 2010 01:31:31 +0200
Message-ID: <20100419233131.3631.20743.stgit@localhost.localdomain>
References: <20100419233026.3631.67086.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 01:31:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O40RH-0006Pb-Su
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 01:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab0DSXbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 19:31:33 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:36922 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab0DSXbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 19:31:32 -0400
Received: from localhost.localdomain (unknown [192.168.9.2])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 8E8906541
	for <git@vger.kernel.org>; Tue, 20 Apr 2010 01:31:31 +0200 (CEST)
In-Reply-To: <20100419233026.3631.67086.stgit@localhost.localdomain>
User-Agent: StGit/0.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145343>

Add '--[no-]tags' options to 'git remote add' which add the
'remote.REMOTE.tagopt = --[no-]tags' to the configuration file.
This mimics the "--tags" and "--no-tags" options of "git fetch".

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 Documentation/git-remote.txt |    8 +++++
 builtin/remote.c             |   21 +++++++++++++-
 t/t5505-remote.sh            |   63 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 3fc599c..ebaaadc 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote set-head' <name> (-a | -d | <branch>)
@@ -51,6 +51,12 @@ update remote-tracking branches <name>/<branch>.
 With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
+With `--tags` option, `git fetch <name>` imports every tag from the
+remote repository.
++
+With `--no-tags` option, `git fetch <name>` does not import tags from
+the remote repository.
++
 With `-t <branch>` option, instead of the default glob
 refspec for the remote to track all branches under
 `$GIT_DIR/remotes/<name>/`, a refspec to track only `<branch>`
diff --git a/builtin/remote.c b/builtin/remote.c
index 277765b..0e99a99 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -104,9 +104,15 @@ static int fetch_remote(const char *name)
 	return 0;
 }
 
+enum {
+	TAGS_UNSET = 0,
+	TAGS_DEFAULT = 1,
+	TAGS_SET = 2
+};
+
 static int add(int argc, const char **argv)
 {
-	int fetch = 0, mirror = 0;
+	int fetch = 0, mirror = 0, fetch_tags = TAGS_DEFAULT;
 	struct string_list track = { NULL, 0, 0 };
 	const char *master = NULL;
 	struct remote *remote;
@@ -116,6 +122,11 @@ static int add(int argc, const char **argv)
 
 	struct option options[] = {
 		OPT_BOOLEAN('f', "fetch", &fetch, "fetch the remote branches"),
+		OPT_SET_INT(0, "tags", &fetch_tags,
+			    "import all tags and associated objects when fetching",
+			    TAGS_SET),
+		OPT_SET_INT(0, NULL, &fetch_tags,
+			    "or do not fetch any tag at all (--no-tags)", TAGS_UNSET),
 		OPT_CALLBACK('t', "track", &track, "branch",
 			"branch(es) to track", opt_parse_track),
 		OPT_STRING('m', "master", &master, "branch", "master branch"),
@@ -172,6 +183,14 @@ static int add(int argc, const char **argv)
 			return 1;
 	}
 
+	if (fetch_tags != TAGS_DEFAULT) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.tagopt", name);
+		if (git_config_set(buf.buf,
+			fetch_tags == TAGS_SET ? "--tags" : "--no-tags"))
+			return 1;
+	}
+
 	if (fetch && fetch_remote(name))
 		return 1;
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 230c0cd..79fe9a0 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -320,6 +320,69 @@ test_expect_success 'add alt && prune' '
 	 git rev-parse --verify refs/remotes/origin/side2)
 '
 
+cat > test/expect << EOF
+some-tag
+EOF
+
+test_expect_success 'add with reachable tags (default)' '
+	(cd one &&
+	 touch foobar &&
+	 git add foobar &&
+	 git commit -m "Foobar" &&
+	 git tag -a -m "Foobar tag" foobar-tag &&
+	 git reset --hard HEAD~1 &&
+	 git tag -a -m "Some tag" some-tag) &&
+	(mkdir add-tags &&
+	 cd add-tags &&
+	 git init &&
+	 git remote add -f origin ../one &&
+	 git tag -l some-tag > ../test/output &&
+	 git tag -l foobar-tag >> ../test/output &&
+	 test_must_fail git config remote.origin.tagopt) &&
+	test_cmp test/expect test/output
+'
+
+cat > test/expect << EOF
+some-tag
+foobar-tag
+--tags
+EOF
+
+test_expect_success 'add --tags' '
+	(rm -rf add-tags &&
+	 mkdir add-tags &&
+	 cd add-tags &&
+	 git init &&
+	 git remote add -f --tags origin ../one &&
+	 git tag -l some-tag > ../test/output &&
+	 git tag -l foobar-tag >> ../test/output &&
+	 git config remote.origin.tagopt >> ../test/output) &&
+	test_cmp test/expect test/output
+'
+
+cat > test/expect << EOF
+--no-tags
+EOF
+
+test_expect_success 'add --no-tags' '
+	(rm -rf add-tags &&
+	 mkdir add-no-tags &&
+	 cd add-no-tags &&
+	 git init &&
+	 git remote add -f --no-tags origin ../one &&
+	 git tag -l some-tag > ../test/output &&
+	 git tag -l foobar-tag > ../test/output &&
+	 git config remote.origin.tagopt >> ../test/output) &&
+	(cd one &&
+	 git tag -d some-tag foobar-tag) &&
+	test_cmp test/expect test/output
+'
+
+test_expect_success 'reject --no-no-tags' '
+	(cd add-no-tags &&
+	 test_must_fail git remote add -f --no-no-tags neworigin ../one)
+'
+
 cat > one/expect << EOF
   apis/master
   apis/side
