Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA582023D
	for <e@80x24.org>; Mon, 22 May 2017 13:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759904AbdEVNuX (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 09:50:23 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32861 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757650AbdEVNuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 09:50:21 -0400
Received: by mail-wr0-f193.google.com with SMTP id w50so7012705wrc.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shdvUzEXOpyStYkTqg3wPsrIMM0xvo+IsZcHHkNtlto=;
        b=tYz1Sh5YhoTdAJA5sUXfVDExsM+DmjW+5aMCe6okjUoBcd1R4uiIn5SZ+H3qMnzk7r
         zITXTmpO+jyKarjZzxnS29Ryl++5OIN8ThDxRfa8T1QdfhvAppn/NnOX0QvG/oKn1/J9
         Cf5Wm5qzVvo+SGc62AfR03VIIGB4VSjpBR4Kh0LX5BNua5GMkszzr3cNXkIsdR8cfOQI
         HUBIQg+gnGUwZj7XwuaboxXLs/xwV312pCo4evJIwpswr2lObLIx2OpAXITJdjoMIJDi
         s0fe7Kr1g8cYE+a8cUBrNYmYkMfuzrzRXsfZeTkQyFYhuNrokXPyDsBa0bBf4yY5Pu1w
         DbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shdvUzEXOpyStYkTqg3wPsrIMM0xvo+IsZcHHkNtlto=;
        b=qgemcZdPJ8oygwJBDbaaPKHDbwpqtqvL/+W90UcWX0D8/8tIfyTR2ATl1pEmyYQ6JR
         ibR0A2LCZDhcm1VU3oiUIwgcazHZnhyvytggWEV+zNAyTeU71Xtaij8YFerCUUbZjju3
         FJwD0Xg3nAbM9YitNF2CL0mRYQiS4sjPTdsRdUVWHuNqTRVXSuroS0qNGYaRTfLPCJVv
         NIKTljHMuJ1NS1lA2hch/KnYnmrKY2Mj/F78ufHz1BlctTlhUcJU2YLYGIgVHF8RoKEa
         DNctiS9E758BUA3sM1NdGXD9K+cbybtZeMimtbNoQavMMiafsNoZyhD15IEI+eY+hwNT
         kR1w==
X-Gm-Message-State: AODbwcCHQ66Lkdimb/BFo+4ngLzironbiwXcky1BXgeXbclyhkINSsR1
        +ez52OmlmctYQw==
X-Received: by 10.223.136.55 with SMTP id d52mr11916248wrd.160.1495461009474;
        Mon, 22 May 2017 06:50:09 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y3sm22638070wmh.21.2017.05.22.06.50.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 06:50:09 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com
Subject: [PATCH v4 4/4] convert: add "status=delayed" to filter process protocol
Date:   Mon, 22 May 2017 15:50:01 +0200
Message-Id: <20170522135001.54506-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170522135001.54506-1-larsxschneider@gmail.com>
References: <20170522135001.54506-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some `clean` / `smudge` filters might require a significant amount of
time to process a single blob (e.g. the Git LFS smudge filter might
perform network requests). During this process the Git checkout
operation is blocked and Git needs to wait until the filter is done to
continue with the checkout.

Teach the filter process protocol (introduced in edcc858) to accept the
status "delayed" as response to a filter request. Upon this response Git
continues with the checkout operation. After the checkout operation Git
calls "finish_delayed_checkout" which queries the filter for remaining
blobs. If the filter is still working on the completion, then the filter
is expected to block. If the filter has completed all remaining blobs
then an empty response is expected.

Git has a multiple code paths that checkout a blob. Support delayed
checkouts only in `clone` (in unpack-trees.c) and `checkout` operations.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/gitattributes.txt |  65 +++++++++++++-
 builtin/checkout.c              |   3 +
 cache.h                         |   6 +-
 convert.c                       | 131 +++++++++++++++++++++++-----
 convert.h                       |  21 +++++
 entry.c                         | 110 +++++++++++++++++++++--
 t/t0021-conversion.sh           |  74 ++++++++++++++++
 t/t0021/rot13-filter.pl         | 189 ++++++++++++++++++++++++++--------------
 unpack-trees.c                  |   2 +
 9 files changed, 507 insertions(+), 94 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4736483865..ec92d3e3fa 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -425,8 +425,8 @@ packet:          git< capability=clean
 packet:          git< capability=smudge
 packet:          git< 0000
 ------------------------
-Supported filter capabilities in version 2 are "clean" and
-"smudge".
+Supported filter capabilities in version 2 are "clean", "smudge",
+and "delay".
 
 Afterwards Git sends a list of "key=value" pairs terminated with
 a flush packet. The list will contain at least the filter command
@@ -512,12 +512,69 @@ the protocol then Git will stop the filter process and restart it
 with the next file that needs to be processed. Depending on the
 `filter.<driver>.required` flag Git will interpret that as error.
 
-After the filter has processed a blob it is expected to wait for
-the next "key=value" list containing a command. Git will close
+After the filter has processed a command it is expected to wait for
+a "key=value" list containing the next command. Git will close
 the command pipe on exit. The filter is expected to detect EOF
 and exit gracefully on its own. Git will wait until the filter
 process has stopped.
 
+Delay
+^^^^^
+
+If the filter supports the "delay" capability, then Git can send the
+flag "can-delay" after the filter command and pathname. This flag
+denotes that the filter can delay filtering the current blob (e.g. to
+compensate network latencies) by responding with no content but with
+the status "delayed" and a flush packet.
+------------------------
+packet:          git> command=smudge
+packet:          git> pathname=path/testfile.dat
+packet:          git> can-delay=1
+packet:          git> 0000
+packet:          git> CONTENT
+packet:          git> 0000
+packet:          git< status=delayed
+packet:          git< 0000
+------------------------
+
+If the filter supports the "delay" capability then it must support the
+"list_available_blobs" command. If Git sends this command, then the
+filter is expected to return a list of pathnames of blobs that are
+available. The list must be terminated with a flush packet followed
+by a "success" status that is also terminated with a flush packet. If
+no blobs for the delayed paths are available, yet, then the filter is
+expected to block the response until at least one blob becomes
+available. The filter can tell Git that it has no more delayed blobs
+by sending an empty list.
+------------------------
+packet:          git> command=list_available_blobs
+packet:          git> 0000
+packet:          git< pathname=path/testfile.dat
+packet:          git< pathname=path/otherfile.dat
+packet:          git< 0000
+packet:          git< status=success
+packet:          git< 0000
+------------------------
+
+After Git received the pathnames, it will request the corresponding
+blobs again. These requests contain a pathname and an empty content
+section. The filter is expected to respond with the smudged content
+in the usual way as explained above.
+------------------------
+packet:          git> command=smudge
+packet:          git> pathname=path/testfile.dat
+packet:          git> 0000
+packet:          git> 0000  # empty content!
+packet:          git< status=success
+packet:          git< 0000
+packet:          git< SMUDGED_CONTENT
+packet:          git< 0000
+packet:          git< 0000
+------------------------
+
+Example
+^^^^^^^
+
 A long running filter demo implementation can be found in
 `contrib/long-running-filter/example.pl` located in the Git
 core repository. If you develop your own long running filter
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f33..dc5638a3bd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -374,6 +374,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	state.force = 1;
 	state.refresh_cache = 1;
 	state.istate = &the_index;
+
+	enable_delayed_checkout(&state);
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
@@ -388,6 +390,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
+	errs |= finish_delayed_checkout(&state);
 
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
diff --git a/cache.h b/cache.h
index 188811920c..2a5945a25c 100644
--- a/cache.h
+++ b/cache.h
@@ -1542,16 +1542,20 @@ extern int ident_cmp(const struct ident_split *, const struct ident_split *);
 struct checkout {
 	struct index_state *istate;
 	const char *base_dir;
+	struct delayed_checkout *delayed_checkout;
 	int base_dir_len;
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
 		 refresh_cache:1;
 };
-#define CHECKOUT_INIT { NULL, "" }
+#define CHECKOUT_INIT { NULL, "", NULL }
+
 
 #define TEMPORARY_FILENAME_LENGTH 25
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
+extern void enable_delayed_checkout(struct checkout *state);
+extern int finish_delayed_checkout(struct checkout *state);
 
 struct cache_def {
 	struct strbuf path;
diff --git a/convert.c b/convert.c
index 8d652bf27c..bc83933c62 100644
--- a/convert.c
+++ b/convert.c
@@ -495,6 +495,7 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 
 #define CAP_CLEAN    (1u<<0)
 #define CAP_SMUDGE   (1u<<1)
+#define CAP_DELAY    (1u<<2)
 
 struct cmd2process {
 	struct hashmap_entry ent; /* must be the first member! */
@@ -632,7 +633,8 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	if (err)
 		goto done;
 
-	err = packet_write_list(process->in, "capability=clean", "capability=smudge", NULL);
+	err = packet_write_list(process->in,
+		"capability=clean", "capability=smudge", "capability=delay", NULL);
 
 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
@@ -648,6 +650,8 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 			entry->supported_capabilities |= CAP_CLEAN;
 		} else if (!strcmp(cap_name, "smudge")) {
 			entry->supported_capabilities |= CAP_SMUDGE;
+		} else if (!strcmp(cap_name, "delay")) {
+			entry->supported_capabilities |= CAP_DELAY;
 		} else {
 			warning(
 				"external filter '%s' requested unsupported filter capability '%s'",
@@ -673,9 +677,11 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
 				   int fd, struct strbuf *dst, const char *cmd,
-				   const unsigned int wanted_capability)
+				   const unsigned int wanted_capability,
+				   struct delayed_checkout *dco)
 {
 	int err;
+	int can_delay = 0;
 	struct cmd2process *entry;
 	struct child_process *process;
 	struct strbuf nbuf = STRBUF_INIT;
@@ -726,6 +732,14 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
+	if (CAP_DELAY & entry->supported_capabilities &&
+	    dco && dco->state == CE_CAN_DELAY) {
+		can_delay = 1;
+		err = packet_write_fmt_gently(process->in, "can-delay=1\n");
+		if (err)
+			goto done;
+	}
+
 	err = packet_flush_gently(process->in);
 	if (err)
 		goto done;
@@ -738,16 +752,22 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		goto done;
 
 	read_multi_file_filter_status(process->out, &filter_status);
-	err = strcmp(filter_status.buf, "success");
-	if (err)
-		goto done;
-
-	err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
-	if (err)
-		goto done;
+	if (can_delay && !strcmp(filter_status.buf, "delayed")) {
+		dco->state = CE_DELAYED;
+		string_list_insert(&dco->filters, cmd);
+		string_list_insert(&dco->paths, path);
+	} else {
+		/* The filter got the blob and wants to send us a response. */
+		err = strcmp(filter_status.buf, "success");
+		if (err)
+			goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
-	err = strcmp(filter_status.buf, "success");
+		err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
+		if (err)
+			goto done;
+		read_multi_file_filter_status(process->out, &filter_status);
+		err = strcmp(filter_status.buf, "success");
+	}
 
 done:
 	sigchain_pop(SIGPIPE);
@@ -777,6 +797,67 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	return !err;
 }
 
+
+int async_query_available_blobs(const char *cmd, struct string_list *delayed_paths)
+{
+	int err;
+	char *line;
+	struct cmd2process *entry;
+	struct child_process *process;
+	struct strbuf filter_status = STRBUF_INIT;
+
+	entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
+	if (!entry) {
+		error("external filter '%s' is not available anymore although "
+		      "not all paths have been filtered", cmd);
+		return 0;
+	}
+	process = &entry->process;
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = packet_write_fmt_gently(
+		process->in, "command=list_available_blobs\n");
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;
+
+	for (;;) {
+		const char* pre = "pathname=";
+		const int pre_len = strlen(pre);
+		line = packet_read_line(process->out, NULL);
+		if (!line)
+			break;
+		err = strlen(line) <= pre_len || strncmp(line, pre, pre_len);
+		if (err)
+			goto done;
+		string_list_insert(delayed_paths, xstrdup(line+pre_len));
+	}
+
+	read_multi_file_filter_status(process->out, &filter_status);
+	err = strcmp(filter_status.buf, "success");
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	if (err || errno == EPIPE) {
+		if (!strcmp(filter_status.buf, "error")) {
+			/* The filter signaled a problem with the file. */
+		} else {
+			/*
+			 * Something went wrong with the protocol filter.
+			 * Force shutdown and restart if another blob requires
+			 * filtering.
+			 */
+			error("external filter '%s' failed", cmd);
+			kill_multi_file_filter(&cmd_process_map, entry);
+		}
+	}
+	return !err;
+}
+
 static struct convert_driver {
 	const char *name;
 	struct convert_driver *next;
@@ -788,7 +869,8 @@ static struct convert_driver {
 
 static int apply_filter(const char *path, const char *src, size_t len,
 			int fd, struct strbuf *dst, struct convert_driver *drv,
-			const unsigned int wanted_capability)
+			const unsigned int wanted_capability,
+			struct delayed_checkout *dco)
 {
 	const char *cmd = NULL;
 
@@ -806,7 +888,8 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (cmd && *cmd)
 		return apply_single_file_filter(path, src, len, fd, dst, cmd);
 	else if (drv->process && *drv->process)
-		return apply_multi_file_filter(path, src, len, fd, dst, drv->process, wanted_capability);
+		return apply_multi_file_filter(path, src, len, fd, dst,
+			drv->process, wanted_capability, dco);
 
 	return 0;
 }
@@ -1147,7 +1230,7 @@ int would_convert_to_git_filter_fd(const char *path)
 	if (!ca.drv->required)
 		return 0;
 
-	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN);
+	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN, NULL);
 }
 
 const char *get_convert_attr_ascii(const char *path)
@@ -1184,7 +1267,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 
 	convert_attrs(&ca, path);
 
-	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN);
+	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN, NULL);
 	if (!ret && ca.drv && ca.drv->required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
@@ -1209,7 +1292,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	assert(ca.drv);
 	assert(ca.drv->clean || ca.drv->process);
 
-	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
+	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
@@ -1218,7 +1301,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 
 static int convert_to_working_tree_internal(const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
-					    int normalizing)
+					    int normalizing, struct delayed_checkout *dco)
 {
 	int ret = 0, ret_filter = 0;
 	struct conv_attrs ca;
@@ -1243,21 +1326,29 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
-	ret_filter = apply_filter(path, src, len, -1, dst, ca.drv, CAP_SMUDGE);
+	ret_filter = apply_filter(
+		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
 	if (!ret_filter && ca.drv && ca.drv->required)
 		die("%s: smudge filter %s failed", path, ca.drv->name);
 
 	return ret | ret_filter;
 }
 
+int async_convert_to_working_tree(const char *path, const char *src,
+				  size_t len, struct strbuf *dst,
+				  void *dco)
+{
+	return convert_to_working_tree_internal(path, src, len, dst, 0, dco);
+}
+
 int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	return convert_to_working_tree_internal(path, src, len, dst, 0);
+	return convert_to_working_tree_internal(path, src, len, dst, 0, NULL);
 }
 
 int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree_internal(path, src, len, dst, 1);
+	int ret = convert_to_working_tree_internal(path, src, len, dst, 1, NULL);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/convert.h b/convert.h
index 82871a11d5..c4beaa5101 100644
--- a/convert.h
+++ b/convert.h
@@ -4,6 +4,8 @@
 #ifndef CONVERT_H
 #define CONVERT_H
 
+#include "string-list.h"
+
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
@@ -32,6 +34,21 @@ enum eol {
 #endif
 };
 
+enum ce_delay_state {
+	CE_NO_DELAY = 0,
+	CE_CAN_DELAY = 1,
+	CE_DELAYED = 2,
+	CE_RETRY = 3
+};
+
+struct delayed_checkout {
+	enum ce_delay_state state;
+	/* List of filter drivers that signaled delayed blobs. */
+	struct string_list filters;
+	/* List of delayed blobs identified by their path. */
+	struct string_list paths;
+};
+
 extern enum eol core_eol;
 extern const char *get_cached_convert_stats_ascii(const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
@@ -42,6 +59,10 @@ extern int convert_to_git(const char *path, const char *src, size_t len,
 			  struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
+extern int async_convert_to_working_tree(const char *path, const char *src,
+					 size_t len, struct strbuf *dst,
+					 void *dco);
+extern int async_query_available_blobs(const char *cmd, struct string_list *delayed_paths);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
 static inline int would_convert_to_git(const char *path)
diff --git a/entry.c b/entry.c
index d2b512da90..73068117f4 100644
--- a/entry.c
+++ b/entry.c
@@ -137,6 +137,81 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
 	return result;
 }
 
+void enable_delayed_checkout(struct checkout *state)
+{
+	if (!state->delayed_checkout) {
+		state->delayed_checkout = xmalloc(sizeof(*state->delayed_checkout));
+		state->delayed_checkout->state = CE_CAN_DELAY;
+		string_list_init(&state->delayed_checkout->filters, 0);
+		string_list_init(&state->delayed_checkout->paths, 0);
+	}
+}
+
+static int remove_available_paths(struct string_list_item *item, void *cb_data)
+{
+	struct string_list *available_paths = cb_data;
+	return !string_list_has_string(available_paths, item->string);
+}
+
+int finish_delayed_checkout(struct checkout *state)
+{
+	int errs = 0;
+	struct string_list_item *filter, *path;
+	struct delayed_checkout *dco = state->delayed_checkout;
+
+	if (!state->delayed_checkout) {
+		return errs;
+	}
+
+	while (dco->filters.nr > 0) {
+		for_each_string_list_item(filter, &dco->filters) {
+			struct string_list available_paths;
+			string_list_init(&available_paths, 0);
+
+			if (!async_query_available_blobs(filter->string, &available_paths)) {
+				/* Filter reported an error */
+				errs = 1;
+				filter->string = "";
+				continue;
+			}
+			if (available_paths.nr <= 0) {
+				/* Filter responded with no entries. That means
+				   the filter is done and we can remove the
+				   filter from the list (see
+				   "string_list_remove_empty_items" call below).
+				*/
+				filter->string = "";
+				continue;
+			}
+
+			/* In dco->paths we store a list of all delayed paths.
+			   The filter just send us a list of available paths.
+			   Remove them from the list.
+			*/
+			filter_string_list(&dco->paths, 0,
+				&remove_available_paths, &available_paths);
+
+			for_each_string_list_item(path, &available_paths) {
+				struct cache_entry* ce = index_file_exists(
+					state->istate, path->string,
+					strlen(path->string), 0);
+				dco->state = CE_RETRY;
+				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
+			}
+		}
+		string_list_remove_empty_items(&dco->filters, 0);
+	}
+	string_list_clear(&dco->filters, 0);
+
+	/* At this point we should not have any delayed paths anymore. */
+	errs |= dco->paths.nr;
+
+	free(dco);
+	state->delayed_checkout = NULL;
+
+	return errs;
+}
+
 static int write_entry(struct cache_entry *ce,
 		       char *path, const struct checkout *state, int to_tempfile)
 {
@@ -179,11 +254,36 @@ static int write_entry(struct cache_entry *ce,
 		/*
 		 * Convert from git internal format to working tree format
 		 */
-		if (ce_mode_s_ifmt == S_IFREG &&
-		    convert_to_working_tree(ce->name, new, size, &buf)) {
-			free(new);
-			new = strbuf_detach(&buf, &newsize);
-			size = newsize;
+		if (ce_mode_s_ifmt == S_IFREG) {
+			struct delayed_checkout *dco = state->delayed_checkout;
+			if (dco && dco->state != CE_NO_DELAY) {
+				/* Do not send the blob in case of a retry. */
+				if (dco->state == CE_RETRY) {
+					new = NULL;
+					size = 0;
+				}
+				ret = async_convert_to_working_tree(
+					ce->name, new, size, &buf, dco);
+				if (ret && dco->state == CE_DELAYED) {
+					free(new);
+					/* Reset the state of the next blob */
+					dco->state = CE_CAN_DELAY;
+					goto finish;
+				}
+			} else
+				ret = convert_to_working_tree(
+					ce->name, new, size, &buf);
+
+			if (ret) {
+				free(new);
+				new = strbuf_detach(&buf, &newsize);
+				size = newsize;
+			}
+			/*
+			 * No "else" here as errors from convert are OK at this
+			 * point. If the error would have been fatal (e.g.
+			 * filter is required), then we would have died already.
+			 */
 		}
 
 		fd = open_output_fd(path, ce, to_tempfile);
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 0c04d346a1..4b5a45fd43 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -701,4 +701,78 @@ test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
 	)
 '
 
+test_expect_success PERL 'delayed checkout in process filter' '
+	test_config_global filter.a.process "rot13-filter.pl a.log clean smudge delay" &&
+	test_config_global filter.a.required true &&
+	test_config_global filter.b.process "rot13-filter.pl b.log clean smudge delay" &&
+	test_config_global filter.b.required true &&
+
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+		echo "*.a filter=a" >.gitattributes &&
+		echo "*.b filter=b" >>.gitattributes &&
+		cp "$TEST_ROOT/test.o" test.a &&
+		cp "$TEST_ROOT/test.o" test-delay10.a &&
+		cp "$TEST_ROOT/test.o" test-delay11.a &&
+		cp "$TEST_ROOT/test.o" test-delay20.a &&
+		cp "$TEST_ROOT/test.o" test-delay10.b &&
+		git add . &&
+		git commit -m "test commit 1"
+	) &&
+
+	S=$(file_size "$TEST_ROOT/test.o") &&
+	cat >a.exp <<-EOF &&
+		START
+		init handshake complete
+		IN: smudge test.a $S [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay10.a $S [OK] -- [DELAYED]
+		IN: smudge test-delay11.a $S [OK] -- [DELAYED]
+		IN: smudge test-delay20.a $S [OK] -- [DELAYED]
+		IN: list_available_blobs test-delay10.a test-delay11.a [OK]
+		IN: smudge test-delay10.a 0 [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay11.a 0 [OK] -- OUT: $S . [OK]
+		IN: list_available_blobs test-delay20.a [OK]
+		IN: smudge test-delay20.a 0 [OK] -- OUT: $S . [OK]
+		IN: list_available_blobs [OK]
+		STOP
+	EOF
+	cat >b.exp <<-EOF &&
+		START
+		init handshake complete
+		IN: smudge test-delay10.b $S [OK] -- [DELAYED]
+		IN: list_available_blobs test-delay10.b [OK]
+		IN: smudge test-delay10.b 0 [OK] -- OUT: $S . [OK]
+		IN: list_available_blobs [OK]
+		STOP
+	EOF
+
+	rm -rf repo-cloned &&
+	filter_git clone repo repo-cloned &&
+	test_cmp_count a.exp repo-cloned/a.log &&
+	test_cmp_count b.exp repo-cloned/b.log &&
+
+	(
+		cd repo-cloned &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay10.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay11.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay20.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay10.b &&
+
+		rm *.a *.b &&
+		filter_git checkout . &&
+		test_cmp_count ../a.exp a.log &&
+		test_cmp_count ../b.exp b.log &&
+
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay10.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay11.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay20.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay10.b
+	)
+'
+
 test_done
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 5e43faeec1..f0dc0aff4a 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -18,6 +18,11 @@
 #     operation then the filter signals that it cannot or does not want
 #     to process the file and any file after that is processed with the
 #     same command.
+# (5) If data with a pathname that is a key in the DELAY hash is
+#     requested (e.g. 'test-delay10.a') then the filter responds with
+#     a "delay" status and sets the "requested" field in the DELAY hash.
+#     The filter will signal the availability of this object after
+#     "count" (field in DELAY hash) "list_available_blobs" commands.
 #
 
 use strict;
@@ -30,6 +35,13 @@ my @capabilities            = @ARGV;
 
 open my $debug, ">>", $log_file or die "cannot open log file: $!";
 
+my %DELAY = (
+	'test-delay10.a' => { "requested" => 0, "count" => 1 },
+	'test-delay11.a' => { "requested" => 0, "count" => 1 },
+	'test-delay20.a' => { "requested" => 0, "count" => 2 },
+	'test-delay10.b' => { "requested" => 0, "count" => 1 },
+);
+
 sub rot13 {
 	my $str = shift;
 	$str =~ y/A-Za-z/N-ZA-Mn-za-m/;
@@ -66,7 +78,7 @@ sub packet_bin_read {
 
 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
-	unless ( $buf =~ s/\n$// ) {
+	unless ( $buf eq '' or $buf =~ s/\n$// ) {
 		die "A non-binary line MUST be terminated by an LF.";
 	}
 	return ( $res, $buf );
@@ -101,6 +113,7 @@ packet_flush();
 
 ( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
 ( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
+( packet_txt_read() eq ( 0, "capability=delay" ) )  || die "bad capability";
 ( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
 
 foreach (@capabilities) {
@@ -115,84 +128,132 @@ while (1) {
 	print $debug "IN: $command";
 	$debug->flush();
 
-	my ($pathname) = packet_txt_read() =~ /^pathname=(.+)$/;
-	print $debug " $pathname";
-	$debug->flush();
-
-	if ( $pathname eq "" ) {
-		die "bad pathname '$pathname'";
-	}
+	if ( $command eq "list_available_blobs" ) {
+		# Flush
+		packet_bin_read();
 
-	# Flush
-	packet_bin_read();
-
-	my $input = "";
-	{
-		binmode(STDIN);
-		my $buffer;
-		my $done = 0;
-		while ( !$done ) {
-			( $done, $buffer ) = packet_bin_read();
-			$input .= $buffer;
+		foreach my $pathname (sort keys %DELAY) {
+			if ( $DELAY{$pathname}{"requested"} >= 1 ) {
+				$DELAY{$pathname}{"count"} = $DELAY{$pathname}{"count"} - 1;
+				if ($DELAY{$pathname}{"count"} == 0 ) {
+					print $debug " $pathname";
+					packet_txt_write("pathname=$pathname");
+				}
+			}
 		}
-		print $debug " " . length($input) . " [OK] -- ";
-		$debug->flush();
-	}
-
-	my $output;
-	if ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
-		$output = "";
-	}
-	elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
-		$output = rot13($input);
-	}
-	elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
-		$output = rot13($input);
-	}
-	else {
-		die "bad command '$command'";
-	}
 
-	if ( $pathname eq "error.r" ) {
-		print $debug "[ERROR]\n";
-		$debug->flush();
-		packet_txt_write("status=error");
 		packet_flush();
-	}
-	elsif ( $pathname eq "abort.r" ) {
-		print $debug "[ABORT]\n";
+
+		print $debug " [OK]\n";
 		$debug->flush();
-		packet_txt_write("status=abort");
+		packet_txt_write("status=success");
 		packet_flush();
 	}
 	else {
-		packet_txt_write("status=success");
-		packet_flush();
+		my ($pathname) = packet_txt_read() =~ /^pathname=(.+)$/;
+		print $debug " $pathname";
+		$debug->flush();
+
+		if ( $pathname eq "" ) {
+			die "bad pathname '$pathname'";
+		}
+
+		# Read until flush
+		my ( $done, $buffer ) = packet_txt_read();
+		while ( $buffer ne '' ) {
+			if ( $buffer eq "can-delay=1" ) {
+				if ( exists $DELAY{$pathname} and $DELAY{$pathname}{"requested"} == 0 ) {
+					$DELAY{$pathname}{"requested"} = 1;
+				}
+			} else {
+				die "Unknown message '$buffer'";
+			}
 
-		if ( $pathname eq "${command}-write-fail.r" ) {
-			print $debug "[WRITE FAIL]\n";
+			( $done, $buffer ) = packet_txt_read();
+		}
+
+		my $input = "";
+		{
+			binmode(STDIN);
+			my $buffer;
+			my $done = 0;
+			while ( !$done ) {
+				( $done, $buffer ) = packet_bin_read();
+				$input .= $buffer;
+			}
+			print $debug " " . length($input) . " [OK] -- ";
 			$debug->flush();
-			die "${command} write error";
 		}
 
-		print $debug "OUT: " . length($output) . " ";
-		$debug->flush();
+		my $output;
+		if ( exists $DELAY{$pathname} and exists $DELAY{$pathname}{"output"} ) {
+			$output = $DELAY{$pathname}{"output"}
+		}
+		elsif ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
+			$output = "";
+		}
+		elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
+			$output = rot13($input);
+		}
+		elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
+			$output = rot13($input);
+		}
+		else {
+			die "bad command '$command'";
+		}
+
+		if ( $pathname eq "error.r" ) {
+			print $debug "[ERROR]\n";
+			$debug->flush();
+			packet_txt_write("status=error");
+			packet_flush();
+		}
+		elsif ( $pathname eq "abort.r" ) {
+			print $debug "[ABORT]\n";
+			$debug->flush();
+			packet_txt_write("status=abort");
+			packet_flush();
+		}
+		elsif ( $command eq "smudge" and
+			exists $DELAY{$pathname} and
+			$DELAY{$pathname}{"requested"} == 1
+		) {
+			print $debug "[DELAYED]\n";
+			$debug->flush();
+			packet_txt_write("status=delayed");
+			packet_flush();
+			$DELAY{$pathname}{"requested"} = 2;
+			$DELAY{$pathname}{"output"} = $output;
+		}
+		else {
+			packet_txt_write("status=success");
+			packet_flush();
 
-		while ( length($output) > 0 ) {
-			my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
-			packet_bin_write($packet);
-			# dots represent the number of packets
-			print $debug ".";
-			if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
-				$output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
+			if ( $pathname eq "${command}-write-fail.r" ) {
+				print $debug "[WRITE FAIL]\n";
+				$debug->flush();
+				die "${command} write error";
 			}
-			else {
-				$output = "";
+
+			print $debug "OUT: " . length($output) . " ";
+			$debug->flush();
+
+			while ( length($output) > 0 ) {
+				my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
+				packet_bin_write($packet);
+				# dots represent the number of packets
+				print $debug ".";
+				if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
+					$output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
+				}
+				else {
+					$output = "";
+				}
 			}
+			packet_flush();
+			print $debug " [OK]\n";
+			$debug->flush();
+			packet_flush();
 		}
-		packet_flush();
-		print $debug " [OK]\n";
-		$debug->flush();
-		packet_flush();
 	}
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index aa15111fef..009fcacb4b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -374,6 +374,7 @@ static int check_updates(struct unpack_trees_options *o)
 	if (should_update_submodules() && o->update && !o->dry_run)
 		reload_gitmodules_file(index, &state);
 
+	enable_delayed_checkout(&state);
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -388,6 +389,7 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 	}
+	errs |= finish_delayed_checkout(&state);
 	stop_progress(&progress);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
-- 
2.13.0

