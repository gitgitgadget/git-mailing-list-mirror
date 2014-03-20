From: Jeff King <peff@peff.net>
Subject: [PATCH 03/12] t: drop useless sane_unset GIT_* calls
Date: Thu, 20 Mar 2014 19:14:33 -0400
Message-ID: <20140320231433.GC8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:14:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmAa-0006ze-EK
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760082AbaCTXOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:14:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:43568 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759810AbaCTXOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:14:35 -0400
Received: (qmail 27726 invoked by uid 102); 20 Mar 2014 23:14:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:14:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:14:33 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244605>

Several test scripts manually unset GIT_CONFIG and other
GIT_* variables. These are generally taken care of for us by
test-lib.sh already.

Unsetting these is not only useless, but can be confusing to
a reader, who may wonder why some tests in a script unset
them and others do not (t0001 is particularly guilty of this
inconsistency, probably because many of its tests predate
the test-lib.sh environment-cleansing).

Note that we cannot always get rid of such unsetting. For
example, t9130 can drop the GIT_CONFIG unset, but not the
GIT_DIR one, because lib-git-svn.sh sets the latter. And in
t1000, we unset GIT_TEMPLATE_DIR, which is explicitly
initialized by test-lib.sh.

Signed-off-by: Jeff King <peff@peff.net>
---
I suppose one could make an argument that test-lib.sh may later change
the set of variables it clears, and these unsets are documenting an
explicit need of each test. I'd find that more compelling if it were
actually applied consistently.

 t/t0001-init.sh                 | 15 ---------------
 t/t9130-git-svn-authors-file.sh |  1 -
 t/t9400-git-cvsserver-server.sh |  1 -
 3 files changed, 17 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 9fb582b..ddc8160 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -25,7 +25,6 @@ check_config () {
 
 test_expect_success 'plain' '
 	(
-		sane_unset GIT_DIR GIT_WORK_TREE &&
 		mkdir plain &&
 		cd plain &&
 		git init
@@ -35,7 +34,6 @@ test_expect_success 'plain' '
 
 test_expect_success 'plain nested in bare' '
 	(
-		sane_unset GIT_DIR GIT_WORK_TREE &&
 		git init --bare bare-ancestor.git &&
 		cd bare-ancestor.git &&
 		mkdir plain-nested &&
@@ -47,7 +45,6 @@ test_expect_success 'plain nested in bare' '
 
 test_expect_success 'plain through aliased command, outside any git repo' '
 	(
-		sane_unset GIT_DIR GIT_WORK_TREE &&
 		HOME=$(pwd)/alias-config &&
 		export HOME &&
 		mkdir alias-config &&
@@ -65,7 +62,6 @@ test_expect_success 'plain through aliased command, outside any git repo' '
 
 test_expect_failure 'plain nested through aliased command' '
 	(
-		sane_unset GIT_DIR GIT_WORK_TREE &&
 		git init plain-ancestor-aliased &&
 		cd plain-ancestor-aliased &&
 		echo "[alias] aliasedinit = init" >>.git/config &&
@@ -78,7 +74,6 @@ test_expect_failure 'plain nested through aliased command' '
 
 test_expect_failure 'plain nested in bare through aliased command' '
 	(
-		sane_unset GIT_DIR GIT_WORK_TREE &&
 		git init --bare bare-ancestor-aliased.git &&
 		cd bare-ancestor-aliased.git &&
 		echo "[alias] aliasedinit = init" >>config &&
@@ -91,7 +86,6 @@ test_expect_failure 'plain nested in bare through aliased command' '
 
 test_expect_success 'plain with GIT_WORK_TREE' '
 	if (
-		sane_unset GIT_DIR &&
 		mkdir plain-wt &&
 		cd plain-wt &&
 		GIT_WORK_TREE=$(pwd) git init
@@ -104,7 +98,6 @@ test_expect_success 'plain with GIT_WORK_TREE' '
 
 test_expect_success 'plain bare' '
 	(
-		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
 		mkdir plain-bare-1 &&
 		cd plain-bare-1 &&
 		git --bare init
@@ -114,7 +107,6 @@ test_expect_success 'plain bare' '
 
 test_expect_success 'plain bare with GIT_WORK_TREE' '
 	if (
-		sane_unset GIT_DIR GIT_CONFIG &&
 		mkdir plain-bare-2 &&
 		cd plain-bare-2 &&
 		GIT_WORK_TREE=$(pwd) git --bare init
@@ -128,7 +120,6 @@ test_expect_success 'plain bare with GIT_WORK_TREE' '
 test_expect_success 'GIT_DIR bare' '
 
 	(
-		sane_unset GIT_CONFIG &&
 		mkdir git-dir-bare.git &&
 		GIT_DIR=git-dir-bare.git git init
 	) &&
@@ -138,7 +129,6 @@ test_expect_success 'GIT_DIR bare' '
 test_expect_success 'init --bare' '
 
 	(
-		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
 		mkdir init-bare.git &&
 		cd init-bare.git &&
 		git init --bare
@@ -149,7 +139,6 @@ test_expect_success 'init --bare' '
 test_expect_success 'GIT_DIR non-bare' '
 
 	(
-		sane_unset GIT_CONFIG &&
 		mkdir non-bare &&
 		cd non-bare &&
 		GIT_DIR=.git git init
@@ -160,7 +149,6 @@ test_expect_success 'GIT_DIR non-bare' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 
 	(
-		sane_unset GIT_CONFIG &&
 		mkdir git-dir-wt-1.git &&
 		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
 	) &&
@@ -170,7 +158,6 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 
 	if (
-		sane_unset GIT_CONFIG &&
 		mkdir git-dir-wt-2.git &&
 		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-2.git git --bare init
 	)
@@ -183,8 +170,6 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 test_expect_success 'reinit' '
 
 	(
-		sane_unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG &&
-
 		mkdir again &&
 		cd again &&
 		git init >out1 2>err1 &&
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index c3443ce..a812783 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -97,7 +97,6 @@ test_expect_success 'fresh clone with svn.authors-file in config' '
 		test x = x"$(git config svn.authorsfile)" &&
 		test_config="$HOME"/.gitconfig &&
 		sane_unset GIT_DIR &&
-		sane_unset GIT_CONFIG &&
 		git config --global \
 		  svn.authorsfile "$HOME"/svn-authors &&
 		test x"$HOME"/svn-authors = x"$(git config svn.authorsfile)" &&
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 3edc408..ed98e64 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -25,7 +25,6 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     test_done
 }
 
-unset GIT_DIR GIT_CONFIG
 WORKDIR=$(pwd)
 SERVERDIR=$(pwd)/gitcvs.git
 git_config="$SERVERDIR/config"
-- 
1.9.0.560.g01ceb46
