From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [WIP/RFC PATCH 1/2] Introduce GIT_INDEX_PREFIX
Date: Wed, 4 Jun 2008 23:28:25 +0700
Message-ID: <20080604162825.GB23975@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 18:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3vra-0001gL-4X
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 18:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbYFDQ2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 12:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYFDQ2d
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 12:28:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:6446 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbYFDQ2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 12:28:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so134198wfd.4
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=dau0ATXHtE0hPaW38dRdsXg+OU7UC4LsA4wO42ZGpO8=;
        b=PFfdKM/v8Db0NxUaqqETRkJXayyA50f/0iXmM8QuCgewa4+J6V32q1O4F6mwml6HhB
         6K8iRa5d4HaHbyD6hmDTwO+widd3sBMT1j6Pk6TnQdCUdnYNKyN11oF4O2OJmEugFJ+y
         N/KX3azX3fVajpGexyF2ZFKJvDTXXIAaANjfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=BN6sRmGxS4N18TTgxPoWoxrEVCpPqbWyXQFFWm8a6U2rzjHdAAU2sAxQ0S9pKGjmy3
         cBdEIgWdXfOx4MYwWkcrEaoHEXVTBtbaeIuIjmJMweyQtGI5C31BF6aHNfDFuNWP/T17
         cA6CBR6OaWtt9u1WtUUVOkQflHz7Gfq0hVfXE=
Received: by 10.142.164.10 with SMTP id m10mr49542wfe.117.1212596911667;
        Wed, 04 Jun 2008 09:28:31 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.6.88])
        by mx.google.com with ESMTPS id 30sm3386799wfd.1.2008.06.04.09.28.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 09:28:30 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  4 Jun 2008 23:28:25 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83794>

GIT_INDEX_PREFIX is used to limit write access to a specific directory.
Only "important" information is protected by index prefix (those will
be used to create tree objects)

When GIT_INDEX_PREFIX is set, any attempt to modify the index (refresh
it is okay though) will bail out. read-tree and merge, however, can
write to full index. For merge, no conflict is allowed outside index
prefix.
---
 builtin-merge-recursive.c |    4 ++-
 builtin-read-tree.c       |    5 +++
 builtin-rev-parse.c       |    5 +++
 builtin-update-index.c    |    3 ++
 cache.h                   |    2 +
 environment.c             |   12 ++++++
 read-cache.c              |   84 +++++++++++++++++++++++++++++++++++++++++++-
 unpack-trees.c            |    3 ++
 unpack-trees.h            |    3 +-
 9 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 362c290..94ca808 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -209,8 +209,10 @@ static int git_merge_trees(int index_only,
 	memset(&opts, 0, sizeof(opts));
 	if (index_only)
 		opts.index_only = 1;
-	else
+	else {
 		opts.update = 1;
+		opts.check_index_prefix = 1;
+	}
 	opts.merge = 1;
 	opts.head_idx = 2;
 	opts.fn = threeway_merge;
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 5a09e17..ea0a929 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -242,6 +242,11 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			opts.head_idx = 1;
 	}
 
+	if (get_index_prefix()) {
+		read_cache();
+		opts.check_index_prefix = 1;
+	}
+
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
 		parse_tree(tree);
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a7860ed..1888208 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -499,6 +499,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					puts(prefix);
 				continue;
 			}
+			if (!strcmp(arg, "--show-index-prefix")) {
+				if (get_index_prefix())
+					puts(get_index_prefix());
+				continue;
+			}
 			if (!strcmp(arg, "--show-cdup")) {
 				const char *pfx = prefix;
 				if (!is_inside_work_tree()) {
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 9e0d7ab..71c83ec 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -242,6 +242,9 @@ static void chmod_path(int flip, const char *path)
 	struct cache_entry *ce;
 	unsigned int mode;
 
+	if (get_index_prefix() && prefixcmp(path, get_index_prefix()))
+		die("%s: cannot update index outside %s", path, get_index_prefix());
+
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		goto fail;
diff --git a/cache.h b/cache.h
index eab1a17..9f5a613 100644
--- a/cache.h
+++ b/cache.h
@@ -300,6 +300,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
+#define INDEX_PREFIX_ENVIRONMENT "GIT_INDEX_PREFIX"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
@@ -318,6 +319,7 @@ extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile_gently(const char *path);
 extern void set_git_work_tree(const char *tree);
+extern const char *get_index_prefix(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/environment.c b/environment.c
index 73feb2d..a8edaf5 100644
--- a/environment.c
+++ b/environment.c
@@ -46,6 +46,8 @@ enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 char *git_work_tree_cfg;
 static char *work_tree;
 
+static const char *index_prefix;
+
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
 
@@ -71,6 +73,9 @@ static void setup_git_env(void)
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file = xstrdup(git_path("info/grafts"));
+	index_prefix = getenv(INDEX_PREFIX_ENVIRONMENT);
+	if (index_prefix && (!*index_prefix || index_prefix[strlen(index_prefix)-1] != '/'))
+		die("GIT_INDEX_PREFIX must end with a slash");
 }
 
 int is_bare_repository(void)
@@ -122,6 +127,13 @@ const char *get_git_work_tree(void)
 	return work_tree;
 }
 
+const char *get_index_prefix()
+{
+	if (!git_dir)
+		setup_git_env();
+	return index_prefix;
+}
+
 char *get_object_directory(void)
 {
 	if (!git_object_dir)
diff --git a/read-cache.c b/read-cache.c
index ac9a8e7..4f8d44b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -23,6 +23,11 @@
 
 struct index_state the_index;
 
+static int outside_index_prefix(const struct index_state *istate, const char *ce_name)
+{
+	return istate == &the_index && get_index_prefix() && prefixcmp(ce_name, get_index_prefix());
+}
+
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
 	istate->cache[nr] = ce;
@@ -380,6 +385,8 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
 
+	if (outside_index_prefix(istate, ce->name))
+		die("%s: cannot remove from index outside %s", ce->name, get_index_prefix());
 	remove_name_hash(ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
@@ -394,6 +401,10 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 int remove_file_from_index(struct index_state *istate, const char *path)
 {
 	int pos = index_name_pos(istate, path, strlen(path));
+
+	if (outside_index_prefix(istate, path))
+		die("%s: cannot remove from index from outside %s", path, get_index_prefix());
+
 	if (pos < 0)
 		pos = -pos-1;
 	cache_tree_invalidate_path(istate->cache_tree, path);
@@ -793,21 +804,35 @@ static int check_file_directory_conflict(struct index_state *istate,
 	return retval + has_dir_name(istate, ce, pos, ok_to_replace);
 }
 
+static int ce_compare(const struct cache_entry *ce1, const struct cache_entry *ce2)
+{
+	return ce1->ce_mode == ce2->ce_mode &&
+		((ce1->ce_flags ^ ce2->ce_flags) & ~(CE_HASHED | CE_UPDATE)) == 0 &&
+		!memcmp(ce1->sha1, ce2->sha1, 20) &&
+		!strcmp(ce1->name, ce2->name);
+}
+
 static int add_index_entry_with_check(struct index_state *istate, struct cache_entry *ce, int option)
 {
 	int pos;
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
+	int is_outside_index_prefix = outside_index_prefix(istate, ce->name);
 
 	cache_tree_invalidate_path(istate->cache_tree, ce->name);
 	pos = index_name_pos(istate, ce->name, ce->ce_flags);
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
+		if (is_outside_index_prefix && !ce_compare(istate->cache[pos], ce))
+			die("%s: cannot add to index outside %s", ce->name, get_index_prefix());
 		replace_index_entry(istate, pos, ce);
 		return 0;
 	}
+
+	if (is_outside_index_prefix)
+		die("%s: cannot add to index outside %s", ce->name, get_index_prefix());
 	pos = -pos-1;
 
 	/*
@@ -842,9 +867,11 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 {
 	int pos;
 
-	if (option & ADD_CACHE_JUST_APPEND)
+	if (option & ADD_CACHE_JUST_APPEND) {
+		if (outside_index_prefix(istate, ce->name))
+			die("%s: cannot add to index outside %s", ce->name, get_index_prefix());
 		pos = istate->cache_nr;
-	else {
+	} else {
 		int ret;
 		ret = add_index_entry_with_check(istate, ce, option);
 		if (ret <= 0)
@@ -1385,3 +1412,56 @@ int write_index(const struct index_state *istate, int newfd)
 	}
 	return ce_flush(&c, newfd);
 }
+
+int check_index_prefix(const struct index_state *index, int is_merge)
+{
+	unsigned start,end1,end2,i;
+	struct cache_entry **cache1, **cache2;
+	const char *index_prefix = get_index_prefix();
+
+	if (!index_prefix)
+		return 0;
+
+	/* Check for unmerged entries first */
+	for (i = 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce = index->cache[i];
+		if (ce_stage(ce) && prefixcmp(ce->name, index_prefix))
+			return 1;
+	}
+
+	if (is_merge)
+		return 0;
+
+	/* not a merge, no change is allowed outside index prefix */
+
+	cache1 = the_index.cache;
+	cache2 = index->cache;
+	start = 0;
+	end1 = the_index.cache_nr ? the_index.cache_nr - 1 : 0;
+	end2 = index->cache_nr ? index->cache_nr - 1 : 0;
+	while (start < end1 && start < end2 &&
+		ce_compare(cache1[start], cache2[start]))
+		start ++;
+
+	while (end1 > start && end2 > start &&
+		ce_compare(cache1[end1], cache2[end2])) {
+		end1 --;
+		end2 --;
+	}
+
+	/*
+	 * everything in start..end1 and start..end2 must
+	 * be prefixed by get_index_prefix()
+	 */
+	if (start < end1 &&
+		(prefixcmp(cache1[start]->name, index_prefix) ||
+		prefixcmp(cache1[end1]->name, index_prefix)))
+		return 1;
+
+	if (start < end2 &&
+		(prefixcmp(cache2[start]->name, index_prefix) ||
+		prefixcmp(cache2[end2]->name, index_prefix)))
+		return 1;
+
+	return 0;
+}
diff --git a/unpack-trees.c b/unpack-trees.c
index 0de5a31..2ef4827 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -403,6 +403,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
 
+	if (o->check_index_prefix && check_index_prefix(&o->result, o->merge && !o->prefix))
+		return unpack_failed(o, "Merge outside index prefix");
+
 	o->src_index = NULL;
 	if (check_updates(o))
 		return -1;
diff --git a/unpack-trees.h b/unpack-trees.h
index 94e5672..a1b46f9 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -26,7 +26,8 @@ struct unpack_trees_options {
 		     verbose_update:1,
 		     aggressive:1,
 		     skip_unmerged:1,
-		     gently:1;
+		     gently:1,
+		     check_index_prefix:1;
 	const char *prefix;
 	int pos;
 	struct dir_struct *dir;
-- 
1.5.5.GIT
