From: Jeff King <peff@peff.net>
Subject: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Sat, 8 Nov 2014 20:59:18 -0500
Message-ID: <20141109015918.GA24736@peff.net>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 02:59:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnHmw-0000vi-2m
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 02:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbaKIB7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 20:59:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:38112 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750957AbaKIB7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 20:59:20 -0500
Received: (qmail 7973 invoked by uid 102); 9 Nov 2014 01:59:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 19:59:20 -0600
Received: (qmail 13425 invoked by uid 107); 9 Nov 2014 01:59:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 20:59:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2014 20:59:18 -0500
Content-Disposition: inline
In-Reply-To: <20141109014354.GA23883@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 08, 2014 at 08:43:54PM -0500, Jeff King wrote:

> Unfortunately I don't have an OS X install handy to test on.

I lied; it turns out I still had access to an old VM. The problem did
turn out to be rather silly. Here's a patch.

-- >8 --
Two tests recently added to t1410 create branches "a" and
"a/b" to test d/f conflicts on reflogs. Earlier, unrelated
tests in that script create the path "A/B" in the working
tree.  There's no conflict on a case-sensitive filesystem,
but on a case-insensitive one, "git log" will complain that
"a/b" is both a revision and a working tree path.

We could fix this by using a "--" to disambiguate, but we
are probably better off using names that are less confusing
to make it more clear that they are unrelated to the working
tree files.  This patch turns "a/b" into "one/two".

Reported-by: Michael Blume <blume.mike@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
The line-diff is hard to read, but if anyone was looking for a chance to
test-drive contrib/diff-highlight, it does a good job of making the
change easy to see.

 t/t1410-reflog.sh | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 976c1d4..8cf4461 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -254,36 +254,36 @@ test_expect_success 'checkout should not delete log for packed ref' '
 '
 
 test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
-	test_when_finished "git branch -d a || git branch -d a/b" &&
+	test_when_finished "git branch -d one || git branch -d one/two" &&
 
-	git branch a/b master &&
-	echo "a/b@{0} branch: Created from master" >expect &&
-	git log -g --format="%gd %gs" a/b >actual &&
+	git branch one/two master &&
+	echo "one/two@{0} branch: Created from master" >expect &&
+	git log -g --format="%gd %gs" one/two >actual &&
 	test_cmp expect actual &&
-	git branch -d a/b &&
+	git branch -d one/two &&
 
-	# now logs/refs/heads/a is a stale directory, but
-	# we should move it out of the way to create "a" reflog
-	git branch a master &&
-	echo "a@{0} branch: Created from master" >expect &&
-	git log -g --format="%gd %gs" a >actual &&
+	# now logs/refs/heads/one is a stale directory, but
+	# we should move it out of the way to create "one" reflog
+	git branch one master &&
+	echo "one@{0} branch: Created from master" >expect &&
+	git log -g --format="%gd %gs" one >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
-	test_when_finished "git branch -d a || git branch -d a/b" &&
+	test_when_finished "git branch -d one || git branch -d one/two" &&
 
-	git branch a/b master &&
-	echo "a/b@{0} branch: Created from master" >expect &&
-	git log -g --format="%gd %gs" a/b >actual &&
+	git branch one/two master &&
+	echo "one/two@{0} branch: Created from master" >expect &&
+	git log -g --format="%gd %gs" one/two >actual &&
 	test_cmp expect actual &&
-	git branch -d a/b &&
+	git branch -d one/two &&
 
-	# same as before, but we only create a reflog for "a" if
+	# same as before, but we only create a reflog for "one" if
 	# it already exists, which it does not
-	git -c core.logallrefupdates=false branch a master &&
+	git -c core.logallrefupdates=false branch one master &&
 	: >expect &&
-	git log -g --format="%gd %gs" a >actual &&
+	git log -g --format="%gd %gs" one >actual &&
 	test_cmp expect actual
 '
 
-- 
2.1.2.596.g7379948
