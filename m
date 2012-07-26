From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] t7502: narrow checks for author/committer name in
 template
Date: Thu, 26 Jul 2012 16:30:29 -0400
Message-ID: <20120726203029.GC16048@sigill.intra.peff.net>
References: <20120726202644.GA15043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:30:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuUhh-0005TM-5W
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 22:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab2GZUac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 16:30:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37596 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab2GZUab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 16:30:31 -0400
Received: (qmail 13355 invoked by uid 107); 26 Jul 2012 20:30:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 16:30:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 16:30:29 -0400
Content-Disposition: inline
In-Reply-To: <20120726202644.GA15043@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202305>

t7502.20 and t7502.21 check that the author and committer
name are mentioned in the commit message template under
certain circumstances. However, they end up checking a much
larger and unnecessary portion of the template. Let's narrow
their checks to the specific lines.

While we're at it, let's give these tests more descriptive
names, so their purposes are more obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
The test just above still checks the "Please write your..." part of the
message. But it is purely about using "-F -e --cleanup=strip", and is
testing whether we correctly include the instructions. I guess we could
limit it to just checking for "^# " or something if we didn't want to
depend on the actual text.

I'm inclined to just leave it for now.

 t/t7502-commit.sh | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 3f9fb55..efecb06 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -235,24 +235,15 @@ test_expect_success 'cleanup commit messages (strip,-F,-e): output' '
 	test_i18ncmp expect actual
 '
 
-echo "#
-# Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
-#" >> expect
-
-test_expect_success 'author different from committer' '
+test_expect_success 'message shows author when it is not equal to committer' '
 	echo >>negative &&
 	test_might_fail git commit -e -m "sample" &&
-	head -n 7 .git/COMMIT_EDITMSG >actual &&
-	test_i18ncmp expect actual
+	test_i18ngrep \
+	  "^# Author: *A U Thor <author@example.com>\$" \
+	  .git/COMMIT_EDITMSG
 '
 
-mv expect expect.tmp
-sed '$d' < expect.tmp > expect
-rm -f expect.tmp
-echo "# Committer:
-#" >> expect
-
-test_expect_success 'committer is automatic' '
+test_expect_success 'message shows committer when it is automatic' '
 
 	echo >>negative &&
 	(
@@ -261,9 +252,9 @@ test_expect_success 'committer is automatic' '
 		# must fail because there is no change
 		test_must_fail git commit -e -m "sample"
 	) &&
-	head -n 8 .git/COMMIT_EDITMSG |	\
-	sed "s/^# Committer: .*/# Committer:/" >actual
-	test_i18ncmp expect actual
+	# the ident is calculated from the system, so we cannot
+	# check the actual value, only that it is there
+	test_i18ngrep "^# Committer: " .git/COMMIT_EDITMSG
 '
 
 write_script .git/FAKE_EDITOR <<EOF
-- 
1.7.11.3.8.ge78f547
