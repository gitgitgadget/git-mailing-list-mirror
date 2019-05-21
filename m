Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3760F1F462
	for <e@80x24.org>; Tue, 21 May 2019 10:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfEUK61 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 06:58:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfEUK61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 06:58:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F5EFC01F278;
        Tue, 21 May 2019 10:58:26 +0000 (UTC)
Received: from localhost (ovpn-112-62.ams2.redhat.com [10.36.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F2075DD7E;
        Tue, 21 May 2019 10:58:21 +0000 (UTC)
From:   marcandre.lureau@redhat.com
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <mlureau@redhat.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4] userdiff: add built-in pattern for rust
Date:   Tue, 21 May 2019 12:58:20 +0200
Message-Id: <20190521105820.28511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 21 May 2019 10:58:26 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc-André Lureau <mlureau@redhat.com>

This adds xfuncname and word_regex patterns for Rust, a quite
popular programming language. It also includes test cases for the
xfuncname regex (t4018) and updated documentation.

The word_regex pattern finds identifiers, integers, floats and
operators, according to the Rust Reference Book.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Documentation/gitattributes.txt | 2 ++
 t/t4018-diff-funcname.sh        | 1 +
 t/t4018/rust-fn                 | 5 +++++
 t/t4018/rust-impl               | 5 +++++
 t/t4018/rust-nested-fn          | 6 ++++++
 t/t4018/rust-struct             | 5 +++++
 t/t4018/rust-trait              | 5 +++++
 t/t4018/rust-trait-default      | 8 ++++++++
 t/t4018/rust-unsafe             | 6 ++++++
 userdiff.c                      | 6 ++++++
 10 files changed, 49 insertions(+)
 create mode 100644 t/t4018/rust-fn
 create mode 100644 t/t4018/rust-impl
 create mode 100644 t/t4018/rust-nested-fn
 create mode 100644 t/t4018/rust-struct
 create mode 100644 t/t4018/rust-trait
 create mode 100644 t/t4018/rust-trait-default
 create mode 100644 t/t4018/rust-unsafe

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4fb20cd0e9..07da08fb27 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -833,6 +833,8 @@ patterns are available:
 
 - `ruby` suitable for source code in the Ruby language.
 
+- `rust` suitable for source code in the Rust language.
+
 - `tex` suitable for source code for LaTeX documents.
 
 
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 22f9f88f0a..9261d6d3a0 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -43,6 +43,7 @@ diffpatterns="
 	php
 	python
 	ruby
+	rust
 	tex
 	custom1
 	custom2
diff --git a/t/t4018/rust-fn b/t/t4018/rust-fn
new file mode 100644
index 0000000000..cbe02155f1
--- /dev/null
+++ b/t/t4018/rust-fn
@@ -0,0 +1,5 @@
+pub(self) fn RIGHT<T>(x: &[T]) where T: Debug {
+    let _ = x;
+    // a comment
+    let a = ChangeMe;
+}
diff --git a/t/t4018/rust-impl b/t/t4018/rust-impl
new file mode 100644
index 0000000000..09df3cd93b
--- /dev/null
+++ b/t/t4018/rust-impl
@@ -0,0 +1,5 @@
+impl<'a, T: AsRef<[u8]>>  std::RIGHT for Git<'a> {
+
+    pub fn ChangeMe(&self) -> () {
+    }
+}
diff --git a/t/t4018/rust-nested-fn b/t/t4018/rust-nested-fn
new file mode 100644
index 0000000000..ca5cca3292
--- /dev/null
+++ b/t/t4018/rust-nested-fn
@@ -0,0 +1,6 @@
+fn foo() {
+    fn RIGHT() {
+        // must catch nested function
+        ChangeMe;
+    }
+}
diff --git a/t/t4018/rust-struct b/t/t4018/rust-struct
new file mode 100644
index 0000000000..76aff1c0d8
--- /dev/null
+++ b/t/t4018/rust-struct
@@ -0,0 +1,5 @@
+#[derive(Debug)]
+pub(super) struct RIGHT<'a> {
+    name: &'a str,
+    age: ChangeMe,
+}
diff --git a/t/t4018/rust-trait b/t/t4018/rust-trait
new file mode 100644
index 0000000000..ea397f09ed
--- /dev/null
+++ b/t/t4018/rust-trait
@@ -0,0 +1,5 @@
+unsafe trait RIGHT<T> {
+    fn len(&self) -> u32;
+    fn ChangeMe(&self, n: u32) -> T;
+    fn iter<F>(&self, f: F) where F: Fn(T);
+}
diff --git a/t/t4018/rust-trait-default b/t/t4018/rust-trait-default
new file mode 100644
index 0000000000..e667d22ca4
--- /dev/null
+++ b/t/t4018/rust-trait-default
@@ -0,0 +1,8 @@
+trait RIGHT {
+
+    fn new(name: &'static str) -> Self;
+
+    fn ChangeMe(&self) {
+        // should skip "new", and return trait name
+    }
+}
diff --git a/t/t4018/rust-unsafe b/t/t4018/rust-unsafe
new file mode 100644
index 0000000000..fd4661a934
--- /dev/null
+++ b/t/t4018/rust-unsafe
@@ -0,0 +1,6 @@
+unsafe fn RIGHT(inc: u32) {
+    unsafe {
+        // don't catch unsafe block
+        ChangeMe += inc;
+    }
+}
diff --git a/userdiff.c b/userdiff.c
index 3a78fbf504..2bcf105caf 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -130,6 +130,12 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
+PATTERNS("rust",
+	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
+	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",

base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
-- 
2.22.0.rc1.1.g079e7d2849.dirty

