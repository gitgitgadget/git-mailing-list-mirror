From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] blame: fix indent of line numbers
Date: Sat, 13 Mar 2010 11:25:12 +0100
Message-ID: <4B9B6808.9070302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 11:25:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqOXI-0005Ym-8L
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 11:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934953Ab0CMKZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 05:25:30 -0500
Received: from india601.server4you.de ([85.25.151.105]:40921 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933489Ab0CMKZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 05:25:29 -0500
Received: from [10.0.1.100] (p57B7E76C.dip.t-dialin.net [87.183.231.108])
	by india601.server4you.de (Postfix) with ESMTPSA id 802AC2F8045;
	Sat, 13 Mar 2010 11:25:27 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142097>

Correct the calculation of the number of digits for line counts of the
form 10^n-1 (9, 99, ...) in lineno_width().  This makes blame stop
printing an extra space before the line numbers of files with that many
total lines.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/blame.c  |    2 +-
 t/t8003-blame.sh |   20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 10f7eac..fc15863 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1772,7 +1772,7 @@ static int lineno_width(int lines)
 {
 	int i, width;
 
-	for (width = 1, i = 10; i <= lines + 1; width++)
+	for (width = 1, i = 10; i <= lines; width++)
 		i *= 10;
 	return width;
 }
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index 3bbddd0..230143c 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -11,7 +11,15 @@ test_expect_success setup '
 	echo B B B B B >two &&
 	echo C C C C C >tres &&
 	echo ABC >mouse &&
-	git add one two tres mouse &&
+	for i in 1 2 3 4 5 6 7 8 9
+	do
+		echo $i
+	done >nine_lines &&
+	for i in 1 2 3 4 5 6 7 8 9 a
+	do
+		echo $i
+	done >ten_lines &&
+	git add one two tres mouse nine_lines ten_lines &&
 	test_tick &&
 	GIT_AUTHOR_NAME=Initial git commit -m Initial &&
 
@@ -167,4 +175,14 @@ test_expect_success 'blame -L with invalid end' '
 	grep "has only 2 lines" errors
 '
 
+test_expect_success 'indent of line numbers, nine lines' '
+	git blame nine_lines >actual &&
+	test $(grep -c "  " actual) = 0
+'
+
+test_expect_success 'indent of line numbers, ten lines' '
+	git blame ten_lines >actual &&
+	test $(grep -c "  " actual) = 9
+'
+
 test_done
-- 
1.7.0.2
