From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC v2 1/2] git_default_config() rewritten using the config-set
 API
Date: Wed, 13 Aug 2014 19:03:08 +0530
Message-ID: <53EB6914.2030807@gmail.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>	<vpqppg4vdii.fsf@anie.imag.fr> <53EB58A0.10307@gmail.com> <vpq4mxgtu07.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 13 15:33:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHYgB-0008Hq-Tb
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 15:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbaHMNdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 09:33:16 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:52505 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaHMNdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 09:33:15 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so14277806pdj.26
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ezUVCsokKg0tkIq0/q/nTYftMm2BI3eDLTlMUjOHsps=;
        b=WsAosZRUmol0jSxUVKiLGkTgM3kcQ5RtpCV6yPUYnyiRXGk99Q04qt0e5rXWb0Xp3J
         UbcBXXr1CekjMtBCViWquewFa6hHjJwwhY1wIGi/mxnyPea9VKxFctsHegAatP/92xh2
         w5uQlzh19knnTjoe63LGPtqbCZBk4vmx8N3By2BaaWqNq0jcsdk7qvm9t8maK3klY3Ny
         bvTinpdf+LSr6q+kNM8IF/DcdUp5A4uwvg/UfK/uPB5ujcsPAJyfSGG/m6Q7dO37sb4Q
         0+X4PV8Gz2ijym/7768aKWJc1IZuLNmN1icxdNS4q6iDJqZDc3rVoZFzmri5CAkyJTC1
         6F9Q==
X-Received: by 10.70.87.177 with SMTP id az17mr4201746pdb.114.1407936794862;
        Wed, 13 Aug 2014 06:33:14 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.223.107])
        by mx.google.com with ESMTPSA id h4sm3151061pdi.30.2014.08.13.06.33.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 06:33:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpq4mxgtu07.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255210>

git_default_config() now uses config-set API functions to query for
values.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
Sorry, for the short log message, I will explain why.
The git_default_config() rewrite is 100% complete, the only
problem remains is the call sites; there are too many of them.
Some are called from callback functions which pass the remaining
variables to git_default_config() which they do not have any use for.
Those call sites can remain as they are, because git_default_config()
is a single call function now, and is guarded by a sentinel value.
So after one call, it would just return immediately instead of going on
checking.

For callers like git_config(git_default_config, NULL) (there are 38 of them),
we can leave them as they are or rewrite them as I have illustrated in the
next attached patch.

I will take this series out of RFC as soon as we have decided what to do with
the call sites.

Cheers,
Tanay Abhra.

 advice.c |  17 ++--
 advice.h |   2 +-
 cache.h  |   2 +-
 config.c | 346 ++++++++++++++++++++++-----------------------------------------
 ident.c  |  17 ++--
 5 files changed, 136 insertions(+), 248 deletions(-)

diff --git a/advice.c b/advice.c
index 9b42033..34e1ccc 100644
--- a/advice.c
+++ b/advice.c
@@ -59,22 +59,17 @@ void advise(const char *advice, ...)
 	strbuf_release(&buf);
 }

-int git_default_advice_config(const char *var, const char *value)
+void git_default_advice_config(void)
 {
-	const char *k;
+	struct strbuf var = STRBUF_INIT;
 	int i;

-	if (!skip_prefix(var, "advice.", &k))
-		return 0;
-
 	for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
-		if (strcmp(k, advice_config[i].name))
-			continue;
-		*advice_config[i].preference = git_config_bool(var, value);
-		return 0;
+		strbuf_addf(&var, "advice.%s", advice_config[i].name);
+		git_config_get_bool(var.buf, advice_config[i].preference);
+		strbuf_reset(&var);
 	}
-
-	return 0;
+	strbuf_release(&var);
 }

 int error_resolve_conflict(const char *me)
diff --git a/advice.h b/advice.h
index 5ecc6c1..5bfe46c 100644
--- a/advice.h
+++ b/advice.h
@@ -19,7 +19,7 @@ extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
 extern int advice_rm_hints;

-int git_default_advice_config(const char *var, const char *value);
+void git_default_advice_config(void);
 __attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
 int error_resolve_conflict(const char *me);
diff --git a/cache.h b/cache.h
index 2693a37..fa28b40 100644
--- a/cache.h
+++ b/cache.h
@@ -1065,7 +1065,7 @@ extern const char *fmt_name(const char *name, const char *email);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
-extern int git_ident_config(const char *, const char *, void *);
+extern void git_ident_config(void);

 struct ident_split {
 	const char *name_begin;
diff --git a/config.c b/config.c
index 427850a..36b9124 100644
--- a/config.c
+++ b/config.c
@@ -46,6 +46,8 @@ static int zlib_compression_seen;
  */
 static struct config_set the_config_set;

+static int default_config_loaded;
+
 static int config_file_fgetc(struct config_source *conf)
 {
 	return fgetc(conf->u.file);
@@ -670,147 +672,91 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 	return 0;
 }

-static int git_default_core_config(const char *var, const char *value)
+static void git_default_core_config(void)
 {
+	const char *value = NULL;
+	unsigned long v_l = 0;
+	int abbrev;
+	const char *comment;
+
 	/* This needs a better name */
-	if (!strcmp(var, "core.filemode")) {
-		trust_executable_bit = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "core.trustctime")) {
-		trust_ctime = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "core.checkstat")) {
+	git_config_get_bool("core.filemode", &trust_executable_bit);
+	git_config_get_bool("core.trustctime", &trust_ctime);
+
+	if (!git_config_get_value("core.checkstat", &value)) {
 		if (!strcasecmp(value, "default"))
 			check_stat = 1;
 		else if (!strcasecmp(value, "minimal"))
 			check_stat = 0;
 	}

-	if (!strcmp(var, "core.quotepath")) {
-		quote_path_fully = git_config_bool(var, value);
-		return 0;
-	}
+	git_config_get_bool("core.quotepath", &quote_path_fully);
+	git_config_get_bool("core.symlinks", &has_symlinks);
+	git_config_get_bool("core.ignorecase", &ignore_case);
+	git_config_get_pathname("core.attributesfile", &git_attributes_file);
+	git_config_get_bool("core.bare", &is_bare_repository_cfg);
+	git_config_get_bool("core.ignorestat", &assume_unchanged);
+	git_config_get_bool("core.prefersymlinkrefs", &prefer_symlink_refs);
+	git_config_get_bool("core.logallrefupdates", &log_all_ref_updates);
+	git_config_get_bool("core.warnambiguousrefs", &warn_ambiguous_refs);

-	if (!strcmp(var, "core.symlinks")) {
-		has_symlinks = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.ignorecase")) {
-		ignore_case = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.attributesfile"))
-		return git_config_pathname(&git_attributes_file, var, value);
-
-	if (!strcmp(var, "core.bare")) {
-		is_bare_repository_cfg = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.ignorestat")) {
-		assume_unchanged = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.prefersymlinkrefs")) {
-		prefer_symlink_refs = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.logallrefupdates")) {
-		log_all_ref_updates = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.warnambiguousrefs")) {
-		warn_ambiguous_refs = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.abbrev")) {
-		int abbrev = git_config_int(var, value);
+	if (!git_config_get_int("core.abbrev", &abbrev)) {
 		if (abbrev < minimum_abbrev || abbrev > 40)
-			return -1;
+			git_die_config("core.abbrev", NULL);
 		default_abbrev = abbrev;
-		return 0;
 	}
-
-	if (!strcmp(var, "core.loosecompression")) {
-		int level = git_config_int(var, value);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die(_("bad zlib compression level %d"), level);
-		zlib_compression_level = level;
+	if (!git_config_get_int("core.loosecompression", &zlib_compression_level)) {
+		if (zlib_compression_level == -1)
+			zlib_compression_level = Z_DEFAULT_COMPRESSION;
+		else if (zlib_compression_level < 0 ||
+			 zlib_compression_level > Z_BEST_COMPRESSION)
+			git_die_config("core.loosecompression", _("bad zlib compression level %d"),
+					zlib_compression_level);
 		zlib_compression_seen = 1;
-		return 0;
 	}
-
-	if (!strcmp(var, "core.compression")) {
-		int level = git_config_int(var, value);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die(_("bad zlib compression level %d"), level);
-		core_compression_level = level;
+	if (!git_config_get_int("core.compression", &core_compression_level)) {
+		if (core_compression_level == -1)
+			core_compression_level = Z_DEFAULT_COMPRESSION;
+		else if (core_compression_level < 0 ||
+			 core_compression_level > Z_BEST_COMPRESSION)
+			git_die_config("core.compression", _("bad zlib compression level %d"),
+					core_compression_level);
 		core_compression_seen = 1;
 		if (!zlib_compression_seen)
-			zlib_compression_level = level;
-		return 0;
+			zlib_compression_level = core_compression_level;
 	}
-
-	if (!strcmp(var, "core.packedgitwindowsize")) {
+	if (!git_config_get_ulong("core.packedgitwindowsize", &v_l)) {
 		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_ulong(var, value);
+		packed_git_window_size = v_l;

 		/* This value must be multiple of (pagesize * 2) */
 		packed_git_window_size /= pgsz_x2;
 		if (packed_git_window_size < 1)
 			packed_git_window_size = 1;
 		packed_git_window_size *= pgsz_x2;
-		return 0;
-	}
-
-	if (!strcmp(var, "core.bigfilethreshold")) {
-		big_file_threshold = git_config_ulong(var, value);
-		return 0;
 	}
+	git_config_get_ulong("core.bigfilethreshold", &big_file_threshold);
+	if (!git_config_get_ulong("core.packedgitlimit", &v_l))
+		packed_git_limit = v_l;
+	if (!git_config_get_ulong("core.deltabasecachelimit", &v_l))
+		delta_base_cache_limit = v_l;

-	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_ulong(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.deltabasecachelimit")) {
-		delta_base_cache_limit = git_config_ulong(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.autocrlf")) {
+	if (!git_config_get_value("core.autocrlf", &value)) {
 		if (value && !strcasecmp(value, "input")) {
 			if (core_eol == EOL_CRLF)
-				return error("core.autocrlf=input conflicts with core.eol=crlf");
+				git_die_config("core.autocrlf",
+						"core.autocrlf=input conflicts with core.eol=crlf");
 			auto_crlf = AUTO_CRLF_INPUT;
-			return 0;
-		}
-		auto_crlf = git_config_bool(var, value);
-		return 0;
+		} else
+			auto_crlf = git_config_bool("core.autocrlf", value);
 	}
-
-	if (!strcmp(var, "core.safecrlf")) {
-		if (value && !strcasecmp(value, "warn")) {
+	if (!git_config_get_value("core.safecrlf", &value)) {
+		if (value && !strcasecmp(value, "warn"))
 			safe_crlf = SAFE_CRLF_WARN;
-			return 0;
-		}
-		safe_crlf = git_config_bool(var, value);
-		return 0;
+		else
+			safe_crlf = git_config_bool("core.safecrlf", value);
 	}
-
-	if (!strcmp(var, "core.eol")) {
+	if (!git_config_get_value("core.eol", &value)) {
 		if (value && !strcasecmp(value, "lf"))
 			core_eol = EOL_LF;
 		else if (value && !strcasecmp(value, "crlf"))
@@ -820,106 +766,71 @@ static int git_default_core_config(const char *var, const char *value)
 		else
 			core_eol = EOL_UNSET;
 		if (core_eol == EOL_CRLF && auto_crlf == AUTO_CRLF_INPUT)
-			return error("core.autocrlf=input conflicts with core.eol=crlf");
-		return 0;
+			git_die_config("core.autocrlf",
+					"core.autocrlf=input conflicts with core.eol=crlf");
 	}
+	git_config_get_string("core.notesref", &notes_ref_name);
+	git_config_get_string_const("core.pager", &pager_program);
+	git_config_get_string_const("core.editor", &editor_program);

-	if (!strcmp(var, "core.notesref")) {
-		notes_ref_name = xstrdup(value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.pager"))
-		return git_config_string(&pager_program, var, value);
-
-	if (!strcmp(var, "core.editor"))
-		return git_config_string(&editor_program, var, value);
-
-	if (!strcmp(var, "core.commentchar")) {
-		if (!value)
-			return config_error_nonbool(var);
-		else if (!strcasecmp(value, "auto"))
+	if (!git_config_get_string_const("core.commentchar", &comment)) {
+		if (!strcasecmp(comment, "auto"))
 			auto_comment_line_char = 1;
-		else if (value[0] && !value[1]) {
-			comment_line_char = value[0];
+		else if (comment[0] && !comment[1]) {
+			comment_line_char = comment[0];
 			auto_comment_line_char = 0;
 		} else
-			return error("core.commentChar should only be one character");
-		return 0;
+			git_die_config("core.commentchar",
+					"core.commentchar should only be one character");
 	}
+	git_config_get_string_const("core.askpass", &askpass_program);
+	git_config_get_pathname("core.excludesfile", &excludes_file);

-	if (!strcmp(var, "core.askpass"))
-		return git_config_string(&askpass_program, var, value);
-
-	if (!strcmp(var, "core.excludesfile"))
-		return git_config_pathname(&excludes_file, var, value);
-
-	if (!strcmp(var, "core.whitespace")) {
+	if (!git_config_get_value("core.whitespace", &value)) {
 		if (!value)
-			return config_error_nonbool(var);
-		whitespace_rule_cfg = parse_whitespace_rule(value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.fsyncobjectfiles")) {
-		fsync_object_files = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.preloadindex")) {
-		core_preload_index = git_config_bool(var, value);
-		return 0;
+			git_die_config("core.whitespace", "Missing value for 'core.whitespace'");
+		else
+			whitespace_rule_cfg = parse_whitespace_rule(value);
 	}
+	git_config_get_bool("core.fsyncobjectfiles", &fsync_object_files);
+	git_config_get_bool("core.preloadindex", &core_preload_index);

-	if (!strcmp(var, "core.createobject")) {
+	if (!git_config_get_value("core.createobject", &value)) {
 		if (!strcmp(value, "rename"))
 			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
 		else if (!strcmp(value, "link"))
 			object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
 		else
-			die(_("invalid mode for object creation: %s"), value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.sparsecheckout")) {
-		core_apply_sparse_checkout = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.precomposeunicode")) {
-		precomposed_unicode = git_config_bool(var, value);
-		return 0;
+			git_die_config("core.createobject",
+					_("Invalid mode for object creation: %s"), value);
 	}
+	git_config_get_bool("core.sparsecheckout", &core_apply_sparse_checkout);
+	git_config_get_bool("core.precomposeunicode", &precomposed_unicode);

 	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
 }

-static int git_default_i18n_config(const char *var, const char *value)
+static void git_default_i18n_config(void)
 {
-	if (!strcmp(var, "i18n.commitencoding"))
-		return git_config_string(&git_commit_encoding, var, value);
-
-	if (!strcmp(var, "i18n.logoutputencoding"))
-		return git_config_string(&git_log_output_encoding, var, value);
+	git_config_get_string_const("i18n.commitencoding", &git_commit_encoding);
+	git_config_get_string_const("i18n.logoutputencoding", &git_log_output_encoding);

 	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
 }

-static int git_default_branch_config(const char *var, const char *value)
+static void git_default_branch_config(void)
 {
-	if (!strcmp(var, "branch.autosetupmerge")) {
-		if (value && !strcasecmp(value, "always")) {
+	const char *value = NULL;
+	if (!git_config_get_value("branch.autosetupmerge", &value)) {
+		if (value && !strcasecmp(value, "always"))
 			git_branch_track = BRANCH_TRACK_ALWAYS;
-			return 0;
-		}
-		git_branch_track = git_config_bool(var, value);
-		return 0;
+		else
+			git_branch_track = git_config_bool("branch.autosetupmerge", value);
 	}
-	if (!strcmp(var, "branch.autosetuprebase")) {
+	if (!git_config_get_value("branch.autosetuprebase", &value)) {
 		if (!value)
-			return config_error_nonbool(var);
+			git_die_config("branch.autosetuprebase",
+					"Missing value for 'branch.autosetuprebase'");
 		else if (!strcmp(value, "never"))
 			autorebase = AUTOREBASE_NEVER;
 		else if (!strcmp(value, "local"))
@@ -929,19 +840,19 @@ static int git_default_branch_config(const char *var, const char *value)
 		else if (!strcmp(value, "always"))
 			autorebase = AUTOREBASE_ALWAYS;
 		else
-			return error("Malformed value for %s", var);
-		return 0;
+			git_die_config("branch.autosetuprebase",
+					"Malformed value for branch.autosetuprebase");
 	}

 	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
 }

-static int git_default_push_config(const char *var, const char *value)
+static void git_default_push_config(void)
 {
-	if (!strcmp(var, "push.default")) {
+	const char *value  = NULL;
+	if (!git_config_get_value("push.default", &value)) {
 		if (!value)
-			return config_error_nonbool(var);
+			git_die_config("push.default", "Missing value for 'push.default'");
 		else if (!strcmp(value, "nothing"))
 			push_default = PUSH_DEFAULT_NOTHING;
 		else if (!strcmp(value, "matching"))
@@ -955,60 +866,44 @@ static int git_default_push_config(const char *var, const char *value)
 		else if (!strcmp(value, "current"))
 			push_default = PUSH_DEFAULT_CURRENT;
 		else {
-			error("Malformed value for %s: %s", var, value);
-			return error("Must be one of nothing, matching, simple, "
+			error("Malformed value for push.default: %s", value);
+			git_die_config("push.default", "Must be one of nothing, matching, simple, "
 				     "upstream or current.");
 		}
-		return 0;
 	}

 	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
 }

-static int git_default_mailmap_config(const char *var, const char *value)
+static void git_default_mailmap_config(void)
 {
-	if (!strcmp(var, "mailmap.file"))
-		return git_config_pathname(&git_mailmap_file, var, value);
-	if (!strcmp(var, "mailmap.blob"))
-		return git_config_string(&git_mailmap_blob, var, value);
+	git_config_get_pathname("mailmap.file", &git_mailmap_file);
+	git_config_get_string_const("mailmap.blob", &git_mailmap_blob);

 	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
 }

-int git_default_config(const char *var, const char *value, void *dummy)
+int git_default_config(const char *unused, const char *unused2, void *dummy)
 {
-	if (starts_with(var, "core."))
-		return git_default_core_config(var, value);
-
-	if (starts_with(var, "user."))
-		return git_ident_config(var, value, dummy);
-
-	if (starts_with(var, "i18n."))
-		return git_default_i18n_config(var, value);
-
-	if (starts_with(var, "branch."))
-		return git_default_branch_config(var, value);
-
-	if (starts_with(var, "push."))
-		return git_default_push_config(var, value);
+	const char *v = NULL;

-	if (starts_with(var, "mailmap."))
-		return git_default_mailmap_config(var, value);
-
-	if (starts_with(var, "advice."))
-		return git_default_advice_config(var, value);
-
-	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
-		pager_use_color = git_config_bool(var,value);
-		return 0;
-	}
-
-	if (!strcmp(var, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(var, value);
+	if (default_config_loaded)
 		return 0;
-	}
+	git_default_core_config();
+	git_ident_config();
+	git_default_i18n_config();
+	git_default_branch_config();
+	git_default_push_config();
+	git_default_mailmap_config();
+	git_default_advice_config();
+
+	if (!git_config_get_value("pager.color", &v))
+		pager_use_color = git_config_bool("pager.color",v);
+	else if (!git_config_get_value("color.pager", &v))
+		pager_use_color = git_config_bool("color.pager",v);
+
+	git_config_get_ulong("pack.packsizelimit", &pack_size_limit_cfg);
+	default_config_loaded = 1;
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
@@ -2082,6 +1977,7 @@ int git_config_set_multivar_in_file(const char *config_filename,

 	/* Invalidate the config cache */
 	git_config_clear();
+	default_config_loaded = 0;

 out_free:
 	if (lock)
diff --git a/ident.c b/ident.c
index 1d9b6e7..0db595f 100644
--- a/ident.c
+++ b/ident.c
@@ -392,29 +392,26 @@ int author_ident_sufficiently_given(void)
 	return ident_is_sufficient(author_ident_explicitly_given);
 }

-int git_ident_config(const char *var, const char *value, void *data)
+void git_ident_config(void)
 {
-	if (!strcmp(var, "user.name")) {
+	const char *value = NULL;
+
+	if (!git_config_get_value("user.name", &value)) {
 		if (!value)
-			return config_error_nonbool(var);
+			git_die_config("user.name", "Missing value for 'user.name'");
 		strbuf_reset(&git_default_name);
 		strbuf_addstr(&git_default_name, value);
 		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
-		return 0;
 	}
-
-	if (!strcmp(var, "user.email")) {
+	if (!git_config_get_value("user.email", &value)) {
 		if (!value)
-			return config_error_nonbool(var);
+			git_die_config("user.email", "Missing value for 'user.email'");
 		strbuf_reset(&git_default_email);
 		strbuf_addstr(&git_default_email, value);
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		return 0;
 	}
-
-	return 0;
 }

 static int buf_cmp(const char *a_begin, const char *a_end,
-- 
1.9.0.GIT
