From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v2 2/2] object name: introduce '^{/!-<negative pattern>}' notation
Date: Sat,  6 Jun 2015 01:24:55 +0100
Message-ID: <1433550295-15098-3-git-send-email-wmpalmer@gmail.com>
References: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
Cc: Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 02:26:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z11vw-0000wb-0V
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 02:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbbFFAZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 20:25:51 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34765 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbFFAZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 20:25:48 -0400
Received: by wibut5 with SMTP id ut5so35487225wib.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 17:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qUg1yGBN7uF12K4kbeB0hRanobvNc2Garnw/5oUbmmk=;
        b=IFaWcqNXjqL+6j6tI5pmvbN3Qi/gD+qSY5hJGKyjtp6CxWOk0tutYdBDjywWI6iLbn
         gHhALQsa/4caTYQFUrG/QA3fgWAAqwikRJgfpLJJBU3yDsagxs2/vfjOlfyyBGVNO4tU
         BShmwXJ9y2qTruOa3Pb50Wc0NUaR5OYx84UnLtlsalFIrzA1tvwZqutJJLpjCBspQaKh
         S72hCW+jxlKpgDKdmubPJKMUDI8NqEpgP7WsA/R3gKxGDhGSXvXYRYYmY1W8bVxmpqD8
         B5/njTU95pjgSgdj4/4dVLXK3sG6koD/tBQTIPJAOPU+bktIspa5lr4ajzx8Ln6QvtYJ
         433w==
X-Received: by 10.194.222.137 with SMTP id qm9mr10914836wjc.43.1433550347165;
        Fri, 05 Jun 2015 17:25:47 -0700 (PDT)
Received: from localhost.localdomain (cpc12-folk2-2-0-cust138.1-2.cable.virginm.net. [81.109.109.139])
        by mx.google.com with ESMTPSA id 12sm12755607wjw.17.2015.06.05.17.25.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Jun 2015 17:25:46 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.rc1
In-Reply-To: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270897>

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
---
 Documentation/revisions.txt | 11 ++++++-----
 sha1_name.c                 | 20 +++++++++++++++-----
 t/t1511-rev-parse-caret.sh  | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 11 deletions(-)

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
index e57513e..82de2db 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -838,8 +838,12 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
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
@@ -868,12 +872,18 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
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
@@ -893,7 +903,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
-		matches = p && !regexec(&regex, p + 2, 0, NULL, 0);
+		matches = p && (negative ^ !regexec(&regex, p + 2, 0, NULL, 0));
 		unuse_commit_buffer(commit, buf);
 
 		if (matches) {
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e0fe102..8a5983f 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -19,13 +19,17 @@ test_expect_success 'setup' '
 	echo modified >>a-blob &&
 	git add -u &&
 	git commit -m Modified &&
+	git branch modref &&
 	echo changed! >>a-blob &&
 	git add -u &&
 	git commit -m !Exp &&
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
@@ -98,4 +102,30 @@ test_expect_success 'ref^{/!!Exp}' '
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
2.3.0.rc1
