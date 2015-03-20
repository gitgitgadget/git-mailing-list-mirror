From: Jeff King <peff@peff.net>
Subject: [PATCH 13/25] t3600: fix &&-chain breakage for setup commands
Date: Fri, 20 Mar 2015 06:12:51 -0400
Message-ID: <20150320101251.GM12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvL-0005YC-ST
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbbCTKMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:12:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:35703 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751842AbbCTKMy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:12:54 -0400
Received: (qmail 5897 invoked by uid 102); 20 Mar 2015 10:12:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:12:54 -0500
Received: (qmail 21604 invoked by uid 107); 20 Mar 2015 10:13:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:12:51 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265887>

As with the earlier patch to fix "trivial" &&-chain
breakage, these missing "&&" operators are not a serious
problem (e.g., we do not expect "echo" to fail).

Ironically, however, inserting them shows that some of the
commands _do_ fail. Specifically, some of the tests start by
making sure we are at a commit with the string "content" in
the file "foo". However, running "git commit" may fail
because the previous test left us in that state already, and
there is nothing to commit.

We could remove these commands entirely, but they serve to
document the test's assumptions, as well as make it robust
when an earlier test has failed. We could use test_might_fail
to handle all cases, but that would miss an unrelated
failure to make the commit. Instead, we can just pass the
--allow-empty flag to git-commit, which means that it will
not complain if our setup is a noop.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3600-rm.sh | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 1962989..9d90d2c 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -38,37 +38,37 @@ test_expect_success \
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo
-     git add foo
+    'echo content >foo &&
+     git add foo &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
+    'echo content >foo &&
+     git add foo &&
+     git commit -m foo &&
+     echo "other content" >foo &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
-     echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+     echo content >foo &&
+     git add foo &&
+     git commit -m foo --allow-empty &&
+     echo "other content" >foo &&
+     git add foo &&
+     echo "yet another content" >foo &&
      test_must_fail git rm --cached foo
 '
 
 test_expect_success \
     'Test that git rm --cached -f foo works in case where --cached only did not' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+    'echo content >foo &&
+     git add foo &&
+     git commit -m foo --allow-empty &&
+     echo "other content" >foo &&
+     git add foo &&
+     echo "yet another content" >foo &&
      git rm --cached -f foo'
 
 test_expect_success \
-- 
2.3.3.520.g3cfbb5d
