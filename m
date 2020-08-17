Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B821C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5D320738
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgHQVdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:33:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:33574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHQVdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:33:16 -0400
Received: (qmail 6714 invoked by uid 109); 17 Aug 2020 21:33:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 21:33:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22278 invoked by uid 111); 17 Aug 2020 21:33:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 17:33:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 17:33:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/7] config: drop git_config_get_string_const()
Message-ID: <20200817213311.GE1854722@coredump.intra.peff.net>
References: <20200817213228.GA1854603@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817213228.GA1854603@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As evidenced by the leak fixes in the previous commit, the "const" in
git_config_get_string_const() clearly misleads people into thinking that
it does not allocate a copy of the string. We can fix this by renaming
it, but it's easier still to just drop it. Of the four remaining
callers:

  - The one in git_config_parse_expiry() still needs to allocate, since
    that's what its callers expect. We can just use the non-const
    version and cast our pointer. Slightly ugly, but the damage is
    contained in one spot.

  - The two in apply are writing to global "const char *" variables, and
    need to continue allocating. We often mark these as const because we
    assign default string literals to them. But in this case we don't do
    that, so we can just declare them as real "char *" pointers and use
    the non-const version.

  - The call in checkout doesn't actually need a copy; it can just use
    the non-allocating "tmp" version of the function.

The function is also mentioned in the MyFirstContribution document. We
can swap that call out for the non-allocating "tmp" variant, which fits
well in the example given.

We'll drop the "configset" and "repo" variants, as well (which are
unused).

Note that this frees up the "const" name, so we could rename the "tmp"
variant back to that. But let's give some time for topics in flight to
adapt to the new code before doing so (if we do it too soon, the
function semantics will change but the compiler won't alert us).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/MyFirstContribution.txt |  4 ++--
 apply.c                               |  4 ++--
 cache.h                               |  4 ++--
 checkout.c                            |  3 +--
 config.c                              | 29 ++++++---------------------
 config.h                              | 11 +---------
 environment.c                         |  4 ++--
 7 files changed, 16 insertions(+), 43 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index d85c9b5143..4f85a089ef 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -319,14 +319,14 @@ function body:
 ...
 
 	git_config(git_default_config, NULL);
-	if (git_config_get_string_const("user.name", &cfg_name) > 0)
+	if (git_config_get_string_tmp("user.name", &cfg_name) > 0)
 		printf(_("No name is found in config\n"));
 	else
 		printf(_("Your name: %s\n"), cfg_name);
 ----
 
 `git_config()` will grab the configuration from config files known to Git and
-apply standard precedence rules. `git_config_get_string_const()` will look up
+apply standard precedence rules. `git_config_get_string_tmp()` will look up
 a specific key ("user.name") and give you the value. There are a number of
 single-key lookup functions like this one; you can see them all (and more info
 about how to use `git_config()`) in `Documentation/technical/api-config.txt`.
diff --git a/apply.c b/apply.c
index 402d80602a..2839dae029 100644
--- a/apply.c
+++ b/apply.c
@@ -30,8 +30,8 @@ struct gitdiff_data {
 
 static void git_apply_config(void)
 {
-	git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
-	git_config_get_string_const("apply.ignorewhitespace", &apply_default_ignorewhitespace);
+	git_config_get_string("apply.whitespace", &apply_default_whitespace);
+	git_config_get_string("apply.ignorewhitespace", &apply_default_ignorewhitespace);
 	git_config(git_xmerge_config, NULL);
 }
 
diff --git a/cache.h b/cache.h
index 0290849c19..4cad61ffa4 100644
--- a/cache.h
+++ b/cache.h
@@ -921,8 +921,8 @@ extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
-extern const char *apply_default_whitespace;
-extern const char *apply_default_ignorewhitespace;
+extern char *apply_default_whitespace;
+extern char *apply_default_ignorewhitespace;
 extern const char *git_attributes_file;
 extern const char *git_hooks_path;
 extern int zlib_compression_level;
diff --git a/checkout.c b/checkout.c
index c72e9f9773..6586e30ca5 100644
--- a/checkout.c
+++ b/checkout.c
@@ -47,15 +47,14 @@ const char *unique_tracking_name(const char *name, struct object_id *oid,
 {
 	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	const char *default_remote = NULL;
-	if (!git_config_get_string_const("checkout.defaultremote", &default_remote))
+	if (!git_config_get_string_tmp("checkout.defaultremote", &default_remote))
 		cb_data.default_remote = default_remote;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	if (dwim_remotes_matched)
 		*dwim_remotes_matched = cb_data.num_matches;
 	free(cb_data.src_ref);
-	free((char *)default_remote);
 	if (cb_data.num_matches == 1) {
 		free(cb_data.default_dst_ref);
 		free(cb_data.default_dst_oid);
diff --git a/config.c b/config.c
index 2f244c67b6..f0367c76ad 100644
--- a/config.c
+++ b/config.c
@@ -2006,20 +2006,15 @@ const struct string_list *git_configset_get_value_multi(struct config_set *cs, c
 	return e ? &e->value_list : NULL;
 }
 
-int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest)
+int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
 {
 	const char *value;
 	if (!git_configset_get_value(cs, key, &value))
-		return git_config_string(dest, key, value);
+		return git_config_string((const char **)dest, key, value);
 	else
 		return 1;
 }
 
-int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
-{
-	return git_configset_get_string_const(cs, key, (const char **)dest);
-}
-
 int git_configset_get_string_tmp(struct config_set *cs, const char *key,
 				 const char **dest)
 {
@@ -2161,24 +2156,17 @@ const struct string_list *repo_config_get_value_multi(struct repository *repo,
 	return git_configset_get_value_multi(repo->config, key);
 }
 
-int repo_config_get_string_const(struct repository *repo,
-				 const char *key, const char **dest)
+int repo_config_get_string(struct repository *repo,
+			   const char *key, char **dest)
 {
 	int ret;
 	git_config_check_init(repo);
-	ret = git_configset_get_string_const(repo->config, key, dest);
+	ret = git_configset_get_string(repo->config, key, dest);
 	if (ret < 0)
 		git_die_config(key, NULL);
 	return ret;
 }
 
-int repo_config_get_string(struct repository *repo,
-			   const char *key, char **dest)
-{
-	git_config_check_init(repo);
-	return repo_config_get_string_const(repo, key, (const char **)dest);
-}
-
 int repo_config_get_string_tmp(struct repository *repo,
 			       const char *key, const char **dest)
 {
@@ -2257,11 +2245,6 @@ const struct string_list *git_config_get_value_multi(const char *key)
 	return repo_config_get_value_multi(the_repository, key);
 }
 
-int git_config_get_string_const(const char *key, const char **dest)
-{
-	return repo_config_get_string_const(the_repository, key, dest);
-}
-
 int git_config_get_string(const char *key, char **dest)
 {
 	return repo_config_get_string(the_repository, key, dest);
@@ -2304,7 +2287,7 @@ int git_config_get_pathname(const char *key, const char **dest)
 
 int git_config_get_expiry(const char *key, const char **output)
 {
-	int ret = git_config_get_string_const(key, output);
+	int ret = git_config_get_string(key, (char **)output);
 	if (ret)
 		return ret;
 	if (strcmp(*output, "now")) {
diff --git a/config.h b/config.h
index a75b22e0d1..91cdfbfb41 100644
--- a/config.h
+++ b/config.h
@@ -458,7 +458,6 @@ void git_configset_clear(struct config_set *cs);
  */
 int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
 
-int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 int git_configset_get_string_tmp(struct config_set *cs, const char *key, const char **dest);
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
@@ -475,8 +474,6 @@ int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value);
 const struct string_list *repo_config_get_value_multi(struct repository *repo,
 						      const char *key);
-int repo_config_get_string_const(struct repository *repo,
-				 const char *key, const char **dest);
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest);
 int repo_config_get_string_tmp(struct repository *repo,
@@ -532,16 +529,10 @@ void git_config_clear(void);
  * error message and returns -1. When the configuration variable `key` is
  * not found, returns 1 without touching `dest`.
  */
-int git_config_get_string_const(const char *key, const char **dest);
-
-/**
- * Similar to `git_config_get_string_const`, except that retrieved value
- * copied into the `dest` parameter is a mutable string.
- */
 int git_config_get_string(const char *key, char **dest);
 
 /**
- * Similar to `git_config_get_string_const`, but does not allocate any new
+ * Similar to `git_config_get_string`, but does not allocate any new
  * memory; on success `dest` will point to memory owned by the config
  * machinery, which could be invalidated if it is discarded and reloaded.
  */
diff --git a/environment.c b/environment.c
index 52e0c979ba..bb518c61cd 100644
--- a/environment.c
+++ b/environment.c
@@ -35,8 +35,8 @@ int repository_format_precious_objects;
 int repository_format_worktree_config;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
-const char *apply_default_whitespace;
-const char *apply_default_ignorewhitespace;
+char *apply_default_whitespace;
+char *apply_default_ignorewhitespace;
 const char *git_attributes_file;
 const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
-- 
2.28.0.605.g35fde94f44

