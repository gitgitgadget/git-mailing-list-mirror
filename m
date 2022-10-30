Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C1EC38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 18:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJ3S4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3S42 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 14:56:28 -0400
Received: from smtp-out-4.talktalk.net (smtp-out-4.talktalk.net [62.24.135.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F934A1BB
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:56:25 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id pDTqo5fqYHeg9pDTrohaB1; Sun, 30 Oct 2022 18:56:23 +0000
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=EtysUhUA c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=v8QVLJpHIbHVB4Z0ef0A:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: [PATCH 1/1] pretty-formats: add hard truncation, without ellipsis, options
Date:   Sun, 30 Oct 2022 18:56:14 +0000
Message-Id: <20221030185614.3842-2-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.281.g83ef3ded8d
In-Reply-To: <20221030185614.3842-1-philipoakley@iee.email>
References: <20221030185614.3842-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfE+67jpJg/+O/FgPkOOfpNchzjfXv7Ozpe3KEW2ZokN4TK1xpaCUbVpnbRltvZZL8Bi4E3rraZrDwvdI2IhEgw64jia0pdjUa+j2qM3KOdkUsGYzidYS
 5NCWHhdgFyhI6w7Oi/ZbFcNNE3yQDKsryV7f06DJNrATO//GOSEImMp5USnDhRtLrJYQgNhjsJlzvOgqqe5cLtHA/7mUjSzIiw0FCIJkvQ7U/BhPnF53kZvY
 yXH9PXRup7mbi9mW64Gmkzygn+ZXRbbs8XXj/+1fM8LZqZv01DWFr6fWpwpE8q70et7FEzuErDjNFuBDMKiA3w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of replacing with "..", replace with the empty string "",
having adjusted the padding length calculation.

Needswork:
There are no tests for these pretty formats, before or after
this change.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/pretty-formats.txt |  7 ++++---
 pretty.c                         | 18 +++++++++++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 0b4c1c8d98..bd1657c032 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -146,14 +146,15 @@ The placeholders are:
 '%m':: left (`<`), right (`>`) or boundary (`-`) mark
 '%w([<w>[,<i1>[,<i2>]]])':: switch line wrapping, like the -w option of
 			    linkgit:git-shortlog[1].
-'%<(<N>[,trunc|ltrunc|mtrunc])':: make the next placeholder take at
+'%<(<N>[,trunc|ltrunc|mtrunc|Trunc|Ltrunc])':: make the next placeholder take at
 				  least N columns, padding spaces on
 				  the right if necessary.  Optionally
-				  truncate at the beginning (ltrunc),
+				  truncate (with ellipsis '..') at the beginning (ltrunc),
 				  the middle (mtrunc) or the end
 				  (trunc) if the output is longer than
-				  N columns.  Note that truncating
+				  N columns.  Note that truncating with ellipsis
 				  only works correctly with N >= 2.
+				  Use (Trunc|Ltrunc) for hard truncation without ellipsis.
 '%<|(<N>)':: make the next placeholder take at least until Nth
 	     columns, padding spaces on the right if necessary
 '%>(<N>)', '%>|(<N>)':: similar to '%<(<N>)', '%<|(<N>)' respectively,
diff --git a/pretty.c b/pretty.c
index 6cb363ae1c..f67844d638 100644
--- a/pretty.c
+++ b/pretty.c
@@ -857,7 +857,9 @@ enum trunc_type {
 	trunc_none,
 	trunc_left,
 	trunc_middle,
-	trunc_right
+	trunc_right,
+	trunc_left_hard,
+	trunc_right_hard
 };
 
 struct format_commit_context {
@@ -1145,6 +1147,10 @@ static size_t parse_padding_placeholder(const char *placeholder,
 				c->truncate = trunc_left;
 			else if (starts_with(start, "mtrunc)"))
 				c->truncate = trunc_middle;
+			else if (starts_with(start, "Ltrunc)"))
+				c->truncate = trunc_left_hard;
+			else if (starts_with(start, "Trunc)"))
+				c->truncate = trunc_right_hard;
 			else
 				return 0;
 		} else
@@ -1743,6 +1749,16 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 					    padding - 2, len - (padding - 2),
 					    "..");
 			break;
+		case trunc_left_hard:
+			strbuf_utf8_replace(&local_sb,
+					    0, len - (padding),
+					    "");
+			break;
+		case trunc_right_hard:
+			strbuf_utf8_replace(&local_sb,
+					    padding, len - (padding),
+					    "");
+			break;
 		case trunc_none:
 			break;
 		}
-- 
2.38.1.281.g83ef3ded8d

