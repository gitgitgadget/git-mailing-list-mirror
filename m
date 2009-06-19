From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t8005: Nobody writes Russian in shift_jis
Date: Thu, 18 Jun 2009 19:18:37 -0700
Message-ID: <7vmy85m0ea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gavrilov <angavrilov@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 04:18:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHTgl-0004Ho-44
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 04:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbZFSCSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 22:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZFSCSg
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 22:18:36 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33230 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbZFSCSf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 22:18:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090619021837.ENUI18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 18 Jun 2009 22:18:37 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5eJd1c0084aMwMQ04eJdoe; Thu, 18 Jun 2009 22:18:37 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=03H-_EX8tQEA:10 a=ybZZDoGAAAAA:8
 a=GsuHB6x55_Wj4acfI8kA:9 a=S8WRqKDkIXnacIBHPX4A:7
 a=fA6CXZcV_jCMTBTIcPu2QgPEg8AA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121881>

The second and third tests of this script expected that Russian strings
are converted between ISO-8859-5 and Shift_JIS in the "blame --porcelain"
format output correctly.

Sure, many platforms may convert between such a combination, but that is
only because one of the base character set of Shift_JIS, JIS X 0208,
defines codepoints for Russian characters (among others); I do not think
anybody uses Shift_JIS when seriously writing Russian, and it is perfectly
understandable if iconv() libraries on some platforms fail converting
between this combination, as it does not matter in reality.

This patch changes the test to verify Japanese strings are converted
correctly between EUC-JP and Shift_JIS in the same procedure.  The point
of the test is not about verifying the platform's iconv() library, but to
see if "git blame" makes correct iconv() library calls when it should.

We could instead use ISO-8859-5 and KOI8-R as the combination, because
they are both meant to represent Russian, in order to make this test
meaningful on more platforms, but we already use Shift_JIS vs EUC-JP
combinations to test other programs in our test suite, so this combination
is safer from the point of view of the portability.  Besides, I do not
read nor write Russian; sorry ;-)

This change allows tests to pass on my (friend's) Solaris 5.11 box.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am Cc'ing Alexander because he originally wrote this test using
   cp1251 and shift_jis, and I could be wrong in saying that nobody sane
   writes Russian in shift_jis.

   To allow 7-bit mailpath to pass this patch through, I tentatively
   dropped this in my t/t8005 directory (the file is not tracked):

	$ echo '*.txt binary' >t/t8005/.gitattributes
   
   before running format-patch on this commit.

 t/t8005-blame-i18n.sh |   26 +++++++++++++-------------
 t/t8005/euc-japan.txt |  Bin 0 -> 66 bytes
 t/t8005/iso8859-5.txt |  Bin 74 -> 0 bytes
 t/t8005/sjis.txt      |  Bin 100 -> 56 bytes
 t/t8005/utf8.txt      |  Bin 100 -> 71 bytes
 5 files changed, 13 insertions(+), 13 deletions(-)
 create mode 100644 t/t8005/euc-japan.txt
 delete mode 100644 t/t8005/iso8859-5.txt

diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index 9cca14d..cb39055 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -4,7 +4,7 @@ test_description='git blame encoding conversion'
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/t8005/utf8.txt
-. "$TEST_DIRECTORY"/t8005/iso8859-5.txt
+. "$TEST_DIRECTORY"/t8005/euc-japan.txt
 . "$TEST_DIRECTORY"/t8005/sjis.txt
 
 test_expect_success 'setup the repository' '
@@ -13,10 +13,10 @@ test_expect_success 'setup the repository' '
 	git add file &&
 	git commit --author "$UTF8_NAME <utf8@localhost>" -m "$UTF8_MSG" &&
 
-	echo "ISO-8859-5 LINE" >> file &&
+	echo "EUC-JAPAN LINE" >> file &&
 	git add file &&
-	git config i18n.commitencoding ISO8859-5 &&
-	git commit --author "$ISO8859_5_NAME <iso8859-5@localhost>" -m "$ISO8859_5_MSG" &&
+	git config i18n.commitencoding eucJP &&
+	git commit --author "$EUC_JAPAN_NAME <euc-japan@localhost>" -m "$EUC_JAPAN_MSG" &&
 
 	echo "SJIS LINE" >> file &&
 	git add file &&
@@ -41,17 +41,17 @@ test_expect_success \
 '
 
 cat >expected <<EOF
-author $ISO8859_5_NAME
-summary $ISO8859_5_MSG
-author $ISO8859_5_NAME
-summary $ISO8859_5_MSG
-author $ISO8859_5_NAME
-summary $ISO8859_5_MSG
+author $EUC_JAPAN_NAME
+summary $EUC_JAPAN_MSG
+author $EUC_JAPAN_NAME
+summary $EUC_JAPAN_MSG
+author $EUC_JAPAN_NAME
+summary $EUC_JAPAN_MSG
 EOF
 
 test_expect_success \
 	'blame respects i18n.logoutputencoding' '
-	git config i18n.logoutputencoding ISO8859-5 &&
+	git config i18n.logoutputencoding eucJP &&
 	git blame --incremental file | \
 		egrep "^(author|summary) " > actual &&
 	test_cmp actual expected
@@ -76,8 +76,8 @@ test_expect_success \
 cat >expected <<EOF
 author $SJIS_NAME
 summary $SJIS_MSG
-author $ISO8859_5_NAME
-summary $ISO8859_5_MSG
+author $EUC_JAPAN_NAME
+summary $EUC_JAPAN_MSG
 author $UTF8_NAME
 summary $UTF8_MSG
 EOF
diff --git a/t/t8005/euc-japan.txt b/t/t8005/euc-japan.txt
new file mode 100644
index 0000000000000000000000000000000000000000..288f040c99f6b61559e3ad964a1247d4b9fd62a3
GIT binary patch
literal 66
zcmZ<_b&mIP3~=;|_jB}hwN=`^`REaaLkG_9QsQ!jOZf)7+bS)+w)D-yJxd=fIk)uK
R(w$3BEIGbp=fcHGTmX#39_;`C

literal 0
HcmV?d00001

diff --git a/t/t8005/iso8859-5.txt b/t/t8005/iso8859-5.txt
deleted file mode 100644
index 2e4b80c8df4da30722561049c46cca778e49cd2f..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 74
zcmeYa_P4MwwTw57_jB}hwN=`2>B3!w{Z}77xOeHsbA^L9uG|B%l(;<M%6x;}ZIupP
Zefa3!rF&Nu9^Sim@#WRKH?Asi0RTCvCqV!J

diff --git a/t/t8005/sjis.txt b/t/t8005/sjis.txt
index 2ccfbad207c6e96b1f4f528031d9e4938d364b92..bbdefeaced4b54f98e5d9a85ddd8e0d7346fe7e3 100644
GIT binary patch
literal 56
zcmWIc@(hmmbM$q!Rq6|xoUAZ$-;78lu3(U;Z?L<qQgdl@Ph)g*L(`e&)aHoh^roXt
J+Z&yfxBxx66{!FK

literal 100
zcmWIc@(hmmbM$q!Rci5UDQYQbsZ(ePXen)JX=!R{018yLbSkt20jUxo7c8X26%5kk
k8|)6$6AV<^3{(tK+R##}0OT|PVPQ)*P@)c~tyGB%00x;U@Bjb+

diff --git a/t/t8005/utf8.txt b/t/t8005/utf8.txt
index f46cfc56d80797740c3ec15e166add052f905fcb..4d00dbea7659ee27fda283e7e45cfb2d5f6ea4d1 100644
GIT binary patch
literal 71
zcmWFyakGf`bM$q!ReHK{<MSyS6rL_w^|HB7i7ON&;~VU5tMs^e+T-RmkDK>AZeH-X
baoywQw#Q97A2)YAZe0GjapvQOCM7Na%AzF~

literal 100
zcmWFyakGf`bM$q!Rk|?a!lnxwF6>pfF#p2Vi%l0BF6;ve?6}yjaADzv9T&D-*as0(
t;tB<6@(p$e>RAL-+IX=EtaRUntqK<#fy{juHeT$!u=T=Tpth|_TmU(XJDmUk

-- 
1.6.3.2.316.gda4e4
