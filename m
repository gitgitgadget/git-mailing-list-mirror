Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB34C7460
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451752; cv=none; b=SKGhXmgxyHHuAn5eHaohXNPm1BezVPoMmtwXd6xUDdHMfAPL12qC+HYzTC5FdCE1fIJZoYgbMAY3q6OsMQwGfiIKYA+s57dsATqaDOTZaLxBiT5a3TUb2OdJ4nmyAuwysysP4H5mdKz6VAOrsY5jEDoQpWcHPcmpV7NM+VVgLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451752; c=relaxed/simple;
	bh=5YbYvAXMYVIY6sW5j16GCC0AUX/+YbeRxeH1LwIFsA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXSpKzt4l8T4JfS8MR7VbweIeVEfd+azQr3uvY2ISA3AmcIeZNyJEW2G6xM/dhLOTT6Wy5xUwyOtWdLZ4HSAqf2shlcIyp40NcJ0iq7wXsAJ+CdkhbrpteEkokqeKrlRYBXnCoVfY9v17HJXwCH6M1kPm6/2Sv1vWhBw0YJy1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7334 invoked by uid 109); 7 Apr 2024 01:02:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:02:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11250 invoked by uid 111); 7 Apr 2024 01:02:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:02:31 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:02:28 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 06/11] config: use git_config_string() in easy cases
Message-ID: <20240407010228.GF868358@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>

The git_config_string() interface is very prone to leaking; it
overwrites the contents of the pointer without freeing any existing
value, so:

  const char *foo;
  ...
  if (!strcmp(var, "foo.bar"))
	git_config_string(&foo, var, value);

is always going to leak if we see the "foo.bar" config more than once.
We don't tend to notice in practice because people don't have a lot of
redundant config, but basically every use of git_config_string() has
this problem.

For simple cases where the initial value of the "foo" pointer is NULL
(like the one above), we can easily convert them to use a variant of the
helper that frees the existing value before writing over it. That works
because free(NULL) is a noop. What we can't change, though, is cases
where the pointer is initialized to a string literal, like:

  const char *foo = "some string literal";

In that case it would be incorrect to free() the original value. Those
cases will take more refactoring to make them leak-free, and this patch
punts on that for now.

In each case we switch the underlying variable from "const char *" to
"char *" to indicate that it will always point to allocated memory (and
our git_config_string_dup() interface enforces this).

Signed-off-by: Jeff King <peff@peff.net>
---
 alias.c                |  3 +--
 attr.c                 |  2 +-
 attr.h                 |  2 +-
 builtin/commit.c       |  4 ++--
 builtin/log.c          | 12 ++++++------
 builtin/merge.c        |  4 ++--
 builtin/receive-pack.c |  4 ++--
 builtin/repack.c       | 16 ++++++++--------
 config.c               | 12 ++++++------
 convert.c              | 12 ++++++------
 delta-islands.c        |  4 ++--
 diff.c                 |  8 ++++----
 environment.c          |  8 ++++----
 environment.h          |  8 ++++----
 gpg-interface.c        |  5 +++--
 imap-send.c            | 20 ++++++++++----------
 mailmap.c              |  2 +-
 mailmap.h              |  2 +-
 merge-ll.c             | 12 ++++++------
 pager.c                |  4 ++--
 promisor-remote.c      |  2 +-
 promisor-remote.h      |  2 +-
 remote.c               | 17 ++++++++---------
 remote.h               |  8 ++++----
 sequencer.c            |  2 +-
 upload-pack.c          |  4 ++--
 26 files changed, 89 insertions(+), 90 deletions(-)

diff --git a/alias.c b/alias.c
index 5a238f2e30..7f8c1c3e7d 100644
--- a/alias.c
+++ b/alias.c
@@ -22,8 +22,7 @@ static int config_alias_cb(const char *key, const char *value,
 
 	if (data->alias) {
 		if (!strcasecmp(p, data->alias))
-			return git_config_string((const char **)&data->v,
-						 key, value);
+			return git_config_string_dup(&data->v, key, value);
 	} else if (data->list) {
 		string_list_append(data->list, p);
 	}
diff --git a/attr.c b/attr.c
index 679e42258c..4eda36c865 100644
--- a/attr.c
+++ b/attr.c
@@ -25,7 +25,7 @@
 #include "tree-walk.h"
 #include "object-name.h"
 
-const char *git_attr_tree;
+char *git_attr_tree;
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
diff --git a/attr.h b/attr.h
index 127998ae01..e7cc318b0c 100644
--- a/attr.h
+++ b/attr.h
@@ -236,6 +236,6 @@ const char *git_attr_global_file(void);
 /* Return whether the system gitattributes file is enabled and should be used. */
 int git_attr_system_is_enabled(void);
 
-extern const char *git_attr_tree;
+extern char *git_attr_tree;
 
 #endif /* ATTR_H */
diff --git a/builtin/commit.c b/builtin/commit.c
index 7ba7201cfb..9b6546d401 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -133,7 +133,7 @@ static struct strvec trailer_args = STRVEC_INIT;
  * is specified explicitly.
  */
 static enum commit_msg_cleanup_mode cleanup_mode;
-static const char *cleanup_arg;
+static char *cleanup_arg;
 
 static enum commit_whence whence;
 static int use_editor = 1, include_status = 1;
@@ -1632,7 +1632,7 @@ static int git_commit_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "commit.cleanup"))
-		return git_config_string(&cleanup_arg, k, v);
+		return git_config_string_dup(&cleanup_arg, k, v);
 	if (!strcmp(k, "commit.gpgsign")) {
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
diff --git a/builtin/log.c b/builtin/log.c
index c0a8bb95e9..eb336f7efb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -49,7 +49,7 @@
 #define FORMAT_PATCH_NAME_MAX_DEFAULT 64
 
 /* Set a default date-time format for git log ("log.date" config variable) */
-static const char *default_date_mode = NULL;
+static char *default_date_mode;
 
 static int default_abbrev_commit;
 static int default_show_root = 1;
@@ -63,7 +63,7 @@ static unsigned int force_in_body_from;
 static int stdout_mboxrd;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
-static const char *fmt_pretty;
+static char *fmt_pretty;
 static int format_no_prefix;
 
 static const char * const builtin_log_usage[] = {
@@ -569,7 +569,7 @@ static int git_log_config(const char *var, const char *value,
 	const char *slot_name;
 
 	if (!strcmp(var, "format.pretty"))
-		return git_config_string(&fmt_pretty, var, value);
+		return git_config_string_dup(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
 	if (!strcmp(var, "format.filenamemaxlength")) {
@@ -585,7 +585,7 @@ static int git_log_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "log.date"))
-		return git_config_string(&default_date_mode, var, value);
+		return git_config_string_dup(&default_date_mode, var, value);
 	if (!strcmp(var, "log.decorate")) {
 		decoration_style = parse_decoration_style(value);
 		if (decoration_style < 0)
@@ -959,7 +959,7 @@ static char *from;
 static const char *signature = git_version_string;
 static const char *signature_file;
 static enum cover_setting config_cover_letter;
-static const char *config_output_directory;
+static char *config_output_directory;
 static enum cover_from_description cover_from_description_mode = COVER_FROM_MESSAGE;
 static int show_notes;
 static struct display_notes_opt notes_opt;
@@ -1054,7 +1054,7 @@ static int git_format_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "format.outputdirectory"))
-		return git_config_string(&config_output_directory, var, value);
+		return git_config_string_dup(&config_output_directory, var, value);
 	if (!strcmp(var, "format.useautobase")) {
 		if (value && !strcasecmp(value, "whenAble")) {
 			auto_base = AUTO_BASE_WHEN_ABLE;
diff --git a/builtin/merge.c b/builtin/merge.c
index 6f4fec87fc..c2be29ed2f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -111,7 +111,7 @@ enum ff_type {
 
 static enum ff_type fast_forward = FF_ALLOW;
 
-static const char *cleanup_arg;
+static char *cleanup_arg;
 static enum commit_msg_cleanup_mode cleanup_mode;
 
 static int option_parse_message(const struct option *opt,
@@ -619,7 +619,7 @@ static int git_merge_config(const char *k, const char *v,
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "commit.cleanup"))
-		return git_config_string(&cleanup_arg, k, v);
+		return git_config_string_dup(&cleanup_arg, k, v);
 	else if (!strcmp(k, "merge.ff")) {
 		int boolval = git_parse_maybe_bool(v);
 		if (0 <= boolval) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 15ed81a3f6..2ba71b6673 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -88,7 +88,7 @@ static struct strbuf push_cert = STRBUF_INIT;
 static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
-static const char *cert_nonce_seed;
+static char *cert_nonce_seed;
 static struct strvec hidden_refs = STRVEC_INIT;
 
 static const char *NONCE_UNSOLICITED = "UNSOLICITED";
@@ -230,7 +230,7 @@ static int receive_pack_config(const char *var, const char *value,
 	}
 
 	if (strcmp(var, "receive.certnonceseed") == 0)
-		return git_config_string(&cert_nonce_seed, var, value);
+		return git_config_string_dup(&cert_nonce_seed, var, value);
 
 	if (strcmp(var, "receive.certnonceslop") == 0) {
 		nonce_stamp_slop_limit = git_config_ulong(var, value, ctx->kvi);
diff --git a/builtin/repack.c b/builtin/repack.c
index 15e4cccc45..c144e18d9f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -48,10 +48,10 @@ static const char incremental_bitmap_conflict_error[] = N_(
 );
 
 struct pack_objects_args {
-	const char *window;
-	const char *window_memory;
-	const char *depth;
-	const char *threads;
+	char *window;
+	char *window_memory;
+	char *depth;
+	char *threads;
 	unsigned long max_pack_size;
 	int no_reuse_delta;
 	int no_reuse_object;
@@ -86,13 +86,13 @@ static int repack_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "repack.cruftwindow"))
-		return git_config_string(&cruft_po_args->window, var, value);
+		return git_config_string_dup(&cruft_po_args->window, var, value);
 	if (!strcmp(var, "repack.cruftwindowmemory"))
-		return git_config_string(&cruft_po_args->window_memory, var, value);
+		return git_config_string_dup(&cruft_po_args->window_memory, var, value);
 	if (!strcmp(var, "repack.cruftdepth"))
-		return git_config_string(&cruft_po_args->depth, var, value);
+		return git_config_string_dup(&cruft_po_args->depth, var, value);
 	if (!strcmp(var, "repack.cruftthreads"))
-		return git_config_string(&cruft_po_args->threads, var, value);
+		return git_config_string_dup(&cruft_po_args->threads, var, value);
 	return git_default_config(var, value, ctx, cb);
 }
 
diff --git a/config.c b/config.c
index c115e6d8c9..449b8f4f66 100644
--- a/config.c
+++ b/config.c
@@ -1579,7 +1579,7 @@ static int git_default_core_config(const char *var, const char *value,
 		return git_config_string_dup(&notes_ref_name, var, value);
 
 	if (!strcmp(var, "core.editor"))
-		return git_config_string(&editor_program, var, value);
+		return git_config_string_dup(&editor_program, var, value);
 
 	if (!strcmp(var, "core.commentchar") ||
 	    !strcmp(var, "core.commentstring")) {
@@ -1598,7 +1598,7 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.askpass"))
-		return git_config_string(&askpass_program, var, value);
+		return git_config_string_dup(&askpass_program, var, value);
 
 	if (!strcmp(var, "core.excludesfile"))
 		return git_config_pathname(&excludes_file, var, value);
@@ -1703,10 +1703,10 @@ static int git_default_sparse_config(const char *var, const char *value)
 static int git_default_i18n_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "i18n.commitencoding"))
-		return git_config_string(&git_commit_encoding, var, value);
+		return git_config_string_dup(&git_commit_encoding, var, value);
 
 	if (!strcmp(var, "i18n.logoutputencoding"))
-		return git_config_string(&git_log_output_encoding, var, value);
+		return git_config_string_dup(&git_log_output_encoding, var, value);
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
@@ -1782,7 +1782,7 @@ static int git_default_mailmap_config(const char *var, const char *value)
 	if (!strcmp(var, "mailmap.file"))
 		return git_config_pathname(&git_mailmap_file, var, value);
 	if (!strcmp(var, "mailmap.blob"))
-		return git_config_string(&git_mailmap_blob, var, value);
+		return git_config_string_dup(&git_mailmap_blob, var, value);
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
@@ -1791,7 +1791,7 @@ static int git_default_mailmap_config(const char *var, const char *value)
 static int git_default_attr_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "attr.tree"))
-		return git_config_string(&git_attr_tree, var, value);
+		return git_config_string_dup(&git_attr_tree, var, value);
 
 	/*
 	 * Add other attribute related config variables here and to
diff --git a/convert.c b/convert.c
index 35b25eb3cb..d462485d1f 100644
--- a/convert.c
+++ b/convert.c
@@ -979,9 +979,9 @@ int async_query_available_blobs(const char *cmd, struct string_list *available_p
 static struct convert_driver {
 	const char *name;
 	struct convert_driver *next;
-	const char *smudge;
-	const char *clean;
-	const char *process;
+	char *smudge;
+	char *clean;
+	char *process;
 	int required;
 } *user_convert, **user_convert_tail;
 
@@ -1047,13 +1047,13 @@ static int read_convert_config(const char *var, const char *value,
 	 */
 
 	if (!strcmp("smudge", key))
-		return git_config_string(&drv->smudge, var, value);
+		return git_config_string_dup(&drv->smudge, var, value);
 
 	if (!strcmp("clean", key))
-		return git_config_string(&drv->clean, var, value);
+		return git_config_string_dup(&drv->clean, var, value);
 
 	if (!strcmp("process", key))
-		return git_config_string(&drv->process, var, value);
+		return git_config_string_dup(&drv->process, var, value);
 
 	if (!strcmp("required", key)) {
 		drv->required = git_config_bool(var, value);
diff --git a/delta-islands.c b/delta-islands.c
index f7e079425f..c8ff736a4d 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -313,7 +313,7 @@ struct island_load_data {
 	size_t nr;
 	size_t alloc;
 };
-static const char *core_island_name;
+static char *core_island_name;
 
 static void free_config_regexes(struct island_load_data *ild)
 {
@@ -362,7 +362,7 @@ static int island_config_callback(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "pack.islandcore"))
-		return git_config_string(&core_island_name, k, v);
+		return git_config_string_dup(&core_island_name, k, v);
 
 	return 0;
 }
diff --git a/diff.c b/diff.c
index 108c187577..bb00bc1110 100644
--- a/diff.c
+++ b/diff.c
@@ -56,8 +56,8 @@ static int diff_color_moved_default;
 static int diff_color_moved_ws_default;
 static int diff_context_default = 3;
 static int diff_interhunk_context_default;
-static const char *diff_word_regex_cfg;
-static const char *external_diff_cmd_cfg;
+static char *diff_word_regex_cfg;
+static char *external_diff_cmd_cfg;
 static const char *diff_order_file_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
@@ -429,9 +429,9 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.external"))
-		return git_config_string(&external_diff_cmd_cfg, var, value);
+		return git_config_string_dup(&external_diff_cmd_cfg, var, value);
 	if (!strcmp(var, "diff.wordregex"))
-		return git_config_string(&diff_word_regex_cfg, var, value);
+		return git_config_string_dup(&diff_word_regex_cfg, var, value);
 	if (!strcmp(var, "diff.orderfile"))
 		return git_config_pathname(&diff_order_file_cfg, var, value);
 
diff --git a/environment.c b/environment.c
index a73ba9c12c..5e9fab4d1a 100644
--- a/environment.c
+++ b/environment.c
@@ -42,8 +42,8 @@ int is_bare_repository_cfg = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int repository_format_precious_objects;
-const char *git_commit_encoding;
-const char *git_log_output_encoding;
+char *git_commit_encoding;
+char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
 const char *git_attributes_file;
@@ -58,8 +58,8 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
-const char *editor_program;
-const char *askpass_program;
+char *editor_program;
+char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 enum eol core_eol = EOL_UNSET;
diff --git a/environment.h b/environment.h
index 05fd94d7be..f06024a457 100644
--- a/environment.h
+++ b/environment.h
@@ -217,11 +217,11 @@ int odb_pack_keep(const char *name);
 const char *get_log_output_encoding(void);
 const char *get_commit_output_encoding(void);
 
-extern const char *git_commit_encoding;
-extern const char *git_log_output_encoding;
+extern char *git_commit_encoding;
+extern char *git_log_output_encoding;
 
-extern const char *editor_program;
-extern const char *askpass_program;
+extern char *editor_program;
+extern char *askpass_program;
 extern const char *excludes_file;
 
 /*
diff --git a/gpg-interface.c b/gpg-interface.c
index b5993385ff..4b2f70ef44 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -27,7 +27,8 @@ static void gpg_interface_lazy_init(void)
 }
 
 static char *configured_signing_key;
-static const char *ssh_default_key_command, *ssh_allowed_signers, *ssh_revocation_file;
+static char *ssh_default_key_command;
+static const char *ssh_allowed_signers, *ssh_revocation_file;
 static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
 
 struct gpg_format {
@@ -762,7 +763,7 @@ static int git_gpg_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "gpg.ssh.defaultkeycommand"))
-		return git_config_string(&ssh_default_key_command, var, value);
+		return git_config_string_dup(&ssh_default_key_command, var, value);
 
 	if (!strcmp(var, "gpg.ssh.allowedsignersfile"))
 		return git_config_pathname(&ssh_allowed_signers, var, value);
diff --git a/imap-send.c b/imap-send.c
index f2e1947e63..d4454a3b49 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -87,16 +87,16 @@ static int nfvasprintf(char **strp, const char *fmt, va_list ap)
 
 struct imap_server_conf {
 	const char *name;
-	const char *tunnel;
+	char *tunnel;
 	const char *host;
 	int port;
-	const char *folder;
-	const char *user;
-	const char *pass;
+	char *folder;
+	char *user;
+	char *pass;
 	int use_ssl;
 	int ssl_verify;
 	int use_html;
-	const char *auth_method;
+	char *auth_method;
 };
 
 static struct imap_server_conf server = {
@@ -1332,15 +1332,15 @@ static int git_imap_config(const char *var, const char *val,
 	else if (!strcmp("imap.preformattedhtml", var))
 		server.use_html = git_config_bool(var, val);
 	else if (!strcmp("imap.folder", var))
-		return git_config_string(&server.folder, var, val);
+		return git_config_string_dup(&server.folder, var, val);
 	else if (!strcmp("imap.user", var))
-		return git_config_string(&server.user, var, val);
+		return git_config_string_dup(&server.user, var, val);
 	else if (!strcmp("imap.pass", var))
-		return git_config_string(&server.pass, var, val);
+		return git_config_string_dup(&server.pass, var, val);
 	else if (!strcmp("imap.tunnel", var))
-		return git_config_string(&server.tunnel, var, val);
+		return git_config_string_dup(&server.tunnel, var, val);
 	else if (!strcmp("imap.authmethod", var))
-		return git_config_string(&server.auth_method, var, val);
+		return git_config_string_dup(&server.auth_method, var, val);
 	else if (!strcmp("imap.port", var))
 		server.port = git_config_int(var, val, ctx->kvi);
 	else if (!strcmp("imap.host", var)) {
diff --git a/mailmap.c b/mailmap.c
index 3d6a5e9400..9bd11c90e6 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -7,7 +7,7 @@
 #include "setup.h"
 
 const char *git_mailmap_file;
-const char *git_mailmap_blob;
+char *git_mailmap_blob;
 
 struct mailmap_info {
 	char *name;
diff --git a/mailmap.h b/mailmap.h
index 0f8fd2c586..a1bc019b52 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -4,7 +4,7 @@
 struct string_list;
 
 extern const char *git_mailmap_file;
-extern const char *git_mailmap_blob;
+extern char *git_mailmap_blob;
 
 int read_mailmap(struct string_list *map);
 void clear_mailmap(struct string_list *map);
diff --git a/merge-ll.c b/merge-ll.c
index 660d9a3bd6..5ef96309d8 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -27,9 +27,9 @@ typedef enum ll_merge_result (*ll_merge_fn)(const struct ll_merge_driver *,
 
 struct ll_merge_driver {
 	const char *name;
-	const char *description;
+	char *description;
 	ll_merge_fn fn;
-	const char *recursive;
+	char *recursive;
 	struct ll_merge_driver *next;
 	char *cmdline;
 };
@@ -268,7 +268,7 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
  * merge.default and merge.driver configuration items
  */
 static struct ll_merge_driver *ll_user_merge, **ll_user_merge_tail;
-static const char *default_ll_merge;
+static char *default_ll_merge;
 
 static int read_merge_config(const char *var, const char *value,
 			     const struct config_context *ctx UNUSED,
@@ -279,7 +279,7 @@ static int read_merge_config(const char *var, const char *value,
 	size_t namelen;
 
 	if (!strcmp(var, "merge.default"))
-		return git_config_string(&default_ll_merge, var, value);
+		return git_config_string_dup(&default_ll_merge, var, value);
 
 	/*
 	 * We are not interested in anything but "merge.<name>.variable";
@@ -305,7 +305,7 @@ static int read_merge_config(const char *var, const char *value,
 	}
 
 	if (!strcmp("name", key))
-		return git_config_string(&fn->description, var, value);
+		return git_config_string_dup(&fn->description, var, value);
 
 	if (!strcmp("driver", key)) {
 		/*
@@ -335,7 +335,7 @@ static int read_merge_config(const char *var, const char *value,
 	}
 
 	if (!strcmp("recursive", key))
-		return git_config_string(&fn->recursive, var, value);
+		return git_config_string_dup(&fn->recursive, var, value);
 
 	return 0;
 }
diff --git a/pager.c b/pager.c
index b8822a9381..6d75528e56 100644
--- a/pager.c
+++ b/pager.c
@@ -13,7 +13,7 @@ int pager_use_color = 1;
 #endif
 
 static struct child_process pager_process;
-static const char *pager_program;
+static char *pager_program;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -47,7 +47,7 @@ static int core_pager_config(const char *var, const char *value,
 			     void *data UNUSED)
 {
 	if (!strcmp(var, "core.pager"))
-		return git_config_string(&pager_program, var, value);
+		return git_config_string_dup(&pager_program, var, value);
 	return 0;
 }
 
diff --git a/promisor-remote.c b/promisor-remote.c
index ac3aa1e365..65693e7931 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -139,7 +139,7 @@ static int promisor_remote_config(const char *var, const char *value,
 		if (!r)
 			return 0;
 
-		return git_config_string(&r->partial_clone_filter, var, value);
+		return git_config_string_dup(&r->partial_clone_filter, var, value);
 	}
 
 	return 0;
diff --git a/promisor-remote.h b/promisor-remote.h
index 2cb9eda9ea..88cb599c39 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -13,7 +13,7 @@ struct object_id;
  */
 struct promisor_remote {
 	struct promisor_remote *next;
-	const char *partial_clone_filter;
+	char *partial_clone_filter;
 	const char name[FLEX_ARRAY];
 };
 
diff --git a/remote.c b/remote.c
index 09912bebf1..761a8b8fe3 100644
--- a/remote.c
+++ b/remote.c
@@ -367,9 +367,9 @@ static int handle_config(const char *key, const char *value,
 			return -1;
 		branch = make_branch(remote_state, name, namelen);
 		if (!strcmp(subkey, "remote")) {
-			return git_config_string(&branch->remote_name, key, value);
+			return git_config_string_dup(&branch->remote_name, key, value);
 		} else if (!strcmp(subkey, "pushremote")) {
-			return git_config_string(&branch->pushremote_name, key, value);
+			return git_config_string_dup(&branch->pushremote_name, key, value);
 		} else if (!strcmp(subkey, "merge")) {
 			if (!value)
 				return config_error_nonbool(key);
@@ -401,8 +401,8 @@ static int handle_config(const char *key, const char *value,
 
 	/* Handle remote.* variables */
 	if (!name && !strcmp(subkey, "pushdefault"))
-		return git_config_string(&remote_state->pushremote_name, key,
-					 value);
+		return git_config_string_dup(&remote_state->pushremote_name, key,
+					     value);
 
 	if (!name)
 		return 0;
@@ -471,13 +471,12 @@ static int handle_config(const char *key, const char *value,
 		else if (!strcmp(value, "--tags"))
 			remote->fetch_tags = 2;
 	} else if (!strcmp(subkey, "proxy")) {
-		return git_config_string((const char **)&remote->http_proxy,
-					 key, value);
+		return git_config_string_dup(&remote->http_proxy, key, value);
 	} else if (!strcmp(subkey, "proxyauthmethod")) {
-		return git_config_string((const char **)&remote->http_proxy_authmethod,
-					 key, value);
+		return git_config_string_dup(&remote->http_proxy_authmethod,
+					     key, value);
 	} else if (!strcmp(subkey, "vcs")) {
-		return git_config_string(&remote->foreign_vcs, key, value);
+		return git_config_string_dup(&remote->foreign_vcs, key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index dfd4837e60..e8c6655e42 100644
--- a/remote.h
+++ b/remote.h
@@ -46,7 +46,7 @@ struct remote_state {
 	struct hashmap branches_hash;
 
 	struct branch *current_branch;
-	const char *pushremote_name;
+	char *pushremote_name;
 
 	struct rewrites rewrites;
 	struct rewrites rewrites_push;
@@ -65,7 +65,7 @@ struct remote {
 
 	int origin, configured_in_repo;
 
-	const char *foreign_vcs;
+	char *foreign_vcs;
 
 	/* An array of all of the url_nr URLs configured for the remote */
 	const char **url;
@@ -309,9 +309,9 @@ struct branch {
 	const char *refname;
 
 	/* The name of the remote listed in the configuration. */
-	const char *remote_name;
+	char *remote_name;
 
-	const char *pushremote_name;
+	char *pushremote_name;
 
 	/* An array of the "merge" lines in the configuration. */
 	const char **merge_name;
diff --git a/sequencer.c b/sequencer.c
index 3e5d82e0e5..29f019b2a0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -266,7 +266,7 @@ static int git_sequencer_config(const char *k, const char *v,
 	}
 
 	if (!opts->default_strategy && !strcmp(k, "pull.twohead")) {
-		int ret = git_config_string((const char**)&opts->default_strategy, k, v);
+		int ret = git_config_string_dup(&opts->default_strategy, k, v);
 		if (ret == 0) {
 			/*
 			 * pull.twohead is allowed to be multi-valued; we only
diff --git a/upload-pack.c b/upload-pack.c
index 902144b9d3..5f5943cc19 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -94,7 +94,7 @@ struct upload_pack_data {
 
 	struct packet_writer writer;
 
-	const char *pack_objects_hook;
+	char *pack_objects_hook;
 
 	unsigned stateless_rpc : 1;				/* v0 only */
 	unsigned no_done : 1;					/* v0 only */
@@ -1386,7 +1386,7 @@ static int upload_pack_protected_config(const char *var, const char *value,
 	struct upload_pack_data *data = cb_data;
 
 	if (!strcmp("uploadpack.packobjectshook", var))
-		return git_config_string(&data->pack_objects_hook, var, value);
+		return git_config_string_dup(&data->pack_objects_hook, var, value);
 	return 0;
 }
 
-- 
2.44.0.872.g288abe5b5b

