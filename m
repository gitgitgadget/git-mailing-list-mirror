From: Jeff King <peff@peff.net>
Subject: Re: test -L usage
Date: Tue, 21 Sep 2010 20:35:59 -0400
Message-ID: <20100922003559.GB23931@sigill.intra.peff.net>
References: <201009220011.o8M0BFO26150@momjian.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bruce Momjian <bruce@momjian.us>
X-From: git-owner@vger.kernel.org Wed Sep 22 02:36:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyDJg-0002pX-Nq
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 02:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994Ab0IVAgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 20:36:01 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59818 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905Ab0IVAgB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 20:36:01 -0400
Received: (qmail 14257 invoked by uid 111); 22 Sep 2010 00:36:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 22 Sep 2010 00:36:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Sep 2010 20:35:59 -0400
Content-Disposition: inline
In-Reply-To: <201009220011.o8M0BFO26150@momjian.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156776>

On Tue, Sep 21, 2010 at 08:11:15PM -0400, Bruce Momjian wrote:

> git-1.7.3/contrib/workdir/git-new-workdir uses 'test -L' to test for
> symlinks.  I suggest using 'test -h' because it is more portable, and
> would have avoided a problem on my BSD machine.

Yeah, we generally do, but the stuff in contrib/ doesn't get exercised
as much. There are also a few occurences in the svn tests. All cleaned
up with the patch below.

-->8--
Subject: [PATCH] prefer test -h over test -L in shell scripts

Even though "-L" is POSIX, the former is more portable, and
we tend to prefer it already.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/workdir/git-new-workdir  |    2 +-
 t/t9100-git-svn-basic.sh         |    6 +++---
 t/t9131-git-svn-empty-symlink.sh |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 3ad2c0c..75e8b25 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -42,7 +42,7 @@ then
 fi
 
 # don't link to a workdir
-if test -L "$git_dir/config"
+if test -h "$git_dir/config"
 then
 	die "\"$orig_git\" is a working directory only, please specify" \
 		"a complete repository."
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 2f458f7..b041516 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -143,7 +143,7 @@ test_expect_success "$name" '
 	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
 	svn_cmd up "$SVN_TREE" &&
-	test -L "$SVN_TREE"/exec.sh'
+	test -h "$SVN_TREE"/exec.sh'
 
 name='new symlink is added to a file that was also just made executable'
 
@@ -156,7 +156,7 @@ test_expect_success "$name" '
 		${remotes_git_svn}..mybranch5 &&
 	svn_cmd up "$SVN_TREE" &&
 	test -x "$SVN_TREE"/bar/zzz &&
-	test -L "$SVN_TREE"/exec-2.sh'
+	test -h "$SVN_TREE"/exec-2.sh'
 
 name='modify a symlink to become a file'
 test_expect_success "$name" '
@@ -169,7 +169,7 @@ test_expect_success "$name" '
 		${remotes_git_svn}..mybranch5 &&
 	svn_cmd up "$SVN_TREE" &&
 	test -f "$SVN_TREE"/exec-2.sh &&
-	test ! -L "$SVN_TREE"/exec-2.sh &&
+	test ! -h "$SVN_TREE"/exec-2.sh &&
 	test_cmp help "$SVN_TREE"/exec-2.sh'
 
 name="commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
diff --git a/t/t9131-git-svn-empty-symlink.sh b/t/t9131-git-svn-empty-symlink.sh
index 9a24a65..f762038 100755
--- a/t/t9131-git-svn-empty-symlink.sh
+++ b/t/t9131-git-svn-empty-symlink.sh
@@ -88,7 +88,7 @@ test_expect_success 'enable broken symlink workaround' \
 test_expect_success '"bar" is an empty file' 'test -f x/bar && ! test -s x/bar'
 test_expect_success 'get "bar" => symlink fix from svn' \
 		'(cd x && git svn rebase)'
-test_expect_success SYMLINKS '"bar" becomes a symlink' 'test -L x/bar'
+test_expect_success SYMLINKS '"bar" becomes a symlink' 'test -h x/bar'
 
 
 test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" y'
-- 
1.7.3.256.gb9713
