Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC45C678D6
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 18:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjASSUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjASSTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 13:19:42 -0500
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6448E5B99
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 10:19:40 -0800 (PST)
Received: from localhost.localdomain ([88.110.98.79])
        by smtp.talktalk.net with SMTP
        id IZUipjyTdLVi2IZUjpC7Tg; Thu, 19 Jan 2023 18:18:37 +0000
X-Originating-IP: [88.110.98.79]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=qs8Jj6vsB7NiZ+3IlNxB6Q==:117
 a=qs8Jj6vsB7NiZ+3IlNxB6Q==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=VwQbUJbxAAAA:8 a=hO_LHwqjR-8dI1bbRI8A:9 a=vMvttVU5AH4A:10
 a=AjGcO6oz07-iQ99wixmX:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        self <philipoakley@iee.email>
Subject: [PATCH v5 5/5] doc: pretty-formats note wide char limitations, and add tests
Date:   Thu, 19 Jan 2023 18:18:27 +0000
Message-Id: <20230119181827.1319-6-philipoakley@iee.email>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <20230119181827.1319-1-philipoakley@iee.email>
References: <20221112143616.1429-1-philipoakley@iee.email>
 <20230119181827.1319-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKjmWDDidILLRDqZI4JfqPxXhx1+6DJpE85VAVVwD/HbvHJ9KCP5dEd4rs3ON1QiHRtNnO0KWF7JDsrMj8EIKCFRV60EB5PXpVJk71yxiBwbkthTJaQ0
 vGbc5Jgpyg4zXpzDbBzic7zkMun3QwdKEHaHB3W1ysYb/+1BXRsGAIK6bkvSl+/W1uVZnuJnqwIh70TozmxCrNfLooxpBwAOHH0YY7piZJbc3ZFxf7aedb53
 Jpdfl8lR9nlGMvIoM3CThr9JnXA/7CKMPphE1Stg1BgVA8X26m74YEYEiBqTKIXL+dmhuswhYjHErc9UWgdkhw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commits added clarifications to the column alignment
placeholders, note that the spaces are optional around the parameters.

Also, a proposed extension [1] to allow hard truncation (without
ellipsis '..') highlighted that the existing code does not play well
with wide characters, such as Asian fonts and emojis.

For example, N wide characters take 2N columns so won't fit an odd number
column width, causing misalignment somewhere.

Further analysis also showed that decomposed characters, e.g. separate
`a` + `umlaut` Unicode code-points may also be mis-counted, in some cases
leaving multiple loose `umlauts` all combined together.

Add some notes about these limitations, and add basic tests to demonstrate
them.

The chosen solution for the tests is to substitute any wide character
that overlaps a splitting boundary for the unicode vertical ellipsis
code point as a rare but 'obvious' substitution.

An alternative could be the substitution with a single dot '.' which
matches regular expression usage, and our two dot ellipsis, and further
in scenarios where the bulk of the text is wide characters, would be
obvious. In mainly 'ascii' scenarios a singleton emoji being substituted
by a dot could be confusing.

It is enough that the tests fail cleanly. The final choice for the
substitute character can be deferred.

[1]
https://lore.kernel.org/git/20221030185614.3842-1-philipoakley@iee.email/

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/pretty-formats.txt |  5 +++++
 t/t4205-log-pretty-formats.sh    | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index e51f1e54e1..3b71334459 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -157,6 +157,11 @@ The placeholders are:
 				  only works correctly with N >= 2.
 				  Note 2: spaces around the N and M (see below)
 				  values are optional.
+				  Note 3: Emojis and other wide characters
+				  will take two display columns, which may
+				  over-run column boundaries.
+				  Note 4: decomposed character combining marks
+				  may be misplaced at padding boundaries.
 '%<|( <M> )':: make the next placeholder take at least until Mth
 	     display column, padding spaces on the right if necessary.
 	     Use negative M values for column positions measured
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 0404491d6e..2cba0e0c56 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1018,4 +1018,31 @@ test_expect_success '%(describe:abbrev=...) vs git describe --abbrev=...' '
 	test_cmp expect actual
 '
 
+# pretty-formats note wide char limitations, and add tests
+test_expect_failure 'wide and decomposed characters column counting' '
+
+# from t/lib-unicode-nfc-nfd.sh hex values converted to octal
+	utf8_nfc=$(printf "\303\251") && # e acute combined.
+	utf8_nfd=$(printf "\145\314\201") && # e with a combining acute (i.e. decomposed)
+	utf8_emoji=$(printf "\360\237\221\250") &&
+
+# replacement character when requesting a wide char fits in a single display colum.
+# "half wide" alternative could be a plain ASCII dot `.`
+	utf8_vert_ell=$(printf "\342\213\256") &&
+
+# use ${xxx} here!
+	nfc10="${utf8_nfc}${utf8_nfc}${utf8_nfc}${utf8_nfc}${utf8_nfc}${utf8_nfc}${utf8_nfc}${utf8_nfc}${utf8_nfc}${utf8_nfc}" &&
+	nfd10="${utf8_nfd}${utf8_nfd}${utf8_nfd}${utf8_nfd}${utf8_nfd}${utf8_nfd}${utf8_nfd}${utf8_nfd}${utf8_nfd}${utf8_nfd}" &&
+	emoji5="${utf8_emoji}${utf8_emoji}${utf8_emoji}${utf8_emoji}${utf8_emoji}" &&
+# emoji5 uses 10 display columns
+
+	test_commit "abcdefghij" &&
+	test_commit --no-tag "${nfc10}" &&
+	test_commit --no-tag "${nfd10}" &&
+	test_commit --no-tag "${emoji5}" &&
+	printf "${utf8_emoji}..${utf8_emoji}${utf8_vert_ell}\n${utf8_nfd}..${utf8_nfd}${utf8_nfd}\n${utf8_nfc}..${utf8_nfc}${utf8_nfc}\na..ij\n" >expected &&
+	git log --format="%<(5,mtrunc)%s" -4 >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.39.1.windows.1

