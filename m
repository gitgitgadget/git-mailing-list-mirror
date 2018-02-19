Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A34B1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 22:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932284AbeBSW7x (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 17:59:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33314 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932251AbeBSW7t (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:49 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 65C9060B10;
        Mon, 19 Feb 2018 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081188;
        bh=nqMhY/7955D1UXegDKR4pB4YTvCCzDk2HSBcOocPxlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=S6/BoCDzrhuWGPNxebDt298AxYBc3+3BkYNKyH4AVSrTtZtfR3Jotd/QSYrgsj8dI
         MajPM2laMUIcP5erVSAKPkDK7nT8tdu234vB9Ln7RGBd7sMRs+kutcwB39oasCYcch
         QMjlRD4bACg2SwV/y6sw0RH8nufhFH7PWyXz2Hjbcs5cigVjNKSbOD6see8Ohwp210
         km50X11LOjIItd80i5ViIOvCZI8gzjf0Zc9BPYlvG+QJXHDnHnRr76bBjaMgYYdgGe
         B4Gbo2WTJ31kKlnrC8sUkHuz1lKsv4gg78tVVU9i7rzP8ZSDpmEF6RZ5dOfQPGx7o+
         Y9a4IxCLriNv6swFALjTARy4eyVvGagB3q5wR6puoGcvFcSntxCdDMABL+EGevapIG
         7+YY9Mvd4GpVI89eoZ9W8s+y1RuIVSbdqOq5L/xdlR7+Fev6Ul2LyFtbzv5eg0mWBY
         075GR6RCrquSc9adfJY69HuZMtNlz9qJlLvxw6z1bLkJIz8KNR4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 14/36] builtin/mktag: convert to struct object_id
Date:   Mon, 19 Feb 2018 22:59:05 +0000
Message-Id: <20180219225927.386065-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/mktag.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index beb552847b..65bb41e3cd 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -18,13 +18,13 @@
 /*
  * We refuse to tag something we can't verify. Just because.
  */
-static int verify_object(const unsigned char *sha1, const char *expected_type)
+static int verify_object(const struct object_id *oid, const char *expected_type)
 {
 	int ret = -1;
 	enum object_type type;
 	unsigned long size;
-	void *buffer = read_sha1_file(sha1, &type, &size);
-	const unsigned char *repl = lookup_replace_object(sha1);
+	void *buffer = read_sha1_file(oid->hash, &type, &size);
+	const unsigned char *repl = lookup_replace_object(oid->hash);
 
 	if (buffer) {
 		if (type == type_from_string(expected_type))
@@ -38,8 +38,8 @@ static int verify_tag(char *buffer, unsigned long size)
 {
 	int typelen;
 	char type[20];
-	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb;
+	struct object_id oid;
+	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb, *p;
 	size_t len;
 
 	if (size < 84)
@@ -52,11 +52,11 @@ static int verify_tag(char *buffer, unsigned long size)
 	if (memcmp(object, "object ", 7))
 		return error("char%d: does not start with \"object \"", 0);
 
-	if (get_sha1_hex(object + 7, sha1))
+	if (parse_oid_hex(object + 7, &oid, &p))
 		return error("char%d: could not get SHA1 hash", 7);
 
 	/* Verify type line */
-	type_line = object + 48;
+	type_line = p + 1;
 	if (memcmp(type_line - 1, "\ntype ", 6))
 		return error("char%d: could not find \"\\ntype \"", 47);
 
@@ -80,8 +80,8 @@ static int verify_tag(char *buffer, unsigned long size)
 	type[typelen] = 0;
 
 	/* Verify that the object matches */
-	if (verify_object(sha1, type))
-		return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
+	if (verify_object(&oid, type))
+		return error("char%d: could not verify object %s", 7, oid_to_hex(&oid));
 
 	/* Verify the tag-name: we don't allow control characters or spaces in it */
 	tag_line += 4;
