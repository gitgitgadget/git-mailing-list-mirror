Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C7C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 09:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F9460F11
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 09:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhJXJ7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 05:59:07 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:22874 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhJXJ7G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 05:59:06 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4HcYQN2BlPz5tlD;
        Sun, 24 Oct 2021 11:56:44 +0200 (CEST)
Subject: [PATCH 7/6] userdiff-cpp: back out the digit-separators in numbers
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
 <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a5a05e33-3ad9-e78c-69c0-a466eadeffec@kdbg.org>
Date:   Sun, 24 Oct 2021 11:56:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The implementation of digit-separating single-quotes introduced a
note-worthy regression: the change of a character literal with a
digit would splice the digit and the closing single-quote. For
example, the change from 'a' to '2' is now tokenized as
'[-a'-]{+2'+} instead of '[-a-]{+2+}'.

The options to fix the regression are:

- Tighten the regular expression such that the single-quote can only
  occur between digits (that would match the official syntax).

- Remove support for digit separators.

I chose to remove support, because

- I have not seen a lot of code make use of digit separators.

- If code does use digit separators, then the numbers are typically
  long. If a change in one of the segments occurs, it is actually
  better visible if only that segment is highlighted as the word
  that changed instead of the whole long number.

This choice does introduce another minor regression, though, which
is highlighted in the test case: when a change occurs in the second
or later segment of a hexadecimal number where the segment begins
with a digit, but also has letters, the segment is mistaken as
consisting of a number and an identifier. I can live with that.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4034/cpp/expect | 12 ++++++------
 t/t4034/cpp/post   | 10 +++++-----
 t/t4034/cpp/pre    |  8 ++++----
 userdiff.c         |  6 +++---
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
index 5ff4ce477b..dc500ae092 100644
--- a/t/t4034/cpp/expect
+++ b/t/t4034/cpp/expect
@@ -1,21 +1,21 @@
 <BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 144cd98..64e78af 100644<RESET>
+<BOLD>index a1a09b7..f1b6f3c 100644<RESET>
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,30 +1,30 @@<RESET>
 Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>(x.<RED>find<RESET><GREEN>Find<RESET>); }
 cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
-<GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>.<RESET>'
+<GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>2<RESET>'
 // long double<RESET>
-<RED>3.141'592'653e-10l<RESET><GREEN>3.141'592'654e+10l<RESET>
+<RED>3.141592653e-10l<RESET><GREEN>3.141592654e+10l<RESET>
 // float<RESET>
 <RED>120E5f<RESET><GREEN>120E6f<RESET>
 // hex<RESET>
-<RED>0xdead'beaf<RESET><GREEN>0xdead'Beaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
+<RED>0xdead<RESET><GREEN>0xdeaf<RESET>'1<RED>eaF<RESET><GREEN>eaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
 // octal<RESET>
-<RED>0123'4567<RESET><GREEN>0123'4560<RESET>
+<RED>01234567<RESET><GREEN>01234560<RESET>
 // binary<RESET>
-<RED>0b10'00<RESET><GREEN>0b11'00<RESET>+e1
+<RED>0b1000<RESET><GREEN>0b1100<RESET>+e1
 // expression<RESET>
 1.5-e+<RED>2<RESET><GREEN>3<RESET>+f
 // another one<RESET>
diff --git a/t/t4034/cpp/post b/t/t4034/cpp/post
index 64e78afbfb..f1b6f3c228 100644
--- a/t/t4034/cpp/post
+++ b/t/t4034/cpp/post
@@ -1,16 +1,16 @@
 Foo() : x(0&42) { bar(x.Find); }
 cout<<"Hello World?\n"<<endl;
-(1 +1e10 0xabcdef) '.'
+(1 +1e10 0xabcdef) '2'
 // long double
-3.141'592'654e+10l
+3.141592654e+10l
 // float
 120E6f
 // hex
-0xdead'Beaf+7ULL
+0xdeaf'1eaf+7ULL
 // octal
-0123'4560
+01234560
 // binary
-0b11'00+e1
+0b1100+e1
 // expression
 1.5-e+3+f
 // another one
diff --git a/t/t4034/cpp/pre b/t/t4034/cpp/pre
index 144cd980d6..a1a09b7712 100644
--- a/t/t4034/cpp/pre
+++ b/t/t4034/cpp/pre
@@ -2,15 +2,15 @@ Foo():x(0&&1){ foo0( x.find); }
 cout<<"Hello World!\n"<<endl;
 1 -1e10 0xabcdef 'x'
 // long double
-3.141'592'653e-10l
+3.141592653e-10l
 // float
 120E5f
 // hex
-0xdead'beaf+8ULL
+0xdead'1eaF+8ULL
 // octal
-0123'4567
+01234567
 // binary
-0b10'00+e1
+0b1000+e1
 // expression
 1.5-e+2+f
 // another one
diff --git a/userdiff.c b/userdiff.c
index 7b143ef36b..8578cb0d12 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -67,11 +67,11 @@
 	 /* identifiers and keywords */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 /* decimal and octal integers as well as floatingpoint numbers */
-	 "|[0-9][0-9.']*([Ee][-+]?[0-9]+)?[fFlLuU]*"
+	 "|[0-9][0-9.]*([Ee][-+]?[0-9]+)?[fFlLuU]*"
 	 /* hexadecimal and binary integers */
-	 "|0[xXbB][0-9a-fA-F']+[lLuU]*"
+	 "|0[xXbB][0-9a-fA-F]+[lLuU]*"
 	 /* floatingpoint numbers that begin with a decimal point */
-	 "|\\.[0-9][0-9']*([Ee][-+]?[0-9]+)?[fFlL]?"
+	 "|\\.[0-9][0-9]*([Ee][-+]?[0-9]+)?[fFlL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*|<=>"),
 PATTERNS("csharp",
 	 /* Keywords */
-- 
2.33.0.129.g739793498e
