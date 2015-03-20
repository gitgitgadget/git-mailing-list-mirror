From: Jeff King <peff@peff.net>
Subject: [PATCH 14/25] t7201: fix &&-chain breakage
Date: Fri, 20 Mar 2015 06:12:55 -0400
Message-ID: <20150320101255.GN12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvW-0005jg-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbbCTKNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:35704 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbbCTKM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:12:58 -0400
Received: (qmail 5900 invoked by uid 102); 20 Mar 2015 10:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:12:58 -0500
Received: (qmail 21607 invoked by uid 107); 20 Mar 2015 10:13:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:12:55 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265888>

One of these breakages is in setup, but one is more severe
and may miss a real test failure. These are pulled out from
the rest, though, because we also clean up a few other
anachronisms. The most interesting is the use of this
here-doc construct:

  (cat >... <<EOF
  ...
  EOF
  ) &&

It looks like an attempt to make the &&-chaining more
natural by letting it come at the end of the here-doc. But
the extra sub-shell is so non-idiomatic (plus the lack of
"<<-") that it ends up confusing.

Since these are just using a single line, we can accomplish
the same thing with a single printf (which also makes the
use of tab more obvious than the verbatim whitespace).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7201-co.sh | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index a7fe4e6..8859236 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -88,14 +88,10 @@ test_expect_success "checkout with unrelated dirty tree without -m" '
 
 	git checkout -f master &&
 	fill 0 1 2 3 4 5 6 7 8 >same &&
-	cp same kept
+	cp same kept &&
 	git checkout side >messages &&
-	test_cmp same kept
-	(cat > messages.expect <<EOF
-M	same
-EOF
-) &&
-	touch messages.expect &&
+	test_cmp same kept &&
+	printf "M\t%s\n" same >messages.expect &&
 	test_cmp messages.expect messages
 '
 
@@ -109,10 +105,7 @@ test_expect_success "checkout -m with dirty tree" '
 
 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
 
-	(cat >expect.messages <<EOF
-M	one
-EOF
-) &&
+	printf "M\t%s\n" one >expect.messages &&
 	test_cmp expect.messages messages &&
 
 	fill "M	one" "A	three" "D	two" >expect.master &&
@@ -409,12 +402,12 @@ test_expect_success \
 
 test_expect_success \
     'checkout w/autosetupmerge=always sets up tracking' '
+    test_when_finished git config branch.autosetupmerge false &&
     git config branch.autosetupmerge always &&
     git checkout master &&
     git checkout -b track2 &&
     test "$(git config branch.track2.remote)" &&
-    test "$(git config branch.track2.merge)"
-    git config branch.autosetupmerge false'
+    test "$(git config branch.track2.merge)"'
 
 test_expect_success 'checkout w/--track from non-branch HEAD fails' '
     git checkout master^0 &&
-- 
2.3.3.520.g3cfbb5d
