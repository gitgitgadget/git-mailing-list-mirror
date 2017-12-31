Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82421F404
	for <e@80x24.org>; Sun, 31 Dec 2017 08:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbdLaIGQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 03:06:16 -0500
Received: from mout.web.de ([217.72.192.78]:54131 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbdLaIGN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 03:06:13 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaTid-1fDAhl0TLb-00mNdW; Sun, 31
 Dec 2017 09:05:58 +0100
From:   tboegi@web.de
To:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 3/5] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Sun, 31 Dec 2017 09:05:56 +0100
Message-Id: <20171231080556.22344-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.4.ga4e00d4fa4
In-Reply-To: <20171229152222.39680-1-lars.schneider@autodesk.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:bakETDn1ozXmBfskBn9QbaOyI3sichaRMpMpa/nc2/Pc4dTjFkF
 S/28aD2l1cv5sgzT9NhEsbrE7OQ87J86bHavGIFgekAbgagmRjNhKDKvcnhDrytDo5/kGjf
 +p+QpogSoHgnAagIdA3Oa0gMu7qAZVwEFgKor6aUvxfRs1ROVdrcQOFH/dW+fwrP+W5O0rS
 8iJbntXX/YLxLfsa3MtoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yxJ6koyEyZU=:reMZ9RhiIVsjGoUBloI8BG
 lS7Sa/e9zrAYSjJ7S/Me3pp04sMG/vY7is8kIenU5StXwABx6vDsfpPSgJhYKG5BAMxD3sl73
 X2NicN5ZLH5u0fGzzE9VjByGGvXAgWjAC3xzVqyhb9EaejlbBAi3LAYhK6CRNmfrFHxMXPUFc
 I+G5fBpXERaByzlKGOSWJ3VxB2JyyoIhsU+OYrSCzBhXEkoHR5DUWgfUDzMvUC0XDiKV8Mie+
 9RLgRe6Meq9cOn8GIYuvlSCIrmC0lVAbmYp7ZEa5hBsRQVzkPlvHqScYD5tPGVeN3o/ApjuPv
 qFa7Oh8JsVxxuqsTSKX3sAgLQpXmoHDYNaeS1zf0qKfxV0FvvQDNVew9EgktDrgUMpXDxaitf
 deQhn10pBCgACKMjACt9roO/y8kiRd3oILPfPEzp1qJ6ZHYkD25r10BgNc9jOsa+q45Q3cvjR
 aek72QAZvtShdadHLnwMPMa1vZ9SCfJ0P2O103B5oPj8zuTHqtnJdULI0hC+OmM8I+3Rsh4ng
 mMgR4yELAKTz1C95yf5f8DSh0JZJepDNumB8ke7g/6Y1Dwn6FQ/Ued+GT4BKBlXO9LsvyFi75
 PuA8/w2LzNEs2hipTsis2VekBsT/Hb2LWX1hMSMtvO815/MPF+Fv/QLGdGHjwIdwv+3zBZs7e
 j5mvp5ocus6+PmFGAguj14m53CL5s59gkVF8F5LKfqvYNLJ8RwI6ff8r90uvLeuKpRaKxDJc3
 zV9/QVU5iYk2h/10ntixzUUzojQyKTPB/0j4FXfpSUJUNmDA4DxbUf1vuNhf6HvJeXw7DUOI6
 1DOj0grmmUaoLTuEVHkt+qC1k2y+bP1VAccqeVCyMlYFkd4mj8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
or UTF-32LE a BOM must not be used [1]. The function returns true if
this is the case.

This function is used in a subsequent commit.

[1] http://unicode.org/faq/utf_bom.html#bom10

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 utf8.c | 24 ++++++++++++++++++++++++
 utf8.h |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/utf8.c b/utf8.c
index 2c27ce0137..776660ee12 100644
--- a/utf8.c
+++ b/utf8.c
@@ -538,6 +538,30 @@ char *reencode_string_len(const char *in, int insz,
 }
 #endif
 
+static int has_bom_prefix(const char *data, size_t len,
+			  const char *bom, size_t bom_len)
+{
+	return (len >= bom_len) && !memcmp(data, bom, bom_len);
+}
+
+const char utf16_be_bom[] = {0xFE, 0xFF};
+const char utf16_le_bom[] = {0xFF, 0xFE};
+const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
+const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	  (!strcmp(enc, "UTF-16BE") || !strcmp(enc, "UTF-16LE")) &&
+	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	  (!strcmp(enc, "UTF-32BE") || !strcmp(enc, "UTF-32LE")) &&
+	  (has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	   has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 6bbcf31a83..4711429af9 100644
--- a/utf8.h
+++ b/utf8.h
@@ -70,4 +70,13 @@ typedef enum {
 void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
 		       const char *s);
 
+/*
+ * Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
+ * or UTF-32LE a BOM must not be used [1]. The function returns true if
+ * this is the case.
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#bom10
+ */
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.0.rc0.4.ga4e00d4fa4

