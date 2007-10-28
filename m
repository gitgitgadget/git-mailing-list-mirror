From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 04/10] push: add "git push HEAD" shorthand for 'push current branch to default repo'
Date: Sun, 28 Oct 2007 18:46:15 +0100
Message-ID: <11935935812185-git-send-email-prohaska@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <11935935812741-git-send-email-prohaska@zib.de>
 <1193593581114-git-send-email-prohaska@zib.de>
 <1193593581486-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCI9-0000ou-MB
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXJ1RuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755519AbXJ1RuL
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:50:11 -0400
Received: from mailer.zib.de ([130.73.108.11]:63860 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754773AbXJ1Rtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:52 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkMsh016196
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLsY019730;
	Sun, 28 Oct 2007 18:46:21 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <1193593581486-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62582>

Sometimes it is handy to push only the current branch to the
default remote repository. For example, if you created a branch
using the '--track' option git knows that the current branch
is linked to a specific remote. But up to now you needed to say
"git push <defaultremote> <thisbranch>", which was quite
annoying.  You could have said "git push" but then _all_ branches
would have been pushed to the default remote.

This commit introduces "git push HEAD", which resolves HEAD to
the current branch and pushes only the current branch to its
default remote.

Setups that have a remote named HEAD will break. But such a setup
if unlikely to exist; and is not very sensible anyway.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-push.txt |    6 +++++-
 builtin-push.c             |    2 ++
 t/t5516-fetch-push.sh      |   12 ++++++++++++
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 67b354b..236898f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-push' [--all] [--dry-run] [--create] [--tags] [--receive-pack=<git-receive-pack>]
-           [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]
+           [--repo=all] [-f | --force] [-v] [HEAD | <repository> <refspec>...]
 
 DESCRIPTION
 -----------
@@ -25,6 +25,10 @@ documentation for gitlink:git-receive-pack[1].
 
 OPTIONS
 -------
+HEAD::
+	Tells push to push the current branch to the default
+	remote repository.
+
 <repository>::
 	The "remote" repository that is destination of a push
 	operation.  See the section <<URLS,GIT URLS>> below.
diff --git a/builtin-push.c b/builtin-push.c
index 2e3c8c6..7c08e19 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -102,6 +102,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 
 		if (arg[0] != '-') {
+			if (!strcmp("HEAD", arg))
+				break;
 			repo = arg;
 			i++;
 			break;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8becaf8..2650e36 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -291,6 +291,18 @@ test_expect_success 'push with HEAD' '
 
 '
 
+test_expect_success 'push HEAD' '
+
+	mk_test heads/track &&
+	git remote add test testrepo &&
+	git fetch test &&
+	git checkout -b track test/track &&
+	git reset --hard master &&
+	git push HEAD &&
+	check_push_result $the_commit heads/track
+
+'
+
 test_expect_success 'push with HEAD (--create)' '
 
 	mk_test &&
-- 
1.5.3.4.439.ge8b49
