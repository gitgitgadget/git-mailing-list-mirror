Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A73D205C9
	for <e@80x24.org>; Sun,  8 Jan 2017 19:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbdAHTRv (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 14:17:51 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35772 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdAHTRr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 14:17:47 -0500
Received: by mail-wm0-f67.google.com with SMTP id l2so17256210wml.2
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 11:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Skrb3KpwSDl9htNrYcr77MIOWcEM+eugWwMJjyzGhz4=;
        b=BHuqRYs7JUJKaE8jr/I9j+Yu8eP3UROhoe+q104jZt95D4jJ7DNDrXBlfE2gqDMf0l
         f6iWVWPSUyCT1Qs7bUdk3Ro8KYCW4jnSRsFWK8PpKvLsoAI5kpKD7Z9UZs4pERkEz5zv
         qg1LnyPg7aTAq3Ob0sjVULZVr6frcqKrUdNzLMS24BUNH5kNBvYH5cYFDBsqkkDCnigc
         tXTnzTUxiYHXFGqhxauYNWzkR/ruQuuld+FRsUYfL56JT4l7lvfz+4arpqVdM1bHXrJV
         ba8bcSExUViAcess5/ObGPJtraoCNv2LyXP/g99HCUm11wUPsClkO3r74L6XwGbmv1d/
         joVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Skrb3KpwSDl9htNrYcr77MIOWcEM+eugWwMJjyzGhz4=;
        b=IZkNZN3lnZE99xsjia/UrtnHLw1pAwNkevaPlQibsN3wJ0E3VaFqtpLmR+5pAs3sol
         3oebfeWF31kwYpYDxAwDvED6LiE/0JMd3axBeHuXsxlstLbEj4BsfovCGUgHKJq8hOFN
         Iy5+OwfSZ+zlUlZZiuwY5QiwEjgzjOnGOY+SafowfNcpv/6mCbHF8FyhHAwXhdkwhoqj
         oZev/fNzSc0VtiNZX6Eh7fsAHKhLvEh8M2wAn4rnfUFknjWZYZ2+uOMOWqikmaO5kh9c
         J/G1Queo1NqIg8yaCh6G/FUW2v4MI2zY7zcxf/dtq+VTYSqrnt2xyNj6BfStSDgixJ49
         fpGw==
X-Gm-Message-State: AIkVDXJfxmW3AlOuyrinVft9pzbTr2wmoT+HVDdnwz6x8KMLYlaR9Z7WlhJaoT0bnGpWeA==
X-Received: by 10.28.105.78 with SMTP id e75mr3424830wmc.55.1483903065328;
        Sun, 08 Jan 2017 11:17:45 -0800 (PST)
Received: from localhost.localdomain (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id di9sm120148497wjc.37.2017.01.08.11.17.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 08 Jan 2017 11:17:44 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, e@80x24.org, jnareb@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] convert: add "status=delayed" to filter process protocol
Date:   Sun,  8 Jan 2017 20:17:36 +0100
Message-Id: <20170108191736.47359-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Some `clean` / `smudge` filters might require a significant amount of
time to process a single blob. During this process the Git checkout
operation is blocked and Git needs to wait until the filter is done to
continue with the checkout.

Teach the filter process protocol (introduced in edcc858) to accept the
status "delayed" as response to a filter request. Upon this response Git
continues with the checkout operation and asks the filter to process the
blob again after all other blobs have been processed.

Git has a multiple code paths that checkout a blob. Support delayed
checkouts only in `clone` (in unpack-trees.c) and `checkout` operations.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

You can find the RFC thread for this topic here:
http://public-inbox.org/git/D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com/

Notes:
    Base Commit: e05806da9e (master)
    Diff on Web: https://github.com/larsxschneider/git/commit/ea25a1834b
    Checkout:    git fetch https://github.com/larsxschneider/git filter-process/delay-v1 && git checkout ea25a1834b

    Interdiff (filter-process/delay-v0..filter-process/delay-v1):

 Documentation/gitattributes.txt |  9 +++++++
 apply.c                         |  2 +-
 archive.c                       |  2 +-
 builtin/cat-file.c              |  2 +-
 builtin/checkout.c              |  1 +
 cache.h                         |  1 +
 convert.c                       | 33 ++++++++++++++-----------
 convert.h                       |  2 +-
 diff.c                          |  2 +-
 entry.c                         | 40 +++++++++++++++++++++++++++----
 merge-recursive.c               |  2 +-
 t/t0021-conversion.sh           | 53 +++++++++++++++++++++++++++++++++++++++++
 t/t0021/rot13-filter.pl         | 19 +++++++++++++++
 unpack-trees.c                  |  1 +
 14 files changed, 145 insertions(+), 24 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e0b66c1220..f6bad8db40 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -473,6 +473,15 @@ packet:          git< 0000  # empty content!
 packet:          git< 0000  # empty list, keep "status=success" unchanged!
 ------------------------

+If the request cannot be fulfilled within a reasonable amount of time
+then the filter can respond with a "delayed" status and a flush packet.
+Git will perform the same request at a later point in time, again. The
+filter can delay a response multiple times for a single request.
+------------------------
+packet:          git< status=delayed
+packet:          git< 0000
+------------------------
+
 In case the filter cannot or does not want to process the content,
 it is expected to respond with an "error" status.
 ------------------------
diff --git a/apply.c b/apply.c
index 2ed808d429..aa7e6e4359 100644
--- a/apply.c
+++ b/apply.c
@@ -4328,7 +4328,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	if (fd < 0)
 		return 1;

-	if (convert_to_working_tree(path, buf, size, &nbuf)) {
+	if (convert_to_working_tree(path, buf, size, &nbuf, NULL)) {
 		size = nbuf.len;
 		buf  = nbuf.buf;
 	}
diff --git a/archive.c b/archive.c
index 01751e574b..90d02463ef 100644
--- a/archive.c
+++ b/archive.c
@@ -77,7 +77,7 @@ void *sha1_file_to_archive(const struct archiver_args *args,
 		size_t size = 0;

 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
-		convert_to_working_tree(path, buf.buf, buf.len, &buf);
+		convert_to_working_tree(path, buf.buf, buf.len, &buf, NULL);
 		if (commit)
 			format_subst(commit, buf.buf, buf.len, &buf);
 		buffer = strbuf_detach(&buf, &size);
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 30383e9eb4..4e3e31a00b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -35,7 +35,7 @@ static int filter_object(const char *path, unsigned mode,
 			     oid_to_hex(oid), path);
 	if ((type == OBJ_BLOB) && S_ISREG(mode)) {
 		struct strbuf strbuf = STRBUF_INIT;
-		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
+		if (convert_to_working_tree(path, *buf, *size, &strbuf, NULL)) {
 			free(*buf);
 			*size = strbuf.len;
 			*buf = strbuf_detach(&strbuf, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfe685c198..42885cfe92 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -369,6 +369,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
+	errs |= checkout_delayed_entries(&state);

 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
diff --git a/cache.h b/cache.h
index a50a61a197..5d119ffc6b 100644
--- a/cache.h
+++ b/cache.h
@@ -1375,6 +1375,7 @@ struct checkout {

 #define TEMPORARY_FILENAME_LENGTH 25
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
+extern int checkout_delayed_entries(const struct checkout *state);

 struct cache_def {
 	struct strbuf path;
diff --git a/convert.c b/convert.c
index 4e17e45ed2..4075a58e64 100644
--- a/convert.c
+++ b/convert.c
@@ -672,7 +672,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 }

 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
-				   int fd, struct strbuf *dst, const char *cmd,
+				   int fd, struct strbuf *dst, int *delayed, const char *cmd,
 				   const unsigned int wanted_capability)
 {
 	int err;
@@ -738,9 +738,14 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		goto done;

 	read_multi_file_filter_status(process->out, &filter_status);
-	err = strcmp(filter_status.buf, "success");
-	if (err)
+	if (delayed && !strcmp(filter_status.buf, "delayed")) {
+		*delayed = 1;
 		goto done;
+	} else {
+		err = strcmp(filter_status.buf, "success");
+		if (err)
+			goto done;
+	}

 	err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
 	if (err)
@@ -787,8 +792,8 @@ static struct convert_driver {
 } *user_convert, **user_convert_tail;

 static int apply_filter(const char *path, const char *src, size_t len,
-			int fd, struct strbuf *dst, struct convert_driver *drv,
-			const unsigned int wanted_capability)
+			int fd, struct strbuf *dst, int *delayed,
+			struct convert_driver *drv, const unsigned int wanted_capability)
 {
 	const char *cmd = NULL;

@@ -806,7 +811,7 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (cmd && *cmd)
 		return apply_single_file_filter(path, src, len, fd, dst, cmd);
 	else if (drv->process && *drv->process)
-		return apply_multi_file_filter(path, src, len, fd, dst, drv->process, wanted_capability);
+		return apply_multi_file_filter(path, src, len, fd, dst, delayed, drv->process, wanted_capability);

 	return 0;
 }
@@ -1152,7 +1157,7 @@ int would_convert_to_git_filter_fd(const char *path)
 	if (!ca.drv->required)
 		return 0;

-	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN);
+	return apply_filter(path, NULL, 0, -1, NULL, NULL, ca.drv, CAP_CLEAN);
 }

 const char *get_convert_attr_ascii(const char *path)
@@ -1189,7 +1194,7 @@ int convert_to_git(const char *path, const char *src, size_t len,

 	convert_attrs(&ca, path);

-	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN);
+	ret |= apply_filter(path, src, len, -1, dst, NULL, ca.drv, CAP_CLEAN);
 	if (!ret && ca.drv && ca.drv->required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

@@ -1214,7 +1219,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	assert(ca.drv);
 	assert(ca.drv->clean || ca.drv->process);

-	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
+	if (!apply_filter(path, NULL, 0, fd, dst, NULL, ca.drv, CAP_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
@@ -1222,7 +1227,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 }

 static int convert_to_working_tree_internal(const char *path, const char *src,
-					    size_t len, struct strbuf *dst,
+					    size_t len, struct strbuf *dst, int *delayed,
 					    int normalizing)
 {
 	int ret = 0, ret_filter = 0;
@@ -1248,21 +1253,21 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}

-	ret_filter = apply_filter(path, src, len, -1, dst, ca.drv, CAP_SMUDGE);
+	ret_filter = apply_filter(path, src, len, -1, dst, delayed, ca.drv, CAP_SMUDGE);
 	if (!ret_filter && ca.drv && ca.drv->required)
 		die("%s: smudge filter %s failed", path, ca.drv->name);

 	return ret | ret_filter;
 }

-int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
+int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst, int *delayed)
 {
-	return convert_to_working_tree_internal(path, src, len, dst, 0);
+	return convert_to_working_tree_internal(path, src, len, dst, delayed, 0);
 }

 int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree_internal(path, src, len, dst, 1);
+	int ret = convert_to_working_tree_internal(path, src, len, dst, NULL, 1);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/convert.h b/convert.h
index 82871a11d5..72f24078de 100644
--- a/convert.h
+++ b/convert.h
@@ -41,7 +41,7 @@ extern const char *get_convert_attr_ascii(const char *path);
 extern int convert_to_git(const char *path, const char *src, size_t len,
 			  struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src,
-				   size_t len, struct strbuf *dst);
+				   size_t len, struct strbuf *dst, int *delayed);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
 static inline int would_convert_to_git(const char *path)
diff --git a/diff.c b/diff.c
index 84dba60c40..243cd0ffdf 100644
--- a/diff.c
+++ b/diff.c
@@ -2960,7 +2960,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	if (fd < 0)
 		die_errno("unable to create temp-file");
 	if (convert_to_working_tree(path,
-			(const char *)blob, (size_t)size, &buf)) {
+			(const char *)blob, (size_t)size, &buf, NULL)) {
 		blob = buf.buf;
 		size = buf.len;
 	}
diff --git a/entry.c b/entry.c
index c6eea240b6..43f3ae7b69 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,14 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "list.h"
+
+static LIST_HEAD(delayed_cache_entry_queue_head);
+
+struct delayed_cache_entry {
+	struct cache_entry *ce;
+	struct list_head node;
+};

 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -140,12 +148,13 @@ static int write_entry(struct cache_entry *ce,
 		       char *path, const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
-	int fd, ret, fstat_done = 0;
+	int fd, ret, fstat_done = 0, delayed = 0;
 	char *new;
 	struct strbuf buf = STRBUF_INIT;
 	unsigned long size;
 	size_t wrote, newsize = 0;
 	struct stat st;
+	struct delayed_cache_entry *delayed_ce;

 	if (ce_mode_s_ifmt == S_IFREG) {
 		struct stream_filter *filter = get_stream_filter(ce->name,
@@ -178,10 +187,17 @@ static int write_entry(struct cache_entry *ce,
 		 * Convert from git internal format to working tree format
 		 */
 		if (ce_mode_s_ifmt == S_IFREG &&
-		    convert_to_working_tree(ce->name, new, size, &buf)) {
+		    convert_to_working_tree(ce->name, new, size, &buf, &delayed)) {
 			free(new);
-			new = strbuf_detach(&buf, &newsize);
-			size = newsize;
+			if (delayed) {
+				delayed_ce = xmalloc(sizeof(*delayed_ce));
+				delayed_ce->ce = ce;
+				list_add_tail(&delayed_ce->node, &delayed_cache_entry_queue_head);
+				goto finish;
+			} else {
+				new = strbuf_detach(&buf, &newsize);
+				size = newsize;
+			}
 		}

 		fd = open_output_fd(path, ce, to_tempfile);
@@ -291,3 +307,19 @@ int checkout_entry(struct cache_entry *ce,
 	create_directories(path.buf, path.len, state);
 	return write_entry(ce, path.buf, state, 0);
 }
+
+int checkout_delayed_entries(const struct checkout *state)
+{
+	struct delayed_cache_entry *head;
+	int errs = 0;
+
+	while (!list_empty(&delayed_cache_entry_queue_head)) {
+		head = list_first_entry(&delayed_cache_entry_queue_head,
+			struct delayed_cache_entry, node);
+		list_del(&head->node);
+		head->ce->ce_flags &= ~CE_UPDATE;
+		errs |= checkout_entry(head->ce, state, NULL);
+	}
+
+	return errs;
+}
diff --git a/merge-recursive.c b/merge-recursive.c
index d327209443..73dd33e61f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -807,7 +807,7 @@ static int update_file_flags(struct merge_options *o,
 		}
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
-			if (convert_to_working_tree(path, buf, size, &strbuf)) {
+			if (convert_to_working_tree(path, buf, size, &strbuf, NULL)) {
 				free(buf);
 				size = strbuf.len;
 				buf = strbuf_detach(&strbuf, NULL);
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 161f560446..8ae5b1a521 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -701,4 +701,57 @@ test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
 	)
 '

+test_expect_success PERL 'delayed checkout in process filter' '
+	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+		echo "*.r filter=protocol" >.gitattributes &&
+		cp "$TEST_ROOT/test.o" test.r &&
+		cp "$TEST_ROOT/test.o" test-delay1.r &&
+		cp "$TEST_ROOT/test.o" test-delay3.r &&
+		git add . &&
+		git commit -m "test commit 1"
+	) &&
+
+	S=$(file_size repo/test.r) &&
+	rm -rf repo-cloned &&
+	filter_git clone repo repo-cloned &&
+	cat >expected.log <<-EOF &&
+		START
+		init handshake complete
+		IN: smudge test.r $S [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay1.r $S [OK] -- OUT: $S [DELAYED]
+		IN: smudge test-delay1.r $S [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
+		IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
+		IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
+		IN: smudge test-delay3.r $S [OK] -- OUT: $S . [OK]
+		STOP
+	EOF
+	test_cmp_count expected.log repo-cloned/rot13-filter.log &&
+
+	(
+		cd repo-cloned &&
+		rm *.r rot13-filter.log &&
+		filter_git checkout . &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
+			IN: smudge test-delay1.r $S [OK] -- OUT: $S [DELAYED]
+			IN: smudge test-delay1.r $S [OK] -- OUT: $S . [OK]
+			IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
+			IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
+			IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
+			IN: smudge test-delay3.r $S [OK] -- OUT: $S . [OK]
+			STOP
+		EOF
+		test_cmp_count expected.log rot13-filter.log
+	)
+'
+
 test_done
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 617f581e56..b10be1e543 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -17,6 +17,10 @@
 #     operation then the filter signals that it cannot or does not want
 #     to process the file and any file after that is processed with the
 #     same command.
+# (5) If data with a pathname that is a key in the DELAY hash is
+#     processed (e.g. 'test-delay1.r') then the filter signals n times
+#     to Git that the processing is delayed (n being the value of the
+#     DELAY hash key).
 #

 use strict;
@@ -25,6 +29,12 @@ use IO::File;

 my $MAX_PACKET_CONTENT_SIZE = 65516;
 my @capabilities            = @ARGV;
+my $DELAY3 = 3;
+my $DELAY1 = 1;
+
+my %DELAY;
+$DELAY{'test-delay1.r'} = 1;
+$DELAY{'test-delay3.r'} = 3;

 open my $debug, ">>", "rot13-filter.log" or die "cannot open log file: $!";

@@ -166,6 +176,15 @@ while (1) {
 		packet_txt_write("status=abort");
 		packet_flush();
 	}
+	elsif ( $command eq "smudge" and
+		    exists $DELAY{$pathname} and
+		    $DELAY{$pathname} gt 0 ) {
+		$DELAY{$pathname} = $DELAY{$pathname} - 1;
+		print $debug "[DELAYED]\n";
+		$debug->flush();
+		packet_txt_write("status=delayed");
+		packet_flush();
+	}
 	else {
 		packet_txt_write("status=success");
 		packet_flush();
diff --git a/unpack-trees.c b/unpack-trees.c
index 7a6df99d10..662b75f72a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -268,6 +268,7 @@ static int check_updates(struct unpack_trees_options *o,
 			}
 		}
 	}
+	errs |= checkout_delayed_entries(state);
 	stop_progress(&progress);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
--
2.11.0

