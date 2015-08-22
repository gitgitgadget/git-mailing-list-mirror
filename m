From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/3] t5004: test ZIP archives with many entries
Date: Sat, 22 Aug 2015 21:06:12 +0200
Message-ID: <55D8C824.6000704@web.de>
References: <20150811104056.16465.58131@localhost> <55CBA140.7050301@web.de>
 <20150813022545.30116.44787@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Johannes Schauer <josch@debian.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 21:06:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTE7j-0002mT-Pe
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 21:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbbHVTGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 15:06:20 -0400
Received: from mout.web.de ([212.227.15.3]:50337 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250AbbHVTGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 15:06:19 -0400
Received: from [192.168.178.36] ([79.253.186.87]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LkPW7-1YsVn21kzL-00cQYL; Sat, 22 Aug 2015 21:06:15
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150813022545.30116.44787@localhost>
X-Provags-ID: V03:K0:i6bQg2IJ6eGxVXuXR1r1xbyhiHRzvOUKnL7QlGltG47NlMgY8JO
 /rigey+HRNjX4amL0bnqb3qpEK/Z9d2ibapE4JrtIBT0YN4lm7fczV1Fr4pAmrDhDBHFlxt
 oR/UnfpAvyRe08Y8catzvH5U0tGjjdIX0A37q7hlicN0+CwpEHcVSX1b/nsxo+wE7UrSbCO
 i80x01J0iw4YSqhnp3l1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ocbWgCnMQ4c=:zUDXXFMNBOqU9nLEmy6rFL
 mipRcphT4IFQ/OFmwga1FjXCTYXh9R9VdjY3SsVX4ooSu+nNTGrTxKLbZ/0Bboy9x5H1IeXZe
 SVGxCV47Ua1PIdqHmoOwLVkrJqK66uB0wkPJqY9Yk+Fc40ynmCMcRJLOMym368jcI0yj0KJjP
 OHNxTDqOL5piQ+GsfwK/dRdYzzy1P577aUIW7KHwcqK8ROc2AuUwGTHwKazBAhOLsIb7xZped
 /1dNC4BcKlEOGOYIfsZuGhZzcNFpCelah9mzhF0pYvOs9GbcZenyekUbR/ZapUaf2+2chZ4Je
 Xp6rukFHwS+kwwCPJRKkuJslBQKjXvNtWscluow+OuWJKpAgwVlaybupJawj0FKRk535IUJBt
 Fd7t87AH6/tIcWtseM7KcfLy9UazY3yyoQqmWpGtoggWVq19Va/mF7LJ+Fm8q3vRNQU6lxyk7
 PTu2Xqy+UcDmkiEW8BrtQABCCBhP7rKsY34BCsxP/xsRH6eFOxlsATRpGBJwJS4DW4WEm2yjF
 P0i0rIjJtx0Fl1brLBqc447f64a+Oi1CNCibtdtzbABHvrY1zHnj/PBm90qMdC6fDoLm3zYM7
 QiHI2JWEyvUOpretrEJoFUoKAV3hBeUoR0aX1O6HcUHmG36uvBSXLv+sTVIAgzIMMk/dzBEFb
 k9Wiafv+jPZ5f45H5KkAH02YLesIvRmXiMJZUpfeoR/EjkPRuSvAPc+hxvt+YiNNYKDxj3hat
 7i00C8iwrnvXyo4rv83FLahFjoExyRJ8Tv+IPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276393>

A ZIP file directory has a 16-bit field for the number of entries it
contains.  There are 64-bit extensions to deal with that.  Demonstrate
that git archive --format=zip currently doesn't use them and instead
overflows the field.

InfoZIP's unzip doesn't care about this field and extracts all files
anyway.  Software that uses the directory for presenting a filesystem
like view quickly -- notably Windows -- depends on it, but doesn't
lend itself to an automatic test case easily.  Use InfoZIP's zipinfo,
which probably isn't available everywhere but at least can provides
*some* way to check this field.

To speed things up a bit create and commit only a subset of the files
and build a fake tree out of duplicates and pass that to git archive.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t5004-archive-corner-cases.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 654adda..c6bd729 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -115,4 +115,44 @@ test_expect_success 'archive empty subtree by direct pathspec' '
 	check_dir extract sub
 '
 
+ZIPINFO=zipinfo
+
+test_lazy_prereq ZIPINFO '
+	n=$("$ZIPINFO" "$TEST_DIRECTORY"/t5004/empty.zip | sed -n "2s/.* //p")
+	test "x$n" = "x0"
+'
+
+test_expect_failure ZIPINFO 'zip archive with many entries' '
+	# add a directory with 256 files
+	mkdir 00 &&
+	for a in 0 1 2 3 4 5 6 7 8 9 a b c d e f
+	do
+		for b in 0 1 2 3 4 5 6 7 8 9 a b c d e f
+		do
+			: >00/$a$b
+		done
+	done &&
+	git add 00 &&
+	git commit -m "256 files in 1 directory" &&
+
+	# duplicate it to get 65536 files in 256 directories
+	subtree=$(git write-tree --prefix=00/) &&
+	for c in 0 1 2 3 4 5 6 7 8 9 a b c d e f
+	do
+		for d in 0 1 2 3 4 5 6 7 8 9 a b c d e f
+		do
+			echo "040000 tree $subtree	$c$d"
+		done
+	done >tree &&
+	tree=$(git mktree <tree) &&
+
+	# zip them
+	git archive -o many.zip $tree &&
+
+	# check the number of entries in the ZIP file directory
+	expr 65536 + 256 >expect &&
+	"$ZIPINFO" many.zip | head -2 | sed -n "2s/.* //p" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.0
