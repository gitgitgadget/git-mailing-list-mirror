Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FFEE1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934481AbeFYOfV (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36439 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934471AbeFYOfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:18 -0400
Received: by mail-qt0-f195.google.com with SMTP id o9-v6so12108928qtp.3
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TAQCcYbVk06kd6ccTvJkx1XUkkOmnBNfhAzrAIh2/zA=;
        b=DqqDhNmwkbvRl7h/4U7SXGJ5eAZcRTOWNUQLvhIgsj9k5E5k6qomcmt7V4XidcvG+X
         rIA+SMiS1MoqzJGR3W+cmXGAx3F0Tx5G4yo4K+VgqCxBcsA63TUqkgokOvq4Wx3VNnsv
         SeN6pYRcb5mK46R+uWMgC3qkZEV61/b8/M2npe9iRA+OY3e+p+f0xVvraWQPiSc448zE
         gAT7gRacwQZTi9JjRijK2CcS/uh8zE/zftbjK62K0M5hhUHONwJyw1S9mSeAeUxd76Ft
         fcVL/tVppu8rJXSr5LkXMe1VrmD6KQqJ7XwoUBgdFxo9+Gw03QkeBqRkzMc9neNLNwvT
         htcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TAQCcYbVk06kd6ccTvJkx1XUkkOmnBNfhAzrAIh2/zA=;
        b=Pw/0pbbTMHS3BBNejU/n9xa8tBLg9hSpBewpXz+u8lWK+TUiv3PQdxOZztzGCqFZSd
         8kfTZ6zGh4UnWd+WsdV8s9eZWZ+FmiiVutq8ZjST9bAPBXG5hm3dgZyN/CgcWS5IUT8V
         X7ZoceypjTqTXZjoU2aqPEQf6MVYC9fq4iCtWsEKnVA+My4pkyG8jGOJbjhMqSt+JK6d
         nlLDrHSbNWQ+I45nKJkcS8wd2PfeGe1ML1Ly8BJ6qG/aLHVfGCMBkHn1xcG3ycbvWBeZ
         yq/GpY0HlYH6cB6iVvYelk0kwVF5CrJvhLNoEcRLXSIdpwRgbGlVU2TlQ/yc2PBgfmfV
         Y9Iw==
X-Gm-Message-State: APt69E35L7RFoSJPVxrreBeVPVabv3Szu4jif73JZDjzqGL/V2MX+hO0
        IlUeSQwIQq2d779tNgQOC6oz+wFd
X-Google-Smtp-Source: ADUXVKIn3+LbBhJO9c7nO5BsGzi++1+fRlEz8grX7zU42A3GXtHC9CjSUu7zqXnJW5UVv6rrWCNJYw==
X-Received: by 2002:ac8:5203:: with SMTP id r3-v6mr9002051qtn.11.1529937317719;
        Mon, 25 Jun 2018 07:35:17 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:16 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 13/24] midx: write object ids in a chunk
Date:   Mon, 25 Jun 2018 10:34:23 -0400
Message-Id: <20180625143434.89044-14-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |  4 ++
 midx.c                                  | 51 ++++++++++++++++++++++---
 object-store.h                          |  1 +
 t/helper/test-read-midx.c               |  2 +
 t/t5319-multi-pack-index.sh             |  4 +-
 5 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 6c5a77475f..78ee0489c6 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -302,6 +302,10 @@ CHUNK DATA:
 	    name. This is the only chunk not guaranteed to be a multiple of four
 	    bytes in length, so should be the last chunk for alignment reasons.
 
+	OID Lookup (ID: {'O', 'I', 'D', 'L'})
+	    The OIDs for all objects in the MIDX are stored in lexicographic
+	    order in this chunk.
+
 	(This section intentionally left incomplete.)
 
 TRAILER:
diff --git a/midx.c b/midx.c
index 648a501d74..aec85b8181 100644
--- a/midx.c
+++ b/midx.c
@@ -14,9 +14,10 @@
 #define MIDX_HASH_LEN 20
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
-#define MIDX_MAX_CHUNKS 1
+#define MIDX_MAX_CHUNKS 2
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
+#define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
 
 static char *get_midx_filename(const char *object_dir)
@@ -102,6 +103,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 				m->chunk_pack_names = m->data + chunk_offset;
 				break;
 
+			case MIDX_CHUNKID_OIDLOOKUP:
+				m->chunk_oid_lookup = m->data + chunk_offset;
+				break;
+
 			case 0:
 				die(_("terminating multi-pack-index chunk id appears earlier than expected"));
 				break;
@@ -117,6 +122,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 
 	if (!m->chunk_pack_names)
 		die(_("multi-pack-index missing required pack-name chunk"));
+	if (!m->chunk_oid_lookup)
+		die(_("multi-pack-index missing required OID lookup chunk"));
 
 	m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
 
@@ -127,7 +134,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 		cur_pack_name += strlen(cur_pack_name) + 1;
 
 		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0) {
-			error("MIDX pack names out of order: '%s' before '%s'",
+			error(_("multi-pack-index pack names out of order: '%s' before '%s'"),
 			      m->pack_names[i - 1],
 			      m->pack_names[i]);
 			goto cleanup_fail;
@@ -394,6 +401,32 @@ static size_t write_midx_pack_names(struct hashfile *f,
 	return written;
 }
 
+static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
+				    struct pack_midx_entry *objects,
+				    uint32_t nr_objects)
+{
+	struct pack_midx_entry *list = objects;
+	uint32_t i;
+	size_t written = 0;
+
+	for (i = 0; i < nr_objects; i++) {
+		struct pack_midx_entry *obj = list++;
+
+		if (i < nr_objects - 1) {
+			struct pack_midx_entry *next = list;
+			if (oidcmp(&obj->oid, &next->oid) >= 0)
+				BUG("OIDs not in order: %s >= %s",
+				oid_to_hex(&obj->oid),
+				oid_to_hex(&next->oid));
+		}
+
+		hashwrite(f, obj->oid.hash, (int)hash_len);
+		written += hash_len;
+	}
+
+	return written;
+}
+
 int write_midx_file(const char *object_dir)
 {
 	unsigned char cur_chunk, num_chunks = 0;
@@ -407,7 +440,7 @@ int write_midx_file(const char *object_dir)
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
 	uint32_t nr_entries;
-	struct pack_midx_entry *entries;
+	struct pack_midx_entry *entries = NULL;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -440,7 +473,7 @@ int write_midx_file(const char *object_dir)
 	FREE_AND_NULL(midx_name);
 
 	cur_chunk = 0;
-	num_chunks = 1;
+	num_chunks = 2;
 
 	written = write_midx_header(f, num_chunks, packs.nr);
 
@@ -448,9 +481,13 @@ int write_midx_file(const char *object_dir)
 	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
 
 	cur_chunk++;
-	chunk_ids[cur_chunk] = 0;
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + packs.pack_name_concat_len;
 
+	cur_chunk++;
+	chunk_ids[cur_chunk] = 0;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_HASH_LEN;
+
 	for (i = 0; i <= num_chunks; i++) {
 		if (i && chunk_offsets[i] < chunk_offsets[i - 1])
 			BUG("incorrect chunk offsets: %"PRIu64" before %"PRIu64,
@@ -480,6 +517,10 @@ int write_midx_file(const char *object_dir)
 				written += write_midx_pack_names(f, packs.names, packs.nr);
 				break;
 
+			case MIDX_CHUNKID_OIDLOOKUP:
+				written += write_midx_oid_lookup(f, MIDX_HASH_LEN, entries, nr_entries);
+				break;
+
 			default:
 				BUG("trying to write unknown chunk id %"PRIx32,
 				    chunk_ids[i]);
diff --git a/object-store.h b/object-store.h
index 88169b33e9..25f8530eb4 100644
--- a/object-store.h
+++ b/object-store.h
@@ -98,6 +98,7 @@ struct multi_pack_index {
 	uint32_t num_objects;
 
 	const unsigned char *chunk_pack_names;
+	const unsigned char *chunk_oid_lookup;
 
 	const char **pack_names;
 	char object_dir[FLEX_ARRAY];
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 0b53a9e8b5..60bca5b668 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -25,6 +25,8 @@ static int read_midx_file(const char *object_dir)
 
 	if (m->chunk_pack_names)
 		printf(" pack_names");
+	if (m->chunk_oid_lookup)
+		printf(" oid_lookup");
 
 	printf("\n");
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 800fa7749c..47e1c7d99e 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -6,8 +6,8 @@ test_description='multi-pack-indexes'
 midx_read_expect() {
 	NUM_PACKS=$1
 	cat >expect <<- EOF
-	header: 4d494458 1 1 $NUM_PACKS
-	chunks: pack_names
+	header: 4d494458 1 2 $NUM_PACKS
+	chunks: pack_names oid_lookup
 	packs:
 	EOF
 	if [ $NUM_PACKS -ge 1 ]
-- 
2.18.0.24.g1b579a2ee9

