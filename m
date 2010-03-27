From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Feature request: option to not fetch tags for 'git remote' branches
Date: Sat, 27 Mar 2010 20:10:25 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2010-03-27-20-10-25+trackit+sam@rfc1149.net>
References: <201003242154.29245.elendil@planet.nl>
	<4BAA7F5B.2040400@feurix.com> <201003242246.16286.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: John Feuerstein <john@feurix.com>, git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Sat Mar 27 20:19:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvbXc-0001Ig-K2
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 20:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab0C0TTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 15:19:21 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:35938 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab0C0TTT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 15:19:19 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Mar 2010 15:19:19 EDT
Received: from localhost (unknown [IPv6:2001:6f8:37a:2:211:2fff:fe8a:af74])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 65B7D6B48;
	Sat, 27 Mar 2010 20:10:25 +0100 (CET)
In-Reply-To: <201003242246.16286.elendil@planet.nl> (Frans Pop's message of
	"Wed, 24 Mar 2010 22:46:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143344>

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


>>>>> "Frans" == Frans Pop <elendil@planet.nl> writes:

Frans> I still think it would be nice if that could be set with an
Frans> option for 'git remote add'. That would make life so much simpler

This should do the job.

  Sam


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
index 2692050..3a92a70 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -319,6 +319,42 @@ test_expect_success 'add alt && prune' '
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
