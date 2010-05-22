From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/8] grep: continue case insensitive fixed string search after
 NUL chars
Date: Sat, 22 May 2010 23:34:06 +0200
Message-ID: <4BF84DCE.1050407@lsrfire.ath.cx>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <4BF84B9E.7060009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 23:34:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFwKv-0003l4-4q
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 23:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758372Ab0EVVeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 17:34:20 -0400
Received: from india601.server4you.de ([85.25.151.105]:47115 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab0EVVeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 17:34:19 -0400
Received: from [10.0.1.100] (p57B7F4C3.dip.t-dialin.net [87.183.244.195])
	by india601.server4you.de (Postfix) with ESMTPSA id 12FD82F8069;
	Sat, 22 May 2010 23:34:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BF84B9E.7060009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147548>

Functions for C strings, like strcasestr(), can't see beyond NUL
characters.  Check if there is such an obstacle on the line and try
again behind it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c                 |   12 +++++++++---
 t/t7008-grep-binary.sh |    4 ++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index c3affb6..b95803b 100644
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
index 9adc9ed..9660842 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -55,4 +55,8 @@ test_expect_success 'git grep -F ile a' '
 	git grep -F ile a
 '
 
+test_expect_success 'git grep -Fi iLE a' '
+	git grep -Fi iLE a
+'
+
 test_done
-- 
1.7.1
