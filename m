From: Jeff King <peff@peff.net>
Subject: [PATCH] t6302: simplify non-gpg cases
Date: Mon, 9 May 2016 12:49:00 -0400
Message-ID: <20160509164859.GA8231@sigill.intra.peff.net>
References: <dea0877d-fe83-fb47-4df3-21fd69d8421d@web.de>
 <20160509160725.GA11861@sigill.intra.peff.net>
 <CAPig+cQ2kSVzy0K303J3Guhk3-NzcReb5V7ohqOy2pPL_5GrSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 09 18:49:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azoMq-0008KJ-65
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbcEIQtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:49:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:36402 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752341AbcEIQtD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:49:03 -0400
Received: (qmail 20963 invoked by uid 102); 9 May 2016 16:49:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 12:49:02 -0400
Received: (qmail 21020 invoked by uid 107); 9 May 2016 16:49:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 12:49:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 12:49:00 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQ2kSVzy0K303J3Guhk3-NzcReb5V7ohqOy2pPL_5GrSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294015>

On Mon, May 09, 2016 at 12:30:43PM -0400, Eric Sunshine wrote:

> The latter seems very preferable, though perhaps it could be made more
> concise like this?
> 
>     sign=
>     test_have_prereq GPG && sign=-s
> 
> (But that's a minor issue.)

I agree that is nicer, but I wanted to keep the definition inside the
test_expect_success close to its point of use. And that means we to deal
with the existing &&-chain (you can get around it with a {} block, but
at that point you might as well if/then).

Since you as the author of 618310a seem to agree with this direction,
here it is as a real patch.

-- >8 --
Subject: [PATCH] t6302: simplify non-gpg cases

When commit 618310a taught t6302 to run without the GPG
prerequisite, it did so by conditionally creating the signed
tags only when gpg is available. As a result, further tests
need to take this into account, which they can do with the
test_prepare_expect helper. This is a minor hassle, though,
as the helper cannot easily cover all cases (it just matches
"signed" in the output, so all output must include the
actual refname).

Instead, let's take a different approach. We'll always
create the tags, and only conditionally sign them. This does
mean our tag-names are a minor lie, but it lets the tests
which do not care about signing easily behave the same in
all settings. We'll include a comment to document our lie
and avoid confusing further test-writers.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6302-for-each-ref-filter.sh | 45 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 70afb44..3225a0b 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -5,15 +5,6 @@ test_description='test for-each-refs usage of ref-filter APIs'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
-test_prepare_expect () {
-	if test_have_prereq GPG
-	then
-		cat
-	else
-		sed '/signed/d'
-	fi
-}
-
 test_expect_success 'setup some history and refs' '
 	test_commit one &&
 	test_commit two &&
@@ -22,11 +13,19 @@ test_expect_success 'setup some history and refs' '
 	test_commit four &&
 	git tag -m "An annotated tag" annotated-tag &&
 	git tag -m "Annonated doubly" doubly-annotated-tag annotated-tag &&
+
+	# Note that these "signed" tags might not actually be signed.
+	# Tests which care about the distinction should be marked
+	# with the GPG prereq.
 	if test_have_prereq GPG
 	then
-		git tag -s -m "A signed tag" signed-tag &&
-		git tag -s -m "Signed doubly" doubly-signed-tag signed-tag
+		sign=-s
+	else
+		sign=
 	fi &&
+	git tag $sign -m "A signed tag" signed-tag &&
+	git tag $sign -m "Signed doubly" doubly-signed-tag signed-tag &&
+
 	git checkout master &&
 	git update-ref refs/odd/spot master
 '
@@ -42,7 +41,7 @@ test_expect_success 'filtering with --points-at' '
 '
 
 test_expect_success 'check signed tags with --points-at' '
-	test_prepare_expect <<-\EOF | sed -e "s/Z$//" >expect &&
+	cat <<-\EOF | sed -e "s/Z$//" >expect &&
 	refs/heads/side Z
 	refs/tags/annotated-tag four
 	refs/tags/four Z
@@ -65,7 +64,7 @@ test_expect_success 'filtering with --merged' '
 '
 
 test_expect_success 'filtering with --no-merged' '
-	test_prepare_expect >expect <<-\EOF &&
+	cat >expect <<-\EOF &&
 	refs/heads/side
 	refs/tags/annotated-tag
 	refs/tags/doubly-annotated-tag
@@ -78,7 +77,7 @@ test_expect_success 'filtering with --no-merged' '
 '
 
 test_expect_success 'filtering with --contains' '
-	test_prepare_expect >expect <<-\EOF &&
+	cat >expect <<-\EOF &&
 	refs/heads/master
 	refs/heads/side
 	refs/odd/spot
@@ -99,7 +98,7 @@ test_expect_success '%(color) must fail' '
 '
 
 test_expect_success 'left alignment is default' '
-	test_prepare_expect >expect <<-\EOF &&
+	cat >expect <<-\EOF &&
 	refname is refs/heads/master  |refs/heads/master
 	refname is refs/heads/side    |refs/heads/side
 	refname is refs/odd/spot      |refs/odd/spot
@@ -117,7 +116,7 @@ test_expect_success 'left alignment is default' '
 '
 
 test_expect_success 'middle alignment' '
-	test_prepare_expect >expect <<-\EOF &&
+	cat >expect <<-\EOF &&
 	| refname is refs/heads/master |refs/heads/master
 	|  refname is refs/heads/side  |refs/heads/side
 	|   refname is refs/odd/spot   |refs/odd/spot
@@ -135,7 +134,7 @@ test_expect_success 'middle alignment' '
 '
 
 test_expect_success 'right alignment' '
-	test_prepare_expect >expect <<-\EOF &&
+	cat >expect <<-\EOF &&
 	|  refname is refs/heads/master|refs/heads/master
 	|    refname is refs/heads/side|refs/heads/side
 	|      refname is refs/odd/spot|refs/odd/spot
@@ -152,7 +151,7 @@ test_expect_success 'right alignment' '
 	test_cmp expect actual
 '
 
-test_prepare_expect >expect <<-\EOF
+cat >expect <<-\EOF
 |       refname is refs/heads/master       |refs/heads/master
 |        refname is refs/heads/side        |refs/heads/side
 |         refname is refs/odd/spot         |refs/odd/spot
@@ -199,7 +198,7 @@ EOF
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
 test_expect_success 'alignment with format quote' "
-	test_prepare_expect >expect <<-\EOF &&
+	cat >expect <<-\EOF &&
 	|'      '\''master| A U Thor'\''      '|
 	|'       '\''side| A U Thor'\''       '|
 	|'     '\''odd/spot| A U Thor'\''     '|
@@ -217,7 +216,7 @@ test_expect_success 'alignment with format quote' "
 "
 
 test_expect_success 'nested alignment with quote formatting' "
-	test_prepare_expect >expect <<-\EOF &&
+	cat >expect <<-\EOF &&
 	|'         master               '|
 	|'           side               '|
 	|'       odd/spot               '|
@@ -235,7 +234,7 @@ test_expect_success 'nested alignment with quote formatting' "
 "
 
 test_expect_success 'check `%(contents:lines=1)`' '
-	test_prepare_expect >expect <<-\EOF &&
+	cat >expect <<-\EOF &&
 	master |three
 	side |four
 	odd/spot |three
@@ -253,7 +252,7 @@ test_expect_success 'check `%(contents:lines=1)`' '
 '
 
 test_expect_success 'check `%(contents:lines=0)`' '
-	test_prepare_expect >expect <<-\EOF &&
+	cat >expect <<-\EOF &&
 	master |
 	side |
 	odd/spot |
@@ -271,7 +270,7 @@ test_expect_success 'check `%(contents:lines=0)`' '
 '
 
 test_expect_success 'check `%(contents:lines=99999)`' '
-	test_prepare_expect >expect <<-\EOF &&
+	cat >expect <<-\EOF &&
 	master |three
 	side |four
 	odd/spot |three
-- 
2.8.2.643.g361a07a
