From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] Fix "grep -w"
Date: Fri, 04 Aug 2006 22:16:42 -0700
Message-ID: <7vwt9ng3t1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 05 07:16:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9EWp-0005AZ-Sy
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 07:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbWHEFQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 01:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWHEFQo
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 01:16:44 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:58571 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932522AbWHEFQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 01:16:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805051643.GYJM6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 01:16:43 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24882>

We used to find the first match of the pattern and then if the
match is not for the entire word, declared that the whole line
does not match.

But that is wrong.  The command "git grep -w -e mmap" should
find that a line "foo_mmap bar mmap baz" matches, by tring the
second instance of pattern "mmap" on the same line.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 builtin-grep.c  |   10 ++++++++++
 t/t7002-grep.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 69b7c48..b5feda4 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -412,6 +412,7 @@ static int match_one_pattern(struct grep
 	int hit = 0;
 	regmatch_t pmatch[10];
 
+ again:
 	if (!opt->fixed) {
 		regex_t *exp = &p->regexp;
 		hit = !regexec(exp, bol, ARRAY_SIZE(pmatch),
@@ -438,6 +439,15 @@ static int match_one_pattern(struct grep
 		if (pmatch[0].rm_eo != (eol-bol) &&
 		    word_char(bol[pmatch[0].rm_eo]))
 			hit = 0;
+
+		if (!hit && pmatch[0].rm_eo + bol < eol) {
+			/* there could be more than one match on the
+			 * line, and the first match might not be
+			 * strict word match.  But later ones could be!
+			 */
+			bol += pmatch[0].rm_eo;
+			goto again;
+		}
 	}
 	return hit;
 }
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
new file mode 100755
index 0000000..0a0e302
--- /dev/null
+++ b/t/t7002-grep.sh
@@ -0,0 +1,45 @@
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
+	git add file &&
+	git commit -m initial
+'
+
+test_expect_success 'grep -w HEAD' '
+	git grep -n -w -e mmap HEAD >actual &&
+	{
+		echo HEAD:file:1:foo mmap bar
+		echo HEAD:file:3:foo_mmap bar mmap
+		echo HEAD:file:4:foo mmap bar_mmap
+		echo HEAD:file:5:foo_mmap bar mmap baz
+	} >expected &&
+	diff expected actual
+'
+
+test_expect_success 'grep -w in working tree' '
+	git grep -n -w -e mmap >actual &&
+	{
+		echo file:1:foo mmap bar
+		echo file:3:foo_mmap bar mmap
+		echo file:4:foo mmap bar_mmap
+		echo file:5:foo_mmap bar mmap baz
+	} >expected &&
+	diff expected actual
+'
+
+test_done
