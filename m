Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FFDC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D01206D9
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sorrel.sh header.i=@sorrel.sh header.b="17sJ8mdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD2XFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:05:31 -0400
Received: from balrog.mythic-beasts.com ([46.235.227.24]:45641 "EHLO
        balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgD2XFa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 19:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sorrel.sh;
         s=mythic-beasts-k1; h=Date:Subject:To:From;
        bh=BdvCNUvg3Dj0L+ipbS1vRoZEvVI8leAM3UTKpP/t0fA=; b=17sJ8mdzltlNr3+rPLukeMpoRL
        QcHSrja4wHijxtf3kX5eN4fCRKFqmFzjM6y6fBDN7ijKSRzCA4zHciJaQdcH9T+EwMW1ixn204sz9
        +ifQFMcjP3R5Bxa5E2GJdOFIHD22PltYUupi5x62GINf+HkMRhzo22egkxeMjGa5DY+CwGqU+H0ic
        9XSo+1tW0XffIiyFxwGHZAg4XJGliMBfeLCbHErLoDpdJzJEDKmnVClWnQ+y15e6YXllX8Zd4Ysbi
        tkQHO00W73VS+2uHb18WNnpWkzacnaYvqcvjB2BZPLpowmnMBuogCAsul1SsxnK38mNKsqS/Zkxwg
        X3BmsBMw==;
Received: from [212.56.100.202] (port=55766 helo=localhost)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <device-what@sorrel.sh>)
        id 1jTvlf-0006kW-Uw; Thu, 30 Apr 2020 00:05:28 +0100
From:   Ash Holland <ash@sorrel.sh>
To:     git@vger.kernel.org
Cc:     Ash Holland <ash@sorrel.sh>, Junio C Hamano <gitster@pobox.com>,
        Boxuan Li <liboxuan@connect.hku.hk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2] userdiff: support Markdown
Date:   Thu, 30 Apr 2020 00:05:07 +0100
Message-Id: <20200429230509.31017-1-ash@sorrel.sh>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200421010035.13915-1-ash@sorrel.sh>
References: <20200421010035.13915-1-ash@sorrel.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's typical to find Markdown documentation alongside source code, and
having better context for documentation changes is useful; see also
commit 69f9c87d4 (userdiff: add support for Fountain documents,
2015-07-21).

The pattern is based on the CommonMark specification 0.29, section 4.2:
https://spec.commonmark.org/

Only ATX headings are supported, as detecting setext headings would
require printing the line before a pattern matches, or matching a
multiline pattern. The word-diff pattern is the same as the pattern for
HTML, because many Markdown parsers accept inline HTML.

Signed-off-by: Ash Holland <ash@sorrel.sh>
---
Changes since the previous patch:
- changed the word-diff pattern to match the HTML pattern
- fixed an off-by-one error in the wording of the test

 Documentation/gitattributes.txt       |  2 ++
 t/t4018-diff-funcname.sh              |  1 +
 t/t4018/markdown-heading-indented     |  6 ++++++
 t/t4018/markdown-heading-non-headings | 17 +++++++++++++++++
 userdiff.c                            |  3 +++
 5 files changed, 29 insertions(+)
 create mode 100644 t/t4018/markdown-heading-indented
 create mode 100644 t/t4018/markdown-heading-non-headings

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 508fe713c..2d0a03715 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -824,6 +824,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `markdown` suitable for Markdown documents.
+
 - `matlab` suitable for source code in the MATLAB and Octave languages.
 
 - `objc` suitable for source code in the Objective-C language.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 02255a08b..9d0779757 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -38,6 +38,7 @@ diffpatterns="
 	golang
 	html
 	java
+	markdown
 	matlab
 	objc
 	pascal
diff --git a/t/t4018/markdown-heading-indented b/t/t4018/markdown-heading-indented
new file mode 100644
index 000000000..1991c2bd4
--- /dev/null
+++ b/t/t4018/markdown-heading-indented
@@ -0,0 +1,6 @@
+Indented headings are allowed, as long as the indent is no more than 3 spaces.
+
+   ### RIGHT
+
+- something
+- ChangeMe
diff --git a/t/t4018/markdown-heading-non-headings b/t/t4018/markdown-heading-non-headings
new file mode 100644
index 000000000..c479c1a3f
--- /dev/null
+++ b/t/t4018/markdown-heading-non-headings
@@ -0,0 +1,17 @@
+Headings can be right next to other lines of the file:
+# RIGHT
+Indents of four or more spaces make a code block:
+
+    # code comment, not heading
+
+If there's no space after the final hash, it's not a heading:
+
+#hashtag
+
+Sequences of more than 6 hashes don't make a heading:
+
+####### over-enthusiastic heading
+
+So the detected heading should be right up at the start of this file.
+
+ChangeMe
diff --git a/userdiff.c b/userdiff.c
index efbe05e5a..3eaa1df08 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -79,6 +79,9 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("markdown",
+	 "^ {0,3}#{1,6}( .*)?$",
+	 "[^<>= \t]+"),
 PATTERNS("matlab",
 	 /*
 	  * Octave pattern is mostly the same as matlab, except that '%%%' and
-- 
2.26.2

