From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC] rewrite `git_default_config()` using config-set API functions
Date: Mon, 21 Jul 2014 17:14:02 +0530
Message-ID: <53CCFD02.6010704@gmail.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 13:44:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9C0t-0005Ri-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 13:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbaGULoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 07:44:11 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:43353 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbaGULoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 07:44:09 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so9033462pdj.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6JtpmW61BlqOtzqCq8exSoubXTDmGzc6gQt3qI8DUCI=;
        b=iIXUa88yaXtY6F/pjQKA8PcF8v/9lXapK8NuJCbrKsXaatPl7JfSG5rmIfH6ycunLC
         UxJcUz8kdhEdPRZJAN9pgWINDxoGCe7QH2dSCdN09mC2S9ZdRCpCUcI8iPJmE9y1pacB
         1WX3QSr2AsUP/VwI4HsLBuKw8G9EPlir4C0GUTldEVgYidiIR7b7su+z1Wlr9a6bmoZK
         x8bsJRm/7heN5RJ2Am1upnN9x5trsGdArztMzgfCrk2kOvKNctGCnCChXt3LwRRTOEWG
         pq3xvWYkdLrpkn33GTtrLOB3Bya0dONjE0x+JnVVDEOyeatj/pVNOPnj1/qkA0W1t/fG
         oLNg==
X-Received: by 10.68.131.33 with SMTP id oj1mr13816859pbb.71.1405943048595;
        Mon, 21 Jul 2014 04:44:08 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.246.202])
        by mx.google.com with ESMTPSA id pz10sm13966621pbb.33.2014.07.21.04.44.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 04:44:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253955>

Use `git_config_get_*()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
Consider this as a proof of concept as the others callers have to be rewritten
as well.
I think that it is not so buggy as it passes all the tests.
After the first six patches in the series which you have already seen there are
five or four left which can rewritten without touching git_default_config().

Thus, this rewrite will serve as the base for rewriting other git_config()
callers which pass control to git_default_config() at the end of the function.
Also there are more than thirty direct callers to git_default_config()
(i.e git_config(git_default_config, NULL)), so this rewrite solves them
in one sweep.

Slight behaviour change, config_error_nonbool() has been replaced with
die("Missing value for '%s'", var);.
The original code also alerted the file name and the line number which we lose here.

Cheers,
Tanay Abhra.

 advice.c |  18 ++--
 advice.h |   2 +-
 cache.h  |   2 +-
 config.c | 287 ++++++++++++++++++++-------------------------------------------
 ident.c  |  15 ++--
 5 files changed, 104 insertions(+), 220 deletions(-)

diff --git a/advice.c b/advice.c
index 9b42033..92d89a9 100644
--- a/advice.c
+++ b/advice.c
@@ -59,22 +59,16 @@ void advise(const char *advice, ...)
 	strbuf_release(&buf);
 }

-int git_default_advice_config(const char *var, const char *value)
+void git_default_advice_config(void)
 {
-	const char *k;
+	struct strbuf var = STRBUF_INIT;
 	int i;
-
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
index e53651c..e667d92 100644
--- a/cache.h
+++ b/cache.h
@@ -1061,7 +1061,7 @@ extern const char *fmt_name(const char *name, const char *email);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
-extern int git_ident_config(const char *, const char *, void *);
+extern void git_ident_config(void);

 struct ident_split {
 	const char *name_begin;
diff --git a/config.c b/config.c
index fe9f399..72196a9 100644
--- a/config.c
+++ b/config.c
@@ -666,88 +666,47 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 	return 0;
 }

-static int git_default_core_config(const char *var, const char *value)
+static void git_default_core_config(void)
 {
+	const char *value = NULL;
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
-
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
+	git_config_get_bool("core.quotepath", &quote_path_fully);
+	git_config_get_bool("core.symlinks", &has_symlinks);
+	git_config_get_bool("core.ignorecase", &ignore_case);
+	git_config_get_pathname("core.attributesfile", &git_attributes_file);
+	git_config_get_bool("core.bare", &is_bare_repository_cfg);
+	git_config_get_bool("core.ignorestat", &assume_unchanged);
+	git_config_get_bool("core.prefersymlinkrefs", &prefer_symlink_refs);
+	git_config_get_bool("core.logallrefupdates", &log_all_ref_updates);
+	git_config_get_bool("core.warnambiguousrefs", &warn_ambiguous_refs);

-	if (!strcmp(var, "core.warnambiguousrefs")) {
-		warn_ambiguous_refs = git_config_bool(var, value);
-		return 0;
+	int abbrev;
+	if (!git_config_get_int("core.abbrev", &abbrev)) {
+		if (abbrev >= minimum_abbrev && abbrev <= 40)
+			default_abbrev = abbrev;
 	}

-	if (!strcmp(var, "core.abbrev")) {
-		int abbrev = git_config_int(var, value);
-		if (abbrev < minimum_abbrev || abbrev > 40)
-			return -1;
-		default_abbrev = abbrev;
-		return 0;
-	}
-
-	if (!strcmp(var, "core.loosecompression")) {
-		int level = git_config_int(var, value);
+	int level;
+	if (!git_config_get_int("core.loosecompression", &level)) {
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
 			die("bad zlib compression level %d", level);
 		zlib_compression_level = level;
 		zlib_compression_seen = 1;
-		return 0;
 	}

-	if (!strcmp(var, "core.compression")) {
-		int level = git_config_int(var, value);
+	if (!git_config_get_int("core.compression", &level)) {
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -756,57 +715,39 @@ static int git_default_core_config(const char *var, const char *value)
 		core_compression_seen = 1;
 		if (!zlib_compression_seen)
 			zlib_compression_level = level;
-		return 0;
 	}

-	if (!strcmp(var, "core.packedgitwindowsize")) {
+	if (!git_config_get_ulong("core.packedgitwindowsize", (long unsigned int*)&packed_git_window_size)) {
 		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_ulong(var, value);

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

-	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_ulong(var, value);
-		return 0;
-	}
+	git_config_get_ulong("core.bigfilethreshold", &big_file_threshold);
+	git_config_get_ulong("core.packedgitlimit", (long unsigned int*)&packed_git_limit);
+	git_config_get_ulong("core.deltabasecachelimit", (long unsigned int*)&delta_base_cache_limit);

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
+				die("core.autocrlf=input conflicts with core.eol=crlf");
 			auto_crlf = AUTO_CRLF_INPUT;
-			return 0;
-		}
-		auto_crlf = git_config_bool(var, value);
-		return 0;
+		} else
+			auto_crlf = git_config_bool("core.autocrlf", value);
 	}

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

-	if (!strcmp(var, "core.eol")) {
+	if (!git_config_get_value("core.eol", &value)) {
 		if (value && !strcasecmp(value, "lf"))
 			core_eol = EOL_LF;
 		else if (value && !strcasecmp(value, "crlf"))
@@ -816,108 +757,74 @@ static int git_default_core_config(const char *var, const char *value)
 		else
 			core_eol = EOL_UNSET;
 		if (core_eol == EOL_CRLF && auto_crlf == AUTO_CRLF_INPUT)
-			return error("core.autocrlf=input conflicts with core.eol=crlf");
-		return 0;
+			die("core.autocrlf=input conflicts with core.eol=crlf");
 	}

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
+	git_config_get_string("core.notesref", (const char**)&notes_ref_name);
+	git_config_get_string("core.pager", &pager_program);
+	git_config_get_string("core.editor", &editor_program);

-	if (!strcmp(var, "core.commentchar")) {
-		const char *comment;
-		int ret = git_config_string(&comment, var, value);
-		if (ret)
-			return ret;
-		else if (!strcasecmp(comment, "auto"))
+	const char *comment;
+	if (!git_config_get_string("core.commentchar", &comment)) {
+		if (!strcasecmp(comment, "auto"))
 			auto_comment_line_char = 1;
 		else if (comment[0] && !comment[1]) {
 			comment_line_char = comment[0];
 			auto_comment_line_char = 0;
 		} else
-			return error("core.commentChar should only be one character");
-		return 0;
+			die("core.commentChar should only be one character");
 	}

-	if (!strcmp(var, "core.askpass"))
-		return git_config_string(&askpass_program, var, value);
+	git_config_get_string("core.askpass", &askpass_program);

-	if (!strcmp(var, "core.excludesfile"))
-		return git_config_pathname(&excludes_file, var, value);
+	git_config_get_pathname("core.excludesfile", &excludes_file);

-	if (!strcmp(var, "core.whitespace")) {
+	if (!git_config_get_value("core.whitespace", &value)) {
 		if (!value)
-			return config_error_nonbool(var);
-		whitespace_rule_cfg = parse_whitespace_rule(value);
-		return 0;
+			config_error_nonbool("core.whitespace");
+		else
+			whitespace_rule_cfg = parse_whitespace_rule(value);
 	}

-	if (!strcmp(var, "core.fsyncobjectfiles")) {
-		fsync_object_files = git_config_bool(var, value);
-		return 0;
-	}
+	git_config_get_bool("core.fsyncobjectfiles", &fsync_object_files);
+	git_config_get_bool("core.preloadindex", &core_preload_index);

-	if (!strcmp(var, "core.preloadindex")) {
-		core_preload_index = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.createobject")) {
+	if (!git_config_get_value("core.createobject", &value)) {
 		if (!strcmp(value, "rename"))
 			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
 		else if (!strcmp(value, "link"))
 			object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
 		else
 			die("Invalid mode for object creation: %s", value);
-		return 0;
 	}

-	if (!strcmp(var, "core.sparsecheckout")) {
-		core_apply_sparse_checkout = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.precomposeunicode")) {
-		precomposed_unicode = git_config_bool(var, value);
-		return 0;
-	}
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
+	git_config_get_string("i18n.commitencoding", &git_commit_encoding);
+	git_config_get_string("i18n.logoutputencoding", &git_log_output_encoding);

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
+
+	if (!git_config_get_value("branch.autosetuprebase", &value)) {
 		if (!value)
-			return config_error_nonbool(var);
+			die("Missing value for 'branch.autosetuprebase'");
 		else if (!strcmp(value, "never"))
 			autorebase = AUTOREBASE_NEVER;
 		else if (!strcmp(value, "local"))
@@ -927,19 +834,18 @@ static int git_default_branch_config(const char *var, const char *value)
 		else if (!strcmp(value, "always"))
 			autorebase = AUTOREBASE_ALWAYS;
 		else
-			return error("Malformed value for %s", var);
-		return 0;
+			die("Malformed value for branch.autosetuprebase");
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
+			die("Missing value for 'push.default'");
 		else if (!strcmp(value, "nothing"))
 			push_default = PUSH_DEFAULT_NOTHING;
 		else if (!strcmp(value, "matching"))
@@ -953,60 +859,47 @@ static int git_default_push_config(const char *var, const char *value)
 		else if (!strcmp(value, "current"))
 			push_default = PUSH_DEFAULT_CURRENT;
 		else {
-			error("Malformed value for %s: %s", var, value);
-			return error("Must be one of nothing, matching, simple, "
+			error("Malformed value for %s: %s", "push.default", value);
+			die("Must be one of nothing, matching, simple, "
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
+	git_config_get_string("mailmap.blob", &git_mailmap_blob);

 	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
 }

 int git_default_config(const char *var, const char *value, void *dummy)
 {
-	if (starts_with(var, "core."))
-		return git_default_core_config(var, value);
+	const char *v = NULL;

-	if (starts_with(var, "user."))
-		return git_ident_config(var, value, dummy);
+	git_default_core_config();

-	if (starts_with(var, "i18n."))
-		return git_default_i18n_config(var, value);
+	git_ident_config();

-	if (starts_with(var, "branch."))
-		return git_default_branch_config(var, value);
+	git_default_i18n_config();

-	if (starts_with(var, "push."))
-		return git_default_push_config(var, value);
+	git_default_branch_config();

-	if (starts_with(var, "mailmap."))
-		return git_default_mailmap_config(var, value);
+	git_default_push_config();

-	if (starts_with(var, "advice."))
-		return git_default_advice_config(var, value);
+	git_default_mailmap_config();

-	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
-		pager_use_color = git_config_bool(var,value);
-		return 0;
-	}
+	git_default_advice_config();

-	if (!strcmp(var, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(var, value);
-		return 0;
-	}
+	if (!git_config_get_value("pager.color", &v))
+		pager_use_color = git_config_bool("pager.color",v);
+	else if (!git_config_get_value("color.pager", &v))
+		pager_use_color = git_config_bool("color.pager",v);
+
+	git_config_get_ulong("pack.packsizelimit", &pack_size_limit_cfg);
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/ident.c b/ident.c
index 1d9b6e7..da889cf 100644
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
+	if (!git_config_get_value("user.name", &value)) {
 		if (!value)
-			return config_error_nonbool(var);
+			die("Missing value for 'user.name'");
 		strbuf_reset(&git_default_name);
 		strbuf_addstr(&git_default_name, value);
 		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
-		return 0;
 	}

-	if (!strcmp(var, "user.email")) {
+	if (!git_config_get_value("user.email", &value)) {
 		if (!value)
-			return config_error_nonbool(var);
+			die("Missing value for 'user.email'");
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
