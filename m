From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] grep: read patterns from stdin with -f -
Date: Sat, 19 Mar 2011 19:33:15 +0100
Message-ID: <4D84F6EB.5000009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 19:33:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q10y9-0001c0-Cc
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 19:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757225Ab1CSSda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 14:33:30 -0400
Received: from india601.server4you.de ([85.25.151.105]:46541 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab1CSSd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 14:33:29 -0400
Received: from [192.168.2.103] (p4FFDB4FC.dip.t-dialin.net [79.253.180.252])
	by india601.server4you.de (Postfix) with ESMTPSA id 87BDD2F8067;
	Sat, 19 Mar 2011 19:33:25 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169455>

Support the well-know convention of reading standard input instead of a
named file if "-" (dash) is specified.  GNU grep does the same.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
I was trying to look for the string "/pack", but MinGW mangles arguments
that look like paths.  "echo /pack | git grep -f-" was my first try to
circumvent this, as echo's arguments are not mangled.  I ended up with
"git grep '[/]pack'" -- and also this patch.

 builtin/grep.c  |    6 ++++--
 t/t7810-grep.sh |    5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index eaf8560..0bf8c01 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -659,11 +659,12 @@ static int context_callback(const struct option *opt, const char *arg,
 static int file_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
+	int from_stdin = !strcmp(arg, "-");
 	FILE *patterns;
 	int lno = 0;
 	struct strbuf sb = STRBUF_INIT;
 
-	patterns = fopen(arg, "r");
+	patterns = from_stdin ? stdin : fopen(arg, "r");
 	if (!patterns)
 		die_errno("cannot open '%s'", arg);
 	while (strbuf_getline(&sb, patterns, '\n') == 0) {
@@ -677,7 +678,8 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 		s = strbuf_detach(&sb, &len);
 		append_grep_pat(grep_opt, s, len, arg, ++lno, GREP_PATTERN);
 	}
-	fclose(patterns);
+	if (!from_stdin)
+		fclose(patterns);
 	strbuf_release(&sb);
 	return 0;
 }
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8a7788d..dbc6cd8 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -303,6 +303,11 @@ test_expect_success 'grep -f, ignore empty lines' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep -f, ignore empty lines, read patterns from stdin' '
+	git grep -f - <patterns >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 y:y yy
 --
-- 
1.7.4
