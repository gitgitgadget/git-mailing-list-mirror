Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE5C38A30
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 01:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751FE2078C
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 01:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sorrel.sh header.i=@sorrel.sh header.b="WzqmA0YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDUBDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:03:14 -0400
Received: from balrog.mythic-beasts.com ([46.235.227.24]:36397 "EHLO
        balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDUBDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 21:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sorrel.sh;
         s=mythic-beasts-k1; h=Date:Subject:To:From;
        bh=QqVLm/WkgDMYurxfikvlTTc5UJ/geH3hPL+rUcQjHO4=; b=WzqmA0YVE7Ko9N4rb2i+ZbF8Tx
        OfSP/ZjkfRgMIYI9l0IBgb68twYHs7jWUaAQH5Xr3VzxuKLUJdvsqKt01pw16G0Uw/oInE5K0mV5d
        72khIQNKphSsStW/ECW3uOb1PJky56Gndn+MEESoIlPb+eERiKY4lIC92HkmYFIns2SbnVhk7ylG/
        FGkKcNWmkniElzU/JZ+wYisUM9r5vBhxsoH3ZyBz09NWuppNUgh0ze7XXMSkNd85td7EtEELwIdup
        zjP0D9lATLjMkp+0TAwZTwYIjkrGKBnXOeR4lU+cNYKAe9Ec9WD3tjruxsdQJePXAyigZsRBYT5G6
        ApgssrZg==;
Received: from [212.56.100.202] (port=64889 helo=localhost)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <device-what@sorrel.sh>)
        id 1jQhJc-0007cG-UX; Tue, 21 Apr 2020 02:03:09 +0100
From:   Ash Holland <ash@sorrel.sh>
To:     git@vger.kernel.org
Cc:     Ash Holland <ash@sorrel.sh>, Junio C Hamano <gitster@pobox.com>,
        Boxuan Li <liboxuan@connect.hku.hk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH] userdiff: support Markdown
Date:   Tue, 21 Apr 2020 02:00:35 +0100
Message-Id: <20200421010035.13915-1-ash@sorrel.sh>
X-Mailer: git-send-email 2.26.1
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
multiline pattern.

Signed-off-by: Ash Holland <ash@sorrel.sh>
---

If it is indeed possible to match multiline patterns, let me know! I
would love to support setext (underlined) headings with this.

I would also appreciate feedback on the word-diff pattern here, I have
no real idea what should constitute a word in a Markdown document, apart
from that it should probably be similar to the definition given for
Fountain, given that Fountain appears to have somewhat similar inline
syntax to Markdown.

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
index 000000000..1f19b91d6
--- /dev/null
+++ b/t/t4018/markdown-heading-non-headings
@@ -0,0 +1,17 @@
+Headings can be right next to other lines of the file:
+# RIGHT
+Indents of more than four spaces make a code block:
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
index efbe05e5a..f79adb3a3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -79,6 +79,9 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("markdown",
+	 "^ {0,3}#{1,6}( .*)?$",
+	 "[^ \t-]+"),
 PATTERNS("matlab",
 	 /*
 	  * Octave pattern is mostly the same as matlab, except that '%%%' and
-- 
2.26.1

