Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB2AC433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0C9614A5
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 19:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhBMTcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 14:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMTcE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 14:32:04 -0500
X-Greylist: delayed 384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Feb 2021 11:31:24 PST
Received: from coral.adamspiers.org (coral.adamspiers.org [IPv6:2001:ba8:1f1:f27f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B9CBC061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 11:31:24 -0800 (PST)
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
        by coral.adamspiers.org (Postfix) with ESMTPSA id 0279C2E5CC;
        Sat, 13 Feb 2021 19:24:55 +0000 (GMT)
From:   Adam Spiers <git@adamspiers.org>
To:     git list <git@vger.kernel.org>
Cc:     Protesilaos Stavrou <info@protesilaos.com>
Subject: [PATCH] userdiff: add support for Emacs Lisp
Date:   Sat, 13 Feb 2021 19:24:47 +0000
Message-Id: <20210213192447.6114-1-git@adamspiers.org>
X-Mailer: git-send-email 2.30.1.490.ge54fde04c8.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a diff driver which recognises Elisp top-level forms and outline
headings for display in hunk headers, and which correctly renders word
diffs.

This approach was previously discussed on the emacs-devel mailing list:

   https://lists.gnu.org/archive/html/emacs-devel/2021-02/msg00705.html

* userdiff.c (builtin_drivers): Provide regexen for Elisp top level
  forms and outline headings, and for word diffs.
* t/t4018-diff-funcname.sh (diffpatterns): Add test for elisp driver
* t/t4018/elisp-outline-heading: Test fixture for outline headings
* t/t4018/elisp-top-level-form: Test fixture for top level forms
* t/t4034-diff-words.sh: Add test for elisp driver
* t/t4034/elisp/*: Test fixtures for word diffs

Signed-off-by: Protesilaos Stavrou <info@protesilaos.com>
Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/gitattributes.txt | 2 ++
 t/t4018-diff-funcname.sh        | 1 +
 t/t4018/elisp-outline-heading   | 6 ++++++
 t/t4018/elisp-top-level-form    | 7 +++++++
 t/t4034-diff-words.sh           | 1 +
 t/t4034/elisp/expect            | 9 +++++++++
 t/t4034/elisp/post              | 4 ++++
 t/t4034/elisp/pre               | 4 ++++
 userdiff.c                      | 9 +++++++++
 9 files changed, 43 insertions(+)
 create mode 100644 t/t4018/elisp-outline-heading
 create mode 100644 t/t4018/elisp-top-level-form
 create mode 100644 t/t4034/elisp/expect
 create mode 100644 t/t4034/elisp/post
 create mode 100644 t/t4034/elisp/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e84e104f93..0026055f99 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -815,6 +815,8 @@ patterns are available:
 
 - `dts` suitable for devicetree (DTS) files.
 
+- `elisp` suitable for source code in the Emacs Lisp language.
+
 - `elixir` suitable for source code in the Elixir language.
 
 - `fortran` suitable for source code in the Fortran language.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9675bc17db..a9ea2d3cd5 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -33,6 +33,7 @@ diffpatterns="
 	csharp
 	css
 	dts
+	elisp
 	elixir
 	fortran
 	fountain
diff --git a/t/t4018/elisp-outline-heading b/t/t4018/elisp-outline-heading
new file mode 100644
index 0000000000..c13bdafafe
--- /dev/null
+++ b/t/t4018/elisp-outline-heading
@@ -0,0 +1,6 @@
+;;; A top-level outline heading
+;;;; A second-level outline heading RIGHT
+
+;; This is a ChangeMe comment outside top-level forms
+(defun foo ()
+  (bar 1 2 3)
diff --git a/t/t4018/elisp-top-level-form b/t/t4018/elisp-top-level-form
new file mode 100644
index 0000000000..683f7ffcf1
--- /dev/null
+++ b/t/t4018/elisp-top-level-form
@@ -0,0 +1,7 @@
+;;; Outline heading
+
+;; This is a comment
+(RIGHT
+  (list 1 2 3)
+  ChangeMe
+  (list a b c))
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 0c8fb39ced..a546ee831a 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -315,6 +315,7 @@ test_language_driver cpp
 test_language_driver csharp
 test_language_driver css
 test_language_driver dts
+test_language_driver elisp
 test_language_driver fortran
 test_language_driver html
 test_language_driver java
diff --git a/t/t4034/elisp/expect b/t/t4034/elisp/expect
new file mode 100644
index 0000000000..29a6ef2520
--- /dev/null
+++ b/t/t4034/elisp/expect
@@ -0,0 +1,9 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 4a39df8..6619e96 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,4 +1,4 @@<RESET>
+(defun <RED>myfunc<RESET><GREEN>my-func<RESET> (<RED>a b<RESET><GREEN>first second<RESET>)
+  "This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function."
+  (let ((c (<RED>+ a b<RESET><GREEN>1+ first<RESET>)))
+    (format "one more than the total is %d" (<RED>1+<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
diff --git a/t/t4034/elisp/post b/t/t4034/elisp/post
new file mode 100644
index 0000000000..6619e96657
--- /dev/null
+++ b/t/t4034/elisp/post
@@ -0,0 +1,4 @@
+(defun my-func (first second)
+  "This is a (moderately) cool function."
+  (let ((c (1+ first)))
+    (format "one more than the total is %d" (+ c second))))
diff --git a/t/t4034/elisp/pre b/t/t4034/elisp/pre
new file mode 100644
index 0000000000..4a39df8ffb
--- /dev/null
+++ b/t/t4034/elisp/pre
@@ -0,0 +1,4 @@
+(defun myfunc (a b)
+  "This is a really cool function."
+  (let ((c (+ a b)))
+    (format "one more than the total is %d" (1+ c))))
diff --git a/userdiff.c b/userdiff.c
index 3f81a2261c..292e51674a 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -53,6 +53,15 @@ PATTERNS("dts",
 	 /* Property names and math operators */
 	 "[a-zA-Z0-9,._+?#-]+"
 	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
+PATTERNS("elisp",
+	 /* Top level forms and outline headings */
+	 "^((\\(|;;;+ +).+)",
+	 /*
+	  * Emacs Lisp allows symbol names containing any characters.
+	  * However spaces within the symbol must be escaped.
+	  */
+	 "(\\.|[^ ()])+"
+	 ),
 PATTERNS("elixir",
 	 "^[ \t]*((def(macro|module|impl|protocol|p)?|test)[ \t].*)$",
 	 /* -- */
-- 
2.30.1.490.ge54fde04c8.dirty

