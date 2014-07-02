From: Jeff King <peff@peff.net>
Subject: [PATCH] t7300: repair filesystem permissions with test_when_finished
Date: Wed, 2 Jul 2014 14:44:30 -0400
Message-ID: <20140702184429.GA32538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 20:44:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2PWG-00029E-BS
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 20:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712AbaGBSoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 14:44:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:55052 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755989AbaGBSoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 14:44:32 -0400
Received: (qmail 30705 invoked by uid 102); 2 Jul 2014 18:44:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jul 2014 13:44:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jul 2014 14:44:30 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252827>

We create a directory that cannot be removed, confirm that
it cannot be removed, and then fix it like:

  chmod 0 foo &&
  test_must_fail git clean -d -f &&
  chmod 755 foo

If the middle step fails but leaves the directory (e.g., the
bug is that clean does not notice the failure), this
pollutes the test repo with an unremovable directory. Not
only does this cause further tests to fail, but it means
that "rm -rf" fails on the whole trash directory, and the
user has to intervene manually to even re-run the test script.

We can bump the "chmod 755" recovery to a test_when_finished
block to be sure that it always runs.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7300-clean.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 74de814..04118ad 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -426,10 +426,10 @@ test_expect_success SANITY 'removal failure' '
 
 	mkdir foo &&
 	touch foo/bar &&
+	test_when_finished "chmod 755 foo" &&
 	(exec <foo/bar &&
 	 chmod 0 foo &&
-	 test_must_fail git clean -f -d &&
-	 chmod 755 foo)
+	 test_must_fail git clean -f -d)
 '
 
 test_expect_success 'nested git work tree' '
-- 
2.0.0.566.gfe3e6b2
