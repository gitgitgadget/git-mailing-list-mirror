Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6114B10CB
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:11:16 -0800 (PST)
Received: (qmail 9817 invoked by uid 109); 7 Dec 2023 07:11:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:11:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 846 invoked by uid 111); 7 Dec 2023 07:11:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:11:19 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:11:14 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 1/7] config: handle NULL value when parsing non-bools
Message-ID: <20231207071114.GA1276005@coredump.intra.peff.net>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207071030.GA1275835@coredump.intra.peff.net>

When the config parser sees an "implicit" bool like:

  [core]
  someVariable

it passes NULL to the config callback. Any callback code which expects a
string must check for NULL. This usually happens via helpers like
git_config_string(), etc, but some custom code forgets to do so and will
segfault.

These are all fairly vanilla cases where the solution is just the usual
pattern of:

  if (!value)
        return config_error_nonbool(var);

though note that in a few cases we have to split initializers like:

  int some_var = initializer();

into:

  int some_var;
  if (!value)
        return config_error_nonbool(var);
  some_var = initializer();

There are still some broken instances after this patch, which I'll
address on their own in individual patches after this one.

Reported-by: Carlos Andrés Ramírez Cataño <antaigroupltda@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c        |  2 ++
 builtin/checkout.c     |  2 ++
 builtin/clone.c        |  2 ++
 builtin/log.c          |  5 ++++-
 builtin/pack-objects.c |  6 +++++-
 compat/mingw.c         |  2 ++
 config.c               |  8 ++++++++
 diff.c                 | 19 ++++++++++++++++---
 mailinfo.c             |  2 ++
 notes-utils.c          |  2 ++
 trailer.c              |  2 ++
 11 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 9c987d6567..2433b7da5c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -748,6 +748,8 @@ static int git_blame_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "blame.coloring")) {
+		if (!value)
+			return config_error_nonbool(var);
 		if (!strcmp(value, "repeatedLines")) {
 			coloring_mode |= OUTPUT_COLOR_LINE;
 		} else if (!strcmp(value, "highlightRecent")) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f02434bc15..d5c784854f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1202,6 +1202,8 @@ static int git_checkout_config(const char *var, const char *value,
 	struct checkout_opts *opts = cb;
 
 	if (!strcmp(var, "diff.ignoresubmodules")) {
+		if (!value)
+			return config_error_nonbool(var);
 		handle_ignore_submodules_arg(&opts->diff_options, value);
 		return 0;
 	}
diff --git a/builtin/clone.c b/builtin/clone.c
index c6357af949..54d9b9976a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -791,6 +791,8 @@ static int git_clone_config(const char *k, const char *v,
 			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(k, "clone.defaultremotename")) {
+		if (!v)
+			return config_error_nonbool(k);
 		free(remote_name);
 		remote_name = xstrdup(v);
 	}
diff --git a/builtin/log.c b/builtin/log.c
index ba775d7b5c..3ce41c4856 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -594,8 +594,11 @@ static int git_log_config(const char *var, const char *value,
 			decoration_style = 0; /* maybe warn? */
 		return 0;
 	}
-	if (!strcmp(var, "log.diffmerges"))
+	if (!strcmp(var, "log.diffmerges")) {
+		if (!value)
+			return config_error_nonbool(var);
 		return diff_merges_config(value);
+	}
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 89a8b5a976..62c540b4db 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3204,14 +3204,18 @@ static int git_pack_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
-		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
+		struct configured_exclusion *ex;
 		const char *oid_end, *pack_end;
 		/*
 		 * Stores the pack hash. This is not a true object ID, but is
 		 * of the same form.
 		 */
 		struct object_id pack_hash;
 
+		if (!v)
+			return config_error_nonbool(k);
+
+		ex = xmalloc(sizeof(*ex));
 		if (parse_oid_hex(v, &ex->e.oid, &oid_end) ||
 		    *oid_end != ' ' ||
 		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
diff --git a/compat/mingw.c b/compat/mingw.c
index ec5280da16..42053c1f65 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -255,6 +255,8 @@ int mingw_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.unsetenvvars")) {
+		if (!value)
+			return config_error_nonbool(var);
 		free(unset_environment_variables);
 		unset_environment_variables = xstrdup(value);
 		return 0;
diff --git a/config.c b/config.c
index b330c7adb4..18085c7e38 100644
--- a/config.c
+++ b/config.c
@@ -1386,6 +1386,8 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "core.checkstat")) {
+		if (!value)
+			return config_error_nonbool(var);
 		if (!strcasecmp(value, "default"))
 			check_stat = 1;
 		else if (!strcasecmp(value, "minimal"))
@@ -1547,11 +1549,15 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.checkroundtripencoding")) {
+		if (!value)
+			return config_error_nonbool(var);
 		check_roundtrip_encoding = xstrdup(value);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.notesref")) {
+		if (!value)
+			return config_error_nonbool(var);
 		notes_ref_name = xstrdup(value);
 		return 0;
 	}
@@ -1619,6 +1625,8 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.createobject")) {
+		if (!value)
+			return config_error_nonbool(var);
 		if (!strcmp(value, "rename"))
 			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
 		else if (!strcmp(value, "link"))
diff --git a/diff.c b/diff.c
index 2c602df10a..5b213a4b44 100644
--- a/diff.c
+++ b/diff.c
@@ -372,7 +372,10 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.colormovedws")) {
-		unsigned cm = parse_color_moved_ws(value);
+		unsigned cm;
+		if (!value)
+			return config_error_nonbool(var);
+		cm = parse_color_moved_ws(value);
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		diff_color_moved_ws_default = cm;
@@ -426,10 +429,15 @@ int git_diff_ui_config(const char *var, const char *value,
 	if (!strcmp(var, "diff.orderfile"))
 		return git_config_pathname(&diff_order_file_cfg, var, value);
 
-	if (!strcmp(var, "diff.ignoresubmodules"))
+	if (!strcmp(var, "diff.ignoresubmodules")) {
+		if (!value)
+			return config_error_nonbool(var);
 		handle_ignore_submodules_arg(&default_diff_options, value);
+	}
 
 	if (!strcmp(var, "diff.submodule")) {
+		if (!value)
+			return config_error_nonbool(var);
 		if (parse_submodule_params(&default_diff_options, value))
 			warning(_("Unknown value for 'diff.submodule' config variable: '%s'"),
 				value);
@@ -473,7 +481,10 @@ int git_diff_basic_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "diff.wserrorhighlight")) {
-		int val = parse_ws_error_highlight(value);
+		int val;
+		if (!value)
+			return config_error_nonbool(var);
+		val = parse_ws_error_highlight(value);
 		if (val < 0)
 			return -1;
 		ws_error_highlight_default = val;
@@ -490,6 +501,8 @@ int git_diff_basic_config(const char *var, const char *value,
 
 	if (!strcmp(var, "diff.dirstat")) {
 		struct strbuf errmsg = STRBUF_INIT;
+		if (!value)
+			return config_error_nonbool(var);
 		default_diff_options.dirstat_permille = diff_dirstat_permille_default;
 		if (parse_dirstat_params(&default_diff_options, value, &errmsg))
 			warning(_("Found errors in 'diff.dirstat' config variable:\n%s"),
diff --git a/mailinfo.c b/mailinfo.c
index a07d2da16d..093bed5d8f 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1253,6 +1253,8 @@ static int git_mailinfo_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "mailinfo.quotedcr")) {
+		if (!value)
+			return config_error_nonbool(var);
 		if (mailinfo_parse_quoted_cr_action(value, &mi->quoted_cr) != 0)
 			return error(_("bad action '%s' for '%s'"), value, var);
 		return 0;
diff --git a/notes-utils.c b/notes-utils.c
index 97c031c26e..01f4f5b424 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -112,6 +112,8 @@ static int notes_rewrite_config(const char *k, const char *v,
 		}
 		return 0;
 	} else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
+		if (!v)
+			return config_error_nonbool(k);
 		/* note that a refs/ prefix is implied in the
 		 * underlying for_each_glob_ref */
 		if (starts_with(v, "refs/notes/"))
diff --git a/trailer.c b/trailer.c
index b6de5d9cb2..b0e2ec224a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -507,6 +507,8 @@ static int git_trailer_default_config(const char *conf_key, const char *value,
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "separators")) {
+			if (!value)
+				return config_error_nonbool(conf_key);
 			separators = xstrdup(value);
 		}
 	}
-- 
2.43.0.664.ga12c899002

