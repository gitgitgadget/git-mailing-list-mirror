From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7400: fix bogus test failure with symlinked trash
Date: Sat, 30 Jul 2011 09:05:54 -0600
Message-ID: <20110730150554.GA5355@sigill.intra.peff.net>
References: <20110730003609.GA6089@sigill.intra.peff.net>
 <4E33DFD6.9050709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 30 17:06:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnB75-00045Q-6h
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 17:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab1G3PF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 11:05:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36119
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572Ab1G3PF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 11:05:57 -0400
Received: (qmail 1507 invoked by uid 107); 30 Jul 2011 15:06:29 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 30 Jul 2011 11:06:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jul 2011 09:05:54 -0600
Content-Disposition: inline
In-Reply-To: <4E33DFD6.9050709@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178205>

On Sat, Jul 30, 2011 at 12:41:26PM +0200, Jens Lehmann wrote:

> Am 30.07.2011 02:36, schrieb Jeff King:
> > This feels a little funny, because we are probably using the same
> > "convert relative to absolute" code to generate our expected value, as
> > well as in the test itself. So any bug in that code is likely to be
> > masked. But this test isn't really about checking the absolute path
> > code, but rather making sure that it is invoked properly.
> 
> While the patch itself is good (apart from using backticks, I think
> a "$()" should be used there), I share your concerns about loosing
> an opportunity to test git functionality against the real world.
> 
> What about doing the following instead?
> 
> submodurl=$(cd "$TRASH_DIRECTORY"; pwd -P)
> 
> (That pattern is already used in t/t0000-basic.sh)

That's fine by me. I assumed we didn't have any portable external tool
we could rely on, but if we have been using "pwd -P" in t0000, it's
probably OK.

So how about:

-- >8 --
Subject: [PATCH] t7400: fix bogus test failure with symlinked trash

One of the tests in t7400 fails if the trash directory has a
symlink anywhere in its path. E.g.:

  $ mkdir /tmp/git-test
  $ mkdir /tmp/git-test/real
  $ ln -s real /tmp/git-test/link

  $ ./t7400-submodule-basic --root=/tmp/git-test/real
  ...
  # passed all 44 test(s)

  $ ./t7400-submodule-basic --root=/tmp/git-test/link
  ...
  not ok - 41 use superproject as upstream when path is relative and no url is set there

The failing test does:

  git submodule add ../repo relative &&
  ...
  git submodule sync relative &&
  test "$(git config submodule.relative.url)" = "$submodurl/repo"

where $submodurl comes from the $TRASH_DIRECTORY the user
gave us. However, git will resolve symlinks when converting
the relative path into an absolute one, leading them to be
textually different (even though they point to the same
directory).

Fix this by asking pwd to canonicalize the name of the trash
directory for us.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7400-submodule-basic.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5afe6cc..14dc927 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -47,8 +47,10 @@ test_expect_success 'setup - repository to add submodules to' '
 '
 
 # The 'submodule add' tests need some repository to add as a submodule.
-# The trash directory is a good one as any.
-submodurl=$TRASH_DIRECTORY
+# The trash directory is a good one as any. We need to canonicalize
+# the name, though, as some tests compare it to the absolute path git
+# generates, which will expand symbolic links.
+submodurl=$(pwd -P)
 
 listbranches() {
 	git for-each-ref --format='%(refname)' 'refs/heads/*'
-- 
1.7.5.4.31.ge4d5e
