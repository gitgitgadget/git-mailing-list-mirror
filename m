From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 9/9] refs.c: make @ a pseudo-ref alias to HEAD
Date: Thu,  2 May 2013 19:09:34 +0530
Message-ID: <1367501974-6879-10-git-send-email-artagnon@gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtio-0002b0-1u
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759649Ab3EBNid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:38:33 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:60144 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759290Ab3EBNiY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:38:24 -0400
Received: by mail-da0-f48.google.com with SMTP id h32so318247dak.35
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0ZZM+zmTFB3EB4+QyykPBmhSGr5kWqMvaGbvGbQhshU=;
        b=JlbFgREmI4usu1sRPammhDVmnKpw7w2RPv4nmLK70tgg7rPNmN9/ulLmS1O8dD5Uhx
         Dg5HI/jHwIlQEoa4WlX93THmg+bod6icQlySyAFvLop3elZ0BaBlqbYGPRucv59hxbRi
         91LPCSmSCxgCTvjmhLMNqbFXaJdfbZTHSgqZ1oDEb23F02t9X3GQIulp4D9SnGLasZSF
         6DWvx3qs48/QYM5jrYx4ILRgv7ST67eLOm1dgQPKqfhy34Ve8dUuymQt2/H5SeSnVuHW
         K+nzoNArM/y6CM9EPeV++sOBodOU82z7vq9kSpM3r9UhuGXLkyMnNU8kQs9rGN56/nNV
         9sJw==
X-Received: by 10.68.1.138 with SMTP id 10mr9118076pbm.136.1367501904125;
        Thu, 02 May 2013 06:38:24 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm7392889pbc.22.2013.05.02.06.38.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:38:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.40.g09a0447
In-Reply-To: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223204>

First, make sure that check_refname_format() rejects the a refname
beginning with a '@'.  Add a test to t1400 (update-ref) demonstrating
that update-ref forbids the user from updating a ref named "@".

Now, resolve_ref_unsafe() is built to resolve any refs that have a
corresponding file inside $GITDIR.  Our "@" ref is a special
pseudo-ref and does not have a filesystem counterpart.  So,
hard-interpret "@" as "HEAD" and resolve .git/HEAD as usual.  This
means that we can drop the 'git symbolic-ref @ HEAD' line in t1508
(at-combinations), and everything will continue working as usual.

If the user does manage to create a '.git/@' unsafely (via
symbolic-ref or otherwise), it will be ignored.

In practice, this means that you will now be able to do:

    $ git show @~1
    $ git log @^2

Advertise these features in the tests and documentation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-check-ref-format.txt |  2 ++
 Documentation/revisions.txt            |  8 ++++++--
 refs.c                                 | 12 ++++++++++--
 t/t1400-update-ref.sh                  |  3 +++
 t/t1508-at-combinations.sh             |  4 +---
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index ec1739a..3de9adc 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -52,6 +52,8 @@ Git imposes the following rules on how references are named:
 
 . They cannot end with a dot `.`.
 
+. They cannot be the single character `@`.
+
 . They cannot contain a sequence `@{`.
 
 . They cannot contain a `\`.
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d477b3f..02bfc90 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -27,6 +27,10 @@ blobs contained in a commit.
   When ambiguous, a '<refname>' is disambiguated by taking the
   first match in the following rules:
 
+  . '@' is a synonym for 'HEAD'.  An '@' followed by '\{' has no
+    relationship to this and means something entirely different (see
+    below).
+
   . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
     useful only for 'HEAD', 'FETCH_HEAD', 'ORIG_HEAD', 'MERGE_HEAD'
     and 'CHERRY_PICK_HEAD');
@@ -93,7 +97,7 @@ some output processing may assume ref names in UTF-8.
   refers to the branch that the branch specified by branchname is set to build on
   top of.  A missing branchname defaults to the current one.
 
-'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
+'<rev>{caret}', e.g. '@{caret}2', 'HEAD{caret}', 'v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   '<rev>{caret}'
@@ -101,7 +105,7 @@ some output processing may assume ref names in UTF-8.
   '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
   object name of a tag object that refers to a commit object.
 
-'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
+'<rev>{tilde}<n>', e.g. '@{tilde}1', 'master{tilde}3'::
   A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation ancestor of the named
   commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
diff --git a/refs.c b/refs.c
index de2d8eb..6a75f77 100644
--- a/refs.c
+++ b/refs.c
@@ -72,6 +72,9 @@ int check_refname_format(const char *refname, int flags)
 {
 	int component_len, component_count = 0;
 
+	if (!strcmp(refname, "@"))
+		return -1;
+
 	while (1) {
 		/* We are at the start of a path component. */
 		component_len = check_refname_component(refname, flags);
@@ -1093,8 +1096,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 	if (flag)
 		*flag = 0;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) < 0) {
+		/* Handle the pseudo-ref @ */
+		if (!strcmp(refname, "@"))
+			refname = "HEAD";
+		else
+			return NULL;
+	}
 
 	for (;;) {
 		char path[PATH_MAX];
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e415ee0..ee93979 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -127,6 +127,9 @@ test_expect_success '(not) change HEAD with wrong SHA1' "
 test_expect_success "(not) changed .git/$m" "
 	! test $B"' = $(cat .git/'"$m"')
 '
+test_expect_success 'disallow creating a ref with name @' '
+	test_must_fail git update-ref @ HEAD
+'
 rm -f .git/$m
 
 : a repository with working tree always has reflog these days...
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 6a69f9e..c50c3f7 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -65,9 +65,7 @@ check "H@{1}" commit new-one
 check "H@{now}" commit new-two
 check "H@{u}" refs/heads/upstream-branch
 
-# To make sure that the @-parser isn't buggy, check things with the
-# symbolic-ref @
-git symbolic-ref @ HEAD
+# Check everything with pseudo-ref @
 check "@@{1}" commit new-one
 check "@@{now}" commit new-two
 check "@@{u}" refs/heads/upstream-branch
-- 
1.8.3.rc0.40.g09a0447
