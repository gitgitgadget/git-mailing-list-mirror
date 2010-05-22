From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/8] grep: use memmem() for fixed string search
Date: Sat, 22 May 2010 23:32:43 +0200
Message-ID: <4BF84D7B.8000100@lsrfire.ath.cx>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <4BF84B9E.7060009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 23:33:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFwJZ-0003DK-Ps
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 23:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758956Ab0EVVc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 17:32:57 -0400
Received: from india601.server4you.de ([85.25.151.105]:47114 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758718Ab0EVVc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 17:32:56 -0400
Received: from [10.0.1.100] (p57B7F4C3.dip.t-dialin.net [87.183.244.195])
	by india601.server4you.de (Postfix) with ESMTPSA id 8AE372F8069;
	Sat, 22 May 2010 23:32:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BF84B9E.7060009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147547>

Allow searching beyond NUL characters by using memmem() instead of
strstr().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c                 |   16 +++++++++-------
 t/t7008-grep-binary.sh |    4 ++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/grep.c b/grep.c
index 22639cd..c3affb6 100644
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
index 4a12d97..9adc9ed 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -51,4 +51,8 @@ test_expect_success 'git grep -q ina a' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git grep -F ile a' '
+	git grep -F ile a
+'
+
 test_done
-- 
1.7.1
