From: Jeff King <peff@peff.net>
Subject: [PATCH] t7400: fix bogus test failure with symlinked trash
Date: Fri, 29 Jul 2011 18:36:09 -0600
Message-ID: <20110730003609.GA6089@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 02:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmxZq-00064s-BK
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 02:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132Ab1G3AgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 20:36:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53036
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab1G3AgP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 20:36:15 -0400
Received: (qmail 28489 invoked by uid 107); 30 Jul 2011 00:36:44 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Jul 2011 20:36:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2011 18:36:09 -0600
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178172>

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

Fix this by asking git to canonicalize the name of the trash
directory for us.

Signed-off-by: Jeff King <peff@peff.net>
---
This feels a little funny, because we are probably using the same
"convert relative to absolute" code to generate our expected value, as
well as in the test itself. So any bug in that code is likely to be
masked. But this test isn't really about checking the absolute path
code, but rather making sure that it is invoked properly.

 t/t7400-submodule-basic.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5afe6cc..12200ca 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -48,7 +48,7 @@ test_expect_success 'setup - repository to add submodules to' '
 
 # The 'submodule add' tests need some repository to add as a submodule.
 # The trash directory is a good one as any.
-submodurl=$TRASH_DIRECTORY
+submodurl=`git rev-parse --show-toplevel`
 
 listbranches() {
 	git for-each-ref --format='%(refname)' 'refs/heads/*'
-- 
1.7.5.4.31.ge4d5e
