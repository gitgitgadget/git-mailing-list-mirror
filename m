Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C76487A5
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712431032; cv=none; b=q3CjLaE1ArSWG2j/+NIxdxaXDcYioTt0AO1kc9cAiYxJDKWrmTKjIKL1EkstgbaWy8JKn8ZBTumGKQ610p/bJpft7F7BSSZWSygNHtECHpK4QPmjPM8QHtV2Ka0jvMslWojnrzwmuDkEsj2JFcAamjTZTCvb4G4j0wJWrc9LpOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712431032; c=relaxed/simple;
	bh=6BrM/Fl0tK1TDOKOPOiiO+WAfTsMN2C3WyMiktBYuzs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dy6XSaGjGUTEJgNRGeSlWNk0hcZ3v0m0pueb7k/Do4jviGZ7ZsRgIBrXN55O2e6iGXtQr7r9QUtqhFHT/3+/VIfG11z076eqIIzy1wwFoj7KStCvuOSElUGj/Arkpgx16Dut+wFpy1PY5MOvAE3HIk+K9WTdyuo8fBCu30g36iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=esA3+74u; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="esA3+74u"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E769E2A50A;
	Sat,  6 Apr 2024 15:17:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6BrM/Fl0tK1TDOKOPOiiO+WAfTsMN2C3WyMikt
	BYuzs=; b=esA3+74uBQyT4Alc0tZI8a5SkMrWkTakR8sr0mDVwoX+ixSry7m9SX
	IuJBAfCVVAWs0AkR0e2LqtlIN2SE4h4OymQ4cmzk7b0nzgI6nr4H+5JHbY8dA9z1
	aNbSvbXhfJDh09TWu87YjawbcO7ZKr+6tpdTHSllvF2ATrdOzie54=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DFCA92A509;
	Sat,  6 Apr 2024 15:17:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 66CB82A507;
	Sat,  6 Apr 2024 15:17:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [WIP] git_config_pathname() leakfix
In-Reply-To: <xmqqttkeicov.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	06 Apr 2024 11:11:12 -0700")
References: <xmqqttkeicov.fsf@gitster.g>
Date: Sat, 06 Apr 2024 12:17:04 -0700
Message-ID: <xmqqa5m6i9n3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 41D5F12C-F44A-11EE-B61B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

The git_config_pathname() function takes a pointer to "const char *"
that specifies where to store the resulting pathname string, but
always assigns a newly assigned value to it.  The caller has to cast
the constness away if it wants to call free() on it, e.g.,

	const char *str;
	int ret = git_config_pathname(&str, var, value);
	use(str)
	free((const char *)str);

Here is a not-working WIP just to show the scale of fallout from an
exercise to plug leaks of returned value from git_config_pathname().
It revealed a few more issues around memory ownership rules.

 * OPTION_FILENAME of parse-options API assigns the string from the
   command line argument directly to the supplied variable.  The
   variable obviously does not own the value and cannot and does not
   have to free() it.  It however is very common to use the same
   variable to also hold a string read from the config API, via
   git_config_pathname(), which wants the caller to own the string.

   In this sketch, I attempted to introduce OPTION_FILENAME_DUP and
   have the parse-options API to treat the destination variable as
   owning the string (i.e. free the existing contents before
   assigning the value from the command line, and xstrdup() the
   string from the command line option), but I am sure I missed
   some (which will lead to segfault when a caller later tries
   to free() it before calling git_config_pathname()) and/or 
   converted too many (which will lead to leaks when a caller
   later does not free() it).

 * http.c has a private set_from_env() helper function, which lets
   the callers to borrow memory from the environment.  But some
   variables that receive value from this mechanism also receive
   pathnames from configuration via git_config_pathname().

   In this sketch, I attempted to solve it by introducing
   dup_from_env() and changed callers that wants to overwrite the
   variable with a value obtained from git_config_pathname().

Some readers might wonder if it is easier to go in the other
direction, i.e. allowing cllaers of git_config_pathname() to
borrow and not worry about freeing, but this is fundamentally
impossible as expanding ~/.gitconfig into /home/jch/.gitconfig
and the like is the central part of its function.

In any case, I am not going to finish this soonish, but I think I
found some existing leaks that can be fixed _without_ going through
the whole nine yards, so perhaps I'll see if I can salvage small
changes like that as "preliminary clean-up".

 builtin/blame.c        |  3 ++-
 builtin/commit.c       |  4 ++--
 builtin/config.c       |  4 ++--
 builtin/log.c          |  4 ++--
 builtin/receive-pack.c |  4 ++--
 config.c               |  8 ++++----
 config.h               |  8 ++++----
 diff.c                 |  2 +-
 environment.c          |  6 +++---
 environment.h          |  6 +++---
 fetch-pack.c           |  4 ++--
 fsck.c                 |  4 ++--
 fsmonitor-settings.c   |  8 ++++++--
 gpg-interface.c        |  3 ++-
 http.c                 | 29 +++++++++++++++++++----------
 mailmap.c              |  2 +-
 mailmap.h              |  2 +-
 parse-options.c        | 14 ++++++++++++--
 parse-options.h        | 11 ++++++++++-
 setup.c                |  8 ++++----
 20 files changed, 84 insertions(+), 50 deletions(-)

diff --git c/builtin/blame.c w/builtin/blame.c
index db1f56de61..23810323e6 100644
--- c/builtin/blame.c
+++ w/builtin/blame.c
@@ -718,13 +718,14 @@ static int git_blame_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "blame.ignorerevsfile")) {
-		const char *str;
+		char *str;
 		int ret;
 
 		ret = git_config_pathname(&str, var, value);
 		if (ret)
 			return ret;
 		string_list_insert(&ignore_revs_file_list, str);
+		free(str);
 		return 0;
 	}
 	if (!strcmp(var, "blame.markunblamablelines")) {
diff --git c/builtin/commit.c w/builtin/commit.c
index 7ba7201cfb..a35c524458 100644
--- c/builtin/commit.c
+++ w/builtin/commit.c
@@ -107,7 +107,7 @@ static enum {
 } commit_style;
 
 static const char *logfile, *force_author;
-static const char *template_file;
+static char *template_file;
 /*
  * The _message variables are commit names from which to take
  * the commit message and/or authorship.
@@ -1319,7 +1319,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 				  !!use_message, "-C",
 				  !!logfile, "-F");
 	if (use_message || edit_message || logfile ||fixup_message || have_option_m)
-		template_file = NULL;
+		FREE_AND_NULL(template_file);
 	if (edit_message)
 		use_message = edit_message;
 	if (amend && !use_message && !fixup_message)
diff --git c/builtin/config.c w/builtin/config.c
index 0015620dde..739d3beb57 100644
--- c/builtin/config.c
+++ w/builtin/config.c
@@ -282,11 +282,11 @@ static int format_config(struct strbuf *buf, const char *key_,
 			else
 				strbuf_addstr(buf, v ? "true" : "false");
 		} else if (type == TYPE_PATH) {
-			const char *v;
+			char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
 				return -1;
 			strbuf_addstr(buf, v);
-			free((char *)v);
+			free(v);
 		} else if (type == TYPE_EXPIRY_DATE) {
 			timestamp_t t;
 			if (git_config_expiry_date(&t, key_, value_) < 0)
diff --git c/builtin/log.c w/builtin/log.c
index c0a8bb95e9..e90d3f13e7 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -957,7 +957,7 @@ static int do_signoff;
 static enum auto_base_setting auto_base;
 static char *from;
 static const char *signature = git_version_string;
-static const char *signature_file;
+static char *signature_file;
 static enum cover_setting config_cover_letter;
 static const char *config_output_directory;
 static enum cover_from_description cover_from_description_mode = COVER_FROM_MESSAGE;
@@ -1981,7 +1981,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "base", &base_commit, N_("base-commit"),
 			       N_("add prerequisite tree info to the patch series"),
 			       0, base_callback),
-		OPT_FILENAME(0, "signature-file", &signature_file,
+		OPT_FILENAME_DUP(0, "signature-file", &signature_file,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_BOOL(0, "progress", &show_progress,
diff --git c/builtin/receive-pack.c w/builtin/receive-pack.c
index 56d8a77ed7..f5e55bad51 100644
--- c/builtin/receive-pack.c
+++ w/builtin/receive-pack.c
@@ -168,13 +168,13 @@ static int receive_pack_config(const char *var, const char *value,
 	}
 
 	if (strcmp(var, "receive.fsck.skiplist") == 0) {
-		const char *path;
+		char *path;
 
 		if (git_config_pathname(&path, var, value))
 			return 1;
 		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
 			fsck_msg_types.len ? ',' : '=', path);
-		free((char *)path);
+		free(path);
 		return 0;
 	}
 
diff --git c/config.c w/config.c
index ae3652b08f..683acbe235 100644
--- c/config.c
+++ w/config.c
@@ -1345,7 +1345,7 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
-int git_config_pathname(const char **dest, const char *var, const char *value)
+int git_config_pathname(char **dest, const char *var, const char *value)
 {
 	if (!value)
 		return config_error_nonbool(var);
@@ -2482,7 +2482,7 @@ int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *d
 		return 1;
 }
 
-int git_configset_get_pathname(struct config_set *set, const char *key, const char **dest)
+int git_configset_get_pathname(struct config_set *set, const char *key, char **dest)
 {
 	const char *value;
 	if (!git_configset_get_value(set, key, &value, NULL))
@@ -2627,7 +2627,7 @@ int repo_config_get_maybe_bool(struct repository *repo,
 }
 
 int repo_config_get_pathname(struct repository *repo,
-			     const char *key, const char **dest)
+			     const char *key, char **dest)
 {
 	int ret;
 	git_config_check_init(repo);
@@ -2726,7 +2726,7 @@ int git_config_get_maybe_bool(const char *key, int *dest)
 	return repo_config_get_maybe_bool(the_repository, key, dest);
 }
 
-int git_config_get_pathname(const char *key, const char **dest)
+int git_config_get_pathname(const char *key, char **dest)
 {
 	return repo_config_get_pathname(the_repository, key, dest);
 }
diff --git c/config.h w/config.h
index f4966e3749..868057c77f 100644
--- c/config.h
+++ w/config.h
@@ -286,7 +286,7 @@ int git_config_string(const char **, const char *, const char *);
  * Similar to `git_config_string`, but expands `~` or `~user` into the
  * user's home directory when found at the beginning of the path.
  */
-int git_config_pathname(const char **, const char *, const char *);
+int git_config_pathname(char **, const char *, const char *);
 
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
@@ -541,7 +541,7 @@ int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned lon
 int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
 int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
-int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
+int git_configset_get_pathname(struct config_set *cs, const char *key, char **dest);
 
 /* Functions for reading a repository's config */
 struct repository;
@@ -577,7 +577,7 @@ int repo_config_get_bool_or_int(struct repository *repo,
 int repo_config_get_maybe_bool(struct repository *repo,
 			       const char *key, int *dest);
 int repo_config_get_pathname(struct repository *repo,
-			     const char *key, const char **dest);
+			     const char *key, char **dest);
 
 /*
  * Functions for reading protected config. By definition, protected
@@ -687,7 +687,7 @@ int git_config_get_maybe_bool(const char *key, int *dest);
  * Similar to `git_config_get_string`, but expands `~` or `~user` into
  * the user's home directory when found at the beginning of the path.
  */
-int git_config_get_pathname(const char *key, const char **dest);
+int git_config_get_pathname(const char *key, char **dest);
 
 int git_config_get_index_threads(int *dest);
 int git_config_get_split_index(void);
diff --git c/diff.c w/diff.c
index 108c187577..e8754888f4 100644
--- c/diff.c
+++ w/diff.c
@@ -58,7 +58,7 @@ static int diff_context_default = 3;
 static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
-static const char *diff_order_file_cfg;
+static char *diff_order_file_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
diff --git c/environment.c w/environment.c
index a73ba9c12c..279ea3fd5e 100644
--- c/environment.c
+++ w/environment.c
@@ -46,8 +46,8 @@ const char *git_commit_encoding;
 const char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
-const char *git_attributes_file;
-const char *git_hooks_path;
+char *git_attributes_file;
+char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
@@ -60,7 +60,7 @@ size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 const char *editor_program;
 const char *askpass_program;
-const char *excludes_file;
+char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
diff --git c/environment.h w/environment.h
index 05fd94d7be..c0e0c8b1f9 100644
--- c/environment.h
+++ w/environment.h
@@ -124,8 +124,8 @@ extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern const char *git_attributes_file;
-extern const char *git_hooks_path;
+extern char *git_attributes_file;
+extern char *git_hooks_path;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern size_t packed_git_window_size;
@@ -222,7 +222,7 @@ extern const char *git_log_output_encoding;
 
 extern const char *editor_program;
 extern const char *askpass_program;
-extern const char *excludes_file;
+extern char *excludes_file;
 
 /*
  * Should we print an ellipsis after an abbreviated SHA-1 value
diff --git c/fetch-pack.c w/fetch-pack.c
index 091f9a80a9..f7579cb3bc 100644
--- c/fetch-pack.c
+++ w/fetch-pack.c
@@ -1863,13 +1863,13 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 	const char *msg_id;
 
 	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
-		const char *path;
+		char *path;
 
 		if (git_config_pathname(&path, var, value))
 			return 1;
 		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
 			fsck_msg_types.len ? ',' : '=', path);
-		free((char *)path);
+		free(path);
 		return 0;
 	}
 
diff --git c/fsck.c w/fsck.c
index 78af29d264..dd0a33028e 100644
--- c/fsck.c
+++ w/fsck.c
@@ -1274,13 +1274,13 @@ int git_fsck_config(const char *var, const char *value,
 	const char *msg_id;
 
 	if (strcmp(var, "fsck.skiplist") == 0) {
-		const char *path;
+		char *path;
 		struct strbuf sb = STRBUF_INIT;
 
 		if (git_config_pathname(&path, var, value))
 			return 1;
 		strbuf_addf(&sb, "skiplist=%s", path);
-		free((char *)path);
+		free(path);
 		fsck_set_msg_types(options, sb.buf);
 		strbuf_release(&sb);
 		return 0;
diff --git c/fsmonitor-settings.c w/fsmonitor-settings.c
index a6a9e6bc19..20e9347907 100644
--- c/fsmonitor-settings.c
+++ w/fsmonitor-settings.c
@@ -129,8 +129,12 @@ static void lookup_fsmonitor_settings(struct repository *r)
 		break;
 
 	case -1: /* config value set to an arbitrary string */
-		if (repo_config_get_pathname(r, "core.fsmonitor", &const_str))
-			return; /* should not happen */
+		{
+			char *str;
+			if (repo_config_get_pathname(r, "core.fsmonitor", &str))
+				return; /* should not happen */
+			const_str = str;
+		}
 		break;
 
 	default: /* should not happen */
diff --git c/gpg-interface.c w/gpg-interface.c
index b5993385ff..87e214c76e 100644
--- c/gpg-interface.c
+++ w/gpg-interface.c
@@ -27,7 +27,8 @@ static void gpg_interface_lazy_init(void)
 }
 
 static char *configured_signing_key;
-static const char *ssh_default_key_command, *ssh_allowed_signers, *ssh_revocation_file;
+static const char *ssh_default_key_command;
+static char *ssh_allowed_signers, *ssh_revocation_file;
 static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
 
 struct gpg_format {
diff --git c/http.c w/http.c
index e73b136e58..b03a9a169d 100644
--- c/http.c
+++ w/http.c
@@ -39,7 +39,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *curl_http_version = NULL;
-static const char *ssl_cert;
+static char *ssl_cert;
 static const char *ssl_cert_type;
 static const char *ssl_cipherlist;
 static const char *ssl_version;
@@ -59,14 +59,14 @@ static struct {
 	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
 #endif
 };
-static const char *ssl_key;
+static char *ssl_key;
 static const char *ssl_key_type;
-static const char *ssl_capath;
+static char *ssl_capath;
 static const char *curl_no_proxy;
 #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
-static const char *ssl_pinnedkey;
+static char *ssl_pinnedkey;
 #endif
-static const char *ssl_cainfo;
+static char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
@@ -108,7 +108,7 @@ static struct {
 
 static struct credential proxy_auth = CREDENTIAL_INIT;
 static const char *curl_proxyuserpwd;
-static const char *curl_cookie_file;
+static char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
@@ -1215,6 +1215,15 @@ static void set_from_env(const char **var, const char *envname)
 		*var = val;
 }
 
+static void dup_from_env(char **var, const char *envname)
+{
+	const char *val = getenv(envname);
+	if (val) {
+		free(*var);
+		*var = strdup(val);
+	}
+}
+
 void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
@@ -1291,12 +1300,12 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (getenv("GIT_SSL_NO_VERIFY"))
 		curl_ssl_verify = 0;
 
-	set_from_env(&ssl_cert, "GIT_SSL_CERT");
+	dup_from_env(&ssl_cert, "GIT_SSL_CERT");
 	set_from_env(&ssl_cert_type, "GIT_SSL_CERT_TYPE");
-	set_from_env(&ssl_key, "GIT_SSL_KEY");
+	dup_from_env(&ssl_key, "GIT_SSL_KEY");
 	set_from_env(&ssl_key_type, "GIT_SSL_KEY_TYPE");
-	set_from_env(&ssl_capath, "GIT_SSL_CAPATH");
-	set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
+	dup_from_env(&ssl_capath, "GIT_SSL_CAPATH");
+	dup_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
 
 	set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
 
diff --git c/mailmap.c w/mailmap.c
index 3d6a5e9400..044466b043 100644
--- c/mailmap.c
+++ w/mailmap.c
@@ -6,7 +6,7 @@
 #include "object-store-ll.h"
 #include "setup.h"
 
-const char *git_mailmap_file;
+char *git_mailmap_file;
 const char *git_mailmap_blob;
 
 struct mailmap_info {
diff --git c/mailmap.h w/mailmap.h
index 0f8fd2c586..429a760945 100644
--- c/mailmap.h
+++ w/mailmap.h
@@ -3,7 +3,7 @@
 
 struct string_list;
 
-extern const char *git_mailmap_file;
+extern char *git_mailmap_file;
 extern const char *git_mailmap_blob;
 
 int read_mailmap(struct string_list *map);
diff --git c/parse-options.c w/parse-options.c
index 30b9e68f8a..94c1e52b60 100644
--- c/parse-options.c
+++ w/parse-options.c
@@ -64,8 +64,11 @@ static void fix_filename(const char *prefix, char **file)
 {
 	if (!file || !*file)
 		; /* leave as NULL */
-	else
-		*file = prefix_filename_except_for_dash(prefix, *file);
+	else {
+		char *tmp = prefix_filename_except_for_dash(prefix, *file);
+		free(*file);
+		*file = tmp;
+	}
 }
 
 static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
@@ -128,6 +131,9 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 			return get_arg(p, opt, flags, (const char **)opt->value);
 		return 0;
 
+	case OPTION_FILENAME_DUP:
+		FREE_AND_NULL(*(char **)opt->value);
+		/* fallthru */
 	case OPTION_FILENAME:
 		err = 0;
 		if (unset)
@@ -137,6 +143,8 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		else
 			err = get_arg(p, opt, flags, (const char **)opt->value);
 
+		if (opt->type == OPTION_FILENAME_DUP)
+			*(char **)opt->value = xstrdup_or_null(*(const char **)opt->value);
 		if (!err)
 			fix_filename(p->prefix, (char **)opt->value);
 		return err;
@@ -649,6 +657,7 @@ static void show_negated_gitcomp(const struct option *opts, int show_all,
 		switch (opts->type) {
 		case OPTION_STRING:
 		case OPTION_FILENAME:
+		case OPTION_FILENAME_DUP:
 		case OPTION_INTEGER:
 		case OPTION_MAGNITUDE:
 		case OPTION_CALLBACK:
@@ -701,6 +710,7 @@ static int show_gitcomp(const struct option *opts, int show_all)
 			continue;
 		case OPTION_STRING:
 		case OPTION_FILENAME:
+		case OPTION_FILENAME_DUP:
 		case OPTION_INTEGER:
 		case OPTION_MAGNITUDE:
 		case OPTION_CALLBACK:
diff --git c/parse-options.h w/parse-options.h
index bd62e20268..e78f72f986 100644
--- c/parse-options.h
+++ w/parse-options.h
@@ -26,7 +26,8 @@ enum parse_opt_type {
 	OPTION_MAGNITUDE,
 	OPTION_CALLBACK,
 	OPTION_LOWLEVEL_CALLBACK,
-	OPTION_FILENAME
+	OPTION_FILENAME,
+	OPTION_FILENAME_DUP
 };
 
 enum parse_opt_flags {
@@ -330,6 +331,14 @@ struct option {
 	.argh = N_("file"), \
 	.help = (h), \
 }
+#define OPT_FILENAME_DUP(s, l, v, h) { \
+	.type = OPTION_FILENAME_DUP, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = N_("file"), \
+	.help = (h), \
+}
 #define OPT_COLOR_FLAG(s, l, v, h) { \
 	.type = OPTION_CALLBACK, \
 	.short_name = (s), \
diff --git c/setup.c w/setup.c
index f4b32f76e3..d99856ac81 100644
--- c/setup.c
+++ w/setup.c
@@ -1176,13 +1176,13 @@ static int safe_directory_cb(const char *key, const char *value,
 	} else if (!strcmp(value, "*")) {
 		data->is_safe = 1;
 	} else {
-		const char *interpolated = NULL;
+		char *interpolated = NULL;
 
 		if (!git_config_pathname(&interpolated, key, value) &&
 		    !fspathcmp(data->path, interpolated ? interpolated : value))
 			data->is_safe = 1;
 
-		free((char *)interpolated);
+		free(interpolated);
 	}
 
 	return 0;
@@ -2023,7 +2023,7 @@ static int create_default_files(const char *template_path,
 	char *path;
 	int reinit;
 	int filemode;
-	const char *init_template_dir = NULL;
+	char *init_template_dir = NULL;
 	const char *work_tree = get_git_work_tree();
 
 	/*
@@ -2037,7 +2037,7 @@ static int create_default_files(const char *template_path,
 	 */
 	git_config_get_pathname("init.templatedir", &init_template_dir);
 	copy_templates(template_path, init_template_dir);
-	free((char *)init_template_dir);
+	free(init_template_dir);
 	git_config_clear();
 	reset_shared_repository();
 	git_config(git_default_config, NULL);
