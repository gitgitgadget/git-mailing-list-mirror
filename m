Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B68C20984
	for <e@80x24.org>; Tue, 13 Sep 2016 23:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbcIMXqZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 19:46:25 -0400
Received: from ikke.info ([178.21.113.177]:41220 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbcIMXqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 19:46:24 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 496AA4400BF; Wed, 14 Sep 2016 01:46:22 +0200 (CEST)
Received: from io.ikke (unknown [10.8.0.30])
        by vps892.directvps.nl (Postfix) with ESMTP id 7308A4400B9;
        Wed, 14 Sep 2016 01:46:21 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>
Subject: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
Date:   Wed, 14 Sep 2016 01:46:12 +0200
Message-Id: <20160913234612.22806-2-me@ikke.info>
X-Mailer: git-send-email 2.10.0.rc2
In-Reply-To: <20160913234612.22806-1-me@ikke.info>
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
 <20160913234612.22806-1-me@ikke.info>
Reply-to: kevin@lists.ikke.info
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rfc2822 has provisions for quoted strings in structured header fields,
but also allows for escaping these with so-called quoted-pairs.

git currently does not do anything with this at all, and verbatim takes
over the field body.

Make sure to properly dequote these quoted-strings and comments.

Signed-off-by: Kevin Daudt <me@ikke.info>
---
 mailinfo.c                 | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t5100-mailinfo.sh        |  5 +++++
 t/t5100/quoted-pair.expect |  5 +++++
 t/t5100/quoted-pair.in     |  9 +++++++++
 t/t5100/quoted-pair.info   |  5 +++++
 5 files changed, 70 insertions(+)
 create mode 100644 t/t5100/quoted-pair.expect
 create mode 100644 t/t5100/quoted-pair.in
 create mode 100644 t/t5100/quoted-pair.info

diff --git a/mailinfo.c b/mailinfo.c
index e19abe3..3b7ae8a 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -445,6 +445,51 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 		mi->input_error = -1;
 }
 
+static int unescape_quoted_pair(struct mailinfo *mi, struct strbuf *line)
+{
+	struct strbuf outbuf = STRBUF_INIT;
+	const char *in = line->buf;
+	int c, skip=0;
+	char escape_context=0;
+
+	while ((c = *in++) != 0) {
+		if (!skip) {
+			switch (c) {
+				case '"':
+					if (!escape_context)
+						escape_context = '"';
+					else if (escape_context == '"')
+						escape_context = 0;
+					break;
+				case '\\':
+					if (escape_context) {
+						skip = 1;
+						continue;
+					}
+					break;
+				case '(':
+					if (!escape_context)
+						escape_context = '(';
+					break;
+				case ')':
+					if (escape_context == '(')
+						escape_context = 0;
+					break;
+			}
+		} else {
+			skip = 0;
+		}
+
+		strbuf_addch(&outbuf, c);
+	}
+
+	strbuf_reset(line);
+	strbuf_addbuf(line, &outbuf);
+
+	return 0;
+
+}
+
 static int check_header(struct mailinfo *mi,
 			const struct strbuf *line,
 			struct strbuf *hdr_data[], int overwrite)
@@ -461,6 +506,7 @@ static int check_header(struct mailinfo *mi,
 			 */
 			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
 			decode_header(mi, &sb);
+			unescape_quoted_pair(mi, &sb);
 			handle_header(&hdr_data[i], &sb);
 			ret = 1;
 			goto check_header_out;
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 1a5a546..2be61bf 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -142,4 +142,9 @@ test_expect_success 'mailinfo unescapes with --mboxrd' '
 	test_cmp expect mboxrd/msg
 '
 
+test_expect_success 'mailinfo unescapes rfc2822 quoted-pair' '
+    git mailinfo /dev/null /dev/null <"$TEST_DIRECTORY"/t5100/quoted-pair.in >"$TEST_DIRECTORY"/t5100/quoted-pair.info &&
+    test_cmp "$TEST_DIRECTORY"/t5100/quoted-pair.expect "$TEST_DIRECTORY"/t5100/quoted-pair.info
+'
+
 test_done
diff --git a/t/t5100/quoted-pair.expect b/t/t5100/quoted-pair.expect
new file mode 100644
index 0000000..9fe72e9
--- /dev/null
+++ b/t/t5100/quoted-pair.expect
@@ -0,0 +1,5 @@
+Author: "Author "The Author" Name"
+Email: somebody@example.com
+Subject: testing quoted-pair
+Date: Sun, 25 May 2008 00:38:18 -0700
+
diff --git a/t/t5100/quoted-pair.in b/t/t5100/quoted-pair.in
new file mode 100644
index 0000000..e2e627a
--- /dev/null
+++ b/t/t5100/quoted-pair.in
@@ -0,0 +1,9 @@
+From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
+From: "Author \"The Author\" Name" <somebody@example.com>
+Date: Sun, 25 May 2008 00:38:18 -0700
+Subject: [PATCH] testing quoted-pair
+
+
+
+---
+patch
diff --git a/t/t5100/quoted-pair.info b/t/t5100/quoted-pair.info
new file mode 100644
index 0000000..9fe72e9
--- /dev/null
+++ b/t/t5100/quoted-pair.info
@@ -0,0 +1,5 @@
+Author: "Author "The Author" Name"
+Email: somebody@example.com
+Subject: testing quoted-pair
+Date: Sun, 25 May 2008 00:38:18 -0700
+
-- 
2.10.0.rc2

