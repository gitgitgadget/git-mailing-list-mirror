Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92996C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345795AbiHITJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345712AbiHITJG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685EF1FCD2
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso9347148wma.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=elWVq8d07rynQLykm6um+HWT12gq5M7NUCyGEK5wpak=;
        b=HxX4ZtegCalzHU2nIwr95/VBvb70OdGkqXhGTp+cYVzk8zpMtfx/77oC+g4MXjuuVl
         wd6I7DBjPnPTDg9GGSRkq19B9aVCBebw6/fjcYPm7mwiFyvdT9ZzuQ/7I2mYynExQmlj
         15hFJifApz1FnKOnADlixDZ9Mn0MS3mMMlw83n0tD02HCcD8dRmNjaX+1NJi4kXq/tLI
         WIfjgzb5G8O32Lvrx3NCH8sH5wHqWuf7LWO3B4IzRu5RA6lJxzyCkL5RqwUNq/Tidxf5
         iNCCHo31SZyzSnvDanM0pdRJyXZKXVTzYxhIkIiD3V622KbohhufAvlZdW/zVK3VOjq5
         EJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=elWVq8d07rynQLykm6um+HWT12gq5M7NUCyGEK5wpak=;
        b=Um/2VFZZnOPnVfWJa+ra4coJdb+2rPUSxTLjl3l3lxezfpACZnEFuFNuMw+1B8vFCe
         kpQX/J//nNDZUpmNEPwcSvj9LRCVRKR07gH5fJctvrp2YD+a3tniWrxq3UF7lHcjazGx
         72sIl4pN6I89yOwZn2koQigpqqq++5K359pP6330TGi9dhyQKVBZ4QUjIF4RQ7Wu5gJP
         kimPJUStm0XEv9i3qvmChEEesDcCUq3YaR4sF+jegcYn+Dt+GA4Nohy+5NrKDxQzZNs+
         CxZO9yKdDwnavbQOY9bUHdPCyug1TQA+/2jKkOxTem0iYVnhk8fGvgzw10lwUhi2hXVW
         nAHQ==
X-Gm-Message-State: ACgBeo0L+Rls33IbT44pn8Zi2cc2KET4UplkW/DUNPjhnZQ6AxAmYiAl
        VCcH8EVMULBEicVABptwvgLr4oMVxG8=
X-Google-Smtp-Source: AA6agR6W5G2PTgHwEssi1JolnCG7USgcFqS3NY934HCrncGy5VALtAz86saA0EZkg6PN882J2fADng==
X-Received: by 2002:a7b:ce12:0:b0:3a5:4d8b:65df with SMTP id m18-20020a7bce12000000b003a54d8b65dfmr5757894wmc.27.1660071327014;
        Tue, 09 Aug 2022 11:55:27 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:26 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 03/14] merge-index: libify merge_one_path() and merge_all()
Date:   Tue,  9 Aug 2022 20:54:18 +0200
Message-Id: <20220809185429.20098-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "resolve" and "octopus" merge strategies do not call directly `git
merge-one-file', they delegate the work to another git command, `git
merge-index', that will loop over files in the index and call the
specified command.  Unfortunately, these functions are not part of
libgit.a, which means that once rewritten, the strategies would still
have to invoke `merge-one-file' by spawning a new process first.

To avoid this, this moves and renames merge_one_path(), merge_all(), and
their helpers to merge-strategies.c.  They also take a callback to
dictate what they should do for each file.  For now, to preserve the
behaviour of `merge-index', only one callback, launching a new process,
is defined.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Makefile               |  1 +
 builtin/merge-index.c  | 92 ++++++++++++++----------------------------
 merge-strategies.c     | 82 +++++++++++++++++++++++++++++++++++++
 merge-strategies.h     | 18 +++++++++
 t/t7607-merge-state.sh |  2 +-
 5 files changed, 133 insertions(+), 62 deletions(-)
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

diff --git a/Makefile b/Makefile
index 2ec9b2dc6b..40d1be4e5e 100644
--- a/Makefile
+++ b/Makefile
@@ -991,6 +991,7 @@ LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-ort-wrappers.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += merge-strategies.o
 LIB_OBJS += merge.o
 LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c0383fe9df..f66cc515d8 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,76 +1,43 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
+#include "merge-strategies.h"
 #include "run-command.h"
 
 static const char *pgm;
-static int one_shot, quiet;
-static int err;
 
-static int merge_entry(int pos, const char *path)
+static int merge_one_file_spawn(struct index_state *istate,
+				const struct object_id *orig_blob,
+				const struct object_id *our_blob,
+				const struct object_id *their_blob, const char *path,
+				unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+				void *data)
 {
-	int found;
-	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
-	char hexbuf[4][GIT_MAX_HEXSZ + 1];
-	char ownbuf[4][60];
+	char oids[3][GIT_MAX_HEXSZ + 1] = {{0}};
+	char modes[3][10] = {{0}};
+	const char *arguments[] = { pgm, oids[0], oids[1], oids[2],
+				    path, modes[0], modes[1], modes[2], NULL };
 
-	if (pos >= active_nr)
-		die("git merge-index: %s not in the cache", path);
-	found = 0;
-	do {
-		const struct cache_entry *ce = active_cache[pos];
-		int stage = ce_stage(ce);
-
-		if (strcmp(ce->name, path))
-			break;
-		found++;
-		oid_to_hex_r(hexbuf[stage], &ce->oid);
-		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
-		arguments[stage] = hexbuf[stage];
-		arguments[stage + 4] = ownbuf[stage];
-	} while (++pos < active_nr);
-	if (!found)
-		die("git merge-index: %s not in the cache", path);
-
-	if (run_command_v_opt(arguments, 0)) {
-		if (one_shot)
-			err++;
-		else {
-			if (!quiet)
-				die("merge program failed");
-			exit(1);
-		}
+	if (orig_blob) {
+		oid_to_hex_r(oids[0], orig_blob);
+		xsnprintf(modes[0], sizeof(modes[0]), "%06o", orig_mode);
 	}
-	return found;
-}
-
-static void merge_one_path(const char *path)
-{
-	int pos = cache_name_pos(path, strlen(path));
 
-	/*
-	 * If it already exists in the cache as stage0, it's
-	 * already merged and there is nothing to do.
-	 */
-	if (pos < 0)
-		merge_entry(-pos-1, path);
-}
+	if (our_blob) {
+		oid_to_hex_r(oids[1], our_blob);
+		xsnprintf(modes[1], sizeof(modes[1]), "%06o", our_mode);
+	}
 
-static void merge_all(void)
-{
-	int i;
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
-		if (!ce_stage(ce))
-			continue;
-		i += merge_entry(i, ce->name)-1;
+	if (their_blob) {
+		oid_to_hex_r(oids[2], their_blob);
+		xsnprintf(modes[2], sizeof(modes[2]), "%06o", their_mode);
 	}
+
+	return run_command_v_opt(arguments, 0);
 }
 
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
-	int i, force_file = 0;
+	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -94,7 +61,9 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 		quiet = 1;
 		i++;
 	}
+
 	pgm = argv[i++];
+
 	for (; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!force_file && *arg == '-') {
@@ -103,14 +72,15 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "-a")) {
-				merge_all();
+				err |= merge_all_index(&the_index, one_shot, quiet,
+						       merge_one_file_spawn, NULL);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
-		merge_one_path(arg);
+		err |= merge_index_path(&the_index, one_shot, quiet, arg,
+					merge_one_file_spawn, NULL);
 	}
-	if (err && !quiet)
-		die("merge program failed");
+
 	return err;
 }
diff --git a/merge-strategies.c b/merge-strategies.c
new file mode 100644
index 0000000000..418c9dd710
--- /dev/null
+++ b/merge-strategies.c
@@ -0,0 +1,82 @@
+#include "cache.h"
+#include "merge-strategies.h"
+
+static int merge_entry(struct index_state *istate, unsigned int pos,
+		       const char *path, int *err, merge_fn fn, void *data)
+{
+	int found = 0;
+	const struct object_id *oids[3] = {NULL};
+	unsigned int modes[3] = {0};
+
+	do {
+		const struct cache_entry *ce = istate->cache[pos];
+		int stage = ce_stage(ce);
+
+		if (strcmp(ce->name, path))
+			break;
+		found++;
+		oids[stage - 1] = &ce->oid;
+		modes[stage - 1] = ce->ce_mode;
+	} while (++pos < istate->cache_nr);
+	if (!found)
+		return error(_("%s is not in the cache"), path);
+
+	if (fn(istate, oids[0], oids[1], oids[2], path,
+	       modes[0], modes[1], modes[2], data))
+		(*err)++;
+
+	return found;
+}
+
+int merge_index_path(struct index_state *istate, int oneshot, int quiet,
+		     const char *path, merge_fn fn, void *data)
+{
+	int pos = index_name_pos(istate, path, strlen(path)), ret, err = 0;
+
+	/*
+	 * If it already exists in the cache as stage0, it's
+	 * already merged and there is nothing to do.
+	 */
+	if (pos < 0) {
+		ret = merge_entry(istate, -pos - 1, path, &err, fn, data);
+		if (ret == -1)
+			return -1;
+		else if (err) {
+			if (!quiet && !oneshot)
+				error(_("merge program failed"));
+			return 1;
+		}
+	}
+	return 0;
+}
+
+int merge_all_index(struct index_state *istate, int oneshot, int quiet,
+		    merge_fn fn, void *data)
+{
+	int err = 0, ret;
+	unsigned int i;
+
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
+		if (!ce_stage(ce))
+			continue;
+
+		ret = merge_entry(istate, i, ce->name, &err, fn, data);
+		if (ret > 0)
+			i += ret - 1;
+		else if (ret == -1)
+			return -1;
+
+		if (err && !oneshot) {
+			if (!quiet)
+				error(_("merge program failed"));
+			return 1;
+		}
+	}
+
+	if (err && !quiet)
+		error(_("merge program failed"));
+	return err;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
new file mode 100644
index 0000000000..88f476f170
--- /dev/null
+++ b/merge-strategies.h
@@ -0,0 +1,18 @@
+#ifndef MERGE_STRATEGIES_H
+#define MERGE_STRATEGIES_H
+
+#include "object.h"
+
+typedef int (*merge_fn)(struct index_state *istate,
+			const struct object_id *orig_blob,
+			const struct object_id *our_blob,
+			const struct object_id *their_blob, const char *path,
+			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+			void *data);
+
+int merge_index_path(struct index_state *istate, int oneshot, int quiet,
+		     const char *path, merge_fn fn, void *data);
+int merge_all_index(struct index_state *istate, int oneshot, int quiet,
+		    merge_fn fn, void *data);
+
+#endif /* MERGE_STRATEGIES_H */
diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
index 89a62ac53b..96befa5b80 100755
--- a/t/t7607-merge-state.sh
+++ b/t/t7607-merge-state.sh
@@ -20,7 +20,7 @@ test_expect_success 'Ensure we restore original state if no merge strategy handl
 	# just hit conflicts, it completely fails and says that it cannot
 	# handle this type of merge.
 	test_expect_code 2 git merge branch2 branch3 >output 2>&1 &&
-	grep "fatal: merge program failed" output &&
+	grep "error: merge program failed" output &&
 	grep "Should not be doing an octopus" output &&
 
 	# Make sure we did not leave stray changes around when no appropriate
-- 
2.37.1.412.gcfdce49ffd

