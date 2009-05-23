From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] grep: fix word-regexp at the beginning of lines
Date: Sat, 23 May 2009 13:45:26 +0200
Message-ID: <4A17E1D6.10401@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 13:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7pfd-0007cT-4m
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 13:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZEWLph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 07:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbZEWLpg
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 07:45:36 -0400
Received: from india601.server4you.de ([85.25.151.105]:54362 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbZEWLpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 07:45:35 -0400
Received: from [10.0.1.101] (p57B7DDA6.dip.t-dialin.net [87.183.221.166])
	by india601.server4you.de (Postfix) with ESMTPSA id D55942F805B;
	Sat, 23 May 2009 13:45:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119775>

After bol is forwarded, it doesn't represent the beginning of the line
any more.  This means that the beginning-of-line marker (^) mustn't match,
i.e. the regex flag REG_NOTBOL needs to be set.

This bug was introduced by fb62eb7fab97cea880ea7fe4f341a4dfad14ab48
("grep -w: forward to next possible position after rejected match").

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Embarrassing.

 grep.c          |    1 +
 t/t7002-grep.sh |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index a649f06..cc6d5b0 100644
--- a/grep.c
+++ b/grep.c
@@ -360,6 +360,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 			bol = pmatch[0].rm_so + bol + 1;
 			while (word_char(bol[-1]) && bol < eol)
 				bol++;
+			eflags |= REG_NOTBOL;
 			if (bol < eol)
 				goto again;
 		}
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index b815937..f275af8 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -16,12 +16,13 @@ test_expect_success setup '
 		echo foo mmap bar_mmap
 		echo foo_mmap bar mmap baz
 	} >file &&
+	echo ww w >w &&
 	echo x x xx x >x &&
 	echo y yy >y &&
 	echo zzz > z &&
 	mkdir t &&
 	echo test >t/t &&
-	git add file x y z t/t &&
+	git add file w x y z t/t &&
 	test_tick &&
 	git commit -m initial
 '
@@ -48,6 +49,12 @@ do
 		diff expected actual
 	'
 
+	test_expect_success "grep -w $L (w)" '
+		: >expected &&
+		! git grep -n -w -e "^w" >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep -w $L (x)" '
 		{
 			echo ${HC}x:1:x x xx x
-- 
1.6.3.1
