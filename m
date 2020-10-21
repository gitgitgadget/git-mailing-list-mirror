Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54FBC4363D
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 03:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5181D22249
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 03:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406508AbgJUDAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 23:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406454AbgJUDAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 23:00:34 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D078C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 20:00:34 -0700 (PDT)
Received: from [2404:440c:1348:1500:2c8c:773:5acb:4adc] (port=44526 helo=default-rdns.vocus.co.nz)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <victor@engmark.name>)
        id 1kV4MY-00043z-My; Wed, 21 Oct 2020 05:00:31 +0200
Message-ID: <1442e85cfbe70665890a79a5054ee07c9c16b7c6.camel@engmark.name>
Subject: [PATCH v2] userdiff: support Bash
From:   Victor Engmark <victor@engmark.name>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 21 Oct 2020 16:00:24 +1300
In-Reply-To: <xmqqk0vk8o20.fsf@gitster.c.googlers.com>
References: <373640ea4d95f3b279b9d460d9a8889b4030b4e9.camel@engmark.name>
         <xmqqk0vk8o20.fsf@gitster.c.googlers.com>
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

Adds testing functionality to verify non-matches by including the
literal string "non-match" somewhere in the test file. To verify that
only the matching files are syntactically valid:

for file in t/t4018/bash*
do
    echo "$file"
    if grep non-match "$file"
    then
        . "$file" && echo FAILED
    else
        . "$file" || echo FAILED
    fi
done 2>/dev/null | grep FAILED

Signed-off-by: Victor Engmark <victor@engmark.name>
---
Fixes issues found by Junio C Hamano.

Supports more valid function declaration formats.

Verifies non-matching code which looks similar to function
declarations.

Does *not* include the following suggested test:

> 	RIGHT () {
> 		: ChangeMe
> 	}

Quoting t/t4018/README:

    Insert the word "ChangeMe" (exactly this form) at a distance of
    at least two lines from the line that must appear in the hunk
    header.

t/t4018-diff-funcname.sh verifies the hunk header as part of `git diff
-U1`, so there's one line of context. In your example "RIGHT" is on the
line directly above "ChangeMe", so it's part of the context. I assume
it is intentional that no part of the context is duplicated in the hunk
header. The other tests, for example t/t4018/python-def, are
implemented in the same way, with at least one line of content between
"RIGHT" and "ChangeMe".

> > diff --git a/t/t4018/bash-trailing-comment b/t/t4018/bash-trailing-
> > comment
> > new file mode 100644
> > index 0000000000..f1edbeda31
> > --- /dev/null
> > +++ b/t/t4018/bash-trailing-comment
> > @@ -0,0 +1,4 @@
> > +RIGHT() { # Comment
> > +
> > +    ChangeMe
> > +}
> 
> This is the closest, but it tests "# with comment" at the same time.

It's meant to test only the comment part, so that is intentional.
t/t4018/bash-trailing-comment is identical to t/t4018/bash-posix-style-
function except for the comment.
---
 Documentation/gitattributes.txt       |  2 ++
 t/t4018-diff-funcname.sh              | 18 ++++++++++++++----
 t/t4018/README                        |  3 +++
 t/t4018/bash-arithmetic-function      |  4 ++++
 t/t4018/bash-bashism-style-compact    |  4 ++++
 t/t4018/bash-bashism-style-function   |  4 ++++
 t/t4018/bash-bashism-style-whitespace |  4 ++++
 t/t4018/bash-conditional-function     |  4 ++++
 t/t4018/bash-missing-parentheses      |  4 ++++
 t/t4018/bash-mixed-style-compact      |  4 ++++
 t/t4018/bash-mixed-style-function     |  4 ++++
 t/t4018/bash-other-characters         |  4 ++++
 t/t4018/bash-posix-style-compact      |  4 ++++
 t/t4018/bash-posix-style-function     |  4 ++++
 t/t4018/bash-posix-style-whitespace   |  4 ++++
 t/t4018/bash-subshell-function        |  4 ++++
 t/t4018/bash-trailing-comment         |  4 ++++
 userdiff.c                            | 22 ++++++++++++++++++++++
 18 files changed, 97 insertions(+), 4 deletions(-)
 create mode 100644 t/t4018/bash-arithmetic-function
 create mode 100644 t/t4018/bash-bashism-style-compact
 create mode 100644 t/t4018/bash-bashism-style-function
 create mode 100644 t/t4018/bash-bashism-style-whitespace
 create mode 100644 t/t4018/bash-conditional-function
 create mode 100644 t/t4018/bash-missing-parentheses
 create mode 100644 t/t4018/bash-mixed-style-compact
 create mode 100644 t/t4018/bash-mixed-style-function
 create mode 100644 t/t4018/bash-other-characters
 create mode 100644 t/t4018/bash-posix-style-compact
 create mode 100644 t/t4018/bash-posix-style-function
 create mode 100644 t/t4018/bash-posix-style-whitespace
 create mode 100644 t/t4018/bash-subshell-function
 create mode 100644 t/t4018/bash-trailing-comment

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
index 9d07797579..d18c4669d2 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -27,6 +27,7 @@ test_expect_success 'setup' '
 
 diffpatterns="
 	ada
+	bash
 	bibtex
 	cpp
 	csharp
@@ -106,10 +107,19 @@ do
 	else
 		result=success
 	fi
-	test_expect_$result "hunk header: $i" "
-		git diff -U1 $i >actual &&
-		grep '@@ .* @@.*RIGHT' actual
-	"
+
+	if grep non-match "$i" >/dev/null 2>&1
+	then
+		test_expect_$result "hunk header non-match: $i" "
+			git diff -U1 $i >actual &&
+			! grep '@@ .* @@.*RIGHT' actual
+		"
+	else
+		test_expect_$result "hunk header: $i" "
+			git diff -U1 $i >actual &&
+			grep '@@ .* @@.*RIGHT' actual
+		"
+	fi
 done
 
 test_done
diff --git a/t/t4018/README b/t/t4018/README
index 283e01cca1..cfe2b86ee7 100644
--- a/t/t4018/README
+++ b/t/t4018/README
@@ -10,6 +10,9 @@ The text that must appear in the hunk header must contain the word
 To mark a test case that highlights a malfunction, insert the word
 BROKEN in all lower-case somewhere in the file.
 
+To mark a test case that verifies some text is not matched, insert the
+word NON-MATCH in all lower-case somewhere in the file.
+
 This text is a bit twisted and out of order, but it is itself a
 test case for the default hunk header pattern. Know what you are doing
 if you change it.
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
diff --git a/t/t4018/bash-bashism-style-compact b/t/t4018/bash-bashism-style-compact
new file mode 100644
index 0000000000..9a06bb08fd
--- /dev/null
+++ b/t/t4018/bash-bashism-style-compact
@@ -0,0 +1,4 @@
+function RIGHT{ # non-match
+    :
+    echo 'ChangeMe'
+}
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
diff --git a/t/t4018/bash-bashism-style-whitespace b/t/t4018/bash-bashism-style-whitespace
new file mode 100644
index 0000000000..ade85dd3a5
--- /dev/null
+++ b/t/t4018/bash-bashism-style-whitespace
@@ -0,0 +1,4 @@
+	 function 	RIGHT 	( 	) 	{
+
+	    ChangeMe
+	 }
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
diff --git a/t/t4018/bash-missing-parentheses b/t/t4018/bash-missing-parentheses
new file mode 100644
index 0000000000..d112761300
--- /dev/null
+++ b/t/t4018/bash-missing-parentheses
@@ -0,0 +1,4 @@
+functionRIGHT { # non-match
+    :
+    echo 'ChangeMe'
+}
diff --git a/t/t4018/bash-mixed-style-compact b/t/t4018/bash-mixed-style-compact
new file mode 100644
index 0000000000..d9364cba67
--- /dev/null
+++ b/t/t4018/bash-mixed-style-compact
@@ -0,0 +1,4 @@
+function RIGHT(){
+    :
+    echo 'ChangeMe'
+}
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
diff --git a/t/t4018/bash-posix-style-compact b/t/t4018/bash-posix-style-compact
new file mode 100644
index 0000000000..045bd2029b
--- /dev/null
+++ b/t/t4018/bash-posix-style-compact
@@ -0,0 +1,4 @@
+RIGHT(){
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
diff --git a/t/t4018/bash-posix-style-whitespace b/t/t4018/bash-posix-style-whitespace
new file mode 100644
index 0000000000..4d984f0aa4
--- /dev/null
+++ b/t/t4018/bash-posix-style-whitespace
@@ -0,0 +1,4 @@
+	 RIGHT 	( 	) 	{
+
+	    ChangeMe
+	 }
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
diff --git a/userdiff.c b/userdiff.c
index fde02f225b..8830019f05 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -23,6 +23,28 @@ IPATTERN("ada",
 	 "[a-zA-Z][a-zA-Z0-9_]*"
 	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
 	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
+PATTERNS("bash",
+	 /* Optional leading indentation */
+	 "^[ \t]*"
+	 /* Start of function definition */
+	 "("
+	 /* Start of POSIX/Bashism grouping */
+	 "("
+	 /* POSIX identifier with mandatory parentheses */
+	 "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
+	 /* Bashism identifier with optional parentheses */
+	 "|(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
+	 /* End of POSIX/Bashism grouping */
+	 ")"
+	 /* Optional whitespace */
+	 "[ \t]*"
+	 /* Compound command starting with `{`, `(`, `((` or `[[` */
+	 "(\\{|\\(\\(?|\\[\\[)"
+	 /* End of function definition */
+	 ")",
+	 /* -- */
+	 /* Characters not in the default $IFS value */
+	 "[^ \t]+"),
 PATTERNS("dts",
 	 "!;\n"
 	 "!=\n"

