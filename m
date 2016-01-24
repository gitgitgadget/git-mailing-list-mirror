From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t6300: use test_atom for some un-modern tests
Date: Sun, 24 Jan 2016 18:08:18 -0500
Message-ID: <20160124230818.GA16455@sigill.intra.peff.net>
References: <20160124230531.GB29115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 00:08:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNTln-00048Z-5b
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 00:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbcAXXIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 18:08:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:59641 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753732AbcAXXIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 18:08:21 -0500
Received: (qmail 15896 invoked by uid 102); 24 Jan 2016 23:08:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 18:08:21 -0500
Received: (qmail 13182 invoked by uid 107); 24 Jan 2016 23:08:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 18:08:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jan 2016 18:08:18 -0500
Content-Disposition: inline
In-Reply-To: <20160124230531.GB29115@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284702>

Because this script has to test so many formatters, we have
the nice "test_atom" helper, but we don't use it
consistently. Let's do so. This is shorter, gets rid of some
tests that have their "expected" setup outside of a
test_expect_success block, and lets us organize the changes
better (e.g., putting "refname:short" near "refname").

We also expand the "%(push)" tests a little to match the
"%(upstream)" ones.

Signed-off-by: Jeff King <peff@peff.net>
---
I suspect one could do even more cleanup in this script, but this looked
like all of the low-hanging fruit (some of the others are
order-dependent, for example).

One of the blocks that goes away must be setting a new
record for "pointless use of cat". See if you can spot it. :)

 t/t6300-for-each-ref.sh | 62 ++++++++-----------------------------------------
 1 file changed, 10 insertions(+), 52 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 03873b0..859b237 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -49,11 +49,15 @@ test_atom() {
 }
 
 test_atom head refname refs/heads/master
+test_atom head refname:short master
 test_atom head upstream refs/remotes/origin/master
+test_atom head upstream:short origin/master
 test_atom head push refs/remotes/myfork/master
+test_atom head push:short myfork/master
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
+test_atom head objectname:short $(git rev-parse --short refs/heads/master)
 test_atom head tree $(git rev-parse refs/heads/master^{tree})
 test_atom head parent ''
 test_atom head numparent 0
@@ -86,11 +90,13 @@ test_atom head contents 'Initial
 test_atom head HEAD '*'
 
 test_atom tag refname refs/tags/testtag
+test_atom tag refname:short testtag
 test_atom tag upstream ''
 test_atom tag push ''
 test_atom tag objecttype tag
 test_atom tag objectsize 154
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
+test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
 test_atom tag tree ''
 test_atom tag parent ''
 test_atom tag numparent ''
@@ -338,47 +344,14 @@ for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
 	"
 done
 
-cat >expected <<\EOF
-master
-testtag
-EOF
-
-test_expect_success 'Check short refname format' '
-	(git for-each-ref --format="%(refname:short)" refs/heads &&
-	git for-each-ref --format="%(refname:short)" refs/tags) >actual &&
-	test_cmp expected actual
-'
-
-cat >expected <<EOF
-origin/master
-EOF
-
-test_expect_success 'Check short upstream format' '
-	git for-each-ref --format="%(upstream:short)" refs/heads >actual &&
-	test_cmp expected actual
-'
-
 test_expect_success 'setup for upstream:track[short]' '
 	test_commit two
 '
 
-cat >expected <<EOF
-[ahead 1]
-EOF
-
-test_expect_success 'Check upstream:track format' '
-	git for-each-ref --format="%(upstream:track)" refs/heads >actual &&
-	test_cmp expected actual
-'
-
-cat >expected <<EOF
->
-EOF
-
-test_expect_success 'Check upstream:trackshort format' '
-	git for-each-ref --format="%(upstream:trackshort)" refs/heads >actual &&
-	test_cmp expected actual
-'
+test_atom head upstream:track '[ahead 1]'
+test_atom head upstream:trackshort '>'
+test_atom head push:track '[ahead 1]'
+test_atom head push:trackshort '>'
 
 test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 	test_must_fail git for-each-ref --format="%(refname:track)" 2>/dev/null &&
@@ -398,21 +371,6 @@ test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	test_cmp expected actual
 '
 
-test_expect_success '%(push) supports tracking specifiers, too' '
-	echo "[ahead 1]" >expected &&
-	git for-each-ref --format="%(push:track)" refs/heads >actual &&
-	test_cmp expected actual
-'
-
-cat >expected <<EOF
-$(git rev-parse --short HEAD)
-EOF
-
-test_expect_success 'Check short objectname format' '
-	git for-each-ref --format="%(objectname:short)" refs/heads >actual &&
-	test_cmp expected actual
-'
-
 test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
-- 
2.7.0.427.g4c6e021
