From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/7] grep: continue case insensitive fixed string search after
 NUL chars
Date: Thu, 13 May 2010 22:39:33 +0200
Message-ID: <4BEC6385.8000106@lsrfire.ath.cx>
References: <4BEC6211.2000309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Phil Lawrence <prlawrence@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 13 22:39:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCfC2-00088k-Gd
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 22:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297Ab0EMUjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 16:39:37 -0400
Received: from india601.server4you.de ([85.25.151.105]:53381 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab0EMUjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 16:39:36 -0400
Received: from [10.0.1.100] (p57B7E766.dip.t-dialin.net [87.183.231.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 32FBE2F806A;
	Thu, 13 May 2010 22:39:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BEC6211.2000309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147026>

Functions for C strings, like strcasestr(), can't see beyond NUL
characters.  Check if there is such an obstacle on the line and try
again behind it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c                 |   12 +++++++++---
 t/t7008-grep-binary.sh |    4 ++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 4633b63..20a02a2 100644
--- a/grep.c
+++ b/grep.c
@@ -334,9 +334,15 @@ static int fixmatch(const char *pattern, char *line, char *eol,
 {
 	char *hit;
 
-	if (ignore_case)
-		hit = strcasestr(line, pattern);
-	else
+	if (ignore_case) {
+		char *s = line;
+		do {
+			hit = strcasestr(s, pattern);
+			if (hit)
+				break;
+			s += strlen(s) + 1;
+		} while (s < eol);
+	} else
 		hit = memmem(line, eol - line, pattern, strlen(pattern));
 
 	if (!hit) {
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index ad97720..1143903 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -37,4 +37,8 @@ test_expect_success 'git grep -F ile a' '
 	git grep -F ile a
 '
 
+test_expect_success 'git grep -Fi iLE a' '
+	git grep -Fi iLE a
+'
+
 test_done
-- 
1.7.1
