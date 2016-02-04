From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 0/9] Expose submodule parallelism to the user
Date: Thu,  4 Feb 2016 14:09:27 -0800
Message-ID: <1454623776-3347-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 04 23:10:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRS6c-0007qL-6k
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbcBDWJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:09:47 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35217 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934316AbcBDWJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:09:44 -0500
Received: by mail-pf0-f171.google.com with SMTP id 65so56786916pfd.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cZAmZUnmSd+D84Ig0UEq0aYE5Co+BhTHZDZ982pHo6s=;
        b=d/+dTdByxCjKTvUPUuebatDc7YkRdTygsaqOBfrKkOQnJubDEydhj3I4aNMBJH/n4h
         FxGfQ5p+0ou5mf0soKumX/pE3hHB3VfiYZXCJES235S8xqkXnDIRQWXS48kgG4daHPzt
         PBTxLM06Tilqpca6Eo0DqWRe11BfDne9ImNRcYu6Egj5jmw5S8OwvdjWmFeSID9w2aNP
         ciek5UyvqoYNq0DmMaCKpU3xfDZlCDUUD78lLuhpFJkyQi+H4Kj/rTnYQ+30Hhe7o11c
         ooqGrRTLzQpL23g3sbfd7byIR/KjsFlqFPXwpu9jwQJsKELPKlgyNlUGdIhMJybzfole
         U8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cZAmZUnmSd+D84Ig0UEq0aYE5Co+BhTHZDZ982pHo6s=;
        b=UmtxH5aG4KDOjXk74d1sFn1GtUr7hfE2Ya6ab+20zrEksePmDPi8GCkOl8hWcvskF8
         Kt21eiPjAodZiLT+pxiIR37ifgbBm4j/pvXtcsqMsQKv5bIzOHV21mbBgJCNESGeaKaq
         3S0bSnUxU2wimNoWcLwW2XRaEpYAOsdhO13NFHAaHl6Ett0dIct5+X6dDngSBFJe2Ho6
         BOLrdettVIqF8WW01efzK0gA2mQaMk3tlOCAXqQqeWKEpcmoEjDfv9Yh0YZvdBSttF46
         /nSbLP2gybPXghv133u3/YVvOYVzSK1kzFfQ2MeJD7i1+1F/ThTNpqP/qa+pKa3Pil2K
         RZnw==
X-Gm-Message-State: AG10YOTTcJV7GE92RHKFQYapulSzXnffOkldnRx9Cm3VvwXJkTb42247jqrkk3y3RCzymzYe
X-Received: by 10.98.76.80 with SMTP id z77mr14741815pfa.121.1454623784121;
        Thu, 04 Feb 2016 14:09:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5194:ebf5:4051:c1fd])
        by smtp.gmail.com with ESMTPSA id xa9sm19303916pab.44.2016.02.04.14.09.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 14:09:43 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.gd102984.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285508>

This replaces sb/submodule-parallel-update.
(which is based on sb/submodule-parallel-fetch,
but this series also applies cleanly on master)

* using a "more" correct version of parsing the section title
* fixed the memleaks, free-after-use in
  "git submodule update: have a dedicated helper for cloning"
* reworded documentation.
* another additional patch snuck in, which makes code a bit more readable
  (0004-submodule-config-slightly-simplify-lookup_or_create_.patch)

Thanks,
Stefan

Interdiff to v7:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index eda3276..3b02732 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2647,11 +2647,10 @@ submodule.<name>.ignore::
 	affected by this setting.
 
 submodule.fetchJobs::
-	This is used to determine how many submodules will be
-	fetched/cloned at the same time. Specifying a positive integer
-	allows up to that number of submodules being fetched in parallel.
-	This is used in fetch and clone operations only. A value of 0 will
-	give some reasonable configuration. It defaults to 1.
+	Specifies how many submodules are fetched/cloned at the same time.
+	A positive integer allows up to that number of submodules fetched
+	in parallel. A value of 0 will give some reasonable default.
+	If unset, it defaults to 1.
 
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8002187..7e01b85 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -312,33 +312,31 @@ static int update_clone_get_next_task(struct child_process *cp,
 
 	for (; pp->count < pp->list.nr; pp->count++) {
 		const struct submodule *sub = NULL;
-		const char *displaypath = NULL;
 		const struct cache_entry *ce = pp->list.entries[pp->count];
+		struct strbuf displaypath_sb = STRBUF_INIT;
 		struct strbuf sb = STRBUF_INIT;
+		const char *displaypath = NULL;
 		const char *update_module = NULL;
 		char *url = NULL;
 		int needs_cloning = 0;
 
 		if (ce_stage(ce)) {
 			if (pp->recursive_prefix)
-				strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
+				strbuf_addf(err,
+					"Skipping unmerged submodule %s/%s\n",
 					pp->recursive_prefix, ce->name);
 			else
-				strbuf_addf(err, "Skipping unmerged submodule %s\n",
+				strbuf_addf(err,
+					"Skipping unmerged submodule %s\n",
 					ce->name);
-			continue;
+			goto cleanup_and_continue;
 		}
 
 		sub = submodule_from_path(null_sha1, ce->name);
-		if (!sub) {
-			strbuf_addf(err, "BUG: internal error managing submodules. "
-				    "The cache could not locate '%s'", ce->name);
-			pp->print_unmatched = 1;
-			continue;
-		}
 
 		if (pp->recursive_prefix)
-			displaypath = relative_path(pp->recursive_prefix, ce->name, &sb);
+			displaypath = relative_path(pp->recursive_prefix,
+						    ce->name, &displaypath_sb);
 		else
 			displaypath = ce->name;
 
@@ -349,14 +347,15 @@ static int update_clone_get_next_task(struct child_process *cp,
 		if (!update_module)
 			update_module = "checkout";
 		if (!strcmp(update_module, "none")) {
-			strbuf_addf(err, "Skipping submodule '%s'\n", displaypath);
-			continue;
+			strbuf_addf(err, "Skipping submodule '%s'\n",
+				    displaypath);
+			goto cleanup_and_continue;
 		}
 
 		/*
 		 * Looking up the url in .git/config.
-		 * We must not fall back to .gitmodules as we only want to process
-		 * configured submodules.
+		 * We must not fall back to .gitmodules as we only want
+		 * to process configured submodules.
 		 */
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.url", sub->name);
@@ -367,9 +366,11 @@ static int update_clone_get_next_task(struct child_process *cp,
 			 * path have been specified
 			 */
 			if (pp->pathspec.nr)
-				strbuf_addf(err, _("Submodule path '%s' not initialized\n"
-					"Maybe you want to use 'update --init'?"), displaypath);
-			continue;
+				strbuf_addf(err,
+					    _("Submodule path '%s' not initialized\n"
+					    "Maybe you want to use 'update --init'?"),
+					    displaypath);
+			goto cleanup_and_continue;
 		}
 
 		strbuf_reset(&sb);
@@ -383,13 +384,19 @@ static int update_clone_get_next_task(struct child_process *cp,
 		string_list_append(&pp->projectlines, sb.buf);
 
 		if (needs_cloning) {
-			fill_clone_command(cp, pp->quiet, pp->prefix, ce->name,
-					   sub->name, url, pp->reference, pp->depth);
+			fill_clone_command(cp, pp->quiet, pp->prefix,
+					   ce->name, sub->name, strdup(url),
+					   pp->reference, pp->depth);
 			pp->count++;
-			free(url);
+		}
+
+cleanup_and_continue:
+		free(url);
+		strbuf_reset(&displaypath_sb);
+		strbuf_reset(&sb);
+
+		if (needs_cloning)
 			return 1;
-		} else
-			free(url);
 	}
 	return 0;
 }
diff --git a/submodule-config.c b/submodule-config.c
index a32259e..339b59d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -32,7 +32,7 @@ enum lookup_type {
 
 static struct submodule_cache cache;
 static int is_cache_init;
-static int parallel_jobs = -1;
+static unsigned long parallel_jobs = -1;
 
 static int config_path_cmp(const struct submodule_entry *a,
 			   const struct submodule_entry *b,
@@ -163,22 +163,17 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
 }
 
 static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
-						  const unsigned char *gitmodules_sha1,
-						  const char *name_ptr, int name_len)
+		const unsigned char *gitmodules_sha1, const char *name)
 {
 	struct submodule *submodule;
-	struct strbuf name_buf = STRBUF_INIT;
-	char *name = xmemdupz(name_ptr, name_len);
 
 	submodule = cache_lookup_name(cache, gitmodules_sha1, name);
 	if (submodule)
-		goto out;
+		return submodule;
 
 	submodule = xmalloc(sizeof(*submodule));
 
-	strbuf_addstr(&name_buf, name);
-	submodule->name = strbuf_detach(&name_buf, NULL);
-
+	submodule->name = xstrdup(name);
 	submodule->path = NULL;
 	submodule->url = NULL;
 	submodule->update = NULL;
@@ -188,8 +183,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
 	cache_add(cache, submodule);
-out:
-	free(name);
+
 	return submodule;
 }
 
@@ -241,18 +235,16 @@ static int parse_generic_submodule_config(const char *key,
 					  struct parse_config_parameter *me)
 {
 	if (!strcmp(key, "fetchjobs")) {
-		parallel_jobs = strtol(value, NULL, 10);
-		if (parallel_jobs < 0) {
-			warning("submodule.fetchJobs not allowed to be negative.");
+		if (!git_parse_ulong(value, &parallel_jobs)) {
+			warning(_("Error parsing submodule.fetchJobs; Defaulting to 1."));
 			parallel_jobs = 1;
-			return 1;
 		}
 	}
 
 	return 0;
 }
 
-static int parse_specific_submodule_config(const char *subsection, int subsection_len,
+static int parse_specific_submodule_config(const char *subsection,
 					   const char *key,
 					   const char *var,
 					   const char *value,
@@ -262,7 +254,7 @@ static int parse_specific_submodule_config(const char *subsection, int subsectio
 	struct submodule *submodule;
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
-					     subsection, subsection_len);
+					     subsection);
 
 	if (!strcmp(key, "path")) {
 		if (!value)
@@ -332,19 +324,22 @@ static int parse_specific_submodule_config(const char *subsection, int subsectio
 static int parse_config(const char *var, const char *value, void *data)
 {
 	struct parse_config_parameter *me = data;
-	int subsection_len;
+	int subsection_len, ret;
 	const char *subsection, *key;
+	char *sub;
 
 	if (parse_config_key(var, "submodule", &subsection,
 			     &subsection_len, &key) < 0)
 		return 0;
 
-	if (!subsection_len)
+	if (!subsection)
 		return parse_generic_submodule_config(key, var, value, me);
-	else
-		return parse_specific_submodule_config(subsection,
-						       subsection_len, key,
-						       var, value, me);
+
+	sub = xmemdupz(subsection, subsection_len);
+	ret = parse_specific_submodule_config(sub, key,
+					      var, value, me);
+	free(sub);
+	return ret;
 }
 
 static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
@@ -493,7 +488,7 @@ void submodule_free(void)
 	is_cache_init = 0;
 }
 
-int config_parallel_submodules(void)
+unsigned long config_parallel_submodules(void)
 {
 	return parallel_jobs;
 }
diff --git a/submodule-config.h b/submodule-config.h
index d9bbf9a..bab1e8d 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -27,6 +27,6 @@ const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
 void submodule_free(void);
 
-int config_parallel_submodules(void);
+unsigned long config_parallel_submodules(void);
 
 #endif /* SUBMODULE_CONFIG_H */


Stefan Beller (9):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  submodule-config: remove name_and_item_from_var
  submodule-config: slightly simplify lookup_or_create_by_name
  submodule-config: introduce parse_generic_submodule_config
  fetching submodules: respect `submodule.fetchJobs` config option
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   6 +
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 +++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 246 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 submodule-config.c              | 104 ++++++++++-------
 submodule-config.h              |   3 +
 submodule.c                     |   5 +
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 13 files changed, 414 insertions(+), 83 deletions(-)

-- 
2.7.0.rc0.41.gd102984.dirty
