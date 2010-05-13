From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 7/7] grep: use regmatch() for line matching
Date: Thu, 13 May 2010 22:41:15 +0200
Message-ID: <4BEC63EB.2060307@lsrfire.ath.cx>
References: <4BEC6211.2000309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Phil Lawrence <prlawrence@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 13 22:41:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCfDh-0000ji-O3
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 22:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758820Ab0EMUlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 16:41:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:60514 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758671Ab0EMUlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 16:41:18 -0400
Received: from [10.0.1.100] (p57B7E766.dip.t-dialin.net [87.183.231.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 3EA802F806A;
	Thu, 13 May 2010 22:41:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BEC6211.2000309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147028>

Use regmatch() in match_one_pattern(), allowing regex matching
beyond NUL characters if regexec() supports the flag REG_STARTEND.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c                 |    2 +-
 t/t7008-grep-binary.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index 5be72cf..9dd2471 100644
--- a/grep.c
+++ b/grep.c
@@ -422,7 +422,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	if (p->fixed)
 		hit = !fixmatch(p->pattern, bol, eol, p->ignore_case, pmatch);
 	else
-		hit = !regexec(&p->regexp, bol, 1, pmatch, eflags);
+		hit = !regmatch(&p->regexp, bol, eol, pmatch, eflags);
 
 	if (hit && p->word_regexp) {
 		if ((pmatch[0].rm_so < 0) ||
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 1143903..d8fde18 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -41,4 +41,14 @@ test_expect_success 'git grep -Fi iLE a' '
 	git grep -Fi iLE a
 '
 
+# This test actually passes on platforms where regexec() supports the
+# flag REG_STARTEND.
+test_expect_failure 'git grep ile a' '
+	git grep ile a
+'
+
+test_expect_failure 'git grep .fi a' '
+	git grep .fi a
+'
+
 test_done
-- 
1.7.1
