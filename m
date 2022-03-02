Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F2C433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiCBA67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbiCBA6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:58:54 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E485E41329
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:11 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id t11so143080ioi.7
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P5GgWkN9cl8Xn1q1KDYUKB5PiHhKBc7Ki0Cn957yFXs=;
        b=4sJl2vzTwjblEivw+fzaLk+ffbmIxEdtzISxDfrqY4tlKykCtItp/u59y8QDPiYqon
         KksRvl2e0Qcv3oyupRVlcGBMZye0o5J2xlPTIHM/JZ3mHGlILeHrkFx4XXahFZku9H5w
         haaQZkpMVXB9204V663SWZOKSe3vD1LMyUpO95aw3ubmBoqBxnQ+GVJ3IguC0yE4sIVQ
         9+mRe58VB7dBV3ZRJ0T9ZTC3EYDBzMcB7GtqU7LIx9XtWPtIEi7CN3Nj8typ9FgqcrK3
         Y+n6KFNcyd7IJN6dEj68NC+HejY3DF9WfJgxm9XJ2IBd8esgfRFhg2ta3Dg1FzdORMbN
         ZTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P5GgWkN9cl8Xn1q1KDYUKB5PiHhKBc7Ki0Cn957yFXs=;
        b=1UXgeLXzXEEljlla3Zduv7Hm8wpP5Az7tQymjQzzkEL3oUlkNmy3Xl8aHTWlc+p1/a
         CltftyFuzIZ9sH8JD7XlW1QSm2ORVFpNc1hGltzEZK81kcd85x6HiDo1zMQHH5691I/h
         8wLXWv1QR6tgGG4v0Py+cEqqHRo0EkB2jP6Uq7/LVbvmHicu4YMij1Rl5NN/3upZF4+m
         cbxkLHAIDcczGJrgdhl5vMPZPzmIN7NVgYZoEFA8QXgzmFJ6hUthP8XyZEQhLlWZt979
         z8J+MtjhoUh0wtgMj8pSARNSOavHqEDL6ileYjFGn0+oU8BxD95ddQjWFa5YJqv0g2WQ
         4LkQ==
X-Gm-Message-State: AOAM530FP3TlExorm4fxD6Yw9pLdZ0K7bSnDS/QoeJwzya91PPka4aqP
        JTXWOHfQURJlapSJJrfOLvlBDtT4y9Qe1S4Z
X-Google-Smtp-Source: ABdhPJxLimPd2rlJ3aNvn7fkY5728+qC5ntWz8kaaTzdIFx1fKggu40obtSFFvo3zSQySCLOF1gvuA==
X-Received: by 2002:a05:6638:3f0a:b0:315:1190:ae9b with SMTP id ck10-20020a0566383f0a00b003151190ae9bmr24331238jab.210.1646182691186;
        Tue, 01 Mar 2022 16:58:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p12-20020a92d28c000000b002c29f97824dsm8606957ilp.48.2022.03.01.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:10 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 05/17] pack-mtimes: support writing pack .mtimes files
Message-ID: <5236490688213ff350b38f618ccb27f055300464.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
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
index ff305b404c..270280c4df 100644
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
@@ -276,6 +280,70 @@ const char *write_rev_file_order(const char *rev_name,
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
+	finalize_hashfile(f, NULL,
+			  CSUM_HASH_IN_STREAM | CSUM_CLOSE | CSUM_FSYNC);
+
+	return mtimes_name;
+}
+
 off_t write_pack_header(struct hashfile *f, uint32_t nr_entries)
 {
 	struct pack_header hdr;
@@ -478,6 +546,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 char **idx_tmp_name)
 {
 	const char *rev_tmp_name = NULL;
+	const char *mtimes_tmp_name = NULL;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -490,9 +559,17 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
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
2.35.1.73.gccc5557600

