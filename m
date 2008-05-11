From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix cloning of HTTP URLs with '+' in their path
Date: Sat, 10 May 2008 17:14:49 -0700
Message-ID: <20080511001449.GA29155@yp-box.dyndns.org>
References: <d06901f0804011111o1da8a197ob6a9aaccb3e1e9a0@mail.gmail.com> <20080407081108.GA28853@soma> <d06901f0804081454r76a373e6h745f99a9dcbd6bc5@mail.gmail.com> <20080511000953.GA3128@yp-box.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Panagiotis Vossos <pavossos@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 02:15:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuzE4-0001Tt-0m
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 02:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbYEKAOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 20:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbYEKAOv
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 20:14:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52537 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbYEKAOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 20:14:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id ECD2E2DC08B;
	Sat, 10 May 2008 17:14:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080511000953.GA3128@yp-box.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81719>

With this, git svn clone -s http://svn.gnome.org/svn/gtk+
is successful.

Also modified the funky rename test for this, which _does_
include escaped '+' signs for HTTP URLs.  SVN seems to accept
either "+" or "%2B" in filenames and directories (just not the
main URL), so I'll leave it alone for now.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                             |    2 +-
 t/lib-git-svn.sh                         |    9 ++++++-
 t/t9115-git-svn-dcommit-funky-renames.sh |   35 +++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e47b1ea..413e0b1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3673,7 +3673,7 @@ sub escape_uri_only {
 	my ($uri) = @_;
 	my @tmp;
 	foreach (split m{/}, $uri) {
-		s/([^\w.%-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
+		s/([^\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
 		push @tmp, $_;
 	}
 	join('/', @tmp);
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 9decd2e..d8f3355 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -73,11 +73,16 @@ for d in \
 done
 
 start_httpd () {
+	repo_base_path="$1"
 	if test -z "$SVN_HTTPD_PORT"
 	then
 		echo >&2 'SVN_HTTPD_PORT is not defined!'
 		return
 	fi
+	if test -z "$repo_base_path"
+	then
+		repo_base_path=svn
+	fi
 
 	mkdir "$GIT_DIR"/logs
 
@@ -90,13 +95,13 @@ LockFile logs/accept.lock
 Listen 127.0.0.1:$SVN_HTTPD_PORT
 LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
 LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
-<Location /svn>
+<Location /$repo_base_path>
 	DAV svn
 	SVNPath $rawsvnrepo
 </Location>
 EOF
 	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k start
-	svnrepo=http://127.0.0.1:$SVN_HTTPD_PORT/svn
+	svnrepo="http://127.0.0.1:$SVN_HTTPD_PORT/$repo_base_path"
 }
 
 stop_httpd () {
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 182299c..4acbcb0 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -9,7 +9,7 @@ test_description='git-svn dcommit can commit renames of files with ugly names'
 
 test_expect_success 'load repository with strange names' "
 	svnadmin load -q $rawsvnrepo < ../t9115/funky-names.dump &&
-	start_httpd
+	start_httpd gtk+
 	"
 
 test_expect_success 'init and fetch repository' "
@@ -49,6 +49,39 @@ test_expect_success 'rename pretty file into ugly one' '
 	git svn dcommit
 	'
 
+test_expect_success 'add a file with plus signs' '
+	echo .. > +_+ &&
+	git update-index --add +_+ &&
+	git commit -m plus &&
+	mkdir gtk+ &&
+	git mv +_+ gtk+/_+_ &&
+	git commit -m plus_dir &&
+	git svn dcommit
+	'
+
+test_expect_success 'clone the repository to test rebase' "
+	git svn clone $svnrepo test-rebase &&
+	cd test-rebase &&
+		echo test-rebase > test-rebase &&
+		git add test-rebase &&
+		git commit -m test-rebase &&
+		cd ..
+	"
+
+test_expect_success 'make a commit to test rebase' "
+		echo test-rebase-main > test-rebase-main &&
+		git add test-rebase-main &&
+		git commit -m test-rebase-main &&
+		git svn dcommit
+	"
+
+test_expect_success 'git-svn rebase works inside a fresh-cloned repository' "
+	cd test-rebase &&
+		git svn rebase &&
+		test -e test-rebase-main &&
+		test -e test-rebase
+	"
+
 stop_httpd
 
 test_done
-- 
Eric Wong
