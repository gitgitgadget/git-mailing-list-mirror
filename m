From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] t6300: test new content:* for-each-ref placeholders
Date: Wed, 31 Aug 2011 12:44:58 -0400
Message-ID: <20110831164458.GB10169@sigill.intra.peff.net>
References: <20110831164233.GA4356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 18:45:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QynuU-0008QL-Pr
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099Ab1HaQpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 12:45:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50279
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756322Ab1HaQpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:45:00 -0400
Received: (qmail 4458 invoked by uid 107); 31 Aug 2011 16:45:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Aug 2011 12:45:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2011 12:44:58 -0400
Content-Disposition: inline
In-Reply-To: <20110831164233.GA4356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180482>

For commits and unsigned tags, these are the same as %(body)
and %(subject). This patch also introduces a signed tag and
checks for-each-ref's output.

These tests would fit better near the top of the script;
however, creating the extra tag throws off the output of
later tests. Those tests can't just be adjusted to the new
output, either, as the presence of the signed tag depends on
the GPG prerequisite.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-gpg.sh            |    8 ++++++++
 t/t6300-for-each-ref.sh |   44 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 28463fb..05824fa 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -24,3 +24,11 @@ else
 		;;
 	esac
 fi
+
+sanitize_pgp() {
+	perl -ne '
+		/^-----END PGP/ and $in_pgp = 0;
+		print unless $in_pgp;
+		/^-----BEGIN PGP/ and $in_pgp = 1;
+	'
+}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7dc8a51..24f39de 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -6,6 +6,7 @@
 test_description='for-each-ref test'
 
 . ./test-lib.sh
+. ../lib-gpg.sh
 
 # Mon Jul 3 15:18:43 2006 +0000
 datestamp=1151939923
@@ -35,13 +36,15 @@ test_expect_success 'Create upstream config' '
 
 test_atom() {
 	case "$1" in
-		head) ref=refs/heads/master ;;
-		 tag) ref=refs/tags/testtag ;;
+		head) ref=refs/heads/master; prereq= ;;
+		 tag) ref=refs/tags/testtag; prereq= ;;
+	      signed) ref=refs/tags/signed-tag; prereq=GPG ;;
 	esac
 	printf '%s\n' "$3" >expected
-	test_expect_${4:-success} "basic atom: $1 $2" "
+	test_expect_${4:-success} $prereq "basic atom: $1 $2" "
 		git for-each-ref --format='%($2)' $ref >actual &&
-		test_cmp expected actual
+		sanitize_pgp <actual >actual.clean &&
+		test_cmp expected actual.clean
 	"
 }
 
@@ -71,7 +74,10 @@ test_atom head taggerdate ''
 test_atom head creator 'C O Mitter <committer@example.com> 1151939923 +0200'
 test_atom head creatordate 'Mon Jul 3 17:18:43 2006 +0200'
 test_atom head subject 'Initial'
+test_atom head contents:subject 'Initial'
 test_atom head body ''
+test_atom head contents:body ''
+test_atom head contents:signature ''
 test_atom head contents 'Initial
 '
 
@@ -101,7 +107,10 @@ test_atom tag taggerdate 'Mon Jul 3 17:18:45 2006 +0200'
 test_atom tag creator 'C O Mitter <committer@example.com> 1151939925 +0200'
 test_atom tag creatordate 'Mon Jul 3 17:18:45 2006 +0200'
 test_atom tag subject 'Tagging at 1151939927'
+test_atom tag contents:subject 'Tagging at 1151939927'
 test_atom tag body ''
+test_atom tag contents:body ''
+test_atom tag contents:signature ''
 test_atom tag contents 'Tagging at 1151939927
 '
 
@@ -359,4 +368,31 @@ test_expect_success 'an unusual tag with an incomplete line' '
 
 '
 
+test_expect_success GPG 'create signed tag' '
+	cat <<-\EOF |
+	subject line
+
+	body contents
+	EOF
+	git tag -s -F - signed-tag
+'
+
+test_atom signed contents 'subject line
+
+body contents
+-----BEGIN PGP SIGNATURE-----
+-----END PGP SIGNATURE-----
+'
+test_atom signed body 'body contents
+-----BEGIN PGP SIGNATURE-----
+-----END PGP SIGNATURE-----
+'
+test_atom signed contents:body 'body contents
+'
+test_atom signed contents:subject 'subject line'
+test_atom signed subject 'subject line'
+test_atom signed contents:signature '-----BEGIN PGP SIGNATURE-----
+-----END PGP SIGNATURE-----
+'
+
 test_done
-- 
1.7.6.10.g62f04
