Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C961DC4332F
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiCCAVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiCCAVe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:21:34 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BC9F1EA2
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:20:48 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h28so2781079ila.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kHAKXZZd4Y/Nyp9Gd+4IEnLixhh5NWU0f8kupjKvR/o=;
        b=usgL3QYb8nfIFgE8NlNqT9BbodDDT2sXd5583/u9CPj1WXkFWsOS0zQnAllCToVo7b
         XgvOxCUgwca8ncazZ7ReZzHk6L3QDOTBOIs361bqd1QzZRcKailmRqQlubhnxx7mtiAC
         CrVtiZDdECo3bL9/8roh6CZUahUCtUXCMPoXp7v6zPK3o2EiqByx+HlTD4YH3y+Gk271
         YHz5Qkf/Fx5JymSIguDQ/nnERLr6no9Ky36S6WPFsvaPSbUKLz3NcHuMGXOYejbNWznx
         MjFCr1DS3Tge+B+o31r9RTmxkZ6PP02qWkirtXikj+WJ6ILOFc7jOTmZT1UZW90LZk0M
         WVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHAKXZZd4Y/Nyp9Gd+4IEnLixhh5NWU0f8kupjKvR/o=;
        b=iXs2VMCvJl4QZW3lkEC5Tg3bQU0xHACWJL8RUdcBhE7/QR8L5hmOKjTKmofZalJ83i
         QgqG4vylj7jV2tL31llnnTP3xo9hzX9jeXVNawechBOkh/GCrYGoYMWzzFl5G/BXwCxY
         eIuDPJEPpijusfgp5c3mSvb/MPSMT/QNFlTt5eUdJ5XgiF6qTj66wfpoceKtF+7043oq
         gNgwCKmoJozsQUuehJdI01oYhtyyYFJ6QBTnyKf1UxzU1ObdjaluIs/18iM/AVxMQbTD
         cOElwq3HG/Spjn7Q2w50a5+pCVS/O0op5g8bswq2+wbD9mTKKoqJMI6DXyEiNaSmQEJk
         18xw==
X-Gm-Message-State: AOAM5321NuBTI6nSC4KL558pwdWuOUl7zMdqXAm8Lh5CkmCFjya8fIdH
        48VrzETVf8sPK8syVjl81mXvXF+DcFVGD37U
X-Google-Smtp-Source: ABdhPJzdvq/Zcem5YJ1neOxCakXBSBnp/kwfGAosSNnxKpuCd/dHV9BAOfB8m2pjjhd2sRbEjFXyEw==
X-Received: by 2002:a05:6e02:1489:b0:2c2:dffe:5c55 with SMTP id n9-20020a056e02148900b002c2dffe5c55mr16270855ilk.177.1646266847433;
        Wed, 02 Mar 2022 16:20:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j19-20020a92c213000000b002c25f2c33f1sm312195ilo.52.2022.03.02.16.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:20:47 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:20:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <1ec754ad1b5c1051b52acef6ec72c0464c0eabf0.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To store the individual mtimes of objects in a cruft pack, introduce a
new `.mtimes` format that can optionally accompany a single pack in the
repository.

The format is defined in Documentation/technical/pack-format.txt, and
stores a 4-byte network order timestamp for each object in name (index)
order.

This patch prepares for cruft packs by defining the `.mtimes` format,
and introducing a basic API that callers can use to read out individual
mtimes.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/pack-format.txt |  19 ++++
 Makefile                                |   1 +
 builtin/repack.c                        |   1 +
 object-store.h                          |   5 +-
 pack-mtimes.c                           | 126 ++++++++++++++++++++++++
 pack-mtimes.h                           |  15 +++
 packfile.c                              |  19 +++-
 7 files changed, 183 insertions(+), 3 deletions(-)
 create mode 100644 pack-mtimes.c
 create mode 100644 pack-mtimes.h

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 6d3efb7d16..c443dbb526 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -294,6 +294,25 @@ Pack file entry: <+
 
 All 4-byte numbers are in network order.
 
+== pack-*.mtimes files have the format:
+
+  - A 4-byte magic number '0x4d544d45' ('MTME').
+
+  - A 4-byte version identifier (= 1).
+
+  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
+
+  - A table of 4-byte unsigned integers in network order. The ith
+    value is the modification time (mtime) of the ith object in the
+    corresponding pack by lexicographic (index) order. The mtimes
+    count standard epoch seconds.
+
+  - A trailer, containing a checksum of the corresponding packfile,
+    and a checksum of all of the above (each having length according
+    to the specified hash function).
+
+All 4-byte numbers are in network order.
+
 == multi-pack-index (MIDX) files have the following format:
 
 The multi-pack-index files refer to multiple pack-files and loose objects.
diff --git a/Makefile b/Makefile
index 6f0b4b775f..1b186f4fd7 100644
--- a/Makefile
+++ b/Makefile
@@ -959,6 +959,7 @@ LIB_OBJS += oidtree.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
+LIB_OBJS += pack-mtimes.o
 LIB_OBJS += pack-objects.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
diff --git a/builtin/repack.c b/builtin/repack.c
index da1e364a75..f908f7d5dd 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -212,6 +212,7 @@ static struct {
 } exts[] = {
 	{".pack"},
 	{".rev", 1},
+	{".mtimes", 1},
 	{".bitmap", 1},
 	{".promisor", 1},
 	{".idx"},
diff --git a/object-store.h b/object-store.h
index 6f89482df0..9b227661f2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -115,12 +115,15 @@ struct packed_git {
 		 freshened:1,
 		 do_not_close:1,
 		 pack_promisor:1,
-		 multi_pack_index:1;
+		 multi_pack_index:1,
+		 is_cruft:1;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct revindex_entry *revindex;
 	const uint32_t *revindex_data;
 	const uint32_t *revindex_map;
 	size_t revindex_size;
+	const uint32_t *mtimes_map;
+	size_t mtimes_size;
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
 };
diff --git a/pack-mtimes.c b/pack-mtimes.c
new file mode 100644
index 0000000000..46ad584af1
--- /dev/null
+++ b/pack-mtimes.c
@@ -0,0 +1,126 @@
+#include "pack-mtimes.h"
+#include "object-store.h"
+#include "packfile.h"
+
+static char *pack_mtimes_filename(struct packed_git *p)
+{
+	size_t len;
+	if (!strip_suffix(p->pack_name, ".pack", &len))
+		BUG("pack_name does not end in .pack");
+	/* NEEDSWORK: this could reuse code from pack-revindex.c. */
+	return xstrfmt("%.*s.mtimes", (int)len, p->pack_name);
+}
+
+#define MTIMES_HEADER_SIZE (12)
+#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 * the_hash_algo->rawsz))
+
+struct mtimes_header {
+	uint32_t signature;
+	uint32_t version;
+	uint32_t hash_id;
+};
+
+static int load_pack_mtimes_file(char *mtimes_file,
+				 uint32_t num_objects,
+				 const uint32_t **data_p, size_t *len_p)
+{
+	int fd, ret = 0;
+	struct stat st;
+	void *data = NULL;
+	size_t mtimes_size;
+	struct mtimes_header header;
+	uint32_t *hdr;
+
+	fd = git_open(mtimes_file);
+
+	if (fd < 0) {
+		ret = -1;
+		goto cleanup;
+	}
+	if (fstat(fd, &st)) {
+		ret = error_errno(_("failed to read %s"), mtimes_file);
+		goto cleanup;
+	}
+
+	mtimes_size = xsize_t(st.st_size);
+
+	if (mtimes_size < MTIMES_MIN_SIZE) {
+		ret = error(_("mtimes file %s is too small"), mtimes_file);
+		goto cleanup;
+	}
+
+	if (mtimes_size - MTIMES_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {
+		ret = error(_("mtimes file %s is corrupt"), mtimes_file);
+		goto cleanup;
+	}
+
+	data = hdr = xmmap(NULL, mtimes_size, PROT_READ, MAP_PRIVATE, fd, 0);
+
+	header.signature = ntohl(hdr[0]);
+	header.version = ntohl(hdr[1]);
+	header.hash_id = ntohl(hdr[2]);
+
+	if (header.signature != MTIMES_SIGNATURE) {
+		ret = error(_("mtimes file %s has unknown signature"), mtimes_file);
+		goto cleanup;
+	}
+
+	if (header.version != 1) {
+		ret = error(_("mtimes file %s has unsupported version %"PRIu32),
+			    mtimes_file, header.version);
+		goto cleanup;
+	}
+
+	if (!(header.hash_id == 1 || header.hash_id == 2)) {
+		ret = error(_("mtimes file %s has unsupported hash id %"PRIu32),
+			    mtimes_file, header.hash_id);
+		goto cleanup;
+	}
+
+cleanup:
+	if (ret) {
+		if (data)
+			munmap(data, mtimes_size);
+	} else {
+		*len_p = mtimes_size;
+		*data_p = (const uint32_t *)data;
+	}
+
+	close(fd);
+	return ret;
+}
+
+int load_pack_mtimes(struct packed_git *p)
+{
+	char *mtimes_name = NULL;
+	int ret = 0;
+
+	if (!p->is_cruft)
+		return ret; /* not a cruft pack */
+	if (p->mtimes_map)
+		return ret; /* already loaded */
+
+	ret = open_pack_index(p);
+	if (ret < 0)
+		goto cleanup;
+
+	mtimes_name = pack_mtimes_filename(p);
+	ret = load_pack_mtimes_file(mtimes_name,
+				    p->num_objects,
+				    &p->mtimes_map,
+				    &p->mtimes_size);
+cleanup:
+	free(mtimes_name);
+	return ret;
+}
+
+uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos)
+{
+	if (!p->mtimes_map)
+		BUG("pack .mtimes file not loaded for %s", p->pack_name);
+	if (p->num_objects <= pos)
+		BUG("pack .mtimes out-of-bounds (%"PRIu32" vs %"PRIu32")",
+		    pos, p->num_objects);
+
+	return get_be32(p->mtimes_map + pos + 3);
+}
diff --git a/pack-mtimes.h b/pack-mtimes.h
new file mode 100644
index 0000000000..38ddb9f893
--- /dev/null
+++ b/pack-mtimes.h
@@ -0,0 +1,15 @@
+#ifndef PACK_MTIMES_H
+#define PACK_MTIMES_H
+
+#include "git-compat-util.h"
+
+#define MTIMES_SIGNATURE 0x4d544d45 /* "MTME" */
+#define MTIMES_VERSION 1
+
+struct packed_git;
+
+int load_pack_mtimes(struct packed_git *p);
+
+uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos);
+
+#endif
diff --git a/packfile.c b/packfile.c
index 835b2d2716..fc0245fbab 100644
--- a/packfile.c
+++ b/packfile.c
@@ -334,12 +334,22 @@ static void close_pack_revindex(struct packed_git *p)
 	p->revindex_data = NULL;
 }
 
+static void close_pack_mtimes(struct packed_git *p)
+{
+	if (!p->mtimes_map)
+		return;
+
+	munmap((void *)p->mtimes_map, p->mtimes_size);
+	p->mtimes_map = NULL;
+}
+
 void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
 	close_pack_fd(p);
 	close_pack_index(p);
 	close_pack_revindex(p);
+	close_pack_mtimes(p);
 	oidset_clear(&p->bad_objects);
 }
 
@@ -363,7 +373,7 @@ void close_object_store(struct raw_object_store *o)
 
 void unlink_pack_path(const char *pack_name, int force_delete)
 {
-	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor"};
+	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 	size_t plen;
@@ -718,6 +728,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	if (!access(p->pack_name, F_OK))
 		p->pack_promisor = 1;
 
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".mtimes");
+	if (!access(p->pack_name, F_OK))
+		p->is_cruft = 1;
+
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
@@ -869,7 +883,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	    ends_with(file_name, ".pack") ||
 	    ends_with(file_name, ".bitmap") ||
 	    ends_with(file_name, ".keep") ||
-	    ends_with(file_name, ".promisor"))
+	    ends_with(file_name, ".promisor") ||
+	    ends_with(file_name, ".mtimes"))
 		string_list_append(data->garbage, full_name);
 	else
 		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
-- 
2.35.1.73.gccc5557600

