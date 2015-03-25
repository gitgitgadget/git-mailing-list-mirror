From: Jeff King <peff@peff.net>
Subject: [PATCH 2/8] t0020: fix ignored exit code inside loops
Date: Wed, 25 Mar 2015 01:28:44 -0400
Message-ID: <20150325052844.GB31924@peff.net>
References: <20150325052456.GA19394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 06:28:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yads4-0000bD-5y
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 06:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbbCYF2r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2015 01:28:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:38158 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750884AbbCYF2r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 01:28:47 -0400
Received: (qmail 17394 invoked by uid 102); 25 Mar 2015 05:28:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 00:28:47 -0500
Received: (qmail 11484 invoked by uid 107); 25 Mar 2015 05:29:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 01:29:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 01:28:44 -0400
Content-Disposition: inline
In-Reply-To: <20150325052456.GA19394@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266255>

A loop like:

  for f in one two; do
	  something $f ||
	  break
  done

will correctly break out of the loop when we see a failure
of one item, but the resulting exit code will always be
zero. We can fix that by putting the loop into a function or
subshell, but in this case it is simpler still to just
unroll the loop. We do add a helper function, which
hopefully makes the end result even more readable (in
addition to being shorter).

Reported-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Jeff King <peff@peff.net>
---
You can make each call site a one-liner that does the loop inside the
function (including the update-index call). But I tried to shoot for
readability rather than absolute minimum characters.

 t/t0020-crlf.sh | 54 +++++++++++++++++++------------------------------=
-----
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 9fa26df..144fdcd 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -8,6 +8,13 @@ has_cr() {
 	tr '\015' Q <"$1" | grep Q >/dev/null
 }
=20
+# add or remove CRs to disk file in-place
+# usage: munge_cr <append|remove> <file>
+munge_cr () {
+	"${1}_cr" <"$2" >tmp &&
+	mv tmp "$2"
+}
+
 test_expect_success setup '
=20
 	git config core.autocrlf false &&
@@ -100,14 +107,9 @@ test_expect_success 'update with autocrlf=3Dinput'=
 '
 	rm -f tmp one dir/two three &&
 	git read-tree --reset -u HEAD &&
 	git config core.autocrlf input &&
-
-	for f in one dir/two
-	do
-		append_cr <$f >tmp && mv -f tmp $f &&
-		git update-index -- $f ||
-		break
-	done &&
-
+	munge_cr append one &&
+	munge_cr append dir/two &&
+	git update-index -- one dir/two &&
 	differs=3D$(git diff-index --cached HEAD) &&
 	verbose test -z "$differs"
=20
@@ -118,14 +120,9 @@ test_expect_success 'update with autocrlf=3Dtrue' =
'
 	rm -f tmp one dir/two three &&
 	git read-tree --reset -u HEAD &&
 	git config core.autocrlf true &&
-
-	for f in one dir/two
-	do
-		append_cr <$f >tmp && mv -f tmp $f &&
-		git update-index -- $f ||
-		break
-	done &&
-
+	munge_cr append one &&
+	munge_cr append dir/two &&
+	git update-index -- one dir/two &&
 	differs=3D$(git diff-index --cached HEAD) &&
 	verbose test -z "$differs"
=20
@@ -136,13 +133,9 @@ test_expect_success 'checkout with autocrlf=3Dtrue=
' '
 	rm -f tmp one dir/two three &&
 	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
-
-	for f in one dir/two
-	do
-		remove_cr <"$f" >tmp && mv -f tmp $f &&
-		verbose git update-index -- $f ||
-		break
-	done &&
+	munge_cr remove one &&
+	munge_cr remove dir/two &&
+	git update-index -- one dir/two &&
 	test "$one" =3D $(git hash-object --stdin <one) &&
 	test "$two" =3D $(git hash-object --stdin <dir/two) &&
 	differs=3D$(git diff-index --cached HEAD) &&
@@ -154,18 +147,9 @@ test_expect_success 'checkout with autocrlf=3Dinpu=
t' '
 	rm -f tmp one dir/two three &&
 	git config core.autocrlf input &&
 	git read-tree --reset -u HEAD &&
-
-	for f in one dir/two
-	do
-		if has_cr "$f"
-		then
-			echo "Eh? $f"
-			false
-			break
-		else
-			git update-index -- $f
-		fi
-	done &&
+	test_must_fail has_cr one &&
+	test_must_fail has_cr two &&
+	git update-index -- one dir/two &&
 	test "$one" =3D $(git hash-object --stdin <one) &&
 	test "$two" =3D $(git hash-object --stdin <dir/two) &&
 	differs=3D$(git diff-index --cached HEAD) &&
--=20
2.3.4.635.gd6ffcfe
