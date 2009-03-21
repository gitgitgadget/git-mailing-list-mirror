From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 15/16] t7004: Use prerequisite tags to skip tests that need gpg
Date: Sat, 21 Mar 2009 22:26:38 +0100
Message-ID: <a4babd41cc6d1e73908209b1917c2123dd2c80fc.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:30:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8ll-0004Ii-Nj
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbZCUV1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755666AbZCUV1p
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27969 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753945AbZCUV1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:27:00 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E18AA2C4014;
	Sat, 21 Mar 2009 22:26:56 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 09E83427B8;
	Sat, 21 Mar 2009 22:26:56 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114074>

The tests are skipped if no gpg was found or if gpg is version 1.0.6.
Previously, the latter condition was checked a bit later in the test file
so that the tag verification tests would be exercised. These are now
skipped as well, but only because we would need a facility to revoke a
test prerequisite, which we do not have.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t7004-tag.sh |   97 +++++++++++++++++++++++++++----------------------------
 1 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1c27ffb..73dbc43 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -581,28 +581,38 @@ test_expect_success \
 '
 
 # subsequent tests require gpg; check if it is available
-gpg --version >/dev/null
+gpg --version >/dev/null 2>/dev/null
 if [ $? -eq 127 ]; then
 	say "gpg not found - skipping tag signing and verification tests"
-	test_done
-	exit
+else
+	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
+	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
+	# that version, creation of signed tags using the generated key fails.
+	case "$(gpg --version)" in
+	'gpg (GnuPG) 1.0.6'*)
+		say "Skipping signed tag tests, because a bug in 1.0.6 version"
+		;;
+	*)
+		test_set_prereq GPG
+		;;
+	esac
 fi
 
 # trying to verify annotated non-signed tags:
 
-test_expect_success \
+test_expect_success GPG \
 	'trying to verify an annotated non-signed tag should fail' '
 	tag_exists annotated-tag &&
 	test_must_fail git tag -v annotated-tag
 '
 
-test_expect_success \
+test_expect_success GPG \
 	'trying to verify a file-annotated non-signed tag should fail' '
 	tag_exists file-annotated-tag &&
 	test_must_fail git tag -v file-annotated-tag
 '
 
-test_expect_success \
+test_expect_success GPG \
 	'trying to verify two annotated non-signed tags should fail' '
 	tag_exists annotated-tag file-annotated-tag &&
 	test_must_fail git tag -v annotated-tag file-annotated-tag
@@ -610,17 +620,6 @@ test_expect_success \
 
 # creating and verifying signed tags:
 
-# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
-# the gpg version 1.0.6 didn't parse trust packets correctly, so for
-# that version, creation of signed tags using the generated key fails.
-case "$(gpg --version)" in
-'gpg (GnuPG) 1.0.6'*)
-	say "Skipping signed tag tests, because a bug in 1.0.6 version"
-	test_done
-	exit
-	;;
-esac
-
 # key generation info: gpg --homedir t/t7004 --gen-key
 # Type DSA and Elgamal, size 2048 bits, no expiration date.
 # Name and email: C O Mitter <committer@example.com>
@@ -634,7 +633,7 @@ export GNUPGHOME
 get_tag_header signed-tag $commit commit $time >expect
 echo 'A signed tag message' >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success 'creating a signed tag with -m message should succeed' '
+test_expect_success GPG 'creating a signed tag with -m message should succeed' '
 	git tag -s -m "A signed tag message" signed-tag &&
 	get_tag_msg signed-tag >actual &&
 	test_cmp expect actual
@@ -643,7 +642,7 @@ test_expect_success 'creating a signed tag with -m message should succeed' '
 get_tag_header u-signed-tag $commit commit $time >expect
 echo 'Another message' >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success 'sign with a given key id' '
+test_expect_success GPG 'sign with a given key id' '
 
 	git tag -u committer@example.com -m "Another message" u-signed-tag &&
 	get_tag_msg u-signed-tag >actual &&
@@ -651,14 +650,14 @@ test_expect_success 'sign with a given key id' '
 
 '
 
-test_expect_success 'sign with an unknown id (1)' '
+test_expect_success GPG 'sign with an unknown id (1)' '
 
 	test_must_fail git tag -u author@example.com \
 		-m "Another message" o-signed-tag
 
 '
 
-test_expect_success 'sign with an unknown id (2)' '
+test_expect_success GPG 'sign with an unknown id (2)' '
 
 	test_must_fail git tag -u DEADBEEF -m "Another message" o-signed-tag
 
@@ -675,7 +674,7 @@ chmod +x fakeeditor
 get_tag_header implied-sign $commit commit $time >expect
 ./fakeeditor >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success '-u implies signed tag' '
+test_expect_success GPG '-u implies signed tag' '
 	GIT_EDITOR=./fakeeditor git tag -u CDDE430D implied-sign &&
 	get_tag_msg implied-sign >actual &&
 	test_cmp expect actual
@@ -688,7 +687,7 @@ EOF
 get_tag_header file-signed-tag $commit commit $time >expect
 cat sigmsgfile >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag with -F messagefile should succeed' '
 	git tag -s -F sigmsgfile file-signed-tag &&
 	get_tag_msg file-signed-tag >actual &&
@@ -702,7 +701,7 @@ EOF
 get_tag_header stdin-signed-tag $commit commit $time >expect
 cat siginputmsg >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success 'creating a signed tag with -F - should succeed' '
+test_expect_success GPG 'creating a signed tag with -F - should succeed' '
 	git tag -s -F - stdin-signed-tag <siginputmsg &&
 	get_tag_msg stdin-signed-tag >actual &&
 	test_cmp expect actual
@@ -711,13 +710,13 @@ test_expect_success 'creating a signed tag with -F - should succeed' '
 get_tag_header implied-annotate $commit commit $time >expect
 ./fakeeditor >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success '-s implies annotated tag' '
+test_expect_success GPG '-s implies annotated tag' '
 	GIT_EDITOR=./fakeeditor git tag -s implied-annotate &&
 	get_tag_msg implied-annotate >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success \
+test_expect_success GPG \
 	'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
 	! tag_exists nosigtag &&
@@ -725,13 +724,13 @@ test_expect_success \
 	! tag_exists nosigtag
 '
 
-test_expect_success 'verifying a signed tag should succeed' \
+test_expect_success GPG 'verifying a signed tag should succeed' \
 	'git tag -v signed-tag'
 
-test_expect_success 'verifying two signed tags in one command should succeed' \
+test_expect_success GPG 'verifying two signed tags in one command should succeed' \
 	'git tag -v signed-tag file-signed-tag'
 
-test_expect_success \
+test_expect_success GPG \
 	'verifying many signed and non-signed tags should fail' '
 	test_must_fail git tag -v signed-tag annotated-tag &&
 	test_must_fail git tag -v file-annotated-tag file-signed-tag &&
@@ -740,7 +739,7 @@ test_expect_success \
 	test_must_fail git tag -v signed-tag annotated-tag file-signed-tag
 '
 
-test_expect_success 'verifying a forged tag should fail' '
+test_expect_success GPG 'verifying a forged tag should fail' '
 	forged=$(git cat-file tag signed-tag |
 		sed -e "s/signed-tag/forged-tag/" |
 		git mktag) &&
@@ -752,7 +751,7 @@ test_expect_success 'verifying a forged tag should fail' '
 
 get_tag_header empty-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag with an empty -m message should succeed' '
 	git tag -s -m "" empty-signed-tag &&
 	get_tag_msg empty-signed-tag >actual &&
@@ -763,7 +762,7 @@ test_expect_success \
 >sigemptyfile
 get_tag_header emptyfile-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag with an empty -F messagefile should succeed' '
 	git tag -s -F sigemptyfile emptyfile-signed-tag &&
 	get_tag_msg emptyfile-signed-tag >actual &&
@@ -786,7 +785,7 @@ Trailing spaces
 Trailing blank lines
 EOF
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'extra blanks in the message for a signed tag should be removed' '
 	git tag -s -F sigblanksfile blanks-signed-tag &&
 	get_tag_msg blanks-signed-tag >actual &&
@@ -796,7 +795,7 @@ test_expect_success \
 
 get_tag_header blank-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag with a blank -m message should succeed' '
 	git tag -s -m "     " blank-signed-tag &&
 	get_tag_msg blank-signed-tag >actual &&
@@ -809,7 +808,7 @@ echo ''      >>sigblankfile
 echo '  '    >>sigblankfile
 get_tag_header blankfile-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag with blank -F file with spaces should succeed' '
 	git tag -s -F sigblankfile blankfile-signed-tag &&
 	get_tag_msg blankfile-signed-tag >actual &&
@@ -820,7 +819,7 @@ test_expect_success \
 printf '      ' >sigblanknonlfile
 get_tag_header blanknonlfile-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag with spaces and no newline should succeed' '
 	git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
 	get_tag_msg blanknonlfile-signed-tag >actual &&
@@ -857,7 +856,7 @@ Another line.
 Last line.
 EOF
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag with a -F file with #comments should succeed' '
 	git tag -s -F sigcommentsfile comments-signed-tag &&
 	get_tag_msg comments-signed-tag >actual &&
@@ -867,7 +866,7 @@ test_expect_success \
 
 get_tag_header comment-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag with #commented -m message should succeed' '
 	git tag -s -m "#comment" comment-signed-tag &&
 	get_tag_msg comment-signed-tag >actual &&
@@ -880,7 +879,7 @@ echo ''         >>sigcommentfile
 echo '####'     >>sigcommentfile
 get_tag_header commentfile-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag with #commented -F messagefile should succeed' '
 	git tag -s -F sigcommentfile commentfile-signed-tag &&
 	get_tag_msg commentfile-signed-tag >actual &&
@@ -891,7 +890,7 @@ test_expect_success \
 printf '#comment' >sigcommentnonlfile
 get_tag_header commentnonlfile-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag with a #comment and no newline should succeed' '
 	git tag -s -F sigcommentnonlfile commentnonlfile-signed-tag &&
 	get_tag_msg commentnonlfile-signed-tag >actual &&
@@ -901,7 +900,7 @@ test_expect_success \
 
 # listing messages for signed tags:
 
-test_expect_success \
+test_expect_success GPG \
 	'listing the one-line message of a signed tag should succeed' '
 	git tag -s -m "A message line signed" stag-one-line &&
 
@@ -926,7 +925,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
+test_expect_success GPG \
 	'listing the zero-lines message of a signed tag should succeed' '
 	git tag -s -m "" stag-zero-lines &&
 
@@ -954,7 +953,7 @@ test_expect_success \
 echo 'stag line one' >sigtagmsg
 echo 'stag line two' >>sigtagmsg
 echo 'stag line three' >>sigtagmsg
-test_expect_success \
+test_expect_success GPG \
 	'listing many message lines of a signed tag should succeed' '
 	git tag -s -F sigtagmsg stag-lines &&
 
@@ -999,12 +998,12 @@ test_expect_success \
 
 tree=$(git rev-parse HEAD^{tree})
 blob=$(git rev-parse HEAD:foo)
-tag=$(git rev-parse signed-tag)
+tag=$(git rev-parse signed-tag 2>/dev/null)
 
 get_tag_header tree-signed-tag $tree tree $time >expect
 echo "A message for a tree" >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag pointing to a tree should succeed' '
 	git tag -s -m "A message for a tree" tree-signed-tag HEAD^{tree} &&
 	get_tag_msg tree-signed-tag >actual &&
@@ -1014,7 +1013,7 @@ test_expect_success \
 get_tag_header blob-signed-tag $blob blob $time >expect
 echo "A message for a blob" >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag pointing to a blob should succeed' '
 	git tag -s -m "A message for a blob" blob-signed-tag HEAD:foo &&
 	get_tag_msg blob-signed-tag >actual &&
@@ -1024,7 +1023,7 @@ test_expect_success \
 get_tag_header tag-signed-tag $tag tag $time >expect
 echo "A message for another tag" >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success \
+test_expect_success GPG \
 	'creating a signed tag pointing to another tag should succeed' '
 	git tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
 	get_tag_msg tag-signed-tag >actual &&
@@ -1033,7 +1032,7 @@ test_expect_success \
 
 # try to sign with bad user.signingkey
 git config user.signingkey BobTheMouse
-test_expect_success \
+test_expect_success GPG \
 	'git tag -s fails if gpg is misconfigured' \
 	'test_must_fail git tag -s -m tail tag-gpg-failure'
 git config --unset user.signingkey
@@ -1041,7 +1040,7 @@ git config --unset user.signingkey
 # try to verify without gpg:
 
 rm -rf gpghome
-test_expect_success \
+test_expect_success GPG \
 	'verify signed tag fails when public key is not present' \
 	'test_must_fail git tag -v signed-tag'
 
-- 
1.6.2.1.224.g2225f
