Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C30C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiETXR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354012AbiETXRx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:17:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2CF1A29C6
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:46 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id m1so8901686qkn.10
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P+Hq+TxYueHz3mILps4sx45Lxjp1F6wSHdMmiOm9nUM=;
        b=OexmsDDGsXEUnNgmgmycqB9lL0pokIJSgH7OzBlX4J1pXix/TRM5gw//WJOmg6AfFH
         HTMjTcf3xR1NYfooydsvHp4wu9bKwQLllWaCG2jttJSO1uj07jccJhWbWHnDjSbxkuVk
         RwAabA6H51+3sadKvEtHVTjxOZEjmKmj6U8vFtKIuSxUYw1vXvFc2vGYT/q9hUaZNzf3
         GRFS8ceYI5Pwz/psVgztrHgzqpynQLKIG2jAvnPflNS3fc1VGlPyZhbV9h2c56g91zvl
         JZdbdIkbKewzrcQaj2FGxa6opKSBnYzvNBNi52SyPTRNZEj7ULp+oOpOajJvUtL7nYeH
         SFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+Hq+TxYueHz3mILps4sx45Lxjp1F6wSHdMmiOm9nUM=;
        b=hzjLqlW4Ens5MVobW6bQWwCWB/Z9mctXoW2XSSPJoiAWE9alxS9/dgrd5ea+M2ALFD
         cIiiuaBnO4VT0wE93Dl/Kcw0Lvj+AsYsIqqudTkpqIKRZdy6Ca5gyocS2Bbzrd0zPrnJ
         AX8G75EZh9KqCKIH3z5nHpAehVoEUDzDOcs6KKWQTNCogtc9ARRgaxLAvvoNkTSFxpZs
         pHhObrPJdmL4eeGbbPFj0zFav2u99apqpiLCoS48PurQO5CZ3d/MdAmNBJyprcIiGSV/
         YjjUJGV1SB1ANkNjGVr1AogsGRI29ZqqGdutmRXhrnUp1+GesnGPSsxox5vJ7hUCxgpg
         3wTw==
X-Gm-Message-State: AOAM530KfDigVe7QzbhsMClUTKP8CQe2tiwYw8LbdLZA8atoVtMHLlIh
        2P84GhOrKbMsGftXnW57P/CSBiX43GIJm0wI
X-Google-Smtp-Source: ABdhPJyc01iCsWVxceh71ogFX0GCukbfj3g5bkaTCUKvDjUR/akjVtqJXzFXtFj+B0r5PLR1KvMV4w==
X-Received: by 2002:a37:9c01:0:b0:6a3:51f9:10a7 with SMTP id f1-20020a379c01000000b006a351f910a7mr2567159qke.242.1653088665230;
        Fri, 20 May 2022 16:17:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cj19-20020a05622a259300b002f39b99f6aasm471566qtb.68.2022.05.20.16.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:17:44 -0700 (PDT)
Date:   Fri, 20 May 2022 19:17:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 05/17] pack-mtimes: support writing pack .mtimes files
Message-ID: <788d1f96f22323f93dec8cf37385865984eb246b.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the `.mtimes` format is defined, supplement the pack-write API
to be able to conditionally write an `.mtimes` file along with a pack by
setting an additional flag and passing an oidmap that contains the
timestamps corresponding to each object in the pack.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-objects.c |  6 ++++
 pack-objects.h | 25 ++++++++++++++++
 pack-write.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++
 pack.h         |  1 +
 4 files changed, 109 insertions(+)

diff --git a/pack-objects.c b/pack-objects.c
index fe2a4eace9..272e8d4517 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -170,6 +170,9 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 		if (pdata->layer)
 			REALLOC_ARRAY(pdata->layer, pdata->nr_alloc);
+
+		if (pdata->cruft_mtime)
+			REALLOC_ARRAY(pdata->cruft_mtime, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
@@ -198,6 +201,9 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 	if (pdata->layer)
 		pdata->layer[pdata->nr_objects - 1] = 0;
 
+	if (pdata->cruft_mtime)
+		pdata->cruft_mtime[pdata->nr_objects - 1] = 0;
+
 	return new_entry;
 }
 
diff --git a/pack-objects.h b/pack-objects.h
index dca2351ef9..393b9db546 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -168,6 +168,14 @@ struct packing_data {
 	/* delta islands */
 	unsigned int *tree_depth;
 	unsigned char *layer;
+
+	/*
+	 * Used when writing cruft packs.
+	 *
+	 * Object mtimes are stored in pack order when writing, but
+	 * written out in lexicographic (index) order.
+	 */
+	uint32_t *cruft_mtime;
 };
 
 void prepare_packing_data(struct repository *r, struct packing_data *pdata);
@@ -289,4 +297,21 @@ static inline void oe_set_layer(struct packing_data *pack,
 	pack->layer[e - pack->objects] = layer;
 }
 
+static inline uint32_t oe_cruft_mtime(struct packing_data *pack,
+				      struct object_entry *e)
+{
+	if (!pack->cruft_mtime)
+		return 0;
+	return pack->cruft_mtime[e - pack->objects];
+}
+
+static inline void oe_set_cruft_mtime(struct packing_data *pack,
+				      struct object_entry *e,
+				      uint32_t mtime)
+{
+	if (!pack->cruft_mtime)
+		CALLOC_ARRAY(pack->cruft_mtime, pack->nr_alloc);
+	pack->cruft_mtime[e - pack->objects] = mtime;
+}
+
 #endif
diff --git a/pack-write.c b/pack-write.c
index 27b171e440..23c0342018 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -3,6 +3,10 @@
 #include "csum-file.h"
 #include "remote.h"
 #include "chunk-format.h"
+#include "pack-mtimes.h"
+#include "oidmap.h"
+#include "chunk-format.h"
+#include "pack-objects.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -277,6 +281,70 @@ const char *write_rev_file_order(const char *rev_name,
 	return rev_name;
 }
 
+static void write_mtimes_header(struct hashfile *f)
+{
+	hashwrite_be32(f, MTIMES_SIGNATURE);
+	hashwrite_be32(f, MTIMES_VERSION);
+	hashwrite_be32(f, oid_version(the_hash_algo));
+}
+
+/*
+ * Writes the object mtimes of "objects" for use in a .mtimes file.
+ * Note that objects must be in lexicographic (index) order, which is
+ * the expected ordering of these values in the .mtimes file.
+ */
+static void write_mtimes_objects(struct hashfile *f,
+				 struct packing_data *to_pack,
+				 struct pack_idx_entry **objects,
+				 uint32_t nr_objects)
+{
+	uint32_t i;
+	for (i = 0; i < nr_objects; i++) {
+		struct object_entry *e = (struct object_entry*)objects[i];
+		hashwrite_be32(f, oe_cruft_mtime(to_pack, e));
+	}
+}
+
+static void write_mtimes_trailer(struct hashfile *f, const unsigned char *hash)
+{
+	hashwrite(f, hash, the_hash_algo->rawsz);
+}
+
+static const char *write_mtimes_file(const char *mtimes_name,
+				     struct packing_data *to_pack,
+				     struct pack_idx_entry **objects,
+				     uint32_t nr_objects,
+				     const unsigned char *hash)
+{
+	struct hashfile *f;
+	int fd;
+
+	if (!to_pack)
+		BUG("cannot call write_mtimes_file with NULL packing_data");
+
+	if (!mtimes_name) {
+		struct strbuf tmp_file = STRBUF_INIT;
+		fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
+		mtimes_name = strbuf_detach(&tmp_file, NULL);
+	} else {
+		unlink(mtimes_name);
+		fd = xopen(mtimes_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+	}
+	f = hashfd(fd, mtimes_name);
+
+	write_mtimes_header(f);
+	write_mtimes_objects(f, to_pack, objects, nr_objects);
+	write_mtimes_trailer(f, hash);
+
+	if (adjust_shared_perm(mtimes_name) < 0)
+		die(_("failed to make %s readable"), mtimes_name);
+
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_CLOSE | CSUM_FSYNC);
+
+	return mtimes_name;
+}
+
 off_t write_pack_header(struct hashfile *f, uint32_t nr_entries)
 {
 	struct pack_header hdr;
@@ -479,6 +547,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 char **idx_tmp_name)
 {
 	const char *rev_tmp_name = NULL;
+	const char *mtimes_tmp_name = NULL;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -491,9 +560,17 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
 				      pack_idx_opts->flags);
 
+	if (pack_idx_opts->flags & WRITE_MTIMES) {
+		mtimes_tmp_name = write_mtimes_file(NULL, to_pack, written_list,
+						    nr_written,
+						    hash);
+	}
+
 	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
 	if (rev_tmp_name)
 		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
+	if (mtimes_tmp_name)
+		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
 }
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
diff --git a/pack.h b/pack.h
index fd27cfdfd7..01d385903a 100644
--- a/pack.h
+++ b/pack.h
@@ -44,6 +44,7 @@ struct pack_idx_option {
 #define WRITE_IDX_STRICT 02
 #define WRITE_REV 04
 #define WRITE_REV_VERIFY 010
+#define WRITE_MTIMES 020
 
 	uint32_t version;
 	uint32_t off32_limit;
-- 
2.36.1.94.gb0d54bedca

