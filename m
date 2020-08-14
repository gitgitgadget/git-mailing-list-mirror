Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F4C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9970A20768
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgHNQRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:17:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:59266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgHNQRi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 12:17:38 -0400
Received: (qmail 1070 invoked by uid 109); 14 Aug 2020 16:17:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 16:17:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26918 invoked by uid 111); 14 Aug 2020 16:17:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 12:17:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 12:17:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/6] config: fix leaks from git_config_get_string_const()
Message-ID: <20200814161736.GC595698@coredump.intra.peff.net>
References: <20200814161328.GA153929@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814161328.GA153929@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two functions to get a single config string:

  - git_config_get_string()

  - git_config_get_string_const()

One might naively think that the first one allocates a new string and
the second one just points us to the internal configset storage. But
in fact they both allocate a new copy; the second one exists only to
avoid having to cast when using it with a const global which we never
intend to free.

The documentation for the function explains that clearly, but it seems
I'm not alone in being surprised by this. Of 17 calls to the function,
13 of them leak the resulting value.

We could obviously fix these by adding the appropriate free(). But it
would be simpler still if we actually had a non-allocating way to get
the string. There's git_config_get_value() but that doesn't quite do
what we want. If the config key is present but is a boolean with no
value (e.g., "[foo]bar" in the file), then we'll get NULL (whereas the
string versions will print an error and die).

So let's introduce a new variant, git_config_get_string_tmp(), that
behaves as these callers expect. We need a new name because we have new
semantics but the same function signature (so even if we converted the
four remaining callers, topics in flight might be surprised). The "tmp"
is because this value should only be held onto for a short time. In
practice it's rare for us to clear and refresh the configset,
invalidating the pointer, but hopefully the "tmp" makes callers think
about the lifetime. In each of the converted cases here the value only
needs to last within the local function or its immediate caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c             |  2 +-
 builtin/submodule--helper.c |  8 ++++----
 config.c                    | 30 ++++++++++++++++++++++++++++++
 config.h                    | 10 ++++++++++
 connect.c                   |  4 ++--
 editor.c                    |  2 +-
 help.c                      |  2 +-
 protocol.c                  |  2 +-
 submodule.c                 |  4 ++--
 t/helper/test-config.c      |  2 +-
 10 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c49f0e9752..b3b77f8e2b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -645,7 +645,7 @@ static void prepare_format_display(struct ref *ref_map)
 	struct ref *rm;
 	const char *format = "full";
 
-	git_config_get_string_const("fetch.output", &format);
+	git_config_get_string_tmp("fetch.output", &format);
 	if (!strcasecmp(format, "full"))
 		compact_format = 0;
 	else if (!strcasecmp(format, "compact"))
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1762458345..e09605716e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1511,7 +1511,7 @@ static void determine_submodule_update_strategy(struct repository *r,
 		if (parse_submodule_update_strategy(update, out) < 0)
 			die(_("Invalid update mode '%s' for submodule path '%s'"),
 				update, path);
-	} else if (!repo_config_get_string_const(r, key, &val)) {
+	} else if (!repo_config_get_string_tmp(r, key, &val)) {
 		if (parse_submodule_update_strategy(val, out) < 0)
 			die(_("Invalid update mode '%s' configured for submodule path '%s'"),
 				val, path);
@@ -1667,7 +1667,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	}
 
 	key = xstrfmt("submodule.%s.update", sub->name);
-	if (!repo_config_get_string_const(the_repository, key, &update_string)) {
+	if (!repo_config_get_string_tmp(the_repository, key, &update_string)) {
 		update_type = parse_submodule_update_type(update_string);
 	} else {
 		update_type = sub->update_strategy.type;
@@ -1690,7 +1690,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	if (repo_config_get_string_const(the_repository, sb.buf, &url)) {
+	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
 		if (starts_with_dot_slash(sub->url) ||
 		    starts_with_dot_dot_slash(sub->url)) {
 			url = compute_submodule_clone_url(sub->url);
@@ -1976,7 +1976,7 @@ static const char *remote_submodule_branch(const char *path)
 		return NULL;
 
 	key = xstrfmt("submodule.%s.branch", sub->name);
-	if (repo_config_get_string_const(the_repository, key, &branch))
+	if (repo_config_get_string_tmp(the_repository, key, &branch))
 		branch = sub->branch;
 	free(key);
 
diff --git a/config.c b/config.c
index 2b79fe76ad..2f244c67b6 100644
--- a/config.c
+++ b/config.c
@@ -2020,6 +2020,20 @@ int git_configset_get_string(struct config_set *cs, const char *key, char **dest
 	return git_configset_get_string_const(cs, key, (const char **)dest);
 }
 
+int git_configset_get_string_tmp(struct config_set *cs, const char *key,
+				 const char **dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		if (!value)
+			return config_error_nonbool(key);
+		*dest = value;
+		return 0;
+	} else {
+		return 1;
+	}
+}
+
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
 {
 	const char *value;
@@ -2165,6 +2179,17 @@ int repo_config_get_string(struct repository *repo,
 	return repo_config_get_string_const(repo, key, (const char **)dest);
 }
 
+int repo_config_get_string_tmp(struct repository *repo,
+			       const char *key, const char **dest)
+{
+	int ret;
+	git_config_check_init(repo);
+	ret = git_configset_get_string_tmp(repo->config, key, dest);
+	if (ret < 0)
+		git_die_config(key, NULL);
+	return ret;
+}
+
 int repo_config_get_int(struct repository *repo,
 			const char *key, int *dest)
 {
@@ -2242,6 +2267,11 @@ int git_config_get_string(const char *key, char **dest)
 	return repo_config_get_string(the_repository, key, dest);
 }
 
+int git_config_get_string_tmp(const char *key, const char **dest)
+{
+	return repo_config_get_string_tmp(the_repository, key, dest);
+}
+
 int git_config_get_int(const char *key, int *dest)
 {
 	return repo_config_get_int(the_repository, key, dest);
diff --git a/config.h b/config.h
index 060874488f..a75b22e0d1 100644
--- a/config.h
+++ b/config.h
@@ -460,6 +460,7 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 
 int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
+int git_configset_get_string_tmp(struct config_set *cs, const char *key, const char **dest);
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
 int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
@@ -478,6 +479,8 @@ int repo_config_get_string_const(struct repository *repo,
 				 const char *key, const char **dest);
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest);
+int repo_config_get_string_tmp(struct repository *repo,
+			       const char *key, const char **dest);
 int repo_config_get_int(struct repository *repo,
 			const char *key, int *dest);
 int repo_config_get_ulong(struct repository *repo,
@@ -537,6 +540,13 @@ int git_config_get_string_const(const char *key, const char **dest);
  */
 int git_config_get_string(const char *key, char **dest);
 
+/**
+ * Similar to `git_config_get_string_const`, but does not allocate any new
+ * memory; on success `dest` will point to memory owned by the config
+ * machinery, which could be invalidated if it is discarded and reloaded.
+ */
+int git_config_get_string_tmp(const char *key, const char **dest);
+
 /**
  * Finds and parses the value to an integer for the configuration variable
  * `key`. Dies on error; otherwise, stores the value of the parsed integer in
diff --git a/connect.c b/connect.c
index 0b6aba177e..8b8f56cf6d 100644
--- a/connect.c
+++ b/connect.c
@@ -1052,7 +1052,7 @@ static const char *get_ssh_command(void)
 	if ((ssh = getenv("GIT_SSH_COMMAND")))
 		return ssh;
 
-	if (!git_config_get_string_const("core.sshcommand", &ssh))
+	if (!git_config_get_string_tmp("core.sshcommand", &ssh))
 		return ssh;
 
 	return NULL;
@@ -1071,7 +1071,7 @@ static void override_ssh_variant(enum ssh_variant *ssh_variant)
 {
 	const char *variant = getenv("GIT_SSH_VARIANT");
 
-	if (!variant && git_config_get_string_const("ssh.variant", &variant))
+	if (!variant && git_config_get_string_tmp("ssh.variant", &variant))
 		return;
 
 	if (!strcmp(variant, "auto"))
diff --git a/editor.c b/editor.c
index 91989ee8a1..6303ae0ab0 100644
--- a/editor.c
+++ b/editor.c
@@ -40,7 +40,7 @@ const char *git_sequence_editor(void)
 	const char *editor = getenv("GIT_SEQUENCE_EDITOR");
 
 	if (!editor)
-		git_config_get_string_const("sequence.editor", &editor);
+		git_config_get_string_tmp("sequence.editor", &editor);
 	if (!editor)
 		editor = git_editor();
 
diff --git a/help.c b/help.c
index d478afb2af..4e2468a44d 100644
--- a/help.c
+++ b/help.c
@@ -375,7 +375,7 @@ void list_cmds_by_config(struct string_list *list)
 {
 	const char *cmd_list;
 
-	if (git_config_get_string_const("completion.commands", &cmd_list))
+	if (git_config_get_string_tmp("completion.commands", &cmd_list))
 		return;
 
 	string_list_sort(list);
diff --git a/protocol.c b/protocol.c
index d1dd3424bb..8d964fc65e 100644
--- a/protocol.c
+++ b/protocol.c
@@ -21,7 +21,7 @@ enum protocol_version get_protocol_version_config(void)
 	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
 	const char *git_test_v;
 
-	if (!git_config_get_string_const("protocol.version", &value)) {
+	if (!git_config_get_string_tmp("protocol.version", &value)) {
 		enum protocol_version version = parse_protocol_version(value);
 
 		if (version == protocol_unknown_version)
diff --git a/submodule.c b/submodule.c
index a52b93a87f..d0b70ca536 100644
--- a/submodule.c
+++ b/submodule.c
@@ -194,7 +194,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		char *key;
 
 		key = xstrfmt("submodule.%s.ignore", submodule->name);
-		if (repo_config_get_string_const(the_repository, key, &ignore))
+		if (repo_config_get_string_tmp(the_repository, key, &ignore))
 			ignore = submodule->ignore;
 		free(key);
 
@@ -1299,7 +1299,7 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 
 		int fetch_recurse = submodule->fetch_recurse;
 		key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
-		if (!repo_config_get_string_const(spf->r, key, &value)) {
+		if (!repo_config_get_string_tmp(spf->r, key, &value)) {
 			fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
 		}
 		free(key);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 234c722b48..a6e936721f 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -126,7 +126,7 @@ int cmd__config(int argc, const char **argv)
 			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_string")) {
-		if (!git_config_get_string_const(argv[2], &v)) {
+		if (!git_config_get_string_tmp(argv[2], &v)) {
 			printf("%s\n", v);
 			goto exit0;
 		} else {
-- 
2.28.0.596.g9c08d63829

