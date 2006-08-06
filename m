From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Fix "grep -w"
Date: Sun, 06 Aug 2006 01:39:37 -0700
Message-ID: <7vy7u2b6ly.fsf@assigned-by-dhcp.cox.net>
References: <7vwt9ng3t1.fsf@assigned-by-dhcp.cox.net>
	<118833cc0608051219q7e19800alc05870058973c2e@mail.gmail.com>
	<7vlkq2dh6b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 06 10:39:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9eAg-0003ur-MD
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 10:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWHFIjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 04:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWHFIjj
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 04:39:39 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43765 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750744AbWHFIji (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 04:39:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060806083938.SQTP6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Aug 2006 04:39:38 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24968>

We used to find the first match of the pattern and then if the
match is not for the entire word, declared that the whole line
does not match.

But that is wrong.  The command "git grep -w -e mmap" should
find that a line "foo_mmap bar mmap baz" matches, by tring the
second instance of pattern "mmap" on the same line.

Problems an earlier round of "fix" had were pointed out by Morten
Welinder, which have been incorporated in the t7002 tests.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Second try.

 builtin-grep.c  |   35 ++++++++++++++++-------
 t/t7002-grep.sh |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 69b7c48..93b7e07 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -410,8 +410,10 @@ static int fixmatch(const char *pattern,
 static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol, char *eol)
 {
 	int hit = 0;
+	int at_true_bol = 1;
 	regmatch_t pmatch[10];
 
+ again:
 	if (!opt->fixed) {
 		regex_t *exp = &p->regexp;
 		hit = !regexec(exp, bol, ARRAY_SIZE(pmatch),
@@ -422,22 +424,35 @@ static int match_one_pattern(struct grep
 	}
 
 	if (hit && opt->word_regexp) {
-		/* Match beginning must be either
-		 * beginning of the line, or at word
-		 * boundary (i.e. the last char must
-		 * not be alnum or underscore).
-		 */
 		if ((pmatch[0].rm_so < 0) ||
 		    (eol - bol) <= pmatch[0].rm_so ||
 		    (pmatch[0].rm_eo < 0) ||
 		    (eol - bol) < pmatch[0].rm_eo)
 			die("regexp returned nonsense");
-		if (pmatch[0].rm_so != 0 &&
-		    word_char(bol[pmatch[0].rm_so-1]))
-			hit = 0;
-		if (pmatch[0].rm_eo != (eol-bol) &&
-		    word_char(bol[pmatch[0].rm_eo]))
+
+		/* Match beginning must be either beginning of the
+		 * line, or at word boundary (i.e. the last char must
+		 * not be a word char).  Similarly, match end must be
+		 * either end of the line, or at word boundary
+		 * (i.e. the next char must not be a word char).
+		 */
+		if ( ((pmatch[0].rm_so == 0 && at_true_bol) ||
+		      !word_char(bol[pmatch[0].rm_so-1])) &&
+		     ((pmatch[0].rm_eo == (eol-bol)) ||
+		      !word_char(bol[pmatch[0].rm_eo])) )
+			;
+		else
 			hit = 0;
+
+		if (!hit && pmatch[0].rm_so + bol + 1 < eol) {
+			/* There could be more than one match on the
+			 * line, and the first match might not be
+			 * strict word match.  But later ones could be!
+			 */
+			bol = pmatch[0].rm_so + bol + 1;
+			at_true_bol = 0;
+			goto again;
+		}
 	}
 	return hit;
 }
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
new file mode 100755
index 0000000..00a7d76
--- /dev/null
+++ b/t/t7002-grep.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Junio C Hamano
+#
+
+test_description='git grep -w
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	{
+		echo foo mmap bar
+		echo foo_mmap bar
+		echo foo_mmap bar mmap
+		echo foo mmap bar_mmap
+		echo foo_mmap bar mmap baz
+	} >file &&
+	echo x x xx x >x &&
+	echo y yy >y &&
+	echo zzz > z &&
+	git add file x y z &&
+	git commit -m initial
+'
+
+for H in HEAD ''
+do
+	case "$H" in
+	HEAD)	HC='HEAD:' L='HEAD' ;;
+	'')	HC= L='in working tree' ;;
+	esac
+
+	test_expect_success "grep -w $L" '
+		{
+			echo ${HC}file:1:foo mmap bar
+			echo ${HC}file:3:foo_mmap bar mmap
+			echo ${HC}file:4:foo mmap bar_mmap
+			echo ${HC}file:5:foo_mmap bar mmap baz
+		} >expected &&
+		git grep -n -w -e mmap $H >actual &&
+		diff expected actual
+	'
+
+	test_expect_success "grep -w $L (x)" '
+		{
+			echo ${HC}x:1:x x xx x
+		} >expected &&
+		git grep -n -w -e "x xx* x" $H >actual &&
+		diff expected actual
+	'
+
+	test_expect_success "grep -w $L (y-1)" '
+		{
+			echo ${HC}y:1:y yy
+		} >expected &&
+		git grep -n -w -e "^y" $H >actual &&
+		diff expected actual
+	'
+
+	test_expect_success "grep -w $L (y-2)" '
+		: >expected &&
+		if git grep -n -w -e "^y y" $H >actual
+		then
+			echo should not have matched
+			cat actual
+			false
+		else
+			diff expected actual
+		fi
+	'
+
+	test_expect_success "grep -w $L (z)" '
+		: >expected &&
+		if git grep -n -w -e "^z" $H >actual
+		then
+			echo should not have matched
+			cat actual
+			false
+		else
+			diff expected actual
+		fi
+	'
+done
+
+test_done
-- 
1.4.2.rc3.g19a8a
