From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH 3/7] Import dump_node to dump what changed and cleanup whitespace
Date: Wed, 23 Jun 2010 18:22:16 +0200
Message-ID: <1277310140-16891-4-git-send-email-artagnon@gmail.com>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 18:21:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORShZ-000170-T8
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 18:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab0FWQVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 12:21:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60555 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab0FWQVM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 12:21:12 -0400
Received: by wyi11 with SMTP id 11so931197wyi.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 09:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oL5BaiqqSARnmxB5zndm6O5/BN7CptRX0YzSUjwnay0=;
        b=IsnPfISAexuXrjCudNMfIibhEEG+/taoOdqeGiTvJ5U4Jtjnrd9VSWiY6wSNVBJ097
         AwzvuK4nc61osN73Jg1HBrsCwpoW2hJW7o3FKcUFThBaeomYRHU3lSiE3xZSFlRqkv5Z
         FTaZRnFi2M5mf6rFeX/0fcGqIFHPv6HMCbFvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=yG8Kt9/N6uRXnLKzzItlchvc4itjLfAtAEC/BnuEMZpdy6d/ME78k4sA4J/W1CcbEg
         /e8d46l/AAuIJ9f/7Z58/UpJwQSQ11W+bD+k6auEO8mS4Z4f4L3H4HGs0oGSO6yti2Da
         zJ/cHNBCYabh0WX9z6NRRl+oOEEAgCC6FSUtk=
Received: by 10.227.143.205 with SMTP id w13mr7831350wbu.162.1277310070500;
        Wed, 23 Jun 2010 09:21:10 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id t15sm62669306wbc.23.2010.06.23.09.21.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 09:21:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149513>

Import dump_node from dump.c after stripping it off filesystem backing
to dump which files/ directories were added or removed without
actually dumping the delta. Modify svnclient_ra to use just the dump
editor, and not the debug editor. Also cleanup whitespace to conform
to Git style. Add LICENSE file.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 LICENSE        |   14 +++
 dump_editor.c  |  344 ++++++++++++++++++++++++++++++++++++++------------------
 svnclient_ra.c |    6 +-
 3 files changed, 251 insertions(+), 113 deletions(-)
 create mode 100644 LICENSE

diff --git a/LICENSE b/LICENSE
new file mode 100644
index 0000000..c8f39ff
--- /dev/null
+++ b/LICENSE
@@ -0,0 +1,14 @@
+Licensed to the Apache Software Foundation (ASF) under one or more
+contributor license agreements.  See the NOTICE file distributed with
+this work for additional information regarding copyright ownership.
+The ASF licenses this file to you under the Apache License, Version
+2.0 (the "License"); you may not use this file except in compliance
+with the License.  You may obtain a copy of the License at
+
+http://www.apache.org/licenses/LICENSE-2.0
+
+Unless required by applicable law or agreed to in writing, software
+distributed under the License is distributed on an "AS IS" BASIS,
+WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
+implied.  See the License for the specific language governing
+permissions and limitations under the License.
diff --git a/dump_editor.c b/dump_editor.c
index f5353b0..ba0630f 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -1,3 +1,7 @@
+/* Licensed under Apache license.
+ * See LICENSE for details.
+ */
+
 #include "svn_pools.h"
 #include "svn_error.h"
 #include "svn_iter.h"
@@ -10,13 +14,8 @@
 #include "svn_props.h"
 
 #define ARE_VALID_COPY_ARGS(p,r) ((p) && SVN_IS_VALID_REVNUM(r))
-/*----------------------------------------------------------------------*/
-/** An editor which dumps node-data in 'dumpfile format' to a file. **/
-
-/* Look, mom!  No file batons! */
 
-struct edit_baton
-{
+struct edit_baton {
 	/* The stream to dump to: stdout */
 	svn_stream_t *stream;
 	
@@ -27,8 +26,7 @@ struct edit_baton
 	apr_size_t bufsize;
 };
 
-struct dir_baton
-{
+struct dir_baton {
 	struct edit_baton *edit_baton;
 	struct dir_baton *parent_dir_baton;
 
@@ -71,20 +69,19 @@ struct dir_baton
    or NULL if this is the top-level directory of the edit.  ADDED
    indicated if this directory is newly added in this revision.
    Perform all allocations in POOL.  */
-struct dir_baton *
-make_dir_baton(const char *path,
-               const char *cmp_path,
-               svn_revnum_t cmp_rev,
-               void *edit_baton,
-               void *parent_dir_baton,
-               svn_boolean_t added,
-               apr_pool_t *pool)
-{
+struct dir_baton *make_dir_baton(const char *path,
+                                 const char *cmp_path,
+                                 svn_revnum_t cmp_rev,
+                                 void *edit_baton,
+                                 void *parent_dir_baton,
+                                 svn_boolean_t added,
+                                 apr_pool_t *pool) {
 	struct edit_baton *eb = edit_baton;
 	struct dir_baton *pb = parent_dir_baton;
 	struct dir_baton *new_db = apr_pcalloc(pool, sizeof(*new_db));
 	const char *full_path;
 
+
 	/* A path relative to nothing?  I don't think so. */
 	SVN_ERR_ASSERT_NO_RETURN(!path || pb);
 
@@ -111,24 +108,170 @@ make_dir_baton(const char *path,
 	return new_db;
 }
 
+static svn_error_t *dump_node(struct edit_baton *eb,
+                              const char *path,    /* an absolute path. */
+                              svn_node_kind_t kind,
+                              enum svn_node_action action,
+                              svn_boolean_t is_copy,
+                              const char *cmp_path,
+                              svn_revnum_t cmp_rev,
+                              apr_pool_t *pool)
+{
+	apr_size_t len;
+	svn_boolean_t must_dump_text = TRUE, must_dump_props = TRUE;
+	const char *compare_path = path;
+	svn_revnum_t compare_rev = eb->current_rev - 1;
+
+	/* Write out metadata headers for this file node. */
+	SVN_ERR(svn_stream_printf(eb->stream, pool,
+	                          SVN_REPOS_DUMPFILE_NODE_PATH ": %s\n",
+	                          (*path == '/') ? path + 1 : path));
+	if (kind == svn_node_file)
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_KIND ": file\n"));
+	else if (kind == svn_node_dir)
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_KIND ": dir\n"));
+
+	/* Remove leading slashes from copyfrom paths. */
+	if (cmp_path)
+		cmp_path = ((*cmp_path == '/') ? cmp_path + 1 : cmp_path);
 
-svn_error_t *
-open_root(void *edit_baton,
-          svn_revnum_t base_revision,
-          apr_pool_t *pool,
-          void **root_baton)
+	/* Validate the comparison path/rev. */
+	if (ARE_VALID_COPY_ARGS(cmp_path, cmp_rev)) {
+		compare_path = cmp_path;
+		compare_rev = cmp_rev;
+	}
+
+	switch (action) {
+		/* Appropriately handle the four svn_node_action actions */
+
+	case svn_node_action_change:
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION
+		                          ": change\n"));
+
+		/* either the text or props changed, or possibly both. */
+		/* SVN_ERR(svn_props_changed(&must_dump_props, */
+		/*                           compare_path, path, pool)); */
+		if (kind == svn_node_file)
+			/* SVN_ERR(svn_contents_changed(&must_dump_text, */
+			/*                              compare_path, path, pool)); */
+		break;
+      
+	case svn_node_action_replace:
+		if (!is_copy) {
+			/* a simple delete+add, implied by a single 'replace' action. */
+			SVN_ERR(svn_stream_printf(eb->stream, pool,
+			                          SVN_REPOS_DUMPFILE_NODE_ACTION
+			                          ": replace\n"));
+
+			/* definitely need to dump all content for a replace. */
+			if (kind == svn_node_file)
+				must_dump_text = TRUE;
+			must_dump_props = TRUE;
+			break;
+		}
+		/* more complex:  delete original, then add-with-history.  */
+
+		/* the path & kind headers have already been printed;  just
+		   add a delete action, and end the current record.*/
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION
+		                          ": delete\n\n"));
+
+		/* recurse:  print an additional add-with-history record. */
+		SVN_ERR(dump_node(eb, path, kind, svn_node_action_add,
+		                  is_copy, compare_path, compare_rev, pool));
+
+		/* we can leave this routine quietly now, don't need to dump
+		   any content;  that was already done in the second record. */
+		must_dump_text = FALSE;
+		must_dump_props = FALSE;
+		break;
+
+	case svn_node_action_delete:
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION
+		                          ": delete\n"));
+
+		/* we can leave this routine quietly now, don't need to dump
+		   any content. */
+		must_dump_text = FALSE;
+		must_dump_props = FALSE;
+		break;
+
+	case svn_node_action_add:
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION ": add\n"));
+
+		if (!is_copy) {
+			/* Dump all contents for a simple 'add'. */
+			if (kind == svn_node_file)
+				must_dump_text = TRUE;
+			must_dump_props = TRUE;
+			break;
+		}
+
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_COPYFROM_REV
+		                          ": %ld\n"
+		                          SVN_REPOS_DUMPFILE_NODE_COPYFROM_PATH
+		                          ": %s\n",
+		                          cmp_rev, cmp_path));
+
+		/* Need to decide if the copied node had any extra textual or
+		   property mods as well.  */
+		/* SVN_ERR(svn_fs_props_changed(&must_dump_props, */
+		/*                              compare_path, path, pool)); */
+		/* if (kind == svn_node_file) */
+		/* { */
+		/* 	svn_checksum_t *checksum; */
+		/* 	const char *hex_digest; */
+		/* 	SVN_ERR(svn_fs_contents_changed(&must_dump_text, */
+		/* 	                                compare_root, compare_path, */
+		/* 	                                eb->fs_root, path, pool)); */
+
+		/* 	SVN_ERR(svn_fs_file_checksum(&checksum, svn_checksum_md5, */
+		/* 	                             compare_root, compare_path, */
+		/* 	                             TRUE, pool)); */
+		/* 	hex_digest = svn_checksum_to_cstring(checksum, pool); */
+		/* 	if (hex_digest) */
+		/* 		SVN_ERR(svn_stream_printf(eb->stream, pool, */
+		/* 		                          SVN_REPOS_DUMPFILE_TEXT_COPY_SOURCE_MD5 */
+		/* 		                          ": %s\n", hex_digest)); */
+
+		/* 	SVN_ERR(svn_fs_file_checksum(&checksum, svn_checksum_sha1, */
+		/* 	                             compare_root, compare_path, */
+		/* 	                             TRUE, pool)); */
+		/* 	hex_digest = svn_checksum_to_cstring(checksum, pool); */
+		/* 	if (hex_digest) */
+		/* 		SVN_ERR(svn_stream_printf(eb->stream, pool, */
+		/* 		                          SVN_REPOS_DUMPFILE_TEXT_COPY_SOURCE_SHA1 */
+		/* 		                          ": %s\n", hex_digest)); */
+		/* } */
+		break;
+	}
+	if (!must_dump_text && !must_dump_props) {
+		len = 2;
+		return svn_stream_write(eb->stream, "\n\n", &len); /* ### needed? */
+	}
+	return SVN_NO_ERROR;
+}
+svn_error_t *open_root(void *edit_baton,
+                       svn_revnum_t base_revision,
+                       apr_pool_t *pool,
+                       void **root_baton)
 {
 	*root_baton = make_dir_baton(NULL, NULL, SVN_INVALID_REVNUM,
 	                             edit_baton, NULL, FALSE, pool);
 	return SVN_NO_ERROR;
 }
 
-
-svn_error_t *
-delete_entry(const char *path,
-             svn_revnum_t revision,
-             void *parent_baton,
-             apr_pool_t *pool)
+svn_error_t *delete_entry(const char *path,
+                          svn_revnum_t revision,
+                          void *parent_baton,
+                          apr_pool_t *pool)
 {
 	struct dir_baton *pb = parent_baton;
 	const char *mypath = apr_pstrdup(pb->pool, path);
@@ -139,14 +282,12 @@ delete_entry(const char *path,
 	return SVN_NO_ERROR;
 }
 
-
-svn_error_t *
-add_directory(const char *path,
-              void *parent_baton,
-              const char *copyfrom_path,
-              svn_revnum_t copyfrom_rev,
-              apr_pool_t *pool,
-              void **child_baton)
+svn_error_t *add_directory(const char *path,
+                           void *parent_baton,
+                           const char *copyfrom_path,
+                           svn_revnum_t copyfrom_rev,
+                           apr_pool_t *pool,
+                           void **child_baton)
 {
 	struct dir_baton *pb = parent_baton;
 	struct edit_baton *eb = pb->edit_baton;
@@ -162,13 +303,13 @@ add_directory(const char *path,
 	is_copy = ARE_VALID_COPY_ARGS(copyfrom_path, copyfrom_rev);
 
 	/* Dump the node. */
-	/* SVN_ERR(dump_node(eb, path, */
-	/*                   svn_node_dir, */
-	/*                   val ? svn_node_action_replace : svn_node_action_add, */
-	/*                   is_copy, */
-	/*                   is_copy ? copyfrom_path : NULL, */
-	/*                   is_copy ? copyfrom_rev : SVN_INVALID_REVNUM, */
-	/*                   pool)); */
+	SVN_ERR(dump_node(eb, path,
+	                  svn_node_dir,
+	                  val ? svn_node_action_replace : svn_node_action_add,
+	                  is_copy,
+	                  is_copy ? copyfrom_path : NULL,
+	                  is_copy ? copyfrom_rev : SVN_INVALID_REVNUM,
+	                  pool));
 
 	if (val)
 		/* Delete the path, it's now been dumped. */
@@ -180,13 +321,11 @@ add_directory(const char *path,
 	return SVN_NO_ERROR;
 }
 
-
-svn_error_t *
-open_directory(const char *path,
-               void *parent_baton,
-               svn_revnum_t base_revision,
-               apr_pool_t *pool,
-               void **child_baton)
+svn_error_t *open_directory(const char *path,
+                            void *parent_baton,
+                            svn_revnum_t base_revision,
+                            apr_pool_t *pool,
+                            void **child_baton)
 {
 	struct dir_baton *pb = parent_baton;
 	struct edit_baton *eb = pb->edit_baton;
@@ -196,8 +335,7 @@ open_directory(const char *path,
 
 	/* If the parent directory has explicit comparison path and rev,
 	   record the same for this one. */
-	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev))
-	{
+	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
 		cmp_path = svn_path_join(pb->cmp_path,
 		                         svn_dirent_basename(path, pool), pool);
 		cmp_rev = pb->cmp_rev;
@@ -208,10 +346,8 @@ open_directory(const char *path,
 	return SVN_NO_ERROR;
 }
 
-
-svn_error_t *
-close_directory(void *dir_baton,
-                apr_pool_t *pool)
+svn_error_t *close_directory(void *dir_baton,
+                             apr_pool_t *pool)
 {
 	struct dir_baton *db = dir_baton;
 	struct edit_baton *eb = db->edit_baton;
@@ -220,8 +356,7 @@ close_directory(void *dir_baton,
 
 	for (hi = apr_hash_first(pool, db->deleted_entries);
 	     hi;
-	     hi = apr_hash_next(hi))
-	{
+	     hi = apr_hash_next(hi)) {
 		const void *key;
 		const char *path;
 		apr_hash_this(hi, &key, NULL, NULL);
@@ -232,23 +367,21 @@ close_directory(void *dir_baton,
 		/* By sending 'svn_node_unknown', the Node-kind: header simply won't
 		   be written out.  No big deal at all, really.  The loader
 		   shouldn't care.  */
-		/* SVN_ERR(dump_node(eb, path, */
-		/*                   svn_node_unknown, svn_node_action_delete, */
-		/*                   FALSE, NULL, SVN_INVALID_REVNUM, subpool)); */
+		SVN_ERR(dump_node(eb, path,
+		                  svn_node_unknown, svn_node_action_delete,
+		                  FALSE, NULL, SVN_INVALID_REVNUM, subpool));
 	}
 
 	svn_pool_destroy(subpool);
 	return SVN_NO_ERROR;
 }
 
-
-svn_error_t *
-add_file(const char *path,
-         void *parent_baton,
-         const char *copyfrom_path,
-         svn_revnum_t copyfrom_rev,
-         apr_pool_t *pool,
-         void **file_baton)
+svn_error_t *add_file(const char *path,
+                      void *parent_baton,
+                      const char *copyfrom_path,
+                      svn_revnum_t copyfrom_rev,
+                      apr_pool_t *pool,
+                      void **file_baton)
 {
 	struct dir_baton *pb = parent_baton;
 	struct edit_baton *eb = pb->edit_baton;
@@ -262,29 +395,29 @@ add_file(const char *path,
 	is_copy = ARE_VALID_COPY_ARGS(copyfrom_path, copyfrom_rev);
 
 	/* Dump the node. */
-	/* SVN_ERR(dump_node(eb, path, */
-	/*                   svn_node_file, */
-	/*                   val ? svn_node_action_replace : svn_node_action_add, */
-	/*                   is_copy, */
-	/*                   is_copy ? copyfrom_path : NULL, */
-	/*                   is_copy ? copyfrom_rev : SVN_INVALID_REVNUM, */
-	/*                   pool)); */
+	SVN_ERR(dump_node(eb, path,
+	                  svn_node_file,
+	                  val ? svn_node_action_replace : svn_node_action_add,
+	                  is_copy,
+	                  is_copy ? copyfrom_path : NULL,
+	                  is_copy ? copyfrom_rev : SVN_INVALID_REVNUM,
+	                  pool));
 
 	if (val)
 		/* delete the path, it's now been dumped. */
 		apr_hash_set(pb->deleted_entries, path, APR_HASH_KEY_STRING, NULL);
 
-	*file_baton = NULL;  /* muhahahaha */
+	/* TODO: Store the delta in file_baton */
+	*file_baton = NULL;
 	return SVN_NO_ERROR;
 }
 
 
-svn_error_t *
-open_file(const char *path,
-          void *parent_baton,
-          svn_revnum_t ancestor_revision,
-          apr_pool_t *pool,
-          void **file_baton)
+svn_error_t *open_file(const char *path,
+                       void *parent_baton,
+                       svn_revnum_t ancestor_revision,
+                       apr_pool_t *pool,
+                       void **file_baton)
 {
 	struct dir_baton *pb = parent_baton;
 	struct edit_baton *eb = pb->edit_baton;
@@ -293,26 +426,25 @@ open_file(const char *path,
 
 	/* If the parent directory has explicit comparison path and rev,
 	   record the same for this one. */
-	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev))
-	{
+	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
 		cmp_path = svn_path_join(pb->cmp_path,
 		                         svn_dirent_basename(path, pool), pool);
 		cmp_rev = pb->cmp_rev;
 	}
 
-	/* SVN_ERR(dump_node(eb, path, */
-	/*                   svn_node_file, svn_node_action_change, */
-	/*                   FALSE, cmp_path, cmp_rev, pool)); */
+	SVN_ERR(dump_node(eb, path,
+	                  svn_node_file, svn_node_action_change,
+	                  FALSE, cmp_path, cmp_rev, pool));
 
-	*file_baton = NULL;  /* muhahahaha again */
+	/* TODO: Store the delta in file_baton */
+	*file_baton = NULL;
 	return SVN_NO_ERROR;
 }
 
-svn_error_t *
-change_dir_prop(void *parent_baton,
-                const char *name,
-                const svn_string_t *value,
-                apr_pool_t *pool)
+svn_error_t *change_dir_prop(void *parent_baton,
+                             const char *name,
+                             const svn_string_t *value,
+                             apr_pool_t *pool)
 {
 	struct dir_baton *db = parent_baton;
 	struct edit_baton *eb = db->edit_baton;
@@ -320,35 +452,27 @@ change_dir_prop(void *parent_baton,
 	/* This function is what distinguishes between a directory that is
 	   opened to merely get somewhere, vs. one that is opened because it
 	   *actually* changed by itself.  */
-	if (! db->written_out)
-	{
-		/* SVN_ERR(dump_node(eb, db->path, */
-		/*                   svn_node_dir, svn_node_action_change, */
-		/*                   FALSE, db->cmp_path, db->cmp_rev, pool)); */
+	if (! db->written_out) {
+		SVN_ERR(dump_node(eb, db->path,
+		                  svn_node_dir, svn_node_action_change,
+		                  FALSE, db->cmp_path, db->cmp_rev, pool));
 		db->written_out = TRUE;
 	}
 	return SVN_NO_ERROR;
 }
 
-svn_error_t *
-get_dump_editor(const svn_delta_editor_t **editor,
-                void **edit_baton,
-                svn_revnum_t to_rev,
-                apr_pool_t *pool)
+svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
+                             void **edit_baton,
+                             svn_revnum_t to_rev,
+                             apr_pool_t *pool)
 {
-	/* Allocate an edit baton to be stored in every directory baton.
-	   Set it up for the directory baton we create here, which is the
-	   root baton. */
 	struct edit_baton *eb = apr_pcalloc(pool, sizeof(*eb));
 	svn_delta_editor_t *dump_editor = svn_delta_default_editor(pool);
 
-	/* Set up the edit baton. */
 	svn_stream_for_stdout(&(eb->stream), pool);
 	eb->bufsize = sizeof(eb->buffer);
 	eb->current_rev = to_rev;
 
-
-	/* Set up the editor. */
 	dump_editor->open_root = open_root;
 	dump_editor->delete_entry = delete_entry;
 	dump_editor->add_directory = add_directory;
diff --git a/svnclient_ra.c b/svnclient_ra.c
index 24d99cb..0b9e002 100644
--- a/svnclient_ra.c
+++ b/svnclient_ra.c
@@ -109,8 +109,8 @@ svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision
 	                                    dump_baton, pool));
 	
 	replay_baton_t *replay_baton = apr_palloc(pool, sizeof(replay_baton_t));
-	replay_baton->editor = debug_editor;
-	replay_baton->baton = debug_baton;
+	replay_baton->editor = dump_editor;
+	replay_baton->baton = dump_baton;
 	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
 	                            0, TRUE, replay_revstart, replay_revend,
 	                            replay_baton, pool));
@@ -125,7 +125,7 @@ void close_connection()
 int main()
 {
 	const char url[] = "http://svn.apache.org/repos/asf";
-	svn_revnum_t start_revision = 1, end_revision = 5;
+	svn_revnum_t start_revision = 1, end_revision = 50;
 	if (svn_cmdline_init ("svnclient_ra", stderr) != EXIT_SUCCESS)
 		return 1;
 	pool = svn_pool_create(NULL);
-- 
1.7.1
