From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] t9107: switch inverted single/double quotes in test
Date: Fri, 13 May 2016 16:47:24 -0400
Message-ID: <20160513204724.GD15391@sigill.intra.peff.net>
References: <20160513204654.GA10684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 22:47:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Jzi-0000VV-5t
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbcEMUr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:47:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:39375 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932178AbcEMUr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:47:28 -0400
Received: (qmail 16736 invoked by uid 102); 13 May 2016 20:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:47:27 -0400
Received: (qmail 21608 invoked by uid 107); 13 May 2016 20:47:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:47:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 16:47:24 -0400
Content-Disposition: inline
In-Reply-To: <20160513204654.GA10684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294582>

One of the test snippets in t9107 is enclosed in double
quotes, but then uses single quotes to surround an
interpolated variable inside the snippet, like:

  test_expect_success '...' "
	test -n '$head'
  "

This happens to work because the variable is interpolated
_before_ the snippet is run, and the result is eval'd. So as
long as the variable does not contain any single quotes, the
two are equivalent. And it doesn't, as we know it is a sha1
from rev-parse above.  But this construct is unnecessarily
confusing.

But we can go a step further in cleaning up. The test is
really checking that a particular ref has a value. Rather
than checking if rev-parse produced output, we can just move
rev-parse into the test itself, and rely on the exit code
from --verify. Nobody else cares about the $head variable at
all.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9107-git-svn-migrate.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 2908aef..bb03722 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -24,8 +24,9 @@ test_expect_success 'setup old-looking metadata' '
 	git update-ref -d refs/remotes/git-svn refs/remotes/git-svn
 	'
 
-head=$(git rev-parse --verify refs/heads/git-svn-HEAD^0)
-test_expect_success 'git-svn-HEAD is a real HEAD' "test -n '$head'"
+test_expect_success 'git-svn-HEAD is a real HEAD' '
+	git rev-parse --verify refs/heads/git-svn-HEAD^0
+'
 
 svnrepo_escaped=$(echo $svnrepo | sed 's/ /%20/')
 
-- 
2.8.2.825.gea31738
