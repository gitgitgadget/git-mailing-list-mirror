From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t3900: ISO-2022-JP has more than one popular variants
Date: Tue, 12 May 2009 02:29:10 -0700
Message-ID: <7vljp28yah.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 11:29:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3oIq-0000IV-JC
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 11:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285AbZELJ3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 05:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757215AbZELJ3N
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 05:29:13 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:40951 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758595AbZELJ3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 05:29:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090512092911.NQSC17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 12 May 2009 05:29:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id qZVA1b00J4aMwMQ04ZVANQ; Tue, 12 May 2009 05:29:10 -0400
X-Authority-Analysis: v=1.0 c=1 a=-YpcWh-SlmEA:10 a=nCHTAXpMmBAA:10
 a=ybZZDoGAAAAA:8 a=IdU-R-_PjJn2m-557ZoA:9 a=9NGBVVfOV3w80dGUUt8A:7
 a=BMXWLfDRw1YCWF7lRUgH0DjnVCIA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118885>

When converting from other encodings (e.g. EUC-JP or UTF-8), there are
subtly different variants of ISO-2022-JP, all of which are valid.  At the
end of line or when a run of string switches to 1-byte sequence, ESC ( B
can be used to switch to ASCII or ESC ( J can be used to switch to ISO
646:JP (JIS X 0201) but they essentially are the same character set and
are used interchangeably.  Similarly the set ESC $ @ switches to (JIS X
0208-1978) and ESC $ B switches to (JIS X 0208-1983) are in practice used
interchangeably.

Depending on the iconv library and the locale definition on the system, a
program that converts from another encoding to ISO-2022-JP can produce
different byte sequence, and GIT_TEST_CMP (aka "diff -u") will report the
difference as a failure.

Fix this by converting the expected and the actual output to UTF-8 before
comparing when the end result is ISO-2022-JP.  The test vector string in
t3900/ISO-2022-JP.txt is expressed with ASCII and JIS X 0208-1983, but it
can be expressed with any other possible variant, and when converted back
to UTF-8, these variants produce identical byte sequences.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I had to spend some time on an OpenSolaris box at work today X-< so
   play with git there while waiting for something else to finish.  They
   seem to produce ESC ( J instead of ESC ( B to switch out of the 2-byte
   Japanese.

   I had to "pkg install lang-support-japanese" to pass this test.

 t/t3900-i18n-commit.sh |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 784c31a..5dbbcb6 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -9,7 +9,15 @@ test_description='commit and log output encodings'
 
 compare_with () {
 	git show -s $1 | sed -e '1,/^$/d' -e 's/^    //' >current &&
-	test_cmp current "$2"
+	case "$3" in
+	'')
+		test_cmp "$2" current ;;
+	?*)
+		iconv -f "$3" -t utf8 >current.utf8 <current &&
+		iconv -f "$3" -t utf8 >expect.utf8 <"$2" &&
+		test_cmp expect.utf8 current.utf8
+		;;
+	esac
 }
 
 test_expect_success setup '
@@ -103,11 +111,17 @@ done
 
 for J in EUCJP ISO-2022-JP
 do
+	if test "$J" = ISO-2022-JP
+	then
+		ICONV=$J
+	else
+		ICONV=
+	fi
 	git config i18n.logoutputencoding $J
 	for H in EUCJP ISO-2022-JP
 	do
 		test_expect_success "$H should be shown in $J now" '
-			compare_with '$H' "$TEST_DIRECTORY"/t3900/'$J'.txt
+			compare_with '$H' "$TEST_DIRECTORY"/t3900/'$J'.txt $ICONV
 		'
 	done
 done
-- 
1.6.3.9.g6345d
