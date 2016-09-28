Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2089B1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbcI1Two (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 15:52:44 -0400
Received: from ikke.info ([178.21.113.177]:48058 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753091AbcI1Twm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 15:52:42 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id D01D34400CA; Wed, 28 Sep 2016 21:52:40 +0200 (CEST)
Received: from io.ikke (unknown [10.8.0.30])
        by vps892.directvps.nl (Postfix) with ESMTP id EFD674400BD;
        Wed, 28 Sep 2016 21:52:39 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Swift Geek <swiftgeek@gmail.com>, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>
Subject: [PATCH v4 2/2] mailinfo: unescape quoted-pair in header fields
Date:   Wed, 28 Sep 2016 21:52:32 +0200
Message-Id: <20160928195232.7843-2-me@ikke.info>
X-Mailer: git-send-email 2.10.0.372.g6fe1b14
In-Reply-To: <20160928194939.7706-1-me@ikke.info>
References: <20160928194939.7706-1-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rfc2822 has provisions for quoted strings in structured header fields,
but also allows for escaping these with so-called quoted-pairs.

The only thing git currently does is removing exterior quotes, but
quotes within are left alone.

Remove exterior quotes and remove escape characters so that they don't
show up in the author field.

Signed-off-by: Kevin Daudt <me@ikke.info>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailinfo.c                   | 82 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5100-mailinfo.sh          | 14 ++++++++
 t/t5100/comment.expect       |  5 +++
 t/t5100/comment.in           |  9 +++++
 t/t5100/quoted-string.expect |  5 +++
 t/t5100/quoted-string.in     |  9 +++++
 6 files changed, 124 insertions(+)
 create mode 100644 t/t5100/comment.expect
 create mode 100644 t/t5100/comment.in
 create mode 100644 t/t5100/quoted-string.expect
 create mode 100644 t/t5100/quoted-string.in

diff --git a/mailinfo.c b/mailinfo.c
index e19abe3..b4118a0 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -54,6 +54,86 @@ static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
 	get_sane_name(&mi->name, &mi->name, &mi->email);
 }
 
+static const char *unquote_comment(struct strbuf *outbuf, const char *in)
+{
+	int c;
+	int take_next_litterally = 0;
+
+	strbuf_addch(outbuf, '(');
+
+	while ((c = *in++) != 0) {
+		if (take_next_litterally == 1) {
+			take_next_litterally = 0;
+		} else {
+			switch (c) {
+			case '\\':
+				take_next_litterally = 1;
+				continue;
+			case '(':
+				in = unquote_comment(outbuf, in);
+				continue;
+			case ')':
+				strbuf_addch(outbuf, ')');
+				return in;
+			}
+		}
+
+		strbuf_addch(outbuf, c);
+	}
+
+	return in;
+}
+
+static const char *unquote_quoted_string(struct strbuf *outbuf, const char *in)
+{
+	int c;
+	int take_next_litterally = 0;
+
+	while ((c = *in++) != 0) {
+		if (take_next_litterally == 1) {
+			take_next_litterally = 0;
+		} else {
+			switch (c) {
+			case '\\':
+				take_next_litterally = 1;
+				continue;
+			case '"':
+				return in;
+			}
+		}
+
+		strbuf_addch(outbuf, c);
+	}
+
+	return in;
+}
+
+static void unquote_quoted_pair(struct strbuf *line)
+{
+	struct strbuf outbuf;
+	const char *in = line->buf;
+	int c;
+
+	strbuf_init(&outbuf, line->len);
+
+	while ((c = *in++) != 0) {
+		switch (c) {
+		case '"':
+			in = unquote_quoted_string(&outbuf, in);
+			continue;
+		case '(':
+			in = unquote_comment(&outbuf, in);
+			continue;
+		}
+
+		strbuf_addch(&outbuf, c);
+	}
+
+	strbuf_swap(&outbuf, line);
+	strbuf_release(&outbuf);
+
+}
+
 static void handle_from(struct mailinfo *mi, const struct strbuf *from)
 {
 	char *at;
@@ -63,6 +143,8 @@ static void handle_from(struct mailinfo *mi, const struct strbuf *from)
 	strbuf_init(&f, from->len);
 	strbuf_addbuf(&f, from);
 
+	unquote_quoted_pair(&f);
+
 	at = strchr(f.buf, '@');
 	if (!at) {
 		parse_bogus_from(mi, from);
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 56988b7..45d228e 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -144,4 +144,18 @@ test_expect_success 'mailinfo unescapes with --mboxrd' '
 	test_cmp expect mboxrd/msg
 '
 
+test_expect_success 'mailinfo handles rfc2822 quoted-string' '
+	mkdir quoted-string &&
+	git mailinfo /dev/null /dev/null <"$DATA/quoted-string.in" \
+		>quoted-string/info &&
+	test_cmp "$DATA/quoted-string.expect" quoted-string/info
+'
+
+test_expect_success 'mailinfo handles rfc2822 comment' '
+	mkdir comment &&
+	git mailinfo /dev/null /dev/null <"$DATA/comment.in" \
+		>comment/info &&
+	test_cmp "$DATA/comment.expect" comment/info
+'
+
 test_done
diff --git a/t/t5100/comment.expect b/t/t5100/comment.expect
new file mode 100644
index 0000000..7228177
--- /dev/null
+++ b/t/t5100/comment.expect
@@ -0,0 +1,5 @@
+Author: A U Thor (this is (really) a comment (honestly))
+Email: somebody@example.com
+Subject: testing comments
+Date: Sun, 25 May 2008 00:38:18 -0700
+
diff --git a/t/t5100/comment.in b/t/t5100/comment.in
new file mode 100644
index 0000000..c53a192
--- /dev/null
+++ b/t/t5100/comment.in
@@ -0,0 +1,9 @@
+From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
+From: "A U Thor" <somebody@example.com> (this is \(really\) a comment (honestly))
+Date: Sun, 25 May 2008 00:38:18 -0700
+Subject: [PATCH] testing comments
+
+
+
+---
+patch
diff --git a/t/t5100/quoted-string.expect b/t/t5100/quoted-string.expect
new file mode 100644
index 0000000..cab1bce
--- /dev/null
+++ b/t/t5100/quoted-string.expect
@@ -0,0 +1,5 @@
+Author: Author "The Author" Name
+Email: somebody@example.com
+Subject: testing quoted-pair
+Date: Sun, 25 May 2008 00:38:18 -0700
+
diff --git a/t/t5100/quoted-string.in b/t/t5100/quoted-string.in
new file mode 100644
index 0000000..e2e627a
--- /dev/null
+++ b/t/t5100/quoted-string.in
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
-- 
2.10.0.372.g6fe1b14

