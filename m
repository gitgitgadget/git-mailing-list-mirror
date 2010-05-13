From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/7] grep: add regmatch(), a wrapper for REG_STARTEND handling
Date: Thu, 13 May 2010 22:40:32 +0200
Message-ID: <4BEC63C0.7080207@lsrfire.ath.cx>
References: <4BEC6211.2000309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Phil Lawrence <prlawrence@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 13 22:40:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCfCz-0000BR-Mg
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 22:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757705Ab0EMUkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 16:40:36 -0400
Received: from india601.server4you.de ([85.25.151.105]:53391 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab0EMUkg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 16:40:36 -0400
Received: from [10.0.1.100] (p57B7E766.dip.t-dialin.net [87.183.231.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 9A3722F806A;
	Thu, 13 May 2010 22:40:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BEC6211.2000309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147027>

Refactor REG_STARTEND handling into a new helper, regmatch().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/grep.c b/grep.c
index 31c0e38..5be72cf 100644
--- a/grep.c
+++ b/grep.c
@@ -359,6 +359,17 @@ static int fixmatch(const char *pattern, char *line, char *eol,
 	}
 }
 
+static int regmatch(const regex_t *preg, char *line, char *eol,
+		    regmatch_t *match, int eflags)
+{
+#ifdef REG_STARTEND
+	match->rm_so = 0;
+	match->rm_eo = eol - line;
+	eflags |= REG_STARTEND;
+#endif
+	return regexec(preg, line, 1, match, eflags);
+}
+
 static int strip_timestamp(char *bol, char **eol_p)
 {
 	char *eol = *eol_p;
@@ -738,15 +749,8 @@ static int look_ahead(struct grep_opt *opt,
 		if (p->fixed) {
 			hit = !fixmatch(p->pattern, bol, bol + *left_p,
 					p->ignore_case, &m);
-		} else {
-#ifdef REG_STARTEND
-			m.rm_so = 0;
-			m.rm_eo = *left_p;
-			hit = !regexec(&p->regexp, bol, 1, &m, REG_STARTEND);
-#else
-			hit = !regexec(&p->regexp, bol, 1, &m, 0);
-#endif
-		}
+		} else
+			hit = !regmatch(&p->regexp, bol, bol + *left_p, &m, 0);
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
 			continue;
 		if (earliest < 0 || m.rm_so < earliest)
-- 
1.7.1
