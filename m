Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A139A20254
	for <e@80x24.org>; Sun, 26 Feb 2017 18:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdBZSsY (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 13:48:24 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35813 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdBZSsX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 13:48:23 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so10336020wmu.2
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l/QB4k3yoTKhDAUj5BVoh5Faysm0kSeEZx5BVoJjbsE=;
        b=H8qZe+jYAVLK5pyZWqyYYqBxwuTdrqFS9RuTXnQ4HcFbSOQMY1dzl4afZgP8tWE9RB
         zesZu9R60TY/oafPB3pub8SNwcnr59Ze8plhDzHD9MVgC6o5RQDOrAPKZaCx6dLFENLa
         m1fhOV+qoCKmLUrSeE2WR51QVYbZr0murmigEd+ZyO6aVWrlQNhnRN4SWRhBonKHMCCO
         Nk+TCJ8q9eDxJOFqi0mDE0cDAaUPYmQY0P8dq0pFYapIt8sddaDe5JuEyWBQg324RFHO
         hYPSC1VvycfSCj/6VTJI0zRXBHfiOBSahxsjh6P9QICFeV1ROBTcc2KRacs+gbYAmLc/
         cp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l/QB4k3yoTKhDAUj5BVoh5Faysm0kSeEZx5BVoJjbsE=;
        b=eGwjp0etLNpXOj5jejGJlV14vO/AjAdREKpdgoEWs5RhDUMAHa2ToXs6zbf3ltT/fC
         mykrRfkRPe3+vcPsKNF30u7joW5mSeNlf6oRUA7W2Vt4sszk/lyA/L1R8IWz9qu5Bnde
         uc6sfb+aWDimB7ZV7cO1/fkX6VN39jRrtbUym5O8ZQ0S1V2k5Vu4+A2/yumFF1RkzKEP
         JzkMnhGb3c4GBUvLUB8L/l35l+YZGHtR0oxfSuFDEyvQN03ud61hJY1CA5vfQYlcPBLQ
         b1aoPKZUCPt+qku0WrhCB+u0oPBSuzIBdI34PrL57w7QBwR9r6nnzpo6DpcQoRkVECjT
         uCJA==
X-Gm-Message-State: AMke39n4ZB3ZTe8KEnv6Nn2EwyRG288HhvwQZh+EF4XYFetlZjifvZXgls0p+lNdQ0Xehw==
X-Received: by 10.28.23.66 with SMTP id 63mr10840672wmx.46.1488134900774;
        Sun, 26 Feb 2017 10:48:20 -0800 (PST)
Received: from slxBook4.fritz.box (p5DDB7AEC.dip0.t-ipconnect.de. [93.219.122.236])
        by smtp.gmail.com with ESMTPSA id g19sm11834828wrb.23.2017.02.26.10.48.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 26 Feb 2017 10:48:20 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@github.com, tboegi@web.de, e@80x24.org,
        jnareb@gmail.com, ttaylorr@github.com
Subject: [PATCH v2] convert: add "status=delayed" to filter process protocol
Date:   Sun, 26 Feb 2017 19:48:16 +0100
Message-Id: <20170226184816.30010-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Hi,

in v1 Junio criticized the "convert.h" interface of this patch [1].
After talking to Peff I think I understand Junio's point and I would
like to get your feedback on the new approach here. Please ignore all
changes behind async_convert_to_working_tree() and async_filter_finish()
for now as I plan to change the implementation as soon as the interface
is in an acceptable state.

The new interface also addresses Torsten's feedback and leaves
convert_to_working_tree() as is [2].

I also use '>' for numeric comparisons in Perl as suggested by Eric [3].

Please note, I rebased the patch to v2.12 as v1 did not apply clean on
master anymore.

Thanks,
Lars

[1] http://public-inbox.org/git/xmqqa8b115ll.fsf@gitster.mtv.corp.google.com/
[2] http://public-inbox.org/git/20170108201415.GA3569@tb-raspi/
[3] http://public-inbox.org/git/20170108204517.GA13779@starla/


RFC: http://public-inbox.org/git/D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com/
 v1: http://public-inbox.org/git/20170108191736.47359-1-larsxschneider@gmail.com/


Notes:
    Base Ref: v2.12.0
    Web-Diff: https://github.com/larsxschneider/git/commit/13d5b37021
    Checkout: git fetch https://github.com/larsxschneider/git filter-process/delay-v2 && git checkout 13d5b37021

 Documentation/gitattributes.txt |  9 ++++++
 builtin/checkout.c              |  1 +
 cache.h                         |  1 +
 convert.c                       | 68 +++++++++++++++++++++++++++++++++--------
 convert.h                       | 13 ++++++++
 entry.c                         | 29 +++++++++++++++---
 t/t0021-conversion.sh           | 53 ++++++++++++++++++++++++++++++++
 t/t0021/rot13-filter.pl         | 19 ++++++++++++
 unpack-trees.c                  |  1 +
 9 files changed, 176 insertions(+), 18 deletions(-)

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
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f174f50303..742e8742cd 100644
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
index 61fc86e6d7..66dde99a79 100644
--- a/cache.h
+++ b/cache.h
@@ -1434,6 +1434,7 @@ struct checkout {

 #define TEMPORARY_FILENAME_LENGTH 25
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
+extern int checkout_delayed_entries(const struct checkout *state);

 struct cache_def {
 	struct strbuf path;
diff --git a/convert.c b/convert.c
index 4e17e45ed2..24d29f5c53 100644
--- a/convert.c
+++ b/convert.c
@@ -4,6 +4,7 @@
 #include "quote.h"
 #include "sigchain.h"
 #include "pkt-line.h"
+#include "list.h"

 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -38,6 +39,13 @@ struct text_stat {
 	unsigned printable, nonprintable;
 };

+static LIST_HEAD(delayed_item_queue_head);
+
+struct delayed_item {
+	void* item;
+	struct list_head node;
+};
+
 static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
 {
 	unsigned long i;
@@ -672,7 +680,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 }

 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
-				   int fd, struct strbuf *dst, const char *cmd,
+				   int fd, struct strbuf *dst, int *delayed, const char *cmd,
 				   const unsigned int wanted_capability)
 {
 	int err;
@@ -738,9 +746,14 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
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
@@ -787,8 +800,8 @@ static struct convert_driver {
 } *user_convert, **user_convert_tail;

 static int apply_filter(const char *path, const char *src, size_t len,
-			int fd, struct strbuf *dst, struct convert_driver *drv,
-			const unsigned int wanted_capability)
+			int fd, struct strbuf *dst, int *delayed,
+			struct convert_driver *drv, const unsigned int wanted_capability)
 {
 	const char *cmd = NULL;

@@ -806,7 +819,7 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (cmd && *cmd)
 		return apply_single_file_filter(path, src, len, fd, dst, cmd);
 	else if (drv->process && *drv->process)
-		return apply_multi_file_filter(path, src, len, fd, dst, drv->process, wanted_capability);
+		return apply_multi_file_filter(path, src, len, fd, dst, delayed, drv->process, wanted_capability);

 	return 0;
 }
@@ -1152,7 +1165,7 @@ int would_convert_to_git_filter_fd(const char *path)
 	if (!ca.drv->required)
 		return 0;

-	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN);
+	return apply_filter(path, NULL, 0, -1, NULL, NULL, ca.drv, CAP_CLEAN);
 }

 const char *get_convert_attr_ascii(const char *path)
@@ -1189,7 +1202,7 @@ int convert_to_git(const char *path, const char *src, size_t len,

 	convert_attrs(&ca, path);

-	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN);
+	ret |= apply_filter(path, src, len, -1, dst, NULL, ca.drv, CAP_CLEAN);
 	if (!ret && ca.drv && ca.drv->required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

@@ -1214,7 +1227,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	assert(ca.drv);
 	assert(ca.drv->clean || ca.drv->process);

-	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
+	if (!apply_filter(path, NULL, 0, fd, dst, NULL, ca.drv, CAP_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
@@ -1222,7 +1235,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 }

 static int convert_to_working_tree_internal(const char *path, const char *src,
-					    size_t len, struct strbuf *dst,
+					    size_t len, struct strbuf *dst, int *delayed,
 					    int normalizing)
 {
 	int ret = 0, ret_filter = 0;
@@ -1248,21 +1261,50 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}

-	ret_filter = apply_filter(path, src, len, -1, dst, ca.drv, CAP_SMUDGE);
+	ret_filter = apply_filter(path, src, len, -1, dst, delayed, ca.drv, CAP_SMUDGE);
 	if (!ret_filter && ca.drv && ca.drv->required)
 		die("%s: smudge filter %s failed", path, ca.drv->name);

 	return ret | ret_filter;
 }

+int async_convert_to_working_tree(const char *path, const char *src,
+								  size_t len, struct strbuf *dst, void *item)
+{
+	int delayed = 0;
+	struct delayed_item *delayed_item;
+	if (convert_to_working_tree_internal(path, src, len, dst, &delayed, 0)) {
+		if (delayed) {
+			delayed_item = xmalloc(sizeof(*delayed_item));
+			delayed_item->item = item;
+			list_add_tail(&delayed_item->node, &delayed_item_queue_head);
+			return ASYNC_FILTER_DELAYED;
+		}
+		return ASYNC_FILTER_SUCCESS;
+	}
+	return ASYNC_FILTER_FAIL;
+}
+
+void* async_filter_finish(void)
+{
+	struct delayed_item *head;
+	if (!list_empty(&delayed_item_queue_head)) {
+		head = list_first_entry(&delayed_item_queue_head,
+			struct delayed_item, node);
+		list_del(&head->node);
+		return head->item;
+	}
+	return NULL;
+}
+
 int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	return convert_to_working_tree_internal(path, src, len, dst, 0);
+	return convert_to_working_tree_internal(path, src, len, dst, NULL, 0);
 }

 int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree_internal(path, src, len, dst, 1);
+	int ret = convert_to_working_tree_internal(path, src, len, dst, NULL, 1);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/convert.h b/convert.h
index 82871a11d5..acc016de9f 100644
--- a/convert.h
+++ b/convert.h
@@ -4,6 +4,15 @@
 #ifndef CONVERT_H
 #define CONVERT_H

+enum async_filter {
+	ASYNC_FILTER_SUCCESS = 0,
+	ASYNC_FILTER_FAIL = 1,
+	ASYNC_FILTER_DELAYED = 2
+};
+
+extern enum async_filter async_filter;
+
+
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
@@ -42,6 +51,10 @@ extern int convert_to_git(const char *path, const char *src, size_t len,
 			  struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
+extern int async_convert_to_working_tree(const char *path, const char *src,
+					 size_t len, struct strbuf *dst,
+					 void *item);
+extern void* async_filter_finish(void);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
 static inline int would_convert_to_git(const char *path)
diff --git a/entry.c b/entry.c
index c6eea240b6..d15e69a55e 100644
--- a/entry.c
+++ b/entry.c
@@ -177,11 +177,17 @@ static int write_entry(struct cache_entry *ce,
 		/*
 		 * Convert from git internal format to working tree format
 		 */
-		if (ce_mode_s_ifmt == S_IFREG &&
-		    convert_to_working_tree(ce->name, new, size, &buf)) {
-			free(new);
-			new = strbuf_detach(&buf, &newsize);
-			size = newsize;
+		if (ce_mode_s_ifmt == S_IFREG) {
+			ret = async_convert_to_working_tree(ce->name, new, size, &buf, ce);
+			if (ret == ASYNC_FILTER_SUCCESS) {
+				free(new);
+				new = strbuf_detach(&buf, &newsize);
+				size = newsize;
+			}
+			else if (ret == ASYNC_FILTER_DELAYED) {
+				free(new);
+				goto finish;
+			}
 		}

 		fd = open_output_fd(path, ce, to_tempfile);
@@ -291,3 +297,16 @@ int checkout_entry(struct cache_entry *ce,
 	create_directories(path.buf, path.len, state);
 	return write_entry(ce, path.buf, state, 0);
 }
+
+int checkout_delayed_entries(const struct checkout *state)
+{
+	struct cache_entry *ce;
+	int errs = 0;
+
+	while ((ce = async_filter_finish())) {
+		ce->ce_flags &= ~CE_UPDATE;
+		errs |= checkout_entry(ce, state, NULL);
+	}
+
+	return errs;
+}
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
index 617f581e56..ece0d314b4 100644
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
+		    $DELAY{$pathname} > 0 ) {
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
index 3a8ee19fe8..6b3246db03 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -315,6 +315,7 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 	}
+	errs |= checkout_delayed_entries(&state);
 	stop_progress(&progress);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);

base-commit: e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7
--
2.11.1

