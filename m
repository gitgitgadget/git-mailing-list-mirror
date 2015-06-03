From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH 2/2] object name: introduce '^{/!<negative pattern>}' notation
Date: Wed,  3 Jun 2015 21:54:14 +0100
Message-ID: <1433364854-30088-3-git-send-email-wmpalmer@gmail.com>
References: <1433364854-30088-1-git-send-email-wmpalmer@gmail.com>
Cc: Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 22:55:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0FgR-0003kX-At
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 22:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbbFCUyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 16:54:40 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34178 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbbFCUyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 16:54:37 -0400
Received: by wibut5 with SMTP id ut5so887811wib.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=imPg1KEf9gwe6zC8BJHIm7IlYsjAZtB8QdSdfiDvQSo=;
        b=b9mcWzgWPT60yXM+p/F8ThZSr32Mt0hdBNMFAM+DvVE1z8hym8BH9uGAE2zv7k9634
         UckQWbSCv8S2GNpWycvIk+cIlv/kfwfp49CuFYVaSZIe4c8ndU9kRCjaamDwkwNqjl/H
         4iZBGNkIspQsxi53LmwhqvzDgAe8e1bwhMIwG5+oqoXEmc7Om8jErddIi1+FaVkGf6vq
         Xf6N7cFn7iTwv2/90qnX0oJt5RFZE0QDKBU1qZ9/2pDDclgJMG4XO3tvuDtBNX6gAPCR
         4MhX8HNdRw5fSdSSG/ORQ3j7FVOTI/h2rA/W6lXc2oFuaxdug+g4rVtZsKza0m2QfSOO
         KR8w==
X-Received: by 10.180.81.3 with SMTP id v3mr1066247wix.36.1433364876619;
        Wed, 03 Jun 2015 13:54:36 -0700 (PDT)
Received: from localhost.localdomain (cpc12-folk2-2-0-cust138.1-2.cable.virginm.net. [81.109.109.139])
        by mx.google.com with ESMTPSA id h7sm1888220wig.13.2015.06.03.13.54.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jun 2015 13:54:35 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.rc1
In-Reply-To: <1433364854-30088-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270737>

To name a commit, you can now say

    $ git rev-parse HEAD^{/!foo}

and it will return the hash of the first commit reachable from HEAD,
whose commit message does not contain "foo".

Since the ability to reference a commit by "name" was introduced (way
back in 1.5, in 364d3e6), with the across-all-refs syntax of ':/foo',
there has been a note in the documentation indicating that a leading
exclamation mark was "reserved for now" (unless followed immediately be
another exclamation mark.)

At the time, this was sensible: we didn't get the '^{/foo}' flavour
until sometime around 1.7.4 (41cd797) , so while a "negative search" was
a foreseeable feature, it wouldn't have made much sense to apply one
across all refs, as the result would have been essentially random.

These days, a negative pattern can make sense. In particular, if you tend
to use a rebase-heavy workflow with many "work in progress" commits, it
may be useful to diff or rebase against the latest "not work-in-progress"
commit. That sort of thing now possible, via commands such as:

    $ git rebase -i @^{/!^WIP}

Perhaps notably, the "special case" for the empty pattern has been
extended to handle the empty negative pattern - which never matches, to
continue to ensure that an empty pattern never reaches the real regexp
code, as per notes in 4322842 "get_sha1: handle special case $commit^{/}"

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/revisions.txt |  7 ++++---
 sha1_name.c                 | 22 ++++++++++++++++------
 t/t1511-rev-parse-caret.sh  | 32 +++++++++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 0796118..6a6b8b9 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -151,9 +151,10 @@ existing tag object.
   A colon, followed by a slash, followed by a text, names
   a commit whose commit message matches the specified regular expression.
   This name returns the youngest matching commit which is
-  reachable from any ref.  If the commit message starts with a
-  '!' you have to repeat that;  the special sequence ':/!',
-  followed by something else than '!', is reserved for now.
+  reachable from any ref.  To name a commit whose commit message does not
+  match the specified regular expression, begin the pattern-part with a
+  '!', e.g. ':/!foo'. If the commit message you wish to match starts with
+  a '!' you have to repeat that.
   The regular expression can match any part of the commit message. To
   match messages starting with a string, one can use e.g. ':/^foo'.
 
diff --git a/sha1_name.c b/sha1_name.c
index 46218ba..3d50dc9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -737,11 +737,15 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 
 		/*
 		 * $commit^{/}. Some regex implementation may reject.
-		 * We don't need regex anyway. '' pattern always matches.
+		 * We don't need regex anyway. '' pattern always matches,
+		 * and '!' pattern never matches.
 		 */
 		if (sp[1] == '}')
 			return 0;
 
+		if (sp[1] == '!' && sp[2] == '}')
+			return -1;
+
 		prefix = xstrndup(sp + 1, name + len - 1 - (sp + 1));
 		commit_list_insert((struct commit *)o, &list);
 		ret = get_sha1_oneline(prefix, sha1, list);
@@ -825,8 +829,9 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
  * through history and returning the first commit whose message starts
  * the given regular expression.
  *
- * For future extension, ':/!' is reserved. If you want to match a message
- * beginning with a '!', you have to repeat the exclamation mark.
+ * For negative-matching, prefix the pattern-part with a '!', like:
+ * ':/!WIP'. If you want to match a message beginning with a literal
+ * '!', you heave to repeat the exlamation mark.
  */
 
 /* Remember to update object flag allocation in object.h */
@@ -855,11 +860,16 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 {
 	struct commit_list *backup = NULL, *l;
 	int found = 0;
+	int negative = 0;
 	regex_t regex;
 
 	if (prefix[0] == '!') {
-		if (prefix[1] != '!')
-			die ("Invalid search pattern: %s", prefix);
+		if (prefix[1] != '!') {
+			negative = 1;
+		} else if (prefix[1] == '!' && prefix[2] == '!') {
+			negative = 1;
+			prefix++;
+		}
 		prefix++;
 	}
 
@@ -880,7 +890,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
-		matches = p && !regexec(&regex, p + 2, 0, NULL, 0);
+		matches = p && (negative ^ !regexec(&regex, p + 2, 0, NULL, 0));
 		unuse_commit_buffer(commit, buf);
 
 		if (matches) {
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index 0c46e5c..1d27aca 100755
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
@@ -84,8 +88,8 @@ test_expect_success 'ref^{/Initial}' '
 	test_cmp expected actual
 '
 
-test_expect_success 'ref^{/!Exp}' '
-	test_must_fail git rev-parse master^{/!Exp}
+test_expect_success 'ref^{/!}' '
+	test_must_fail git rev-parse master^{/!}
 '
 
 test_expect_success 'ref^{/!!Exp}' '
@@ -94,4 +98,26 @@ test_expect_success 'ref^{/!!Exp}' '
 	test_cmp expected actual
 '
 
+test_expect_success 'ref^{/!.}' '
+	test_must_fail git rev-parse master^{/\!.}
+'
+
+test_expect_success 'ref^{/!non-existent}' '
+	git rev-parse master >expected &&
+	git rev-parse master^{/\!non-existent} >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref^{/!Changed}' '
+	git rev-parse expref >expected &&
+	git rev-parse master^{/!Changed} >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref^{/!!!Exp}' '
+	git rev-parse modref >expected &&
+	git rev-parse expref^{/!!!Exp} >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.3.0.rc1
