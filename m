Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6917BA1
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754233302; cv=pass; b=MOsaXLhFQ9rXQEu58dlS5mzFlDhl2WByu0tKP+rUkoQOvBvhhR1MEDAzfXftUS9TVm3RvqIFWvBDb30d7ybFF1TDQAKjcmkxeYD5m4Om2Yr5G870SB5bTDtdWMsO3R6XP/K72DEztPUqPfOmqZ4hmiSgk6OEC4Ea3OBZYIPg/Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754233302; c=relaxed/simple;
	bh=hzc539kagI8F/S+DQ9VVqOH/koRB4NBs7AxCcmUpfgQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sq8IZ7kjtC/aiYN0yCvMu6O/wbBIjBKHzzJeBQnFYqijAPh+uUz8LW1Dpey4vslbA2QMsLHQ8JvV/1NhW/ln94f8wiDJX14xdkQh1B8J/BIl/TCUIuyIMtNMPeFzJF10YarZawwiHHGF+BdAtOpXHNCzlaIk3ioaIb8hpP0/emE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Fde6Q5Ks; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Fde6Q5Ks"
ARC-Seal: i=1; a=rsa-sha256; t=1754233279; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NnBCcuJc+ayMxigygoHFL+geKicnzv3s/h6RZmLXT8Ax7MvaNfqVdgsDf21tvgtL5TKeOW3R404/qVTFYjKZfAWKNO9B4dWC0071AB2PjoGCbBcuwCftCWKlgZe/aRLZC4nEzthDE9dQvTiATfiLaR0qOFXNa/t0S4l7/9eEov8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754233279; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=TKvpA31iU+OpSuLCOXKYm6asr2MNyIVaDp59Deox/PI=; 
	b=npQOqHqRDj38/ZpZrXg8mbpQmgnSz/b6cGSwm76hAu4Ra373QHLDhmJB94uqqMwETGSI2lcNQuJ2M5dAAf36+CjWEtTzxae4P8brzVPIgcs8i6mglX8xTS+CpAJvB+DiO6BSFYXOA3Z2wONx2e6TvvD6O2DmmHkaxlQLr67Ib78=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754233279;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=TKvpA31iU+OpSuLCOXKYm6asr2MNyIVaDp59Deox/PI=;
	b=Fde6Q5KswEq2GjWUBK4JOwRClXsSJ/349Xv/DdQwQrFRT1CcJHruDcZUBAD5zWHD
	VtbIULsTJM9+GES0CiFWqVoPZ79Q1sxY9PMs1DdAQHzjTIUgfOf6KwOdXtJSl1Vh1bJ
	cl3Oi+s83zM4rSOvegfQseNtBLiDlnmJjCiHC7DM=
Received: by mx.zohomail.com with SMTPS id 1754233269481508.5511455894339;
	Sun, 3 Aug 2025 08:01:09 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v3 1/2] trailer: append trailers in-process and drop the fork to `interpret-trailers`
Date: Sun,  3 Aug 2025 23:00:56 +0800
Message-ID: <20250803150059.402017-2-me@linux.beauty>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250803150059.402017-1-me@linux.beauty>
References: <20250803150059.402017-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

All trailer insertion now funnels through trailer_process():

* builtin/interpret-trailers.c is reduced to file I/O + a single call.
* amend_file_with_trailers() shares the same path; the old
  amend_strbuf_with_trailers() helper is dropped.
* New helpers parse_trailer_args()/free_new_trailer_list() convert
  --trailer=... strings to new_trailer_item lists.

Behaviour is unchanged; the full test-suite still passes, and the
fork/exec is gone.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/interpret-trailers.c | 117 ++++++++------------------------
 trailer.c                    | 125 ++++++++++++++++++++++++++++++++---
 trailer.h                    |  18 ++++-
 3 files changed, 158 insertions(+), 102 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 44d8ccddc9..3a49d3d7b0 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -9,7 +9,6 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
-#include "tempfile.h"
 #include "trailer.h"
 #include "config.h"
 
@@ -84,6 +83,7 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 			   int unset)
 {
 	struct process_trailer_options *v = opt->value;
+
 	v->only_trailers = 1;
 	v->only_input = 1;
 	v->unfold = 1;
@@ -92,37 +92,6 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static struct tempfile *trailers_tempfile;
-
-static FILE *create_in_place_tempfile(const char *file)
-{
-	struct stat st;
-	struct strbuf filename_template = STRBUF_INIT;
-	const char *tail;
-	FILE *outfile;
-
-	if (stat(file, &st))
-		die_errno(_("could not stat %s"), file);
-	if (!S_ISREG(st.st_mode))
-		die(_("file %s is not a regular file"), file);
-	if (!(st.st_mode & S_IWUSR))
-		die(_("file %s is not writable by user"), file);
-
-	/* Create temporary file in the same directory as the original */
-	tail = strrchr(file, '/');
-	if (tail)
-		strbuf_add(&filename_template, file, tail - file + 1);
-	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
-
-	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
-	strbuf_release(&filename_template);
-	outfile = fdopen_tempfile(trailers_tempfile, "w");
-	if (!outfile)
-		die_errno(_("could not open temporary file"));
-
-	return outfile;
-}
-
 static void read_input_file(struct strbuf *sb, const char *file)
 {
 	if (file) {
@@ -135,61 +104,6 @@ static void read_input_file(struct strbuf *sb, const char *file)
 	strbuf_complete_line(sb);
 }
 
-static void interpret_trailers(const struct process_trailer_options *opts,
-			       struct list_head *new_trailer_head,
-			       const char *file)
-{
-	LIST_HEAD(head);
-	struct strbuf sb = STRBUF_INIT;
-	struct strbuf trailer_block_sb = STRBUF_INIT;
-	struct trailer_block *trailer_block;
-	FILE *outfile = stdout;
-
-	trailer_config_init();
-
-	read_input_file(&sb, file);
-
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
-	trailer_block = parse_trailers(opts, sb.buf, &head);
-
-	/* Print the lines before the trailer block */
-	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
-
-	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
-		fprintf(outfile, "\n");
-
-
-	if (!opts->only_input) {
-		LIST_HEAD(config_head);
-		LIST_HEAD(arg_head);
-		parse_trailers_from_config(&config_head);
-		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
-		list_splice(&config_head, &arg_head);
-		process_trailers_lists(&head, &arg_head);
-	}
-
-	/* Print trailer block. */
-	format_trailers(opts, &head, &trailer_block_sb);
-	free_trailers(&head);
-	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
-	strbuf_release(&trailer_block_sb);
-
-	/* Print the lines after the trailer block as is. */
-	if (!opts->only_trailers)
-		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
-		       sb.len - trailer_block_end(trailer_block), outfile);
-	trailer_block_release(trailer_block);
-
-	if (opts->in_place)
-		if (rename_tempfile(&trailers_tempfile, file))
-			die_errno(_("could not rename temporary file to %s"), file);
-
-	strbuf_release(&sb);
-}
-
 int cmd_interpret_trailers(int argc,
 			   const char **argv,
 			   const char *prefix,
@@ -231,14 +145,37 @@ int cmd_interpret_trailers(int argc,
 			git_interpret_trailers_usage,
 			options);
 
+	trailer_config_init();
+
 	if (argc) {
 		int i;
-		for (i = 0; i < argc; i++)
-			interpret_trailers(&opts, &trailers, argv[i]);
+		for (i = 0; i < argc; i++) {
+			struct strbuf in_buf = STRBUF_INIT;
+			struct strbuf out_buf = STRBUF_INIT;
+
+			read_input_file(&in_buf, argv[i]);
+			if (trailer_process(&opts, in_buf.buf, &trailers, &out_buf) < 0)
+				die(_("failed to process trailers for %s"), argv[i]);
+			if (opts.in_place)
+				write_file_buf(argv[i], out_buf.buf, out_buf.len);
+			else
+				fwrite(out_buf.buf, 1, out_buf.len, stdout);
+			strbuf_release(&in_buf);
+			strbuf_release(&out_buf);
+		}
 	} else {
+		struct strbuf in_buf = STRBUF_INIT;
+		struct strbuf out_buf = STRBUF_INIT;
+
 		if (opts.in_place)
 			die(_("no input file given for in-place editing"));
-		interpret_trailers(&opts, &trailers, NULL);
+
+		read_input_file(&in_buf, NULL);
+		if (trailer_process(&opts, in_buf.buf, &trailers, &out_buf) < 0)
+			die(_("failed to process trailers"));
+		fwrite(out_buf.buf, 1, out_buf.len, stdout);
+		strbuf_release(&in_buf);
+		strbuf_release(&out_buf);
 	}
 
 	new_trailers_clear(&trailers);
diff --git a/trailer.c b/trailer.c
index 310cf582dc..03814443c3 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1224,14 +1224,121 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->key);
 }
 
-int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
+static int amend_strbuf_with_trailers(struct strbuf *buf,
+				   const struct strvec *trailer_args)
 {
-	struct child_process run_trailer = CHILD_PROCESS_INIT;
-
-	run_trailer.git_cmd = 1;
-	strvec_pushl(&run_trailer.args, "interpret-trailers",
-		     "--in-place", "--no-divider",
-		     path, NULL);
-	strvec_pushv(&run_trailer.args, trailer_args->v);
-	return run_command(&run_trailer);
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	LIST_HEAD(new_trailer_head);
+	struct strbuf out = STRBUF_INIT;
+	size_t i;
+
+	opts.no_divider = 1;
+
+	for (i = 0; i < trailer_args->nr; i++) {
+		const char *arg = trailer_args->v[i];
+		const char *text;
+		struct new_trailer_item *item;
+		if (!skip_prefix(arg, "--trailer=", &text))
+			text = arg;
+		if (!*text)
+			continue;
+		item = xcalloc(1, sizeof(*item));
+		INIT_LIST_HEAD(&item->list);
+		item->text = text;
+		list_add_tail(&item->list, &new_trailer_head);
+	}
+	if (trailer_process(&opts, buf->buf, &new_trailer_head, &out) < 0)
+		die("failed to process trailers");
+	strbuf_swap(buf, &out);
+	strbuf_release(&out);
+	while (!list_empty(&new_trailer_head)) {
+		struct new_trailer_item *item =
+			list_first_entry(&new_trailer_head, struct new_trailer_item, list);
+		list_del(&item->list);
+		free(item);
+	}
+	return 0;
 }
+
+int trailer_process(const struct process_trailer_options *opts,
+				   const char *msg,
+				   struct list_head *new_trailer_head,
+				   struct strbuf *out)
+{
+		struct trailer_block *blk;
+		LIST_HEAD(orig_head);
+		LIST_HEAD(config_head);
+		LIST_HEAD(arg_head);
+		struct strbuf trailers_sb = STRBUF_INIT;
+		int had_trailer_before;
+
+		blk = parse_trailers(opts, msg, &orig_head);
+		had_trailer_before = !list_empty(&orig_head);
+		if (!opts->only_input) {
+			parse_trailers_from_config(&config_head);
+			parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
+			list_splice(&config_head, &arg_head);
+			process_trailers_lists(&orig_head, &arg_head);
+		}
+		format_trailers(opts, &orig_head, &trailers_sb);
+		if (!opts->only_trailers && !opts->only_input && !opts->unfold &&
+			!opts->trim_empty && list_empty(&orig_head) &&
+			(list_empty(new_trailer_head) || opts->only_input)) {
+			size_t split = trailer_block_start(blk); /* end-of-log-msg */
+			if (!blank_line_before_trailer_block(blk)) {
+				strbuf_add(out, msg, split);
+				strbuf_addch(out, '\n');
+				strbuf_addstr(out, msg + split);
+			} else
+				strbuf_addstr(out, msg);
+
+			strbuf_release(&trailers_sb);
+			trailer_block_release(blk);
+			return 0;
+		}
+		if (opts->only_trailers) {
+			strbuf_addbuf(out, &trailers_sb);
+		} else if (had_trailer_before) {
+			strbuf_add(out, msg, trailer_block_start(blk));
+			if (!blank_line_before_trailer_block(blk))
+				strbuf_addch(out, '\n');
+			strbuf_addbuf(out, &trailers_sb);
+			strbuf_add(out, msg + trailer_block_end(blk),
+						strlen(msg) - trailer_block_end(blk));
+		}
+		else {
+			size_t cpos = trailer_block_start(blk);
+			strbuf_add(out, msg, cpos);
+			if (cpos == 0)                     /* empty body → just one \n */
+				strbuf_addch(out, '\n');
+			else if (!blank_line_before_trailer_block(blk))
+				strbuf_addch(out, '\n');   /* body without trailing blank */
+
+			strbuf_addbuf(out, &trailers_sb);
+			strbuf_add(out, msg + cpos, strlen(msg) - cpos);
+	   }
+		strbuf_release(&trailers_sb);
+		free_trailers(&orig_head);
+		trailer_block_release(blk);
+		return 0;
+}
+
+int amend_file_with_trailers(const char *path,
+							 const struct strvec *trailer_args)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!trailer_args || !trailer_args->nr)
+		return 0;
+
+	if (strbuf_read_file(&buf, path, 0) < 0)
+		return error_errno("could not read '%s'", path);
+
+	if (amend_strbuf_with_trailers(&buf, trailer_args))
+		die("failed to append trailers");
+
+	/* `write_file_buf()` aborts on error internally */
+	write_file_buf(path, buf.buf, buf.len);
+	strbuf_release(&buf);
+	return 0;
+ }
diff --git a/trailer.h b/trailer.h
index 4740549586..01f711fb13 100644
--- a/trailer.h
+++ b/trailer.h
@@ -196,10 +196,22 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
 void trailer_iterator_release(struct trailer_iterator *iter);
 
 /*
- * Augment a file to add trailers to it by running git-interpret-trailers.
- * This calls run_command() and its return value is the same (i.e. 0 for
- * success, various non-zero for other errors). See run-command.h.
+ * Augment a file to add trailers to it (similar to 'git interpret-trailers').
+ * Returns 0 on success or a non-zero error code on failure.
  */
 int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
 
+/*
+ * Process trailer lines for a commit message in-memory.
+ * @opts: trailer processing options (e.g. from parse-options)
+ * @msg: the input message string
+ * @new_trailer_head: list of new trailers to add (struct new_trailer_item)
+ * @out: strbuf to store the resulting message (must be initialized)
+ *
+ * Returns 0 on success, <0 on error.
+ */
+int trailer_process(const struct process_trailer_options *opts,
+			const char *msg,
+			struct list_head *new_trailer_head,
+			struct strbuf *out);
 #endif /* TRAILER_H */
-- 
2.50.0

