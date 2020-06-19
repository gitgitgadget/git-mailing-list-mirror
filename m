Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A94C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1920776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="B2/E94yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405240AbgFSR5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39652 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbgFSR45 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 30E2060A6B;
        Fri, 19 Jun 2020 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589380;
        bh=lgxPzgzAwkZLununwCcPrRYoAXzLeH7+ltMQ+PAhsc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=B2/E94yvkbc4Fb0bCF4UypBGEf6Lhj4HT0bP7DEqpqfKMK9UnWrUsucXFNkDbA0PP
         jOp/3r5mk5HMEzYSbBElAYol3F+4QsJ6ITZP26pATwm6S+GTTLgejICpFwAQ9RRVJ5
         /N3xBXT8NntRytwrL6epSEy1zLPQlzw03T5we645dmJqqPQR3LLOVFvPz8YXVDTFz7
         angFfUKnq04LP4yhxmrWNpkveVJsA7+t1AkaTDOpCvM1nmGPrOLFg8HxSfYHxGHctt
         ElHYRiEViqWrCl2DjK9MG7x59TGoFbUmvppifwF2uRannlBdRdU+Za2yOVLUznZkZn
         899GQ8Tg+w6o8ueG8q8zugW1353FhETpXRxSSvp2SSnrWxF677D7w/3pHqUqQrgnad
         qTCqQ7+kNV8uZRl+0Pyk7Gh9+11V1SXT9DvGVzP6XqtXz9Dq/8MECtl6L3hJt0BnET
         l5ndn7NWYk8x+n1DDKwK9lyqU+vzE5i43l7yABjHMxxTEkD+aBF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 14/44] connect: detect algorithm when fetching refs
Date:   Fri, 19 Jun 2020 17:55:31 +0000
Message-Id: <20200619175601.569856-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we're fetching refs, detect the hash algorithm and parse the refs
using that algorithm.

As mentioned in the documentation, if multiple versions of the
object-format capability are provided, we use the first.  No known
implementation supports multiple algorithms now, but they may in the
future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index 8f70a05699..b6e110cb24 100644
--- a/connect.c
+++ b/connect.c
@@ -221,12 +221,25 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 
 static void process_capabilities(struct packet_reader *reader, int *linelen)
 {
+	const char *feat_val;
+	int feat_len;
 	const char *line = reader->line;
 	int nul_location = strlen(line);
 	if (nul_location == *linelen)
 		return;
 	server_capabilities_v1 = xstrdup(line + nul_location + 1);
 	*linelen = nul_location;
+
+	feat_val = server_feature_value("object-format", &feat_len);
+	if (feat_val) {
+		char *hash_name = xstrndup(feat_val, feat_len);
+		int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo != GIT_HASH_UNKNOWN)
+			reader->hash_algo = &hash_algos[hash_algo];
+		free(hash_name);
+	} else {
+		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	}
 }
 
 static int process_dummy_ref(const struct packet_reader *reader)
@@ -235,7 +248,7 @@ static int process_dummy_ref(const struct packet_reader *reader)
 	struct object_id oid;
 	const char *name;
 
-	if (parse_oid_hex(line, &oid, &name))
+	if (parse_oid_hex_algop(line, &oid, &name, reader->hash_algo))
 		return 0;
 	if (*name != ' ')
 		return 0;
@@ -259,7 +272,7 @@ static int process_ref(const struct packet_reader *reader, int len,
 	struct object_id old_oid;
 	const char *name;
 
-	if (parse_oid_hex(line, &old_oid, &name))
+	if (parse_oid_hex_algop(line, &old_oid, &name, reader->hash_algo))
 		return 0;
 	if (*name != ' ')
 		return 0;
@@ -271,7 +284,7 @@ static int process_ref(const struct packet_reader *reader, int len,
 		die(_("protocol error: unexpected capabilities^{}"));
 	} else if (check_ref(name, flags)) {
 		struct ref *ref = alloc_ref(name);
-		oidcpy(&ref->old_oid, &old_oid);
+		memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
 		**list = ref;
 		*list = &ref->next;
 	}
@@ -289,7 +302,7 @@ static int process_shallow(const struct packet_reader *reader, int len,
 	if (!skip_prefix(line, "shallow ", &arg))
 		return 0;
 
-	if (get_oid_hex(arg, &old_oid))
+	if (get_oid_hex_algop(arg, &old_oid, reader->hash_algo))
 		die(_("protocol error: expected shallow sha-1, got '%s'"), arg);
 	if (!shallow_points)
 		die(_("repository on the other end cannot be shallow"));
