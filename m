Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55C411F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934441AbeFYOfE (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:04 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45698 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934426AbeFYOfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:01 -0400
Received: by mail-qk0-f195.google.com with SMTP id c198-v6so7579168qkg.12
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBBsKnfQgHfb3J/TO09Lc+8eq+Bxr3AD3zPCzzKeg0M=;
        b=K8OxV4N/81VenNROVxfJbojP5Qry9fB0uQqOVxlnay1VWDy5QOcD5+6S8AakHzz5P4
         LgCssVQ8i7OTWzGNel1HJV/LfAWrh1qxdWjZ5ZE1SShZEbKbmFXW8GnKDe+fN8yMI7Rr
         fhjCRuc+EGudG+mIdMOZB9bIbYzZHbMQzY9hL7OgE9LqPtxnMZ1zr9M5l9tJthlROuXe
         5Xi3Qp5pk38otPHmhaKejX7SYEHi1Hos6TAIa185/EVEYGK4vf4dhiZKNRfypoqxJNgN
         A+VDIInF85QD64QX34vN7KyWnsc9h3eEOUzgUzWnfM9s3S4g/DrndJTGtv4ZULNSWvdB
         k05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBBsKnfQgHfb3J/TO09Lc+8eq+Bxr3AD3zPCzzKeg0M=;
        b=aN2dogkH6QBKXWaoeMz/6RlVijlsTdYc7bdDs2J/PIA6moCtutC2zuh252eSYfNDmr
         VZoG+OlOX0vMYvHw/eEwdpheoqsE+5UzXBIl0ovYB86or/ljI9aLvn+gVbTcZGAEo6OZ
         B2SliFoI+2X5n43QcVGurG7oaLF9i2hlwooaZ9/hr8XciABZuu5bmHIhbpWlDd1h/Et0
         GfImF4tejYc74YeSDNPYUAOgUVHyGJsZ7dsZ1eZUkSHk44+nNFwKECyb6iK00M9omMGv
         qhcs/rfP2PoAKr88PInJdSfWCedfmY7vJT2hfKP6UJxuH0BZJPrTL3vH8AbBcoRb2Eel
         Sv5g==
X-Gm-Message-State: APt69E1pfUP+XKqtUhYV4aZ7Aim5P4UESwVtp3p9sCJko0KuwinpHhN0
        iO76pGMGZ0bG8zsmo/S1JvqzKT3Z
X-Google-Smtp-Source: ADUXVKJa34CfTQ0sSGmjVSmBwvWgnYBnGewa0CsmgZSh2kitx174FM7b4UL9QPCASDvlRomxPxF4dg==
X-Received: by 2002:a37:b1c6:: with SMTP id a189-v6mr10578525qkf.321.1529937299912;
        Mon, 25 Jun 2018 07:34:59 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:34:59 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 06/24] multi-pack-index: load into memory
Date:   Mon, 25 Jun 2018 10:34:16 -0400
Message-Id: <20180625143434.89044-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new multi_pack_index struct for loading multi-pack-indexes into
memory. Create a test-tool builtin for reading basic information about
that multi-pack-index to verify the correct data is written.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile                    |  1 +
 midx.c                      | 78 +++++++++++++++++++++++++++++++++++++
 midx.h                      |  4 ++
 object-store.h              | 16 ++++++++
 t/helper/test-read-midx.c   | 34 ++++++++++++++++
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 t/t5319-multi-pack-index.sh | 12 +++++-
 8 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-read-midx.c

diff --git a/Makefile b/Makefile
index f5636c711d..0b801d1b16 100644
--- a/Makefile
+++ b/Makefile
@@ -717,6 +717,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-read-cache.o
+TEST_BUILTINS_OBJS += test-read-midx.o
 TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
diff --git a/midx.c b/midx.c
index 393d526881..0977397d6a 100644
--- a/midx.c
+++ b/midx.c
@@ -1,18 +1,96 @@
 #include "cache.h"
 #include "csum-file.h"
 #include "lockfile.h"
+#include "object-store.h"
 #include "midx.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
 #define MIDX_HASH_VERSION 1
 #define MIDX_HEADER_SIZE 12
+#define MIDX_HASH_LEN 20
+#define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
 static char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
 
+struct multi_pack_index *load_multi_pack_index(const char *object_dir)
+{
+	struct multi_pack_index *m = NULL;
+	int fd;
+	struct stat st;
+	size_t midx_size;
+	void *midx_map = NULL;
+	uint32_t hash_version;
+	char *midx_name = get_midx_filename(object_dir);
+
+	fd = git_open(midx_name);
+
+	if (fd < 0) {
+		error_errno(_("failed to read %s"), midx_name);
+		FREE_AND_NULL(midx_name);
+		return NULL;
+	}
+	if (fstat(fd, &st)) {
+		error_errno(_("failed to read %s"), midx_name);
+		FREE_AND_NULL(midx_name);
+		close(fd);
+		return NULL;
+	}
+
+	midx_size = xsize_t(st.st_size);
+
+	if (midx_size < MIDX_MIN_SIZE) {
+		close(fd);
+		error(_("multi-pack-index file %s is too small"), midx_name);
+		goto cleanup_fail;
+	}
+
+	FREE_AND_NULL(midx_name);
+
+	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+
+	m = xcalloc(1, sizeof(*m) + strlen(object_dir) + 1);
+	strcpy(m->object_dir, object_dir);
+	m->data = midx_map;
+
+	m->signature = get_be32(m->data);
+	if (m->signature != MIDX_SIGNATURE) {
+		error(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
+		      m->signature, MIDX_SIGNATURE);
+		goto cleanup_fail;
+	}
+
+	m->version = m->data[4];
+	if (m->version != MIDX_VERSION) {
+		error(_("multi-pack-index version %d not recognized"),
+		      m->version);
+		goto cleanup_fail;
+	}
+
+	hash_version = m->data[5];
+	if (hash_version != MIDX_HASH_VERSION) {
+		error(_("hash version %u does not match"), hash_version);
+		goto cleanup_fail;
+	}
+	m->hash_len = MIDX_HASH_LEN;
+
+	m->num_chunks = *(m->data + 6);
+
+	m->num_packs = get_be32(m->data + 8);
+
+	return m;
+
+cleanup_fail:
+	FREE_AND_NULL(m);
+	FREE_AND_NULL(midx_name);
+	munmap(midx_map, midx_size);
+	close(fd);
+	return NULL;
+}
+
 static size_t write_midx_header(struct hashfile *f,
 				unsigned char num_chunks,
 				uint32_t num_packs)
diff --git a/midx.h b/midx.h
index dbdbe9f873..2d83dd9ec1 100644
--- a/midx.h
+++ b/midx.h
@@ -1,6 +1,10 @@
 #ifndef __MIDX_H__
 #define __MIDX_H__
 
+struct multi_pack_index;
+
+struct multi_pack_index *load_multi_pack_index(const char *object_dir);
+
 int write_midx_file(const char *object_dir);
 
 #endif
diff --git a/object-store.h b/object-store.h
index d683112fd7..4f410841cc 100644
--- a/object-store.h
+++ b/object-store.h
@@ -84,6 +84,22 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+struct multi_pack_index {
+	int fd;
+
+	const unsigned char *data;
+	size_t data_len;
+
+	uint32_t signature;
+	unsigned char version;
+	unsigned char hash_len;
+	unsigned char num_chunks;
+	uint32_t num_packs;
+	uint32_t num_objects;
+
+	char object_dir[FLEX_ARRAY];
+};
+
 struct raw_object_store {
 	/*
 	 * Path to the repository's object store.
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
new file mode 100644
index 0000000000..5abf969175
--- /dev/null
+++ b/t/helper/test-read-midx.c
@@ -0,0 +1,34 @@
+/*
+ * test-mktemp.c: code to exercise the creation of temporary files
+ */
+#include "test-tool.h"
+#include "cache.h"
+#include "midx.h"
+#include "repository.h"
+#include "object-store.h"
+
+static int read_midx_file(const char *object_dir)
+{
+	struct multi_pack_index *m = load_multi_pack_index(object_dir);
+
+	if (!m)
+		return 0;
+
+	printf("header: %08x %d %d %d\n",
+	       m->signature,
+	       m->version,
+	       m->num_chunks,
+	       m->num_packs);
+
+	printf("object_dir: %s\n", m->object_dir);
+
+	return 0;
+}
+
+int cmd__read_midx(int argc, const char **argv)
+{
+	if (argc != 2)
+		usage("read-midx <object_dir>");
+
+	return read_midx_file(argv[1]);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 805a45de9c..1c3ab36e6c 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -27,6 +27,7 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", cmd__path_utils },
 	{ "prio-queue", cmd__prio_queue },
 	{ "read-cache", cmd__read_cache },
+	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "regex", cmd__regex },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7116ddfb94..6af8c08a66 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -21,6 +21,7 @@ int cmd__online_cpus(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
+int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 8622a7cdce..0372704c96 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -3,9 +3,19 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 
+midx_read_expect() {
+	cat >expect <<- EOF
+	header: 4d494458 1 0 0
+	object_dir: .
+	EOF
+	test-tool read-midx . >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'write midx with no packs' '
 	git multi-pack-index --object-dir=. write &&
-	test_path_is_file pack/multi-pack-index
+	test_path_is_file pack/multi-pack-index &&
+	midx_read_expect
 '
 
 test_done
-- 
2.18.0.24.g1b579a2ee9

