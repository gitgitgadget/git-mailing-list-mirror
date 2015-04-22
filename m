From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t3903: avoid applying onto dirty index
Date: Wed, 22 Apr 2015 15:30:58 -0400
Message-ID: <20150422193058.GB27945@peff.net>
References: <20150422192948.GA27656@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Gutov <dgutov@yandex.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:31:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0MU-0004S7-VZ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbbDVTbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:31:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:48767 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753820AbbDVTbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:31:00 -0400
Received: (qmail 11055 invoked by uid 102); 22 Apr 2015 19:31:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 14:31:00 -0500
Received: (qmail 13171 invoked by uid 107); 22 Apr 2015 19:31:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:31:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 15:30:58 -0400
Content-Disposition: inline
In-Reply-To: <20150422192948.GA27656@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267620>

One of the tests in t3903 wants to make sure that applying a
stash that touches only "file" can still happen even if there
are working tree changes to "other-file". To do so, it adds
"other-file" to the index (since otherwise it is an
untracked file, voiding the purpose of the test).

But as we are about to refactor the dirty-index handling,
and as this test does not actually care about having a dirty
index (only a dirty working tree), let's bump the tracking
of "other-file" into the setup phase, so we can have _just_
a dirty working tree here.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3903-stash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 6da4856..f179c93 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -10,6 +10,8 @@ test_description='Test git stash'
 test_expect_success 'stash some dirty working directory' '
 	echo 1 > file &&
 	git add file &&
+	echo unrelated >other-file &&
+	git add other-file &&
 	test_tick &&
 	git commit -m initial &&
 	echo 2 > file &&
@@ -45,8 +47,6 @@ test_expect_success 'applying bogus stash does nothing' '
 
 test_expect_success 'apply does not need clean working directory' '
 	echo 4 >other-file &&
-	git add other-file &&
-	echo 5 >other-file &&
 	git stash apply &&
 	echo 3 >expect &&
 	test_cmp expect file
-- 
2.4.0.rc2.498.g02440db
