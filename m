From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 7/8] grep: use REG_STARTEND for all matching if available
Date: Sat, 22 May 2010 23:35:07 +0200
Message-ID: <4BF84E0B.5080902@lsrfire.ath.cx>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <4BF84B9E.7060009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 23:35:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFwLt-000491-P5
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 23:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758781Ab0EVVfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 17:35:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:47117 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758725Ab0EVVfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 17:35:20 -0400
Received: from [10.0.1.100] (p57B7F4C3.dip.t-dialin.net [87.183.244.195])
	by india601.server4you.de (Postfix) with ESMTPSA id 2A1C72F8069;
	Sat, 22 May 2010 23:35:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BF84B9E.7060009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147549>

Refactor REG_STARTEND handling inlook_ahead() into a new helper,
regmatch(), and use it for line matching, too.  This allows regex
matching beyond NUL characters if regexec() supports the flag.  NUL
characters themselves are not matched in any way, though.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c                 |   24 ++++++++++++++----------
 t/t7008-grep-binary.sh |   10 ++++++++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/grep.c b/grep.c
index b95803b..70a776f 100644
--- a/grep.c
+++ b/grep.c
@@ -356,6 +356,17 @@ static int fixmatch(const char *pattern, char *line, char *eol,
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
@@ -408,7 +419,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	if (p->fixed)
 		hit = !fixmatch(p->pattern, bol, eol, p->ignore_case, pmatch);
 	else
-		hit = !regexec(&p->regexp, bol, 1, pmatch, eflags);
+		hit = !regmatch(&p->regexp, bol, eol, pmatch, eflags);
 
 	if (hit && p->word_regexp) {
 		if ((pmatch[0].rm_so < 0) ||
@@ -735,15 +746,8 @@ static int look_ahead(struct grep_opt *opt,
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
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 9660842..4f5e74f 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -59,4 +59,14 @@ test_expect_success 'git grep -Fi iLE a' '
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
