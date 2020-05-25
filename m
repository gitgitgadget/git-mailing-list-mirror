Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEEDC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339312073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JOIO/+uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390473AbgEYUAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390445AbgEYT76 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 78D0D60D16;
        Mon, 25 May 2020 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436797;
        bh=BrGE5IRK4iD22ojUaw6vyETbInj2RPhBRq6D/5gJkk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JOIO/+uBSwvVusO7yiGWK8pJQsl7TqzOuQQpkhyXUjJ4EyhSkznN5QSG9icbY17Ml
         v03v8uogRa7HS4DSSEA+jjQ5l61TPtnwTvSc+TCu3K1AJccbUseb6bucKf/TV+ohIi
         /4Cx7fFz+8Ajyrr8QtvCX4i9RNUnTzWTrFfi8VsK/C7Qtn/LyGdIB2uAg1N7Pi8NMI
         wICeBykPe1j5mdM9urhPB2IZDipyzZb6esrI6JcR1O7UGQCRaZ7If+kXi/nTi6hCyz
         kfVGzBI0fPC99Wh9vT8/t0YWHugkpzhmvxVXrTAwiLe2OtuukQMzEeEc/Pp2pQA0Iy
         ImOePx9h8ud6h/RvM4RhSF5hj1KeZYiJz8ziB+gpdZQiDoOdN+zI0dUspUYrMnX722
         ltSTaebN3N6Fs4+OzySjHgBnMIJ218IvEtuhyZLV2+iK+eALtA8SsnaqEDooyNbxmy
         rogVSQSk78KDXc2jeOyVe7f5fpZgmmmRB1VrNNTJky1pFPQ38Th
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 34/44] remote-curl: detect algorithm for dumb HTTP by size
Date:   Mon, 25 May 2020 19:59:20 +0000
Message-Id: <20200525195930.309665-35-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading the info/refs file for a repository, we have no explicit
way to detect which hash algorithm is in use because the file doesn't
provide one. Detect the hash algorithm in use by the size of the first
object ID.

We anonymize the URL like elsewhere in the function in case the user has
decided to include a secret in the URL.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 3ed0dfec1b..617edfedf4 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -252,6 +252,19 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 	return list;
 }
 
+static const struct git_hash_algo *detect_hash_algo(struct discovery *heads)
+{
+	const char *p = memchr(heads->buf, '\t', heads->len);
+	int algo;
+	if (!p)
+		return NULL;
+
+	algo = hash_algo_by_length((p - heads->buf) / 2);
+	if (algo == GIT_HASH_UNKNOWN)
+		return NULL;
+	return &hash_algos[algo];
+}
+
 static struct ref *parse_info_refs(struct discovery *heads)
 {
 	char *data, *start, *mid;
@@ -262,6 +275,12 @@ static struct ref *parse_info_refs(struct discovery *heads)
 	struct ref *ref = NULL;
 	struct ref *last_ref = NULL;
 
+	options.hash_algo = detect_hash_algo(heads);
+	if (!options.hash_algo)
+		die("%sinfo/refs not valid: could not determine hash algorithm; "
+		    "is this a git repository?",
+		    transport_anonymize_url(url.buf));
+
 	data = heads->buf;
 	start = NULL;
 	mid = data;
@@ -272,13 +291,13 @@ static struct ref *parse_info_refs(struct discovery *heads)
 		if (data[i] == '\t')
 			mid = &data[i];
 		if (data[i] == '\n') {
-			if (mid - start != the_hash_algo->hexsz)
+			if (mid - start != options.hash_algo->hexsz)
 				die(_("%sinfo/refs not valid: is this a git repository?"),
 				    transport_anonymize_url(url.buf));
 			data[i] = 0;
 			ref_name = mid + 1;
 			ref = alloc_ref(ref_name);
-			get_oid_hex(start, &ref->old_oid);
+			get_oid_hex_algop(start, &ref->old_oid, options.hash_algo);
 			if (!refs)
 				refs = ref;
 			if (last_ref)
