From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: link shell libraries into valgrind directory
Date: Fri, 17 Jun 2011 16:36:32 -0400
Message-ID: <20110617203632.GA27793@sigill.intra.peff.net>
References: <20110617082956.GA20414@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 17 22:36:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXfmU-0006O4-4M
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 22:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493Ab1FQUgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 16:36:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45288
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932321Ab1FQUgf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 16:36:35 -0400
Received: (qmail 28607 invoked by uid 107); 17 Jun 2011 20:36:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Jun 2011 16:36:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2011 16:36:32 -0400
Content-Disposition: inline
In-Reply-To: <20110617082956.GA20414@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175958>

On Fri, Jun 17, 2011 at 04:29:57AM -0400, Jeff King wrote:

> I'm attempting to run the whole test suite under valgrind for 1.7.6-rc2.
> It's been a while since I've done a whole run, as there were some false
> positives in strspn on recent glibc which I've finally addressed.
> 
> We'll see what it comes up with later today. :)

It took about 8 hours to run on my measly quad-core. The good news is
that there were no actual bugs. After fixing the strspn (and some
strcasestr) false positives at the valgrind level, the only patch I
needed to get every test script running successfully was:

-- >8 --
Subject: tests: link shell libraries into valgrind directory

When we run tests under valgrind, we symlink anything
executable that starts with git-* or test-* into a special
valgrind bin directory, and then make that our
GIT_EXEC_PATH.

However, shell libraries like git-sh-setup do not have the
executable bit marked, and did not get symlinked.  This
means that any test looking for shell libraries in our
exec-path would fail to find them, even though that is a
fine thing to do when testing against a regular git build
(or in a git install, for that matter).

t2300 demonstrated this problem. The fix is to symlink these
shell libraries directly into the valgrind directory.

Signed-off-by: Jeff King <peff@peff.net>
---
Another strategy would be to actually check the Makefile variables to
see what to symlink; but that's a pretty big change, and what we have
now works fine (with this exception).

 t/test-lib.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 64390d7..8c57a00 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -884,8 +884,13 @@ then
 	}
 
 	make_valgrind_symlink () {
-		# handle only executables
-		test -x "$1" || return
+		# handle only executables, unless they are shell libraries that
+		# need to be in the exec-path.  We will just use "#!" as a
+		# guess for a shell-script, since we have no idea what the user
+		# may have configured as the shell path.
+		test -x "$1" ||
+		test "#!" = "$(head -c 2 <"$1")" ||
+		return;
 
 		base=$(basename "$1")
 		symlink_target=$GIT_BUILD_DIR/$base
-- 
1.7.6.rc1.38.g97f64
