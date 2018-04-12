Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996B31F404
	for <e@80x24.org>; Thu, 12 Apr 2018 22:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeDLW5T (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 18:57:19 -0400
Received: from ao2.it ([92.243.12.208]:51122 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753064AbeDLW5S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 18:57:18 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6kZd-0008Uu-3n; Fri, 13 Apr 2018 00:20:09 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6kac-0001VA-Ug; Fri, 13 Apr 2018 00:21:10 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 01/10] submodule: add 'core.submodulesFile' to override the '.gitmodules' path
Date:   Fri, 13 Apr 2018 00:20:38 +0200
Message-Id: <20180412222047.5716-2-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412222047.5716-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When multiple repositories with detached work-trees take turns using the
same directory as their work-tree, and more than one of them want to use
submodules, there will be conflicts about the '.gitmodules' file.

git hardcodes this path so it's not possible to override its location on
a per-repository basis to allow such repositories to coexists
peacefully.

Make the path of the "gitmodules file" customizable exposing
a 'core.submodulesFile' configuration setting.

The default value will still be '.gitmodules' when 'core.submodulesFile'
is not set.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 cache.h            |  1 +
 config.c           |  6 +++++-
 environment.c      |  1 +
 git-submodule.sh   | 14 +++++++++-----
 submodule-config.c |  4 ++--
 submodule.c        | 20 ++++++++++----------
 unpack-trees.c     |  2 +-
 7 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index bbaf5c349..f4dd8bc00 100644
--- a/cache.h
+++ b/cache.h
@@ -1774,6 +1774,7 @@ extern void prepare_pager_args(struct child_process *, const char *pager);
 extern const char *editor_program;
 extern const char *askpass_program;
 extern const char *excludes_file;
+extern const char *submodules_file;
 
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
diff --git a/config.c b/config.c
index c698988f5..6ffb1d501 100644
--- a/config.c
+++ b/config.c
@@ -1199,6 +1199,10 @@ static int git_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.excludesfile"))
 		return git_config_pathname(&excludes_file, var, value);
 
+	if (!strcmp(var, "core.submodulesfile")) {
+		return git_config_pathname(&submodules_file, var, value);
+	}
+
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -2084,7 +2088,7 @@ int git_config_get_pathname(const char *key, const char **dest)
 void config_from_gitmodules(config_fn_t fn, void *data)
 {
 	if (the_repository->worktree) {
-		char *file = repo_worktree_path(the_repository, GITMODULES_FILE);
+		char *file = repo_worktree_path(the_repository, submodules_file);
 		git_config_from_file(fn, file, data);
 		free(file);
 	}
diff --git a/environment.c b/environment.c
index 39b3d906c..69cae6d68 100644
--- a/environment.c
+++ b/environment.c
@@ -49,6 +49,7 @@ int pager_use_color = 1;
 const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
+const char *submodules_file = GITMODULES_FILE;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
diff --git a/git-submodule.sh b/git-submodule.sh
index 24914963c..610fd0dc5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -71,7 +71,9 @@ get_submodule_config () {
 	value=$(git config submodule."$name"."$option")
 	if test -z "$value"
 	then
-		value=$(git config -f .gitmodules submodule."$name"."$option")
+		gitmodules_file=$(git config core.submodulesfile)
+		: ${gitmodules_file:=.gitmodules}
+		value=$(git config -f "$gitmodules_file" submodule."$name"."$option")
 	fi
 	printf '%s' "${value:-$default}"
 }
@@ -271,13 +273,15 @@ or you are unsure what this means choose another name with the '--name' option."
 	git add --no-warn-embedded-repo $force "$sm_path" ||
 	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
 
-	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
-	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
+	gitmodules_file=$(git config core.submodulesfile)
+	: ${gitmodules_file:=.gitmodules}
+	git config -f "$gitmodules_file" submodule."$sm_name".path "$sm_path" &&
+	git config -f "$gitmodules_file" submodule."$sm_name".url "$repo" &&
 	if test -n "$branch"
 	then
-		git config -f .gitmodules submodule."$sm_name".branch "$branch"
+		git config -f "$gitmodules_file" submodule."$sm_name".branch "$branch"
 	fi &&
-	git add --force .gitmodules ||
+	git add --force "$gitmodules_file" ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 
 	# NEEDSWORK: In a multi-working-tree world, this needs to be
diff --git a/submodule-config.c b/submodule-config.c
index 3f2075764..8a3396ade 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -468,7 +468,7 @@ static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
 		return 1;
 	}
 
-	strbuf_addf(rev, "%s:.gitmodules", oid_to_hex(treeish_name));
+	strbuf_addf(rev, "%s:%s", oid_to_hex(treeish_name), submodules_file);
 	if (get_oid(rev->buf, gitmodules_oid) >= 0)
 		ret = 1;
 
@@ -583,7 +583,7 @@ void repo_read_gitmodules(struct repository *repo)
 		if (repo_read_index(repo) < 0)
 			return;
 
-		gitmodules = repo_worktree_path(repo, GITMODULES_FILE);
+		gitmodules = repo_worktree_path(repo, submodules_file);
 
 		if (!is_gitmodules_unmerged(repo->index))
 			git_config_from_file(gitmodules_cb, gitmodules, repo);
diff --git a/submodule.c b/submodule.c
index 9a50168b2..2afbdb644 100644
--- a/submodule.c
+++ b/submodule.c
@@ -36,13 +36,13 @@ static struct oid_array ref_tips_after_fetch;
  */
 int is_gitmodules_unmerged(const struct index_state *istate)
 {
-	int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
+	int pos = index_name_pos(istate, submodules_file, strlen(submodules_file));
 	if (pos < 0) { /* .gitmodules not found or isn't merged */
 		pos = -1 - pos;
 		if (istate->cache_nr > pos) {  /* there is a .gitmodules */
 			const struct cache_entry *ce = istate->cache[pos];
-			if (ce_namelen(ce) == strlen(GITMODULES_FILE) &&
-			    !strcmp(ce->name, GITMODULES_FILE))
+			if (ce_namelen(ce) == strlen(submodules_file) &&
+			    !strcmp(ce->name, submodules_file))
 				return 1;
 		}
 	}
@@ -60,11 +60,11 @@ int is_gitmodules_unmerged(const struct index_state *istate)
  */
 int is_staging_gitmodules_ok(struct index_state *istate)
 {
-	int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
+	int pos = index_name_pos(istate, submodules_file, strlen(submodules_file));
 
 	if ((pos >= 0) && (pos < istate->cache_nr)) {
 		struct stat st;
-		if (lstat(GITMODULES_FILE, &st) == 0 &&
+		if (lstat(submodules_file, &st) == 0 &&
 		    ie_match_stat(istate, istate->cache[pos], &st,
 				  CE_MATCH_IGNORE_FSMONITOR) & DATA_CHANGED)
 			return 0;
@@ -90,7 +90,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	struct strbuf entry = STRBUF_INIT;
 	const struct submodule *submodule;
 
-	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
+	if (!file_exists(submodules_file)) /* Do nothing without .gitmodules */
 		return -1;
 
 	if (is_gitmodules_unmerged(&the_index))
@@ -104,7 +104,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	strbuf_addstr(&entry, "submodule.");
 	strbuf_addstr(&entry, submodule->name);
 	strbuf_addstr(&entry, ".path");
-	if (git_config_set_in_file_gently(GITMODULES_FILE, entry.buf, newpath) < 0) {
+	if (git_config_set_in_file_gently(submodules_file, entry.buf, newpath) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not update .gitmodules entry %s"), entry.buf);
 		strbuf_release(&entry);
@@ -124,7 +124,7 @@ int remove_path_from_gitmodules(const char *path)
 	struct strbuf sect = STRBUF_INIT;
 	const struct submodule *submodule;
 
-	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
+	if (!file_exists(submodules_file)) /* Do nothing without .gitmodules */
 		return -1;
 
 	if (is_gitmodules_unmerged(&the_index))
@@ -137,7 +137,7 @@ int remove_path_from_gitmodules(const char *path)
 	}
 	strbuf_addstr(&sect, "submodule.");
 	strbuf_addstr(&sect, submodule->name);
-	if (git_config_rename_section_in_file(GITMODULES_FILE, sect.buf, NULL) < 0) {
+	if (git_config_rename_section_in_file(submodules_file, sect.buf, NULL) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not remove .gitmodules entry for %s"), path);
 		strbuf_release(&sect);
@@ -149,7 +149,7 @@ int remove_path_from_gitmodules(const char *path)
 
 void stage_updated_gitmodules(struct index_state *istate)
 {
-	if (add_file_to_index(istate, GITMODULES_FILE, 0))
+	if (add_file_to_index(istate, submodules_file, 0))
 		die(_("staging updated .gitmodules failed"));
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index e73745051..b4d834ef4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -283,7 +283,7 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 static void load_gitmodules_file(struct index_state *index,
 				 struct checkout *state)
 {
-	int pos = index_name_pos(index, GITMODULES_FILE, strlen(GITMODULES_FILE));
+	int pos = index_name_pos(index, submodules_file, strlen(submodules_file));
 
 	if (pos >= 0) {
 		struct cache_entry *ce = index->cache[pos];
-- 
2.17.0

