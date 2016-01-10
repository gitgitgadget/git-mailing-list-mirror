From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V3 2/2] object name: introduce '^{/!-<negative pattern>}' notation
Date: Sat,  9 Jan 2016 19:23:03 -0700
Message-ID: <1452392583-2708-1-git-send-email-ischis2@cox.net>
References: <1452392429-2578-1-git-send-email-ischis2@cox.net>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Will Palmer <wmpalmer@gmail.com>,
	"Stephen P . Smith" <ischis2@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 03:22:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aI5eA-00015I-PJ
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 03:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718AbcAJCWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 21:22:19 -0500
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:52870 "EHLO
	fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634AbcAJCWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 21:22:18 -0500
Received: from fed1rmimpo209 ([68.230.241.160]) by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160110022217.BTJK22785.fed1rmfepo202.cox.net@fed1rmimpo209>
          for <git@vger.kernel.org>; Sat, 9 Jan 2016 21:22:17 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo209 with cox
	id 42NH1s0022tqoqC012NHef; Sat, 09 Jan 2016 21:22:17 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020205.5691C059.0068,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=RNFt6fe+ c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=7aQ_Q-yQQ-AA:10
 a=pGLkceISAAAA:8 a=TSbVqHtbAAAA:8 a=VMeQZgButWaJwkk0FOQA:9
 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 2131C13F7BB;
	Sat,  9 Jan 2016 19:23:05 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <1452392429-2578-1-git-send-email-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283611>

From: Will Palmer <wmpalmer@gmail.com>

To name a commit, you can now say

    $ git rev-parse HEAD^{/!-foo}

and it will return the hash of the first commit reachable from HEAD,
whose commit message does not contain "foo". This is the opposite of the
existing <rev>^{/<pattern>} syntax.

The specific use-case this is intended for is to perform an operation,
excluding the most-recent commits containing a particular marker. For
example, if you tend to make "work in progress" commits, with messages
beginning with "WIP", you work, then it could be useful to diff against
"the most recent commit which was not a WIP commit". That sort of thing
now possible, via commands such as:

    $ git diff @^{/!-^WIP}

The leader '/!-', rather than simply '/!', to denote a negative match,
is chosen to leave room for additional modifiers in the future.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

Notes:
    Moved modref branch from 2/2 to the 1/2 patch as discussed in [1] and
    [2].
    
    [1] http://article.gmane.org/gmane.comp.version-control.git/271071
    [2] http://article.gmane.org/gmane.comp.version-control.git/283573

 Documentation/revisions.txt | 11 ++++++-----
 sha1_name.c                 | 20 +++++++++++++++-----
 t/t1511-rev-parse-caret.sh  | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d85e303..0c84d4f 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -176,11 +176,12 @@ existing tag object.
   A colon, followed by a slash, followed by a text, names
   a commit whose commit message matches the specified regular expression.
   This name returns the youngest matching commit which is
-  reachable from any ref.  If the commit message starts with a
-  '!' you have to repeat that;  the special sequence ':/!',
-  followed by something else than '!', is reserved for now.
-  The regular expression can match any part of the commit message. To
-  match messages starting with a string, one can use e.g. ':/^foo'.
+  reachable from any ref. The regular expression can match any part of the
+  commit message. To match messages starting with a string, one can use
+  e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
+  is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
+  literal '!' character, followed by 'foo'. Any other sequence beginning with
+  ':/!' is reserved for now.
 
 '<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
   A suffix ':' followed by a path names the blob or tree
diff --git a/sha1_name.c b/sha1_name.c
index 892db21..a2c5303 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -848,8 +848,12 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
  * through history and returning the first commit whose message starts
  * the given regular expression.
  *
- * For future extension, ':/!' is reserved. If you want to match a message
- * beginning with a '!', you have to repeat the exclamation mark.
+ * For negative-matching, prefix the pattern-part with '!-', like: ':/!-WIP'.
+ *
+ * For a literal '!' character at the beginning of a pattern, you have to repeat
+ * that, like: ':/!!foo'
+ *
+ * For future extension, all other sequences beginning with ':/!' are reserved.
  */
 
 /* Remember to update object flag allocation in object.h */
@@ -878,12 +882,18 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 {
 	struct commit_list *backup = NULL, *l;
 	int found = 0;
+	int negative = 0;
 	regex_t regex;
 
 	if (prefix[0] == '!') {
-		if (prefix[1] != '!')
-			die ("Invalid search pattern: %s", prefix);
 		prefix++;
+
+		if (prefix[0] == '-') {
+			prefix++;
+			negative = 1;
+		} else if (prefix[0] != '!') {
+			die ("Invalid search pattern: %s", prefix);
+		}
 	}
 
 	if (regcomp(&regex, prefix, REG_EXTENDED))
@@ -903,7 +913,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
-		matches = p && !regexec(&regex, p + 2, 0, NULL, 0);
+		matches = p && (negative ^ !regexec(&regex, p + 2, 0, NULL, 0));
 		unuse_commit_buffer(commit, buf);
 
 		if (matches) {
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index b2f90be..8a5983f 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -26,7 +26,10 @@ test_expect_success 'setup' '
 	git branch expref &&
 	echo changed >>a-blob &&
 	git add -u &&
-	git commit -m Changed
+	git commit -m Changed &&
+	echo changed-again >>a-blob &&
+	git add -u &&
+	git commit -m Changed-again
 '
 
 test_expect_success 'ref^{non-existent}' '
@@ -99,4 +102,30 @@ test_expect_success 'ref^{/!!Exp}' '
 	test_cmp expected actual
 '
 
+test_expect_success 'ref^{/!-}' '
+	test_must_fail git rev-parse master^{/!-}
+'
+
+test_expect_success 'ref^{/!-.}' '
+	test_must_fail git rev-parse master^{/!-.}
+'
+
+test_expect_success 'ref^{/!-non-existent}' '
+	git rev-parse master >expected &&
+	git rev-parse master^{/!-non-existent} >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref^{/!-Changed}' '
+	git rev-parse expref >expected &&
+	git rev-parse master^{/!-Changed} >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref^{/!-!Exp}' '
+	git rev-parse modref >expected &&
+	git rev-parse expref^{/!-!Exp} >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.7.0-rc2
