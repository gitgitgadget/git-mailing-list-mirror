From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add test-script for git-tag
Date: Thu, 14 Jun 2007 18:58:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706141851160.4059@racer.site>
References: <1b46aba20706140945i2545c06fxce3fda71fe59a7af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 20:02:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyteF-0004bZ-8W
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 20:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbXFNSCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbXFNSCP
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 14:02:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:43476 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750725AbXFNSCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 14:02:14 -0400
Received: (qmail invoked by alias); 14 Jun 2007 18:02:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 14 Jun 2007 20:02:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19OEu52aXxOmkhl5+c5lr94WEBoYEn87J33wrtMH2
	IQXorKeW5mwaTm
X-X-Sender: gene099@racer.site
In-Reply-To: <1b46aba20706140945i2545c06fxce3fda71fe59a7af@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50216>

From: Carlos Rica <jasampler@gmail.com>

These tests are useful to develop the C version for git-tag.sh,
ensuring that the future builtin-tag.c will not break previous
behaviour.

The tests are focused on listing, verifying, deleting and creating
tags, checking always that the correct status value is returned
and everything remains as expected.

In order to verify and create signed tags, a PGP key was also
added, being created this way: gpg --homedir t/t7003 --gen-key
Type DSA and Elgamal, size 2048 bits, no expiration date.
Name and email: C O Mitter <committer@example.com>
No password given, to enable non-interactive operation.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Gmail had a problem with one line. Thus the resend.

 t/t7003-tag.sh      |  616 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t7003/pubring.gpg |  Bin 0 -> 1164 bytes
 t/t7003/random_seed |  Bin 0 -> 600 bytes
 t/t7003/secring.gpg |  Bin 0 -> 1237 bytes
 t/t7003/trustdb.gpg |  Bin 0 -> 1280 bytes
 5 files changed, 616 insertions(+), 0 deletions(-)
 create mode 100755 t/t7003-tag.sh
 create mode 100644 t/t7003/pubring.gpg
 create mode 100644 t/t7003/random_seed
 create mode 100644 t/t7003/secring.gpg
 create mode 100644 t/t7003/trustdb.gpg

diff --git a/t/t7003-tag.sh b/t/t7003-tag.sh
new file mode 100755
index 0000000..d998dd2
--- /dev/null
+++ b/t/t7003-tag.sh
@@ -0,0 +1,616 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Carlos Rica
+#
+
+test_description='git-tag
+
+Basic tests for operations with tags.'
+
+. ./test-lib.sh
+
+# creating and listing lightweight tags:
+
+tag_exists () {
+	git show-ref --quiet --verify refs/tags/$1
+}
+
+test_expect_success 'listing all tags in an empty tree now should succeed' \
+	'git tag -l'
+
+test_expect_success 'listing all tags in an empty tree should output nothing' \
+	'test `git-tag -l | wc -l` -eq 0'
+
+test_expect_failure 'looking for a tag in an empty tree should fail' \
+	'tag_exists mytag'
+
+test_expect_failure 'creating a tag in an empty tree should fail' '
+	git-tag mynotag ||
+	tag_exists mynotag
+'
+
+test_expect_failure 'creating a tag for HEAD in an empty tree should fail' '
+	git-tag mytaghead HEAD ||
+	tag_exists mytaghead
+'
+
+test_expect_failure 'creating a tag for an unknown revision should fail' '
+	git-tag mytagnorev aaaaaaaaaaa ||
+	tag_exists mytagnorev
+'
+
+test_expect_success 'creating a tag using default HEAD should succeed' '
+	echo foo >foo &&
+	git add foo &&
+	test_tick && git commit -m Foo &&
+	git tag mytag
+'
+
+test_expect_success 'listing all tags if one exists now also should succeed' \
+	'git-tag -l'
+
+test_expect_success 'listing all tags if one exists should output that tag' \
+	'test `git-tag -l` = mytag'
+
+# pattern matching:
+
+test_expect_success 'listing a tag using a matching pattern should succeed' \
+	'git-tag -l mytag'
+
+test_expect_success \
+	'listing a tag using a matching pattern should output that tag' \
+	'test `git-tag -l mytag` = mytag'
+
+test_expect_success \
+	'listing tags using a non-matching pattern now should suceed' \
+	'git-tag -l xxx'
+
+test_expect_success \
+	'listing tags using a non-matching pattern should output nothing' \
+	'test `git-tag -l xxx | wc -l` -eq 0'
+
+# special cases for creating tags:
+
+test_expect_failure \
+	'trying to create a tag with the name of one existing should fail' \
+	'git tag mytag'
+
+test_expect_failure 'trying to create a tag with a non-valid name should fail' '
+	test `git-tag -l | wc -l` -ne 1 ||
+	git tag .othertag ||
+	git tag "other tag" ||
+	git tag "othertag^" ||
+	git tag "other~tag" ||
+	test `git-tag -l | wc -l` -ne 1
+'
+
+test_expect_success 'creating a tag using HEAD directly should succeed' '
+	git tag myhead HEAD &&
+	tag_exists myhead
+'
+
+# deleting tags:
+
+test_expect_failure 'trying to delete an unknown tag should fail' '
+	tag_exists unknown-tag ||
+	git-tag -d unknown-tag
+'
+
+cat >expect <<EOF
+myhead
+mytag
+EOF
+test_expect_success \
+	'trying to delete tags without params should succeed and do nothing' '
+	git tag -l > actual && git diff expect actual &&
+	git-tag -d &&
+	git tag -l > actual && git diff expect actual
+'
+
+test_expect_success \
+	'deleting two existing tags in one command should succeed' '
+	tag_exists mytag &&
+	tag_exists myhead &&
+	git-tag -d mytag myhead &&
+	! tag_exists mytag &&
+	! tag_exists myhead
+'
+
+test_expect_success \
+	'creating a tag with the name of another deleted one should succeed' '
+	! tag_exists mytag &&
+	git-tag mytag &&
+	tag_exists mytag
+'
+
+test_expect_failure \
+	'trying to delete two tags -existing and not- should fail for the 2nd' '
+	tag_exists mytag &&
+	! tag_exists myhead &&
+	git-tag -d mytag anothertag
+	! tag_exists mytag &&
+	! tag_exists myhead &&
+'
+
+test_expect_failure 'trying to delete an already deleted tag should fail' \
+	'git-tag -d mytag'
+
+# listing various tags with pattern matching:
+
+cat >expect <<EOF
+a1
+aa1
+cba
+t210
+t211
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+EOF
+test_expect_success 'listing all tags should print them ordered' '
+	git tag v1.0.1 &&
+	git tag t211 &&
+	git tag aa1 &&
+	git tag v0.2.1 &&
+	git tag v1.1.3 &&
+	git tag cba &&
+	git tag a1 &&
+	git tag v1.0 &&
+	git tag t210 &&
+	git tag -l > actual
+	git diff expect actual
+'
+
+cat >expect <<EOF
+a1
+aa1
+cba
+EOF
+test_expect_success \
+	'listing tags with substring as pattern now must print those matching' '
+	git-tag -l a > actual &&
+	git-diff expect actual
+'
+
+cat >expect <<EOF
+v0.2.1
+v1.0.1
+v1.1.3
+EOF
+test_expect_success \
+	'listing tags with substring as pattern now must print those matching' '
+	git-tag -l .1 > actual &&
+	git-diff expect actual
+'
+
+cat >expect <<EOF
+t210
+t211
+EOF
+test_expect_success \
+	'listing tags with substring as pattern now must print those matching' '
+	git-tag -l t21 > actual &&
+	git-diff expect actual
+'
+
+cat >expect <<EOF
+a1
+aa1
+EOF
+test_expect_success \
+	'listing tags using a name as pattern now must print those matching' '
+	git-tag -l a1 > actual &&
+	git-diff expect actual
+'
+
+cat >expect <<EOF
+v1.0
+v1.0.1
+EOF
+test_expect_success \
+	'listing tags using a name as pattern now must print those matching' '
+	git-tag -l v1.0 > actual &&
+	git-diff expect actual
+'
+
+cat >expect <<EOF
+v1.1.3
+EOF
+test_expect_success \
+	'listing tags with ? in the pattern should print those matching' '
+	git-tag -l 1.1? > actual &&
+	git-diff expect actual
+'
+
+# creating and verifying lightweight tags:
+
+test_expect_success \
+	'a non-annotated tag created without parameters should point to HEAD' '
+	git-tag non-annotated-tag &&
+	! git cat-file tag non-annotated-tag &&
+	test "$(git rev-parse non-annotated-tag^{commit})" = \
+		"$(git rev-parse HEAD)"
+'
+
+test_expect_failure 'trying to verify an unknown tag should fail' \
+	'git-tag -v unknown-tag'
+
+test_expect_failure \
+	'trying to verify a non-annotated and non-signed tag should fail' \
+	'git-tag -v non-annotated-tag'
+
+# creating annotated tags:
+
+get_tag_msg () {
+	git cat-file tag "$1" | sed -n -e "1,/BEGIN PGP/p"
+}
+
+get_tag_header () {
+cat >expect <<EOF
+object $2
+type commit
+tag $1
+tagger C O Mitter <committer@example.com> $3 -0700
+
+EOF
+}
+
+commit=$(git rev-parse HEAD)
+time=$test_tick
+
+get_tag_header annotated-tag $commit $time >expect
+echo "A message" >>expect
+test_expect_success \
+	'creating an annotated tag with -m message should succeed' '
+	git-tag -m "A message" annotated-tag &&
+	get_tag_msg annotated-tag >actual &&
+	git diff expect actual
+'
+
+cat >msgfile <<EOF
+Another message
+in a file.
+EOF
+get_tag_header file-annotated-tag $commit $time >expect
+cat msgfile >>expect
+test_expect_success \
+	'creating an annotated tag with -F messagefile should succeed' '
+	git-tag -F msgfile file-annotated-tag &&
+	get_tag_msg file-annotated-tag >actual &&
+	git diff expect actual
+'
+
+# blank and empty messages:
+
+get_tag_header empty-annotated-tag $commit $time >expect
+test_expect_success \
+	'creating a tag with an empty -m message should succeed' '
+	git-tag -m "" empty-annotated-tag &&
+	get_tag_msg empty-annotated-tag >actual &&
+	git diff expect actual
+'
+
+touch emptyfile
+get_tag_header emptyfile-annotated-tag $commit $time >expect
+test_expect_success \
+	'creating a tag with an empty -F messagefile should succeed' '
+	git-tag -F emptyfile emptyfile-annotated-tag &&
+	get_tag_msg emptyfile-annotated-tag >actual &&
+	git diff expect actual
+'
+
+printf '\n\n  \n\t\nLeading blank lines\n' >blanksfile
+printf '\n\t \t  \nRepeated blank lines\n' >>blanksfile
+printf '\n\n\nTrailing spaces      \t  \n' >>blanksfile
+printf '\nTrailing blank lines\n\n\t \n\n' >>blanksfile
+get_tag_header blanks-annotated-tag $commit $time >expect
+cat >>expect <<EOF
+Leading blank lines
+
+Repeated blank lines
+
+Trailing spaces
+
+Trailing blank lines
+EOF
+test_expect_success \
+	'extra blanks in the message for an annotated tag should be removed' '
+	git-tag -F blanksfile blanks-annotated-tag &&
+	get_tag_msg blanks-annotated-tag >actual &&
+	git diff expect actual
+'
+
+get_tag_header blank-annotated-tag $commit $time >expect
+test_expect_success \
+	'creating a tag with blank -m message with spaces should succeed' '
+	git-tag -m "     " blank-annotated-tag &&
+	get_tag_msg blank-annotated-tag >actual &&
+	git diff expect actual
+'
+
+echo '     ' >blankfile
+echo ''      >>blankfile
+echo '  '    >>blankfile
+get_tag_header blankfile-annotated-tag $commit $time >expect
+test_expect_success \
+	'creating a tag with blank -F messagefile with spaces should succeed' '
+	git-tag -F blankfile blankfile-annotated-tag &&
+	get_tag_msg blankfile-annotated-tag >actual &&
+	git diff expect actual
+'
+
+printf '      ' >blanknonlfile
+get_tag_header blanknonlfile-annotated-tag $commit $time >expect
+test_expect_success \
+	'creating a tag with -F file of spaces and no newline should succeed' '
+	git-tag -F blanknonlfile blanknonlfile-annotated-tag &&
+	get_tag_msg blanknonlfile-annotated-tag >actual &&
+	git diff expect actual
+'
+
+# messages with commented lines:
+
+cat >commentsfile <<EOF
+# A comment
+
+############
+The message.
+############
+One line.
+
+
+# commented lines
+# commented lines
+
+Another line.
+# comments
+
+Last line.
+EOF
+get_tag_header comments-annotated-tag $commit $time >expect
+cat >>expect <<EOF
+The message.
+One line.
+
+Another line.
+
+Last line.
+EOF
+test_expect_success \
+	'creating a tag using a -F messagefile with #comments should succeed' '
+	git-tag -F commentsfile comments-annotated-tag &&
+	get_tag_msg comments-annotated-tag >actual &&
+	git diff expect actual
+'
+
+get_tag_header comment-annotated-tag $commit $time >expect
+test_expect_success \
+	'creating a tag with a #comment in the -m message should succeed' '
+	git-tag -m "#comment" comment-annotated-tag &&
+	get_tag_msg comment-annotated-tag >actual &&
+	git diff expect actual
+'
+
+echo '#comment' >commentfile
+echo ''         >>commentfile
+echo '####'     >>commentfile
+get_tag_header commentfile-annotated-tag $commit $time >expect
+test_expect_success \
+	'creating a tag with #comments in the -F messagefile should succeed' '
+	git-tag -F commentfile commentfile-annotated-tag &&
+	get_tag_msg commentfile-annotated-tag >actual &&
+	git diff expect actual
+'
+
+printf '#comment' >commentnonlfile
+get_tag_header commentnonlfile-annotated-tag $commit $time >expect
+test_expect_success \
+	'creating a tag with a file of #comment and no newline should succeed' '
+	git-tag -F commentnonlfile commentnonlfile-annotated-tag &&
+	get_tag_msg commentnonlfile-annotated-tag >actual &&
+	git diff expect actual
+'
+
+# trying to verify annotated non-signed tags:
+
+test_expect_failure \
+	'trying to verify an annotated non-signed tag should fail' '
+	! tag_exists annotated-tag ||
+	git-tag -v annotated-tag
+'
+
+test_expect_failure \
+	'trying to verify a file-annotated non-signed tag should fail' '
+	! tag_exists file-annotated-tag ||
+	git-tag -v file-annotated-tag
+'
+
+# creating and verifying signed tags:
+
+gpg --version >/dev/null
+if [ $? -eq 127 ]; then
+	echo "Skipping signed tags tests, because gpg was not found"
+	test_done
+	exit
+fi
+
+# key generation info: gpg --homedir t/t7003 --gen-key
+# Type DSA and Elgamal, size 2048 bits, no expiration date.
+# Name and email: C O Mitter <committer@example.com>
+# No password given, to enable non-interactive operation.
+
+cp -R ../t7003 ./gpghome
+chmod 0700 gpghome
+export GNUPGHOME="$(pwd)/gpghome"
+
+get_tag_header signed-tag $commit $time >expect
+echo 'A signed tag message' >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success 'creating a signed tag with -m message should succeed' '
+	git-tag -s -m "A signed tag message" signed-tag &&
+	get_tag_msg signed-tag >actual &&
+	git-diff expect actual
+'
+
+test_expect_success 'verifying a signed tag should succeed' \
+	'git-tag -v signed-tag'
+
+# blank and empty messages for signed tags:
+
+get_tag_header empty-signed-tag $commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'creating a signed tag with an empty -m message should succeed' '
+	git-tag -s -m "" empty-signed-tag &&
+	get_tag_msg empty-signed-tag >actual &&
+	git diff expect actual &&
+	git-tag -v empty-signed-tag
+'
+
+touch sigemptyfile
+get_tag_header emptyfile-signed-tag $commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'creating a signed tag with an empty -F messagefile should succeed' '
+	git-tag -s -F sigemptyfile emptyfile-signed-tag &&
+	get_tag_msg emptyfile-signed-tag >actual &&
+	git diff expect actual &&
+	git-tag -v emptyfile-signed-tag
+'
+
+printf '\n\n  \n\t\nLeading blank lines\n' > sigblanksfile
+printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
+printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
+printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
+get_tag_header blanks-signed-tag $commit $time >expect
+cat >>expect <<EOF
+Leading blank lines
+
+Repeated blank lines
+
+Trailing spaces
+
+Trailing blank lines
+EOF
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'extra blanks in the message for a signed tag should be removed' '
+	git-tag -s -F sigblanksfile blanks-signed-tag &&
+	get_tag_msg blanks-signed-tag >actual &&
+	git diff expect actual &&
+	git-tag -v blanks-signed-tag
+'
+
+get_tag_header blank-signed-tag $commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'creating a signed tag with a blank -m message should succeed' '
+	git-tag -s -m "     " blank-signed-tag &&
+	get_tag_msg blank-signed-tag >actual &&
+	git diff expect actual &&
+	git-tag -v blank-signed-tag
+'
+
+echo '     ' >sigblankfile
+echo ''      >>sigblankfile
+echo '  '    >>sigblankfile
+get_tag_header blankfile-signed-tag $commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'creating a signed tag with blank -F file with spaces should succeed' '
+	git-tag -s -F sigblankfile blankfile-signed-tag &&
+	get_tag_msg blankfile-signed-tag >actual &&
+	git diff expect actual &&
+	git-tag -v blankfile-signed-tag
+'
+
+printf '      ' >sigblanknonlfile
+get_tag_header blanknonlfile-signed-tag $commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'creating a signed tag with spaces and no newline should succeed' '
+	git-tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
+	get_tag_msg blanknonlfile-signed-tag >actual &&
+	git diff expect actual &&
+	git-tag -v signed-tag
+'
+
+# messages with commented lines for signed tags:
+
+cat >sigcommentsfile <<EOF
+# A comment
+
+############
+The message.
+############
+One line.
+
+
+# commented lines
+# commented lines
+
+Another line.
+# comments
+
+Last line.
+EOF
+get_tag_header comments-signed-tag $commit $time >expect
+cat >>expect <<EOF
+The message.
+One line.
+
+Another line.
+
+Last line.
+EOF
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'creating a signed tag with a -F file with #comments should succeed' '
+	git-tag -s -F sigcommentsfile comments-signed-tag &&
+	get_tag_msg comments-signed-tag >actual &&
+	git diff expect actual &&
+	git-tag -v comments-signed-tag
+'
+
+get_tag_header comment-signed-tag $commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'creating a signed tag with #commented -m message should succeed' '
+	git-tag -s -m "#comment" comment-signed-tag &&
+	get_tag_msg comment-signed-tag >actual &&
+	git diff expect actual &&
+	git-tag -v comment-signed-tag
+'
+
+echo '#comment' >sigcommentfile
+echo ''         >>sigcommentfile
+echo '####'     >>sigcommentfile
+get_tag_header commentfile-signed-tag $commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'creating a signed tag with #commented -F messagefile should succeed' '
+	git-tag -s -F sigcommentfile commentfile-signed-tag &&
+	get_tag_msg commentfile-signed-tag >actual &&
+	git diff expect actual &&
+	git-tag -v commentfile-signed-tag
+'
+
+printf '#comment' >sigcommentnonlfile
+get_tag_header commentnonlfile-signed-tag $commit $time >expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success \
+	'creating a signed tag with a #comment and no newline should succeed' '
+	git-tag -s -F sigcommentnonlfile commentnonlfile-signed-tag &&
+	get_tag_msg commentnonlfile-signed-tag >actual &&
+	git diff expect actual &&
+	git-tag -v commentnonlfile-signed-tag
+'
+
+rm -rf gpghome
+test_expect_failure \
+	'verify signed tag fails when public key is not present' \
+	'git-tag -v signed-tag'
+
+test_done
+
diff --git a/t/t7003/pubring.gpg b/t/t7003/pubring.gpg
new file mode 100644
index 0000000000000000000000000000000000000000..83855fa4e1c6c37afe550c17afa1e7971042ded5
GIT binary patch
literal 1164
zcmV;71ateD0ipy(XUi!O1OT%L_{gO;4KKDfwF;#WWYZ2?*>Ph_j9y>uobJf#jXEbw
zQUOEXs+@;X*)1kyN*7VwW}f-GD3>Vlu2F6j{T^Kt%(kMo(W3C}W^X)NL|0VdGIzc`
z5@TY!;Du~AFGW=#0vYgS@U2j8Q{Qe9F~lQEBVt+(yjM1jQ{YLe0lxsC<HX~BiFSU3
zs3oq~QtxsAzbwuV1N{{&PcudMk6}p><?O}^6vikhMm+>LD}W25r?wdKr$(|R8_;Mn
z&Yh%2Hbu9IX>#(R8S&@jVI!K^K7AI$=A+*-qJ>-J^fdR_m5GZao*%P{nee=O$Eb$s
zes#O%4Z_4OAZW}8Ey8%%w->rA>z!nf)&NPikkr&pkRlB>=W+x68fwevWl9Ys2R3m2
zNPf<ig>x1y^AXyemu>Q}DAp%==Q`5sCrBzLaH^rOm1NLtt-ig*IfY?HMdv66@%u%#
zy0K62;Z+4O3Ol6i*<7GlXeW6FC?0yV!c_#yGozNjrOE#8+Rw@Z8cGAG=eE%uMUW=V
zX(76db;AG@lD)hAv?4<wPasWcbaZ8MAUtDlZEb0EbY*ftWq4t2aBO8RV{dIfh+YH}
z5dr`n1p-EA%P9gI0|pBT2nPcK0~G=T0~P`S0v-VZ7k~f?2@n&u^&ZXMLk)Bt0G~<e
ziCMX)QRqT4mEiivJ-X>{Mxg+pzucC_!d-8(MV+3G?_=VDC^nQ}umS)BxdIIYMrX@T
z5C{Oyxp_ZR>*yfS@@M%BVY6{X4EXUYpbiBs(uw7knRB|b)>)=o+wQ%-v34o&a|fQ;
z&R=xVK8Z-jS8R4m_gj2C$xPq$xv1H553!y9ip8A~vxoyq&fFbw!L$zU@hDh#f$r>>
zAYPcTf%K%xv5<+JivV@Da!&`-v8eIo5ApKIdiK7E`krA1X!I73&)t#yo}GERUSnBN
zlK-+<I<**0!u}jvbPz5b{hhe8_PVcR!i8ObFp-W0bqNWKA+W14zV9Mj$a~(KZ-0uf
z|BVvaf!K}k92MNalP4hQ^Yxqk-*SzY6q{6Cw*+Fr_+LZp=BFzuo3pVX*T?Ic-|hbZ
z1PurPv|=$EKX~Bz_Bz;JW71^>8;AnsY?5ub{hajO)@PHTt`On@Z;}jyeue<@oS$3l
zEu9m5O={<O&85HqUN|R$bZiPXX4YsWsPOn@@M)Lf;hyI_(eM$*#Sf3}T=1jzGvsiy
ziKuCmV^)`UC@8ma=jBiHqr!1L4>w`5P=-vvIiJTGj0-lRpc+EU9(`B#rn1m1WqmXr
z5Z+N|DR*y*k<4fY0I_eP7qVo9Fx58WMwaK^N~I=>1VN29R|Umg^2q$WGlE#9AFC2_
zOYG5M$}OL?FQ)ej0!KGwY-hAFz#wAPr>3&{`s7!HUZ22Y7KY{9ly1wQ8^hqBojPv8
zh)Dz(5dr`S1p-EA%T59t3;+rV5EHib9?jlE4Z-XHpqd%~B34SUmtRi+{;vv2ei?p%
eLjau^#pu5ba=n|GS94<zkje^zT1YFf0ssTLm?$>@

literal 0
HcmV?d00001

diff --git a/t/t7003/random_seed b/t/t7003/random_seed
new file mode 100644
index 0000000000000000000000000000000000000000..8fed1339ed0a744e5663f4a5e6b6ac9bae3d8524
GIT binary patch
literal 600
zcmV-e0;m1=h9nBV>1C6QsKJEiEJaD@Q3F8s5u<$E+<2(By)JAZSxviTsXg(wKC+O%
zzvV{Z>W3*k?r7~pgmmkbw8-x{Am!eeN)z?cwIHcT2jqgiA(SXo<iO=E?cY80`p#w8
z)O-&?SnwsJ=1VJ-?26&*g88Nr8E=g2onRW^(c+2nJlX)?dmK)tPO0EY-!B!vMCv1)
z-AOW(3WuF+7IdSxMnzrDgnMqVU=|+YFxlY|VeR+Fg<%C@0Xupi0<S7QYJyFTR$}FQ
zzoSAbU>CoCKWKX;!3@L_U=aFUm!M<>ILG}$`bfnadAkLQbI-upV7Qwf^OE&N45Pz<
zk~^KlzNC6)d@QGv=K5-At&A8FS&MQSR`LB}@R1?A3K1p(vM>7CK}EfFhmBJd&cH^-
z(3Ih^`VuoVBB|w~p!Q^#DY%V2A2FhXu<Bp*L)lSCUdqRyI5wxMG&E1sL$)E$Zo&pJ
zgy#;fENqHImgN>LL2!7DhfZ}&;BSAyz=T0#S?2+NET5St@16L?YI?5Io%<uD|2}hl
zx0xsuefz1+bM^-ZIgtKs=)&VAI8(MfytvM>t>%~nsXUb~*EkptHiN?W{=DRu_s;2u
ziHh{2&>;CQO7;>{$DN33_Ef}g+;b<2hIF^p(Y>^riLBb*Y2Xw>F8)jp49&oLKJOic
z+V{Lt!_`eKGhyk5Edie{-^#n!TFlsfux*QBRZEh^4SVePPmb{BvF|>sKd2cYg@vKp
mVI8jcB1(k(tlt^Kr<{EMs>|b*d70nyVMQcc%xEnE(#Uq3d^-35

literal 0
HcmV?d00001

diff --git a/t/t7003/secring.gpg b/t/t7003/secring.gpg
new file mode 100644
index 0000000000000000000000000000000000000000..d831cd9eb3eee613d3c0e1a71093ae01ea7347e3
GIT binary patch
literal 1237
zcmV;`1S<QL0lNf7XUi!O1OT%L_{gO;4KKDfwF;#WWYZ2?*>Ph_j9y>uobJf#jXEbw
zQUOEXs+@;X*)1kyN*7VwW}f-GD3>Vlu2F6j{T^Kt%(kMo(W3C}W^X)NL|0VdGIzc`
z5@TY!;Du~AFGW=#0vYgS@U2j8Q{Qe9F~lQEBVt+(yjM1jQ{YLe0lxsC<HX~BiFSU3
zs3oq~QtxsAzbwuV1N{{&PcudMk6}p><?O}^6vikhMm+>LD}W25r?wdKr$(|R8_;Mn
z&Yh%2Hbu9IX>#(R8S&@jVI!K^K7AI$=A+*-qJ>-J^fdR_m5GZao*%P{nee=O$Eb$s
zes#O%4Z_4OAZW}8Ey8%%w->rA>z!nf)&NPikkr&pkRlB>=W+x68fwevWl9Ys2R3m2
zNPf<ig>x1y^AXyemu>Q}DAp%==Q`5sCrBzLaH^rOm1NLtt-ig*IfY?HMdv66@%u%#
zy0K62;Z+4O3Ol6i*<7GlXeW6FC?0yV!c_#yGozNjrOE#8+Rw@Z8cGAG=eE%uMUW=V
zX(76db;AG@lD)hA005tK#LT31ryNoF9o-(`X`Xl5w88@mle8j3AWtAoX>@dDav(fo
zZ*6U9baZ8MKxKGgZE$R5E@N+PK8Rif6A=Oc9t8qMXUi!98v_Ol2?z%R0s|ES0|OQU
z0RkQY0vCV)3JDMsw)Gy(-a`#^9RQ%c+5fOQwB&AM#DD9)s1L@!pm9S0pF>@|C2*qL
z%1j5#NZ6^U*PB>^d9VTi0G$Fo1V(4eP7nwH&bfI%Q|ss;(eh{c3}LfzMGW}yE1(Vq
zEz*hQmYH+9vesFqTifovzOi;G@N);A+0I{d(LRYt$5(82OZQuRJjqPo^tq_na}Tkd
z|BA((5wnN`O3vIJaly0>?(ryCcY*Hgm>^!5uz~cX%CV4%oQnW;wsKDg)3K=W<qz@l
z$a?m^i29yk259sakI&ta{GOe8x?W>hQIh|%Svs{CO~U>hTXYaE9sQlSv-Y~LWWt4A
ze=w1b1$7Atj3KbAF~092T*!Ogn{R)Lum6n_*@4)N@EjG~z>_B+>GSoQ{oitpmlT^+
zUAF{c!T4W8?B=H{DVwvgAlJw1n&0jJ00a#P0JLH;8$Wp9`Sv>4USrZ_1sjM0<!q8|
zxc!{;-PUK5pso<&0dJBFgMNkp@|>Sr>@A%Wd`)WSc+I820A4sJf^=*OHfGjnC8+TD
zW$<a2;o+X=JkjtG#>Eeh?p*Mr_A}&gvx%r_lw($xcPJ>gap&bv^P|FXJr6fwvQUOh
zz&W4C8jK4zqM#Z=%N~7K_NKDXEM<K(9uVG9XDN4YijmA{1^}^dq8GAcg)r4N<3^U}
z-b$q=iUdK8Hdh73UGm8MyfcDWr5~#ja!c&dVahF^v@fRj3IazrWNc@&F~A^V)u*Pi
z`ugNogkGP(V-|+x+mvq0pc}*Bpq)By!2khN4M6SOU21NKpXW5P=UU_LoDzvrTdR;4
zU)W&&o9V6>MQOk{A%?1(Ozs{Qqlifa7!d*h2?YX1XUk3k8w>yn2@n&u^&ZXMLk+>~
z0HDxvfGrJTMY@$ys#k#t?D63Zq=W#R3eUeT(L61`VGHe?zP;`rnta#-umS)8nA%Rq

literal 0
HcmV?d00001

diff --git a/t/t7003/trustdb.gpg b/t/t7003/trustdb.gpg
new file mode 100644
index 0000000000000000000000000000000000000000..abace962b8bf84be688a6f27e4ebd0ee7052f210
GIT binary patch
literal 1280
zcmZQfFGy!*W@Ke#U|?`dKkWykumMIcY@%4iM%7^n6rj+M4;MLzzlOX&pwTnxkD-}P
zc^HbXN0fL!SIq1?>env3?W^3`d(OOU5YNaX{KU(k^<0;M@87ONv)_6ZxD={-=<kYO
M2Ud3=2BC}r0AuhNr2qf`

literal 0
HcmV?d00001

-- 
1.5.2.1.2876.g6670-dirty
