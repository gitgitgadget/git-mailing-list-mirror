From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] remote add: add a --no-tags (-n) option
Date: Mon, 19 Apr 2010 22:19:10 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2010-04-19-22-19-11+trackit+sam@rfc1149.net>
References: <20100419135014.1077.28627.stgit@localhost.localdomain>
	<7vvdbnqpis.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 22:19:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3xRB-0002RE-UE
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 22:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138Ab0DSUTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 16:19:16 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:33901 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab0DSUTP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 16:19:15 -0400
Received: from localhost (unknown [IPv6:2001:6f8:37a:2:211:2fff:fe8a:af74])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 679FE70B4;
	Mon, 19 Apr 2010 22:19:11 +0200 (CEST)
In-Reply-To: <7vvdbnqpis.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 19 Apr 2010 11:13:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145324>

Add a '--no-tags' option to 'git remote add' which adds a
'remote.REMOTE.tagopt = --no-tags' to the configuration file.

'git remote add -f -n REMOTE' will create a new remote and fetch
from it without importing the tags. Subsequent 'git fetch REMOTE'
will also not import the tags.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

---
 Documentation/git-remote.txt |    5 ++++-
 builtin/remote.c             |   12 +++++++++++-
 t/t5505-remote.sh            |   41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> Any long-opt that begins with "no-" looks wrong, especially that
Junio> will allow people to say "--no-no-tags".  Perhaps something like
Junio> this is necessary.

Junio>     { OPTION_BOOLEAN, 0, "tags", &tags, NULL, "fetch tags",
Junio> PARSE_OPT_NOARG }

In this version I've used "PARSE_OPT_NOARG | PARSE_OPT_NONEG" to forbid
"--no-no-tags" and added a test for it.

Junio> Or imitate whatever we do in builtin-fetch.c; although I suspect
Junio> the default would be different in this command and "git fetch",
Junio> so you may need to adjust for the difference a bit.

I don't think we need to add "--tags" to "git remote add", do you? If
you do, this is not difficult to add using the "git fetch" logic you
describe.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

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
index 277765b..ff16487 100644
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
@@ -116,6 +116,9 @@ static int add(int argc, const char **argv)
 
 	struct option options[] = {
 		OPT_BOOLEAN('f', "fetch", &fetch, "fetch the remote branches"),
+		{ OPTION_BOOLEAN, 'n', "no-tags", &notags, NULL,
+		  "do not import remote tags when fetching",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG },
 		OPT_CALLBACK('t', "track", &track, "branch",
 			"branch(es) to track", opt_parse_track),
 		OPT_STRING('m', "master", &master, "branch", "master branch"),
@@ -172,6 +175,13 @@ static int add(int argc, const char **argv)
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
index 230c0cd..47e9e67 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -320,6 +320,47 @@ test_expect_success 'add alt && prune' '
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
+test_expect_success 'reject --no-no-tags' '
+	(cd add-no-tags &&
+	 test_must_fail git remote add -f --no-no-tags neworigin ../one)
+'
+
 cat > one/expect << EOF
   apis/master
   apis/side
-- 
tg: (af02b6d..) t/no-tags (depends on: origin/next)
