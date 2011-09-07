From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] t7004: factor out gpg setup
Date: Wed, 7 Sep 2011 13:42:39 -0400
Message-ID: <20110907174239.GA11355@sigill.intra.peff.net>
References: <20110902175323.GA29761@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:42:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1M9A-00019J-Be
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab1IGRmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:42:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37326
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337Ab1IGRml (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:42:41 -0400
Received: (qmail 3908 invoked by uid 107); 7 Sep 2011 17:43:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 13:43:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 13:42:39 -0400
Content-Disposition: inline
In-Reply-To: <20110902175323.GA29761@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180885>

Other test scripts may want to look at or verify signed
tags, and the setup is non-trivial. Let's factor this out
into lib-gpg.sh for other tests to use.

Signed-off-by: Jeff King <peff@peff.net>
---
Similar to the one I sent out earlier, but in that one I accidentally
did:

  . ../lib-gpg.sh

which is not right. If --root is used for the test script, then ".." is
not necessarily the right place to find the lib-gpg script. This fixes
it to use $TEST_DIRECTORY.

 t/lib-gpg.sh                     |   26 ++++++++++++++++++++++++++
 t/{t7004 => lib-gpg}/pubring.gpg |  Bin 1164 -> 1164 bytes
 t/{t7004 => lib-gpg}/random_seed |  Bin 600 -> 600 bytes
 t/{t7004 => lib-gpg}/secring.gpg |  Bin 1237 -> 1237 bytes
 t/{t7004 => lib-gpg}/trustdb.gpg |  Bin 1280 -> 1280 bytes
 t/t7004-tag.sh                   |   29 +----------------------------
 6 files changed, 27 insertions(+), 28 deletions(-)
 create mode 100755 t/lib-gpg.sh
 rename t/{t7004 => lib-gpg}/pubring.gpg (100%)
 rename t/{t7004 => lib-gpg}/random_seed (100%)
 rename t/{t7004 => lib-gpg}/secring.gpg (100%)
 rename t/{t7004 => lib-gpg}/trustdb.gpg (100%)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
new file mode 100755
index 0000000..28463fb
--- /dev/null
+++ b/t/lib-gpg.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+gpg_version=`gpg --version 2>&1`
+if test $? = 127; then
+	say "You do not seem to have gpg installed"
+else
+	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
+	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
+	# that version, creation of signed tags using the generated key fails.
+	case "$gpg_version" in
+	'gpg (GnuPG) 1.0.6'*)
+		say "Your version of gpg (1.0.6) is too buggy for testing"
+		;;
+	*)
+		# key generation info: gpg --homedir t/lib-gpg --gen-key
+		# Type DSA and Elgamal, size 2048 bits, no expiration date.
+		# Name and email: C O Mitter <committer@example.com>
+		# No password given, to enable non-interactive operation.
+		cp -R "$TEST_DIRECTORY"/lib-gpg ./gpghome
+		chmod 0700 gpghome
+		GNUPGHOME="$(pwd)/gpghome"
+		export GNUPGHOME
+		test_set_prereq GPG
+		;;
+	esac
+fi
diff --git a/t/t7004/pubring.gpg b/t/lib-gpg/pubring.gpg
similarity index 100%
rename from t/t7004/pubring.gpg
rename to t/lib-gpg/pubring.gpg
diff --git a/t/t7004/random_seed b/t/lib-gpg/random_seed
similarity index 100%
rename from t/t7004/random_seed
rename to t/lib-gpg/random_seed
diff --git a/t/t7004/secring.gpg b/t/lib-gpg/secring.gpg
similarity index 100%
rename from t/t7004/secring.gpg
rename to t/lib-gpg/secring.gpg
diff --git a/t/t7004/trustdb.gpg b/t/lib-gpg/trustdb.gpg
similarity index 100%
rename from t/t7004/trustdb.gpg
rename to t/lib-gpg/trustdb.gpg
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 097ce2b..e93ac73 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -8,6 +8,7 @@ test_description='git tag
 Tests for operations with tags.'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
 
 # creating and listing lightweight tags:
 
@@ -585,24 +586,6 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-# subsequent tests require gpg; check if it is available
-gpg --version >/dev/null 2>/dev/null
-if [ $? -eq 127 ]; then
-	say "# gpg not found - skipping tag signing and verification tests"
-else
-	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
-	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
-	# that version, creation of signed tags using the generated key fails.
-	case "$(gpg --version)" in
-	'gpg (GnuPG) 1.0.6'*)
-		say "Skipping signed tag tests, because a bug in 1.0.6 version"
-		;;
-	*)
-		test_set_prereq GPG
-		;;
-	esac
-fi
-
 # trying to verify annotated non-signed tags:
 
 test_expect_success GPG \
@@ -625,16 +608,6 @@ test_expect_success GPG \
 
 # creating and verifying signed tags:
 
-# key generation info: gpg --homedir t/t7004 --gen-key
-# Type DSA and Elgamal, size 2048 bits, no expiration date.
-# Name and email: C O Mitter <committer@example.com>
-# No password given, to enable non-interactive operation.
-
-cp -R "$TEST_DIRECTORY"/t7004 ./gpghome
-chmod 0700 gpghome
-GNUPGHOME="$(pwd)/gpghome"
-export GNUPGHOME
-
 get_tag_header signed-tag $commit commit $time >expect
 echo 'A signed tag message' >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-- 
1.7.6.10.g62f04
