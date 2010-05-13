From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/7] grep: use memmem() for fixed string search
Date: Thu, 13 May 2010 22:38:16 +0200
Message-ID: <4BEC6338.9080300@lsrfire.ath.cx>
References: <4BEC6211.2000309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Phil Lawrence <prlawrence@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 13 22:38:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCfB1-0007bc-RU
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 22:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759507Ab0EMUiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 16:38:22 -0400
Received: from india601.server4you.de ([85.25.151.105]:53377 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759505Ab0EMUiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 16:38:19 -0400
Received: from [10.0.1.100] (p57B7E766.dip.t-dialin.net [87.183.231.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 1A2A12F806A;
	Thu, 13 May 2010 22:38:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BEC6211.2000309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147025>

Allow searching beyond NUL characters by using memmem() instead of
strstr().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c                 |   16 +++++++++-------
 t/t7008-grep-binary.sh |    4 ++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/grep.c b/grep.c
index 4b6c02e..4633b63 100644
--- a/grep.c
+++ b/grep.c
@@ -329,14 +329,15 @@ static void show_name(struct grep_opt *opt, const char *name)
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
-
-static int fixmatch(const char *pattern, char *line, int ignore_case, regmatch_t *match)
+static int fixmatch(const char *pattern, char *line, char *eol,
+		    int ignore_case, regmatch_t *match)
 {
 	char *hit;
+
 	if (ignore_case)
 		hit = strcasestr(line, pattern);
 	else
-		hit = strstr(line, pattern);
+		hit = memmem(line, eol - line, pattern, strlen(pattern));
 
 	if (!hit) {
 		match->rm_so = match->rm_eo = -1;
@@ -399,7 +400,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 
  again:
 	if (p->fixed)
-		hit = !fixmatch(p->pattern, bol, p->ignore_case, pmatch);
+		hit = !fixmatch(p->pattern, bol, eol, p->ignore_case, pmatch);
 	else
 		hit = !regexec(&p->regexp, bol, 1, pmatch, eflags);
 
@@ -725,9 +726,10 @@ static int look_ahead(struct grep_opt *opt,
 		int hit;
 		regmatch_t m;
 
-		if (p->fixed)
-			hit = !fixmatch(p->pattern, bol, p->ignore_case, &m);
-		else {
+		if (p->fixed) {
+			hit = !fixmatch(p->pattern, bol, bol + *left_p,
+					p->ignore_case, &m);
+		} else {
 #ifdef REG_STARTEND
 			m.rm_so = 0;
 			m.rm_eo = *left_p;
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 5449dd9..ad97720 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -33,4 +33,8 @@ test_expect_success 'git grep -c ina a' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git grep -F ile a' '
+	git grep -F ile a
+'
+
 test_done
-- 
1.7.1
