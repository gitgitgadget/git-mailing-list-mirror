Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673931F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeGPBx0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58974 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727532AbeGPBx0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6FC986077D;
        Mon, 16 Jul 2018 01:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704504;
        bh=YW6ZugRDXIu9uUNfX1tK/nceo2rm76l5nk2nhovdXFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qxgB06qeZCfNTFIBflrFWUXmiMc7TaUUmmTy7VJfV5ijos11y5wEYh2TF6sw/JIlY
         Ysc2+Q1ulsyrC1CetgAKIrg3ZeHmlC4KxS0rakHeaopt2nk9S8sovV1CGcehSQvHM1
         54r9aaKIhc6RQfPYYIPk+PzyOc6n+/FIPyYJuZb8EFEGagrQOawa1jXE+RwYy6DRyJ
         eIx5+lFzvKi8pt3a+m0PtRa/1AjpPfeXbEKGTaTv/+eFrm4kMgBgVGAijBNS/sQu8Y
         0qvYVMy/SScAf/iwG3PuSvhyIgD7XYw4ssTxpMgpDPNWSJv2MbFlbQHE8fGZ7NfAiR
         1a16Z349ttvBSyfSwOYQW7kA1pN2vLtaImQfZgxMtjqnDdJZUUvBB6CF00cisjotLH
         T263SIeKDSWyci4goSOIUSayWMnAydWVxrUzEsLqKRC483CTaODItA7EbLy5lnIySc
         po8iRQILGXqwQrydsTc/TThUSc/VctWApzS9dBHvZOK2nLfHhwv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 06/16] sha1-name: use the_hash_algo when parsing object names
Date:   Mon, 16 Jul 2018 01:27:58 +0000
Message-Id: <20180716012808.961328-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1-name.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7e..ba6a5a689f 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -310,7 +310,7 @@ static int init_object_disambiguation(const char *name, int len,
 {
 	int i;
 
-	if (len < MINIMUM_ABBREV || len > GIT_SHA1_HEXSZ)
+	if (len < MINIMUM_ABBREV || len > the_hash_algo->hexsz)
 		return -1;
 
 	memset(ds, 0, sizeof(*ds));
@@ -576,6 +576,8 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
 	struct object_id oid_ret;
+	const unsigned hexsz = the_hash_algo->hexsz;
+
 	if (len < 0) {
 		unsigned long count = approximate_object_count();
 		/*
@@ -599,8 +601,8 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	}
 
 	oid_to_hex_r(hex, oid);
-	if (len == GIT_SHA1_HEXSZ || !len)
-		return GIT_SHA1_HEXSZ;
+	if (len == hexsz || !len)
+		return hexsz;
 
 	mad.init_len = len;
 	mad.cur_len = len;
@@ -706,7 +708,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 	int refs_found = 0;
 	int at, reflog_len, nth_prior = 0;
 
-	if (len == GIT_SHA1_HEXSZ && !get_oid_hex(str, oid)) {
+	if (len == the_hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
 			refs_found = dwim_ref(str, len, &tmp_oid, &real_ref);
 			if (refs_found > 0) {
@@ -750,7 +752,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 		int detached;
 
 		if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
-			detached = (buf.len == GIT_SHA1_HEXSZ && !get_oid_hex(buf.buf, oid));
+			detached = (buf.len == the_hash_algo->hexsz && !get_oid_hex(buf.buf, oid));
 			strbuf_release(&buf);
 			if (detached)
 				return 0;
