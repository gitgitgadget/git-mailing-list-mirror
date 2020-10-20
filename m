Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27454C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 07:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F73223BF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 07:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgJTHK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 03:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgJTHK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 03:10:57 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72216C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 00:10:57 -0700 (PDT)
Received: from [2404:440c:1348:1500:ed01:7244:93fb:830c] (port=55094 helo=default-rdns.vocus.co.nz)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <victor@engmark.name>)
        id 1kUlnJ-0007Bx-5P
        for git@vger.kernel.org; Tue, 20 Oct 2020 09:10:53 +0200
Message-ID: <373640ea4d95f3b279b9d460d9a8889b4030b4e9.camel@engmark.name>
Subject: [PATCH] userdiff: support Bash
From:   Victor Engmark <victor@engmark.name>
To:     git@vger.kernel.org
Date:   Tue, 20 Oct 2020 20:10:49 +1300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Supports POSIX, bashism and mixed function declarations, all four compound
command types, trailing comments and mixed whitespace.

Uses the POSIX.1-2017 definition of allowed characters in names
<https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_235>
since actual allowed characters in Bash function names are locale
dependent <https://unix.stackexchange.com/a/245336/3645>.

Uses the default `IFS` characters to define words.

Signed-off-by: Victor Engmark <victor@engmark.name>
---
 Documentation/gitattributes.txt     | 2 ++
 t/t4018-diff-funcname.sh            | 1 +
 t/t4018/bash-arithmetic-function    | 4 ++++
 t/t4018/bash-bashism-style-function | 4 ++++
 t/t4018/bash-conditional-function   | 4 ++++
 t/t4018/bash-mixed-style-function   | 4 ++++
 t/t4018/bash-other-characters       | 4 ++++
 t/t4018/bash-posix-style-function   | 4 ++++
 t/t4018/bash-subshell-function      | 4 ++++
 t/t4018/bash-trailing-comment       | 4 ++++
 t/t4018/bash-whitespace             | 4 ++++
 userdiff.c                          | 6 ++++++
 12 files changed, 45 insertions(+)
 create mode 100644 t/t4018/bash-arithmetic-function
 create mode 100644 t/t4018/bash-bashism-style-function
 create mode 100644 t/t4018/bash-conditional-function
 create mode 100644 t/t4018/bash-mixed-style-function
 create mode 100644 t/t4018/bash-other-characters
 create mode 100644 t/t4018/bash-posix-style-function
 create mode 100644 t/t4018/bash-subshell-function
 create mode 100644 t/t4018/bash-trailing-comment
 create mode 100644 t/t4018/bash-whitespace

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2d0a03715b..8a15ff6bdf 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -802,6 +802,8 @@ patterns are available:
 
 - `ada` suitable for source code in the Ada language.
 
+- `bash` suitable for source code in the Bourne-Again SHell language.
+
 - `bibtex` suitable for files with BibTeX coded references.
 
 - `cpp` suitable for source code in the C and C++ languages.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9d07797579..9675bc17db 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -27,6 +27,7 @@ test_expect_success 'setup' '
 
 diffpatterns="
 	ada
+	bash
 	bibtex
 	cpp
 	csharp
diff --git a/t/t4018/bash-arithmetic-function b/t/t4018/bash-arithmetic-function
new file mode 100644
index 0000000000..c0b276cb50
--- /dev/null
+++ b/t/t4018/bash-arithmetic-function
@@ -0,0 +1,4 @@
+RIGHT() ((
+
+    ChangeMe = "$x" + "$y"
+))
diff --git a/t/t4018/bash-bashism-style-function b/t/t4018/bash-bashism-style-function
new file mode 100644
index 0000000000..f1de4fa831
--- /dev/null
+++ b/t/t4018/bash-bashism-style-function
@@ -0,0 +1,4 @@
+function RIGHT {
+    :
+    echo 'ChangeMe'
+}
diff --git a/t/t4018/bash-conditional-function b/t/t4018/bash-conditional-function
new file mode 100644
index 0000000000..c5949e829b
--- /dev/null
+++ b/t/t4018/bash-conditional-function
@@ -0,0 +1,4 @@
+RIGHT() [[ \
+
+    "$a" > "$ChangeMe"
+]]
diff --git a/t/t4018/bash-mixed-style-function b/t/t4018/bash-mixed-style-function
new file mode 100644
index 0000000000..555f9b2466
--- /dev/null
+++ b/t/t4018/bash-mixed-style-function
@@ -0,0 +1,4 @@
+function RIGHT() {
+
+    ChangeMe
+}
diff --git a/t/t4018/bash-other-characters b/t/t4018/bash-other-characters
new file mode 100644
index 0000000000..a3f390d525
--- /dev/null
+++ b/t/t4018/bash-other-characters
@@ -0,0 +1,4 @@
+_RIGHT_0n() {
+
+    ChangeMe
+}
diff --git a/t/t4018/bash-posix-style-function b/t/t4018/bash-posix-style-function
new file mode 100644
index 0000000000..a4d144856e
--- /dev/null
+++ b/t/t4018/bash-posix-style-function
@@ -0,0 +1,4 @@
+RIGHT() {
+
+    ChangeMe
+}
diff --git a/t/t4018/bash-subshell-function b/t/t4018/bash-subshell-function
new file mode 100644
index 0000000000..80baa09484
--- /dev/null
+++ b/t/t4018/bash-subshell-function
@@ -0,0 +1,4 @@
+RIGHT() (
+
+    ChangeMe=2
+)
diff --git a/t/t4018/bash-trailing-comment b/t/t4018/bash-trailing-comment
new file mode 100644
index 0000000000..f1edbeda31
--- /dev/null
+++ b/t/t4018/bash-trailing-comment
@@ -0,0 +1,4 @@
+RIGHT() { # Comment
+
+    ChangeMe
+}
diff --git a/t/t4018/bash-whitespace b/t/t4018/bash-whitespace
new file mode 100644
index 0000000000..62e7d1f25c
--- /dev/null
+++ b/t/t4018/bash-whitespace
@@ -0,0 +1,4 @@
+	 function 	RIGHT() 	{
+
+	    ChangeMe
+	 }
diff --git a/userdiff.c b/userdiff.c
index fde02f225b..9de0497007 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -23,6 +23,12 @@ IPATTERN("ada",
 	 "[a-zA-Z][a-zA-Z0-9_]*"
 	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
 	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
+PATTERNS("bash",
+	 /* POSIX & bashism form; all four compound command types */
+	 "^[ \t]*((function[ \t]*)?[a-zA-Z_][a-zA-Z0-9_]*(\\(\\))?[ \t]*(\\{|\\(\\(?|\\[\\[))",
+	 /* -- */
+	 /* Characters not in the default $IFS value */
+	 "[^ \t]+"),
 PATTERNS("dts",
 	 "!;\n"
 	 "!=\n"

