Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA789C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 06:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJQGMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 02:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJQGMk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 02:12:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15522CDDB
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 23:12:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bv10so16878668wrb.4
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 23:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KButjAMEVwgwJlhsBD+VPrcPppp/og4b/oWsahd3wlY=;
        b=WniBp/OB4MCQV1xrFpsWUkLF2zzs4DRkZGDbqtMNgfX990O0NBgWM+fsB/UL7wSR25
         7N2HW3GY+lRUCe2DUw5a/tLil8BSAtkKo7Ma2i4pB8xOJf96yFql8ol34az/sDPIDIil
         jhhQB9cn6X8cQ/ezYkJoWW4SnnB5RkUOb0CnuTH5ze82uL4pO5x7hPCyABv6nA3MFUKN
         r85fuusmwP30FHgXg2VurpPddMypnSqEpiXiyt5SQvRAtnfNWH4m04OTrefKA6sjPhlX
         RlIKj+4C0DMF8lp78H9sogHwARK3FutT6qsC3ImJmQLcPDVCuAIIAod7INKSqZed6H9y
         JvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KButjAMEVwgwJlhsBD+VPrcPppp/og4b/oWsahd3wlY=;
        b=QLoybk09pMnnwbeoI6N7Dv0cDe5X7qr4YS/rgZmVy9WgFCZf3+jJ05++UfeDR4pJtj
         y9jW71dTG2FgyoaqXgUlzIa+GotnzDHGWDojAJimvas0j6SgAKlwbS/Z+r6QPPybGqWo
         W7fegI2A+OpSoFGEZJLFCdOb9TX/gBtSIjizQuH1V9rhhSo/Oqyivu9LkwXquHu1okLa
         OsW+e5MNMpHOeCuwfhgIiV6WSNfLQI1+55a2oAMLpZQbkhVkBqM7L6nF2HiwcnN/l9UG
         ji8gyUE5YEHKrnzNXeALy7yq7Y0NiHvVw0T1zPbtaa8YR4Nh71Qqr0ZMM6YL5OOv2ShY
         ihcw==
X-Gm-Message-State: ACrzQf2hP1igqsH2h0hZJELN+HVbx0FP3bJ5zgPBBr+RvflUTEYIZoiz
        nHSW2aFqw8ljnh2RTdinMhSMVaAGm4w=
X-Google-Smtp-Source: AMsMyM7xy7c/GsSP6dHhLYpUdS8kIw8I0AthestexkLG3wPv9N0YgWduCYhvBNiMNDxJpbPkGAfrNA==
X-Received: by 2002:a5d:4950:0:b0:230:cc5a:f6b0 with SMTP id r16-20020a5d4950000000b00230cc5af6b0mr5156824wrs.656.1665987158417;
        Sun, 16 Oct 2022 23:12:38 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05600c1e2600b003b435c41103sm17172710wmb.0.2022.10.16.23.12.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 23:12:37 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] path.c: add_to_trie - possible global-buffer-overflow fixed
Message-ID: <d28ecc16-1e73-98bb-04e7-33f4f8986986@gmail.com>
Date:   Mon, 17 Oct 2022 08:12:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 4e09cf2ac (path: optimize common dir checking, 2015-08-31) a trie
is used to search over the common_list array.  The trie is formed from a
well-known list of values.  With the current implementation there can be
problems if the current values are rearranged or new values are
introduced.

This is fine:

	static const struct common_dir common_list[] = {
		{ 1, 1, 1, "logs" },
		{ 1, 0, 0, "logs/HEAD" },
		...

But this will lead to a global-buffer-overflow:

	static const struct common_dir common_list[] = {
		{ 1, 0, 0, "logs/HEAD" },
		{ 1, 1, 1, "logs" },
		...

And this will confuse and is probably a bug:

	static const struct common_dir common_list[] = {
		{ 1, 1, 1, "logs" },
		{ 0, 0, 0, "logs" },
		...

Let's fix the former and throw an assert on the latter.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 path.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/path.c b/path.c
index a3cfcd8a6e..a925cf073b 100644
--- a/path.c
+++ b/path.c
@@ -185,13 +185,6 @@ static void *add_to_trie(struct trie *root, const char *key, void *value)
 	void *old;
 	int i;
 
-	if (!*key) {
-		/* we have reached the end of the key */
-		old = root->value;
-		root->value = value;
-		return old;
-	}
-
 	for (i = 0; i < root->len; i++) {
 		if (root->contents[i] == key[i])
 			continue;
@@ -209,15 +202,17 @@ static void *add_to_trie(struct trie *root, const char *key, void *value)
 						   child->len);
 		}
 		child->value = root->value;
-		root->value = NULL;
+		root->value = key[i]
+			? NULL /* Key splits the compressed section. */
+			: value; /* Key matches up to here. */
 		root->len = i;
 
 		memset(root->children, 0, sizeof(root->children));
 		root->children[(unsigned char)root->contents[i]] = child;
 
-		/* This is the newly-added child. */
-		root->children[(unsigned char)key[i]] =
-			make_trie_node(key + i + 1, value);
+		if (key[i])
+			root->children[(unsigned char)key[i]] =
+				make_trie_node(key + i + 1, value);
 		return NULL;
 	}
 
@@ -233,6 +228,8 @@ static void *add_to_trie(struct trie *root, const char *key, void *value)
 		}
 	}
 
+	/* We have matched the entire compressed section with the entire key */
+	assert(!root->value); /* Key already present in the trie? */
 	old = root->value;
 	root->value = value;
 	return old;
-- 
2.36.1
