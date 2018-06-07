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
	by dcvr.yhbt.net (Postfix) with ESMTP id B19351F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932868AbeFGOEA (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:00 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36646 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932865AbeFGOD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:58 -0400
Received: by mail-qk0-f194.google.com with SMTP id a195-v6so6611432qkg.3
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hS5kCwNBXDgE286+RJZMTUkQgUskV2IRc19pjJlL4PA=;
        b=COz0tCKGoLZmUCbOH/DdVxDWumYtDJye0SrDWzyYnKGmxNbp/c1txhJg5yqEsgAnTd
         fhTuPMMy1PY0K1LZF6cPVyzizXdcZV0GkK+fRA2wAG2nkkR6dZDe+sk3rTe8cegUKha0
         TzQH8cXstUuna+BQ4V7RYSCKIQu5u9H0uOyHsQjNKl3C8tXoYmMTFhpCCM5bH4aNepQs
         52oiHkmwwc8w8Tn5+K6Cu9JhEgH5QISvFRgqw3FN/HnP1vQzrLcwiMJUFKjbUDFTBABl
         +Ny0WLod47kF2GseZMMKW/eUyeOYSIJBfNf0s9x7HtfJDQVjGyayP0NJ4zliyM419OZi
         5Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hS5kCwNBXDgE286+RJZMTUkQgUskV2IRc19pjJlL4PA=;
        b=s58HLKNBuWbzECQ4urjk03QLnRTJWlrosR8QtKSUFDb5tQGpAjYX+mbgmD2LluOC9M
         MopSnbdE+plyS9Qnumt5G8gjER7n/J/VXW+wKiIiqSovn9Kb2Ub6jCfzQ+hIDvMfCfC5
         E9+EHb9gC6wnOJ2d0Z00+NritFs5Xl66KVIpHZUHpi/61LHqntPLL+vRNdbMzpmNykdO
         hYfKm1+gAvRuBzrFNLFSkwNYKFwKm/mrrxQ/Tnwewe1AxtSCy0AlhtAKdIArxlcAx+YN
         DmnZIfD8pXsVqrThQlrQVGp+PyMQkWk4P+Hru3t1WvccTCOrXBiyWO0aYS99ikNmozim
         5eOw==
X-Gm-Message-State: APt69E0ypTVc6guBt3mgzrmSbk6YvD05HaD/m9dmMW6h73qWIO+2guEZ
        /GSNLgKtO12PtyIw4ngFV1xnYJG2
X-Google-Smtp-Source: ADUXVKIAYzvsjXQO3ZqyBBHDCBtCcMDlxWeIu9lrO/3Qk5nEuJmhECBBoyD1ZaNPMlPBymAVO0OJ5Q==
X-Received: by 2002:a37:af05:: with SMTP id y5-v6mr1599027qke.55.1528380237341;
        Thu, 07 Jun 2018 07:03:57 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:56 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 12/23] midx: write object ids in a chunk
Date:   Thu,  7 Jun 2018 10:03:27 -0400
Message-Id: <20180607140338.32440-13-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |  4 ++
 builtin/midx.c                          |  2 +
 midx.c                                  | 50 +++++++++++++++++++++++--
 object-store.h                          |  1 +
 t/t5319-midx.sh                         |  4 +-
 5 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 29bf87283a..de9ac778b6 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -307,6 +307,10 @@ CHUNK DATA:
 	    name. This is the only chunk not guaranteed to be a multiple of four
 	    bytes in length, so should be the last chunk for alignment reasons.
 
+	OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
+	    The OIDs for all objects in the MIDX are stored in lexicographic
+	    order in this chunk.
+
 	(This section intentionally left incomplete.)
 
 TRAILER:
diff --git a/builtin/midx.c b/builtin/midx.c
index 3a261e9bbf..86edd30174 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -35,6 +35,8 @@ static int read_midx_file(const char *object_dir)
 		printf(" pack_lookup");
 	if (m->chunk_pack_names)
 		printf(" pack_names");
+	if (m->chunk_oid_lookup)
+		printf(" oid_lookup");
 
 	printf("\n");
 
diff --git a/midx.c b/midx.c
index b20d52713c..d06bc6876a 100644
--- a/midx.c
+++ b/midx.c
@@ -14,10 +14,11 @@
 #define MIDX_HASH_LEN 20
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
-#define MIDX_MAX_CHUNKS 2
+#define MIDX_MAX_CHUNKS 3
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKLOOKUP 0x504c4f4f /* "PLOO" */
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
+#define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
 
 static char *get_midx_filename(const char *object_dir)
@@ -95,6 +96,10 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 				m->chunk_pack_names = m->data + chunk_offset;
 				break;
 
+			case MIDX_CHUNKID_OIDLOOKUP:
+				m->chunk_oid_lookup = m->data + chunk_offset;
+				break;
+
 			case 0:
 				die("terminating MIDX chunk id appears earlier than expected");
 				break;
@@ -112,6 +117,8 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 		die("MIDX missing required pack lookup chunk");
 	if (!m->chunk_pack_names)
 		die("MIDX missing required pack-name chunk");
+	if (!m->chunk_oid_lookup)
+		die("MIDX missing required OID lookup chunk");
 
 	m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
 	for (i = 0; i < m->num_packs; i++) {
@@ -370,6 +377,32 @@ static size_t write_midx_pack_names(struct hashfile *f,
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
@@ -389,6 +422,7 @@ int write_midx_file(const char *object_dir)
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
+	struct pack_midx_entry *entries;
 	uint32_t nr_entries;
 
 	midx_name = get_midx_filename(object_dir);
@@ -448,14 +482,14 @@ int write_midx_file(const char *object_dir)
 	ALLOC_ARRAY(pack_perm, nr_packs);
 	sort_packs_by_name(pack_names, nr_packs, pack_perm);
 
-	get_sorted_entries(packs, pack_perm, nr_packs, &nr_entries);
+	entries = get_sorted_entries(packs, pack_perm, nr_packs, &nr_entries);
 
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
 	cur_chunk = 0;
-	num_chunks = 2;
+	num_chunks = 3;
 
 	written = write_midx_header(f, num_chunks, nr_packs);
 
@@ -467,9 +501,13 @@ int write_midx_file(const char *object_dir)
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_packs * sizeof(uint32_t);
 
 	cur_chunk++;
-	chunk_ids[cur_chunk] = 0;
+	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
 
+	cur_chunk++;
+	chunk_ids[cur_chunk] = 0;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_HASH_LEN;
+
 	for (i = 0; i <= num_chunks; i++) {
 		if (i && chunk_offsets[i] < chunk_offsets[i - 1])
 			BUG("incorrect chunk offsets: %"PRIu64" before %"PRIu64,
@@ -503,6 +541,10 @@ int write_midx_file(const char *object_dir)
 				written += write_midx_pack_names(f, pack_names, nr_packs);
 				break;
 
+			case MIDX_CHUNKID_OIDLOOKUP:
+				written += write_midx_oid_lookup(f, MIDX_HASH_LEN, entries, nr_entries);
+				break;
+
 			default:
 				BUG("trying to write unknown chunk id %"PRIx32,
 				    chunk_ids[i]);
diff --git a/object-store.h b/object-store.h
index 1ba50459ca..7d14d3586e 100644
--- a/object-store.h
+++ b/object-store.h
@@ -102,6 +102,7 @@ struct midxed_git {
 
 	const uint32_t *chunk_pack_lookup;
 	const unsigned char *chunk_pack_names;
+	const unsigned char *chunk_oid_lookup;
 
 	const char **pack_names;
 	char object_dir[FLEX_ARRAY];
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index a31c387c8f..e71aa52b80 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -6,8 +6,8 @@ test_description='multi-pack-indexes'
 midx_read_expect() {
 	NUM_PACKS=$1
 	cat >expect <<- EOF
-	header: 4d494458 1 1 2 $NUM_PACKS
-	chunks: pack_lookup pack_names
+	header: 4d494458 1 1 3 $NUM_PACKS
+	chunks: pack_lookup pack_names oid_lookup
 	packs:
 	EOF
 	if [ $NUM_PACKS -ge 1 ]
-- 
2.18.0.rc1

