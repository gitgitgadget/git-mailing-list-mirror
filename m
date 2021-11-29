Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46ECC433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhK2W3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhK2W24 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:56 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1484DC09676B
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:17 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id z8so8981692ilu.7
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l9odbvWx1JTYqAjkhRRCS7ssyYnU3S9crqggWqJVCnU=;
        b=bLVTrX/c9517M8f/QuZxATrTnlRrY9S3y8Ch0SEAWVz75l0YXpEqbmeIzoyznewPNq
         7B9oPxZ70f+inltUAowDIq5Pbgg+qewSYOHbFb57ZSsaFxpT607l7RNmmRF5A7Yrq4Np
         iwnyWwuQL/U+SyzKj5XpG21yIZ64fstdAzZNurFxxO12pPz5JVcMhwr+wRpinX8IX+J+
         DGP8M38BxcdK982QpEd3/BOl9qdhaVQLvHTBuKPZvYB8Ns3+88cA7cDCMsDZn7Rak5pk
         RWVVAJkawcGyko09ZBr+NfkOaUeBxW8RahYsC13WmzOoTi/TWBcXPE1szcwi16R/FLJ6
         06tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l9odbvWx1JTYqAjkhRRCS7ssyYnU3S9crqggWqJVCnU=;
        b=Kl9YjNd1WMSo6uLZND5GMb5a3B+0fmQwGpoMfSF91aKJ15ozLub7Q8X+itgx+yTDrT
         QVUrm3vZLciyS12+BPBkJZL3+7ho3SuDdvxSf+0dGR1iZvWPjrJG4QO+aFFfFrJNwmkK
         R1JE3u9+looUoAWdvqfkh6+EUCjVpNQsIQEI8+eU6XIjzEQhJ6oFNPAi7lF4gZlXgK0X
         wl5AG6dlfSxxrQqHLz+jqRi8KWwmxE+d2yzmUvmbYI9rsYYntpDdBryiYqppVPs6GHB5
         4aJlVCXp//SlA2wjDRQoQUoK8WT1RWiF+HAkyk6DB7sukt8JLcTgiaCmwvoB/RVejiSu
         VFrQ==
X-Gm-Message-State: AOAM533TmHzlX9DWVQIxxMP1v+fL/UUvmtzvSWV2wuIgLan8Rzzo5PG4
        53Zb61lWIfDDggYSuNuTg+uNukcEW1ESUxYh
X-Google-Smtp-Source: ABdhPJyBsGChtD/LHuIr/utn0qvzXZYyM4QJ3tBKIGZT8zC7cP9ytmZjHmLw40AJGUEp47FTBSp5YA==
X-Received: by 2002:a05:6e02:1ca1:: with SMTP id x1mr29988218ill.72.1638224716320;
        Mon, 29 Nov 2021 14:25:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x13sm9099394ilp.43.2021.11.29.14.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:16 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 05/17] pack-mtimes: support writing pack .mtimes files
Message-ID: <deece9eb70e9750bb8350946679b521e59139fe2.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
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
 pack-objects.h | 20 ++++++++++++++
 pack-write.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 pack.h         |  1 +
 4 files changed, 101 insertions(+)

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
index dca2351ef9..f17119de26 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -168,6 +168,9 @@ struct packing_data {
 	/* delta islands */
 	unsigned int *tree_depth;
 	unsigned char *layer;
+
+	/* cruft packs */
+	uint32_t *cruft_mtime;
 };
 
 void prepare_packing_data(struct repository *r, struct packing_data *pdata);
@@ -289,4 +292,21 @@ static inline void oe_set_layer(struct packing_data *pack,
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
index ff305b404c..8c3efda2c3 100644
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
@@ -276,6 +280,65 @@ const char *write_rev_file_order(const char *rev_name,
 	return rev_name;
 }
 
+static void write_mtimes_header(struct hashfile *f)
+{
+	hashwrite_be32(f, MTIMES_SIGNATURE);
+	hashwrite_be32(f, MTIMES_VERSION);
+	hashwrite_be32(f, oid_version(the_hash_algo));
+}
+
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
+	if (mtimes_name && adjust_shared_perm(mtimes_name) < 0)
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
@@ -478,6 +541,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 char **idx_tmp_name)
 {
 	const char *rev_tmp_name = NULL;
+	const char *mtimes_tmp_name = NULL;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -490,9 +554,19 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
 				      pack_idx_opts->flags);
 
+	if (pack_idx_opts->flags & WRITE_MTIMES) {
+		mtimes_tmp_name = write_mtimes_file(NULL, to_pack, written_list,
+						    nr_written,
+						    hash);
+		if (adjust_shared_perm(mtimes_tmp_name))
+			die_errno("unable to make temporary mtimes file readable");
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
2.34.1.25.gb3157a20e6

