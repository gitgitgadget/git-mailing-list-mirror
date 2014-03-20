From: Jeff King <peff@peff.net>
Subject: [PATCH 06/12] t: prefer "git config --file" to GIT_CONFIG
Date: Thu, 20 Mar 2014 19:17:01 -0400
Message-ID: <20140320231701.GF8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:17:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmD0-0000f2-5Y
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759630AbaCTXRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:17:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:43583 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758342AbaCTXRD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:17:03 -0400
Received: (qmail 27971 invoked by uid 102); 20 Mar 2014 23:17:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:17:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:17:01 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244608>

Doing:

  GIT_CONFIG=foo git config ...

is equivalent to:

  git config --file=foo ...

The latter is easier to read and slightly less error-prone,
because of issues with one-shot variables and shell
functions (e.g., you cannot use the former with
test_must_fail).

Note that we explicitly leave one case in t1300 which checks
the same operation on both GIT_CONFIG and "git config
--file". They are equivalent in the code these days, but
this will make sure it remains so.

Signed-off-by: Jeff King <peff@peff.net>
---
Unlike the last patch, this one has no tangible benefits besides "Peff
thinks it looks better". I also tend to think that GIT_CONFIG is
something that it would be nice to get rid of in the long run, but I
don't have any immediate plans to do so.

 t/t1300-repo-config.sh          | 20 ++++++++++----------
 t/t1302-repo-version.sh         |  2 +-
 t/t7400-submodule-basic.sh      |  5 ++---
 t/t9130-git-svn-authors-file.sh |  2 +-
 t/t9154-git-svn-fancy-glob.sh   |  6 +++---
 5 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index e355aa1..85c6637 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -461,7 +461,7 @@ test_expect_success 'new variable inserts into proper section' '
 	test_cmp expect .git/config
 '
 
-test_expect_success 'alternative GIT_CONFIG (non-existing file should fail)' '
+test_expect_success 'alternative --file (non-existing file should fail)' '
 	test_must_fail git config --file non-existing-config -l
 '
 
@@ -495,10 +495,10 @@ test_expect_success 'refer config from subdirectory' '
 
 '
 
-test_expect_success 'refer config from subdirectory via GIT_CONFIG' '
+test_expect_success 'refer config from subdirectory via --file' '
 	(
 		cd x &&
-		GIT_CONFIG=../other-config git config --get ein.bahn >actual &&
+		git config --file=../other-config --get ein.bahn >actual &&
 		test_cmp expect actual
 	)
 '
@@ -510,8 +510,8 @@ cat > expect << EOF
 	park = ausweis
 EOF
 
-test_expect_success '--set in alternative GIT_CONFIG' '
-	GIT_CONFIG=other-config git config anwohner.park ausweis &&
+test_expect_success '--set in alternative file' '
+	git config --file=other-config anwohner.park ausweis &&
 	test_cmp expect other-config
 '
 
@@ -942,11 +942,11 @@ test_expect_success 'inner whitespace kept verbatim' '
 
 test_expect_success SYMLINKS 'symlinked configuration' '
 	ln -s notyet myconfig &&
-	GIT_CONFIG=myconfig git config test.frotz nitfol &&
+	git config --file=myconfig test.frotz nitfol &&
 	test -h myconfig &&
 	test -f notyet &&
-	test "z$(GIT_CONFIG=notyet git config test.frotz)" = znitfol &&
-	GIT_CONFIG=myconfig git config test.xyzzy rezrov &&
+	test "z$(git config --file=notyet test.frotz)" = znitfol &&
+	git config --file=myconfig test.xyzzy rezrov &&
 	test -h myconfig &&
 	test -f notyet &&
 	cat >expect <<-\EOF &&
@@ -954,8 +954,8 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 	rezrov
 	EOF
 	{
-		GIT_CONFIG=notyet git config test.frotz &&
-		GIT_CONFIG=notyet git config test.xyzzy
+		git config --file=notyet test.frotz &&
+		git config --file=notyet test.xyzzy
 	} >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 0e47662..0d9388a 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 
 	test_create_repo "test" &&
 	test_create_repo "test2" &&
-	GIT_CONFIG=test2/.git/config git config core.repositoryformatversion 99
+	git config --file=test2/.git/config core.repositoryformatversion 99
 '
 
 test_expect_success 'gitdir selection on normal repos' '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c28e8d8..7c88245 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -249,8 +249,7 @@ test_expect_success 'submodule add in subdirectory with relative path should fai
 '
 
 test_expect_success 'setup - add an example entry to .gitmodules' '
-	GIT_CONFIG=.gitmodules \
-	git config submodule.example.url git://example.com/init.git
+	git config --file=.gitmodules submodule.example.url git://example.com/init.git
 '
 
 test_expect_success 'status should fail for unmapped paths' '
@@ -264,7 +263,7 @@ test_expect_success 'setup - map path in .gitmodules' '
 	path = init
 EOF
 
-	GIT_CONFIG=.gitmodules git config submodule.example.path init &&
+	git config --file=.gitmodules submodule.example.path init &&
 
 	test_cmp expect .gitmodules
 '
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index a812783..c44de26 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -67,7 +67,7 @@ test_expect_success 'fetch fails on ee' '
 	'
 
 tmp_config_get () {
-	GIT_CONFIG=.git/svn/.metadata git config --get "$1"
+	git config --file=.git/svn/.metadata --get "$1"
 }
 
 test_expect_success 'failure happened without negative side effects' '
diff --git a/t/t9154-git-svn-fancy-glob.sh b/t/t9154-git-svn-fancy-glob.sh
index b780e0e..a0150f0 100755
--- a/t/t9154-git-svn-fancy-glob.sh
+++ b/t/t9154-git-svn-fancy-glob.sh
@@ -22,7 +22,7 @@ test_expect_success 'add red branch' "
 	"
 
 test_expect_success 'add gre branch' "
-	GIT_CONFIG=.git/svn/.metadata git config --unset svn-remote.svn.branches-maxRev &&
+	git config --file=.git/svn/.metadata --unset svn-remote.svn.branches-maxRev &&
 	git config svn-remote.svn.branches 'branches/{red,gre}:refs/remotes/*' &&
 	git svn fetch &&
 	git rev-parse refs/remotes/red &&
@@ -31,7 +31,7 @@ test_expect_success 'add gre branch' "
 	"
 
 test_expect_success 'add green branch' "
-	GIT_CONFIG=.git/svn/.metadata git config --unset svn-remote.svn.branches-maxRev &&
+	git config --file=.git/svn/.metadata --unset svn-remote.svn.branches-maxRev &&
 	git config svn-remote.svn.branches 'branches/{red,green}:refs/remotes/*' &&
 	git svn fetch &&
 	git rev-parse refs/remotes/red &&
@@ -40,7 +40,7 @@ test_expect_success 'add green branch' "
 	"
 
 test_expect_success 'add all branches' "
-	GIT_CONFIG=.git/svn/.metadata git config --unset svn-remote.svn.branches-maxRev &&
+	git config --file=.git/svn/.metadata --unset svn-remote.svn.branches-maxRev &&
 	git config svn-remote.svn.branches 'branches/*:refs/remotes/*' &&
 	git svn fetch &&
 	git rev-parse refs/remotes/red &&
-- 
1.9.0.560.g01ceb46
