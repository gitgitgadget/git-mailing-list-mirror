From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH] pull: fix 'git pull --all' when current branch is tracking remote that is not last in the list of remotes
Date: Tue, 23 Feb 2010 22:55:31 +0000
Message-ID: <1266965731-4208-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 23:56:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk3fb-0003cp-Et
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679Ab0BWWzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 17:55:51 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35966 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab0BWWzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 17:55:49 -0500
Received: by bwz1 with SMTP id 1so1483007bwz.21
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 14:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=iP/thT7LIHBhIAOnuC+WmZpb6iRXiqVC2dWmGcJmtG8=;
        b=lBqDMwMfybUjuOKiP0BlU06LREoydOT6kzauRGJwQDW6yptnQr259hpBXucnbSsL7s
         5r/ZMTiKSOX2vmi7o+EKCxWSyxCqvedY2mhyowsPvvvSJsiqWjJyZofq70mFcokfH7sK
         yg1fuK3aYOj47WHWfIRRdKx7mxF1QGrohWf4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WvN7aWXPOdfkDvmAngTonOGxCIbmjZ94ujFeIs/aCDZ04rk4uE+ifGBW72ma4nV+GE
         tMLRc6M2pggHkplaStQxT8FYow8T6/QchMDywsvad4Ltt/4+chuF6GbGTZCk+YuQB9cK
         7Ch5nEaJKennpWIH7E5lVxDUD1CNgVH0dfU2s=
Received: by 10.204.33.211 with SMTP id i19mr149906bkd.127.1266965748381;
        Tue, 23 Feb 2010 14:55:48 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 14sm2235723bwz.2.2010.02.23.14.55.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 14:55:47 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1673.gc64ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140863>

Steps to reproduce the bug:

	1. Create repository and add more than one remote
	2. Make sure current branch is tracking branch from the remote AND this remote
	   is not last in the list of remotes
	3. 'git pull --all' exits with error message:

You asked to pull from the remote '--all', but did not specify
a branch. Because this is not the default configured remote
for your current branch, you must specify a branch on the command line.

A minimal test case is added that reproduces the problem.
Tested under Windows and Debian GNU/Linux.

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 builtin-fetch.c         |    6 +++++-
 git-pull.sh             |    6 +++++-
 t/t5521-pull-options.sh |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index d3b9d8a..8e54c5a 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -784,13 +784,17 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 static int fetch_multiple(struct string_list *list)
 {
 	int i, result = 0;
-	const char *argv[] = { "fetch", NULL, NULL, NULL, NULL, NULL, NULL };
+	const char *argv[] = { "fetch", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL };
 	int argc = 1;
 
 	if (dry_run)
 		argv[argc++] = "--dry-run";
 	if (prune)
 		argv[argc++] = "--prune";
+	if (append)
+		argv[argc++] = "--append";
+	if (update_head_ok)
+		argv[argc++] = "--update-head-ok";
 	if (verbosity >= 2)
 		argv[argc++] = "-v";
 	if (verbosity >= 1)
diff --git a/git-pull.sh b/git-pull.sh
index 38331a8..fcde096 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -214,7 +214,11 @@ test true = "$rebase" && {
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity --update-head-ok "$@" || exit 1
+if test -e "$GIT_DIR"/FETCH_HEAD
+then
+	rm "$GIT_DIR"/FETCH_HEAD 2>/dev/null
+fi
+git fetch $verbosity --update-head-ok --append "$@" || exit 1
 
 curr_head=$(git rev-parse -q --verify HEAD)
 if test -n "$orig_head" && test "$curr_head" != "$orig_head"
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 83e2e8a..2665caa 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -4,6 +4,17 @@ test_description='pull options'
 
 . ./test-lib.sh
 
+setup_repository () {
+	mkdir "$1" && (
+	cd "$1" &&
+	git init &&
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m "Initial"
+	)
+}
+
 D=`pwd`
 
 test_expect_success 'setup' '
@@ -57,4 +68,32 @@ test_expect_success 'git pull -q -v' '
 	test -s out
 '
 
+cd "$D"
+
+test_expect_success 'git pull --all' '
+	mkdir pullall &&
+	cd pullall &&
+	setup_repository remote1 &&
+	setup_repository remote2 &&
+	mkdir test &&
+	cd test &&
+	git init &&
+	git remote add remote1 "$D/pullall/remote1" &&
+	git remote add remote2 "$D/pullall/remote2" &&
+	(
+		# "git pull remote1" should print error message
+		# because there is no local branch that is tracking remote repo
+		git pull remote1
+		test $? = 1
+	) &&
+	(
+		# "git pull --all" should not print error message
+		# when current branch is tracking remote repo and that remote
+		# is not last in the list of remotes
+		git checkout -b remote1master remote1/master
+		git pull --all
+		test $? = 0
+	)
+'
+
 test_done
-- 
1.7.0.1706.g00cdbe
