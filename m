From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] Add svnrdump
Date: Fri, 9 Jul 2010 16:29:10 +0200
Message-ID: <20100709142910.GB20383@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "dev@subversion.apache.org" <dev@subversion.apache.org>
X-From: git-owner@vger.kernel.org Fri Jul 09 16:27:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXEYF-0006uE-Jg
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 16:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab0GIO1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 10:27:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57114 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756874Ab0GIO1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 10:27:32 -0400
Received: by ewy23 with SMTP id 23so490119ewy.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=6jlE8SUPWW+asaGHPkyQpVVfkI/ILdRT3rc6wtF6Fcc=;
        b=RA3eLVWyEeKVJ80wC44AjWZG5wCCB2zJdXJmQJECVbT91zOddWTFpk03IY5jn6XCqv
         L6EkESIaSLh9B1lQJskKbMiWWR67gKl80nkBR1Wufx5JtOqpgK5bY5WOjfJje33xG7w7
         RkVAUvyJK8d32B2uxCRoC1HQtYjJ3TrSAVvvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=lSiYTvU9gzhVS0tT9Bj8sNkUI5nccrBF3VNlZYgq8xZUcmqSirhVdZzD/aWG8fI+Db
         lTwuvI1dxnXjeTbWT35PHKHdAp9mWvyCKuw0S55YGYLpv7IOhxjRqmUT/s4+pWMNm5D4
         DyXmWESHHwypSJpjMUEMOH9ebJMPHZnnRsTPY=
Received: by 10.213.15.202 with SMTP id l10mr7888683eba.58.1278685650144;
        Fri, 09 Jul 2010 07:27:30 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm7962006eei.19.2010.07.09.07.27.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 07:27:27 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150671>

Hi,

Along with the changes suggested by Bert and Daniel, this new version
includes a few small bugfixes and feature additions contributed by
David and Will, among others. Unfortunately, a diff of the changes
made is not available due to whitespace/ style conversion issues:
please check the recent commits on my GitHub repository for a summary
of these changes: ra-svn branch of
http://github.com/artagnon/svn-dump-fast-export

Thanks.

-- Ram

------------------------8<---------------->8-----------------------------------
Index: svnrdump/dump_editor.c
===================================================================
--- svnrdump/dump_editor.c	(revision 0)
+++ svnrdump/dump_editor.c	(working copy)
@@ -0,0 +1,690 @@
+/*
+ * ====================================================================
+ *    Licensed to the Apache Software Foundation (ASF) under one
+ *    or more contributor license agreements.  See the NOTICE file
+ *    distributed with this work for additional information
+ *    regarding copyright ownership.  The ASF licenses this file
+ *    to you under the Apache License, Version 2.0 (the
+ *    "License"); you may not use this file except in compliance
+ *    with the License.  You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ *    Unless required by applicable law or agreed to in writing,
+ *    software distributed under the License is distributed on an
+ *    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
+ *    KIND, either express or implied.  See the License for the
+ *    specific language governing permissions and limitations
+ *    under the License.
+ * ====================================================================
+ */
+
+#include "svn_pools.h"
+#include "svn_repos.h"
+#include "svn_path.h"
+#include "svn_props.h"
+#include "svn_dirent_uri.h"
+
+#include "svnrdump.h"
+#include "dump_editor.h"
+
+#define ARE_VALID_COPY_ARGS(p,r) ((p) && SVN_IS_VALID_REVNUM(r))
+
+/* Make a directory baton to represent the directory was path
+   (relative to EDIT_BATON's path) is PATH.
+
+   CMP_PATH/CMP_REV are the path/revision against which this directory
+   should be compared for changes.  If either is omitted (NULL for the
+   path, SVN_INVALID_REVNUM for the rev), just compare this directory
+   PATH against itself in the previous revision.
+
+   PARENT_DIR_BATON is the directory baton of this directory's parent,
+   or NULL if this is the top-level directory of the edit.  ADDED
+   indicated if this directory is newly added in this revision.
+   Perform all allocations in POOL.  */
+static struct dir_baton *
+make_dir_baton(const char *path,
+               const char *cmp_path,
+               svn_revnum_t cmp_rev,
+               void *edit_baton,
+               void *parent_dir_baton,
+               svn_boolean_t added,
+               apr_pool_t *pool)
+{
+  struct dump_edit_baton *eb = edit_baton;
+  struct dir_baton *pb = parent_dir_baton;
+  struct dir_baton *new_db = apr_pcalloc(pool, sizeof(*new_db));
+  const char *full_path;
+  apr_array_header_t *compose_path = apr_array_make(pool, 2,
+						    sizeof(const char *));
+
+  /* A path relative to nothing?  I don't think so. */
+  SVN_ERR_ASSERT_NO_RETURN(!path || pb);
+
+  /* Construct the full path of this node. */
+  if (pb) {
+    APR_ARRAY_PUSH(compose_path, const char *) = "/";
+    APR_ARRAY_PUSH(compose_path, const char *) = path;
+    full_path = svn_path_compose(compose_path, pool);
+  }
+  else
+    full_path = apr_pstrdup(pool, "/");
+
+  /* Remove leading slashes from copyfrom paths. */
+  if (cmp_path)
+    cmp_path = ((*cmp_path == '/') ? cmp_path + 1 : cmp_path);
+
+  new_db->eb = eb;
+  new_db->parent_dir_baton = pb;
+  new_db->path = full_path;
+  new_db->cmp_path = cmp_path ? apr_pstrdup(pool, cmp_path) : NULL;
+  new_db->cmp_rev = cmp_rev;
+  new_db->added = added;
+  new_db->written_out = FALSE;
+  new_db->deleted_entries = apr_hash_make(pool);
+  new_db->pool = pool;
+
+  return new_db;
+}
+/*
+ * Write out a node record for PATH of type KIND under EB->FS_ROOT.
+ * ACTION describes what is happening to the node (see enum svn_node_action).
+ * Write record to writable EB->STREAM, using EB->BUFFER to write in chunks.
+ *
+ * If the node was itself copied, IS_COPY is TRUE and the
+ * path/revision of the copy source are in CMP_PATH/CMP_REV.  If
+ * IS_COPY is FALSE, yet CMP_PATH/CMP_REV are valid, this node is part
+ * of a copied subtree.
+ */
+static svn_error_t *
+dump_node(struct dump_edit_baton *eb,
+          const char *path,    /* an absolute path. */
+          svn_node_kind_t kind,
+          enum svn_node_action action,
+          const char *cmp_path,
+          svn_revnum_t cmp_rev,
+          apr_pool_t *pool)
+{
+  /* Write out metadata headers for this file node. */
+  SVN_ERR(svn_stream_printf(eb->stream, pool,
+          SVN_REPOS_DUMPFILE_NODE_PATH ": %s\n",
+          (*path == '/') ? path + 1 : path));
+
+  if (kind == svn_node_file)
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+                              SVN_REPOS_DUMPFILE_NODE_KIND ": file\n"));
+  else if (kind == svn_node_dir)
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+                              SVN_REPOS_DUMPFILE_NODE_KIND ": dir\n"));
+
+  /* Remove leading slashes from copyfrom paths. */
+  if (cmp_path)
+    cmp_path = ((*cmp_path == '/') ? cmp_path + 1 : cmp_path);
+
+  switch (action) {
+    /* Appropriately handle the four svn_node_action actions */
+
+  case svn_node_action_change:
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+                              SVN_REPOS_DUMPFILE_NODE_ACTION
+                              ": change\n"));
+    break;
+
+  case svn_node_action_replace:
+    if (!eb->is_copy) {
+      /* a simple delete+add, implied by a single 'replace' action. */
+      SVN_ERR(svn_stream_printf(eb->stream, pool,
+                                SVN_REPOS_DUMPFILE_NODE_ACTION
+                                ": replace\n"));
+
+      eb->dump_props_pending = TRUE;
+      break;
+    }
+    /* More complex case: eb->is_copy is true, and
+       cmp_path/ cmp_rev are present: delete the original,
+       and then re-add it */
+
+    /* the path & kind headers have already been printed;  just
+       add a delete action, and end the current record.*/
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+                              SVN_REPOS_DUMPFILE_NODE_ACTION
+                              ": delete\n\n"));
+
+    /* recurse:  print an additional add-with-history record. */
+    SVN_ERR(dump_node(eb, path, kind, svn_node_action_add,
+                      cmp_path, cmp_rev, pool));
+
+    /* we can leave this routine quietly now, don't need to dump
+       any content;  that was already done in the second record. */
+    eb->must_dump_props = FALSE;
+    eb->is_copy = FALSE;
+    break;
+
+  case svn_node_action_delete:
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+                              SVN_REPOS_DUMPFILE_NODE_ACTION
+                              ": delete\n"));
+
+    /* we can leave this routine quietly now, don't need to dump
+       any content. */
+    SVN_ERR(svn_stream_printf(eb->stream, pool, "\n\n"));
+    eb->must_dump_props = FALSE;
+    break;
+
+  case svn_node_action_add:
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+                              SVN_REPOS_DUMPFILE_NODE_ACTION ": add\n"));
+
+    if (!eb->is_copy) {
+      /* eb->dump_props_pending for files is handled in
+         close_file which is called immediately.
+         However, directories are not closed until
+         all the work inside them have been done;
+         eb->dump_props_pending for directories is
+         handled in all the functions that can
+         possibly be called after add_directory:
+         add_directory, open_directory,
+         delete_entry, close_directory, add_file,
+         open_file and change_dir_prop;
+         change_dir_prop is a special case
+         ofcourse */
+
+      eb->dump_props_pending = TRUE;
+      break;
+    }
+
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+                              SVN_REPOS_DUMPFILE_NODE_COPYFROM_REV
+                              ": %ld\n"
+                              SVN_REPOS_DUMPFILE_NODE_COPYFROM_PATH
+                              ": %s\n",
+                              cmp_rev, cmp_path));
+
+    /* Dump the text only if apply_textdelta sets
+       eb->must_dump_text */
+
+    /* UGLY hack: If a directory was copied from a
+       previous revision, nothing else can be done, and
+       close_file won't be called to write two blank
+       lines; write them here */
+    if (kind == svn_node_dir)
+      SVN_ERR(svn_stream_printf(eb->stream, pool, "\n\n"));
+
+    eb->is_copy = FALSE;
+
+    break;
+  }
+
+  /* Dump property headers */
+  SVN_ERR(dump_props(eb, &(eb->must_dump_props), FALSE, pool));
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *open_root(void *edit_baton,
+			      svn_revnum_t base_revision,
+			      apr_pool_t *pool,
+			      void **root_baton)
+{
+  /* Allocate a special pool for the edit_baton to avoid pool
+     lifetime issues */
+  struct dump_edit_baton *eb = edit_baton;
+  eb->pool = svn_pool_create(pool);
+  eb->properties = apr_hash_make(eb->pool);
+  eb->del_properties = apr_hash_make(eb->pool);
+  eb->propstring = svn_stringbuf_create("", eb->pool);
+  eb->is_copy = FALSE;
+
+  *root_baton = make_dir_baton(NULL, NULL, SVN_INVALID_REVNUM,
+                               edit_baton, NULL, FALSE, pool);
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+delete_entry(const char *path,
+             svn_revnum_t revision,
+             void *parent_baton,
+             apr_pool_t *pool)
+{
+  struct dir_baton *pb = parent_baton;
+  const char *mypath = apr_pstrdup(pb->pool, path);
+
+  /* Some pending properties to dump? */
+  SVN_ERR(dump_props(pb->eb, &(pb->eb->dump_props_pending), TRUE, pool));
+
+  /* remember this path needs to be deleted */
+  apr_hash_set(pb->deleted_entries, mypath, APR_HASH_KEY_STRING, pb);
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+add_directory(const char *path,
+              void *parent_baton,
+              const char *copyfrom_path,
+              svn_revnum_t copyfrom_rev,
+              apr_pool_t *pool,
+              void **child_baton)
+{
+  struct dir_baton *pb = parent_baton;
+  void *val;
+  struct dir_baton *new_db
+    = make_dir_baton(path, copyfrom_path, copyfrom_rev, pb->eb, pb, TRUE, pool);
+
+  /* Some pending properties to dump? */
+  SVN_ERR(dump_props(pb->eb, &(pb->eb->dump_props_pending), TRUE, pool));
+
+  /* This might be a replacement -- is the path already deleted? */
+  val = apr_hash_get(pb->deleted_entries, path, APR_HASH_KEY_STRING);
+
+  /* Detect an add-with-history */
+  pb->eb->is_copy = ARE_VALID_COPY_ARGS(copyfrom_path, copyfrom_rev);
+
+  /* Dump the node */
+  SVN_ERR(dump_node(pb->eb, path,
+                    svn_node_dir,
+                    val ? svn_node_action_replace : svn_node_action_add,
+                    pb->eb->is_copy ? copyfrom_path : NULL,
+                    pb->eb->is_copy ? copyfrom_rev : SVN_INVALID_REVNUM,
+                    pool));
+
+  if (val)
+    /* Delete the path, it's now been dumped */
+    apr_hash_set(pb->deleted_entries, path, APR_HASH_KEY_STRING, NULL);
+
+  new_db->written_out = TRUE;
+
+  *child_baton = new_db;
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+open_directory(const char *path,
+               void *parent_baton,
+               svn_revnum_t base_revision,
+               apr_pool_t *pool,
+               void **child_baton)
+{
+  struct dir_baton *pb = parent_baton;
+  struct dir_baton *new_db;
+  const char *cmp_path = NULL;
+  svn_revnum_t cmp_rev = SVN_INVALID_REVNUM;
+  apr_array_header_t *compose_path = apr_array_make(pool, 2,
+						    sizeof(const char *));
+
+  /* Some pending properties to dump? */
+  SVN_ERR(dump_props(pb->eb, &(pb->eb->dump_props_pending), TRUE, pool));
+
+  /* If the parent directory has explicit comparison path and rev,
+     record the same for this one. */
+  if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
+    APR_ARRAY_PUSH(compose_path, const char *) = pb->cmp_path;
+    APR_ARRAY_PUSH(compose_path, const char *) =
+	    svn_relpath_basename(path, pool);
+    cmp_path = svn_path_compose(compose_path, pool);
+    cmp_rev = pb->cmp_rev;
+  }
+
+  new_db = make_dir_baton(path, cmp_path, cmp_rev, pb->eb, pb, FALSE, pool);
+  *child_baton = new_db;
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+close_directory(void *dir_baton,
+                apr_pool_t *pool)
+{
+  struct dir_baton *db = dir_baton;
+  struct dump_edit_baton *eb = db->eb;
+  apr_hash_index_t *hi;
+  apr_pool_t *subpool = svn_pool_create(pool);
+
+  /* Some pending properties to dump? */
+  SVN_ERR(dump_props(eb, &(eb->dump_props_pending), TRUE, pool));
+
+  /* Dump the directory entries */
+  for (hi = apr_hash_first(pool, db->deleted_entries); hi;
+       hi = apr_hash_next(hi)) {
+    const void *key;
+    const char *path;
+    apr_hash_this(hi, &key, NULL, NULL);
+    path = key;
+
+    svn_pool_clear(subpool);
+
+    SVN_ERR(dump_node(db->eb, path,
+                      svn_node_unknown, svn_node_action_delete,
+                      NULL, SVN_INVALID_REVNUM, subpool));
+  }
+
+  svn_pool_destroy(subpool);
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+add_file(const char *path,
+         void *parent_baton,
+         const char *copyfrom_path,
+         svn_revnum_t copyfrom_rev,
+         apr_pool_t *pool,
+         void **file_baton)
+{
+  struct dir_baton *pb = parent_baton;
+  void *val;
+
+  /* Some pending properties to dump? */
+  SVN_ERR(dump_props(pb->eb, &(pb->eb->dump_props_pending), TRUE, pool));
+
+  /* This might be a replacement -- is the path already deleted? */
+  val = apr_hash_get(pb->deleted_entries, path, APR_HASH_KEY_STRING);
+
+  /* Detect add-with-history. */
+  pb->eb->is_copy = ARE_VALID_COPY_ARGS(copyfrom_path, copyfrom_rev);
+
+  /* Dump the node. */
+  SVN_ERR(dump_node(pb->eb, path,
+                    svn_node_file,
+                    val ? svn_node_action_replace : svn_node_action_add,
+                    pb->eb->is_copy ? copyfrom_path : NULL,
+                    pb->eb->is_copy ? copyfrom_rev : SVN_INVALID_REVNUM,
+                    pool));
+
+  if (val)
+    /* delete the path, it's now been dumped. */
+    apr_hash_set(pb->deleted_entries, path, APR_HASH_KEY_STRING, NULL);
+
+  /* Build a nice file baton to pass to change_file_prop and apply_textdelta */
+  pb->eb->changed_path = path;
+  *file_baton = pb->eb;
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+open_file(const char *path,
+          void *parent_baton,
+          svn_revnum_t ancestor_revision,
+          apr_pool_t *pool,
+          void **file_baton)
+{
+  struct dir_baton *pb = parent_baton;
+  const char *cmp_path = NULL;
+  svn_revnum_t cmp_rev = SVN_INVALID_REVNUM;
+
+  /* Some pending properties to dump? */
+  SVN_ERR(dump_props(pb->eb, &(pb->eb->dump_props_pending), TRUE, pool));
+
+  apr_array_header_t *compose_path = apr_array_make(pool, 2,
+						    sizeof(const char *));
+  /* If the parent directory has explicit comparison path and rev,
+     record the same for this one. */
+  if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
+    APR_ARRAY_PUSH(compose_path, const char *) = pb->cmp_path;
+    APR_ARRAY_PUSH(compose_path, const char *) =
+	    svn_relpath_basename(path, pool);
+    cmp_path = svn_path_compose(compose_path, pool);
+    cmp_rev = pb->cmp_rev;
+  }
+
+  SVN_ERR(dump_node(pb->eb, path,
+                    svn_node_file, svn_node_action_change,
+                    cmp_path, cmp_rev, pool));
+
+  /* Build a nice file baton to pass to change_file_prop and apply_textdelta */
+  pb->eb->changed_path = path;
+  *file_baton = pb->eb;
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+change_dir_prop(void *parent_baton,
+                const char *name,
+                const svn_string_t *value,
+                apr_pool_t *pool)
+{
+  struct dir_baton *db = parent_baton;
+
+  if (svn_property_kind(NULL, name) != svn_prop_regular_kind)
+    return SVN_NO_ERROR;
+
+  value ? apr_hash_set(db->eb->properties, apr_pstrdup(pool, name),
+                       APR_HASH_KEY_STRING, svn_string_dup(value, pool)) :
+    apr_hash_set(db->eb->del_properties, apr_pstrdup(pool, name),
+                 APR_HASH_KEY_STRING, (void *)0x1);
+
+  /* This function is what distinguishes between a directory that is
+     opened to merely get somewhere, vs. one that is opened because it
+     actually changed by itself  */
+  if (! db->written_out) {
+    /* If eb->dump_props_pending was set, it means that the
+       node information corresponding to add_directory has already
+       been written; just don't unset it and dump_node will dump
+       the properties before doing anything else. If it wasn't
+       set, node information hasn't been written yet: so dump the
+       node itself before dumping the props */
+
+    SVN_ERR(dump_node(db->eb, db->path,
+                      svn_node_dir, svn_node_action_change,
+                      db->cmp_path, db->cmp_rev, pool));
+
+    SVN_ERR(dump_props(db->eb, NULL, TRUE, pool));
+    db->written_out = TRUE;
+  }
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+change_file_prop(void *file_baton,
+                 const char *name,
+                 const svn_string_t *value,
+                 apr_pool_t *pool)
+{
+  struct dump_edit_baton *eb = file_baton;
+
+  if (svn_property_kind(NULL, name) != svn_prop_regular_kind)
+    return SVN_NO_ERROR;
+
+  apr_hash_set(eb->properties, apr_pstrdup(pool, name),
+               APR_HASH_KEY_STRING, value ?
+               svn_string_dup(value, pool): (void *)0x1);
+  /* Dump the property headers and wait; close_file might need
+     to write text headers too depending on whether
+     apply_textdelta is called */
+  eb->dump_props_pending = TRUE;
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+window_handler(svn_txdelta_window_t *window, void *baton)
+{
+  struct handler_baton *hb = baton;
+  struct dump_edit_baton *eb = hb->eb;
+  static svn_error_t *err;
+
+  err = hb->apply_handler(window, hb->apply_baton);
+  if (window != NULL && !err)
+    return SVN_NO_ERROR;
+
+  if (err)
+    SVN_ERR(err);
+
+  /* Write information about the filepath to hb->eb */
+  eb->temp_filepath = apr_pstrdup(eb->pool,
+          hb->temp_filepath);
+
+  /* Cleanup */
+  SVN_ERR(svn_io_file_close(hb->temp_file, hb->pool));
+  SVN_ERR(svn_stream_close(hb->temp_filestream));
+  svn_pool_destroy(hb->pool);
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+apply_textdelta(void *file_baton, const char *base_checksum,
+                apr_pool_t *pool,
+                svn_txdelta_window_handler_t *handler,
+                void **handler_baton)
+{
+  struct dump_edit_baton *eb = file_baton;
+  apr_status_t apr_err;
+  const char *tempdir;
+
+  /* Custom handler_baton allocated in a separate pool */
+  apr_pool_t *handler_pool = svn_pool_create(pool);
+  struct handler_baton *hb = apr_pcalloc(handler_pool, sizeof(*hb));
+  hb->pool = handler_pool;
+  hb->eb = eb;
+
+  /* Use a temporary file to measure the text-content-length */
+  SVN_ERR(svn_io_temp_dir(&tempdir, hb->pool));
+
+  hb->temp_filepath = svn_dirent_join(tempdir, "XXXXXX", hb->pool);
+  apr_err = apr_file_mktemp(&(hb->temp_file), hb->temp_filepath,
+          APR_CREATE | APR_READ | APR_WRITE | APR_EXCL,
+          hb->pool);
+  if (apr_err != APR_SUCCESS)
+    SVN_ERR(svn_error_wrap_apr(apr_err, NULL));
+
+  hb->temp_filestream = svn_stream_from_aprfile2(hb->temp_file, TRUE, hb->pool);
+
+  /* Prepare to write the delta to the temporary file */
+  svn_txdelta_to_svndiff2(&(hb->apply_handler), &(hb->apply_baton),
+                          hb->temp_filestream, 0, hb->pool);
+  eb->must_dump_text = TRUE;
+
+  /* The actual writing takes place when this function has finished */
+  /* Set the handler and handler_baton */
+  *handler = window_handler;
+  *handler_baton = hb;
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+close_file(void *file_baton,
+           const char *text_checksum,
+           apr_pool_t *pool)
+{
+  struct dump_edit_baton *eb = file_baton;
+  apr_file_t *temp_file;
+  svn_stream_t *temp_filestream;
+  apr_finfo_t *info = apr_pcalloc(pool, sizeof(apr_finfo_t));
+
+  /* We didn't write the property headers because we were
+     waiting for file_prop_change; write them now */
+  SVN_ERR(dump_props(eb, &(eb->dump_props_pending), FALSE, pool));
+
+  /* The prop headers have already been dumped in dump_node */
+  /* Dump the text headers */
+  if (eb->must_dump_text) {
+    /* text-delta header */
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+            SVN_REPOS_DUMPFILE_TEXT_DELTA
+            ": true\n"));
+
+    /* Measure the length */
+    SVN_ERR(svn_io_stat(info, eb->temp_filepath, APR_FINFO_SIZE, pool));
+
+    /* text-content-length header */
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+            SVN_REPOS_DUMPFILE_TEXT_CONTENT_LENGTH
+            ": %lu\n",
+            (unsigned long)info->size));
+    /* text-content-md5 header */
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+            SVN_REPOS_DUMPFILE_TEXT_CONTENT_MD5
+            ": %s\n",
+            text_checksum));
+  }
+
+  /* content-length header: if both text and props are absent,
+     skip this block */
+  if (eb->must_dump_props || eb->dump_props_pending)
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+            SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+            ": %ld\n\n",
+            (unsigned long)info->size + eb->propstring->len));
+  else if (eb->must_dump_text)
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+            SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+            ": %ld\n\n",
+            (unsigned long)info->size));
+
+  /* Dump the props; the propstring should have already been
+     written in dump_node or above */
+  if (eb->must_dump_props || eb->dump_props_pending) {
+    SVN_ERR(svn_stream_write(eb->stream, eb->propstring->data,
+           &(eb->propstring->len)));
+
+    /* Cleanup */
+    eb->must_dump_props = eb->dump_props_pending = FALSE;
+    apr_hash_clear(eb->properties);
+    apr_hash_clear(eb->del_properties);
+  }
+
+  /* Dump the text */
+  if (eb->must_dump_text) {
+
+    /* Open the temporary file, map it to a stream, copy
+       the stream to eb->stream, close and delete the
+       file */
+    SVN_ERR(svn_io_file_open(&temp_file, eb->temp_filepath,APR_READ,
+			     0600,pool));
+    temp_filestream = svn_stream_from_aprfile2(temp_file, TRUE, pool);
+    SVN_ERR(svn_stream_copy3(temp_filestream, eb->stream, NULL, NULL, pool));
+
+    /* Cleanup */
+    SVN_ERR(svn_io_file_close(temp_file, pool));
+    SVN_ERR(svn_stream_close(temp_filestream));
+    SVN_ERR(svn_io_remove_file2(eb->temp_filepath, TRUE, pool));
+    eb->must_dump_text = FALSE;
+  }
+
+  SVN_ERR(svn_stream_printf(eb->stream, pool, "\n\n"));
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+close_edit(void *edit_baton, apr_pool_t *pool)
+{
+  struct dump_edit_baton *eb = edit_baton;
+  svn_pool_destroy(eb->pool);
+  (eb->current_rev) ++;
+
+  return SVN_NO_ERROR;
+}
+
+svn_error_t *
+get_dump_editor(const svn_delta_editor_t **editor,
+                void **edit_baton,
+                svn_revnum_t from_rev,
+                apr_pool_t *pool)
+{
+  struct dump_edit_baton *eb = apr_pcalloc(pool,
+					   sizeof(struct dump_edit_baton));
+  eb->current_rev = from_rev;
+  SVN_ERR(svn_stream_for_stdout(&(eb->stream), pool));
+  svn_delta_editor_t *de = svn_delta_default_editor(pool);
+
+  de->open_root = open_root;
+  de->delete_entry = delete_entry;
+  de->add_directory = add_directory;
+  de->open_directory = open_directory;
+  de->close_directory = close_directory;
+  de->change_dir_prop = change_dir_prop;
+  de->change_file_prop = change_file_prop;
+  de->apply_textdelta = apply_textdelta;
+  de->add_file = add_file;
+  de->open_file = open_file;
+  de->close_file = close_file;
+  de->close_edit = close_edit;
+
+  /* Set the edit_baton and editor */
+  *edit_baton = eb;
+  *editor = de;
+
+  return SVN_NO_ERROR;
+}
Index: svnrdump/dump_editor.h
===================================================================
--- svnrdump/dump_editor.h	(revision 0)
+++ svnrdump/dump_editor.h	(working copy)
@@ -0,0 +1,104 @@
+/*
+ * ====================================================================
+ *    Licensed to the Apache Software Foundation (ASF) under one
+ *    or more contributor license agreements.  See the NOTICE file
+ *    distributed with this work for additional information
+ *    regarding copyright ownership.  The ASF licenses this file
+ *    to you under the Apache License, Version 2.0 (the
+ *    "License"); you may not use this file except in compliance
+ *    with the License.  You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ *    Unless required by applicable law or agreed to in writing,
+ *    software distributed under the License is distributed on an
+ *    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
+ *    KIND, either express or implied.  See the License for the
+ *    specific language governing permissions and limitations
+ *    under the License.
+ * ====================================================================
+ */
+
+#ifndef DUMP_EDITOR_H_
+#define DUMP_EDITOR_H_
+
+struct dump_edit_baton {
+  svn_stream_t *stream;
+  svn_revnum_t current_rev;
+
+  /* pool is for per-edit-session allocations */
+  apr_pool_t *pool;
+
+  /* Store the properties that changed */
+  apr_hash_t *properties;
+  apr_hash_t *del_properties; /* Value is always 0x1 */
+  svn_stringbuf_t *propstring;
+
+  /* Was a copy command issued? */
+  svn_boolean_t is_copy;
+
+  /* Path of changed file */
+  const char *changed_path;
+
+  /* Temporary file to write delta to along with its checksum */
+  char *temp_filepath;
+  svn_checksum_t *checksum;
+
+  /* Flags to trigger dumping props and text */
+  svn_boolean_t must_dump_props;
+  svn_boolean_t must_dump_text;
+  svn_boolean_t dump_props_pending;
+};
+
+struct dir_baton {
+  struct dump_edit_baton *eb;
+  struct dir_baton *parent_dir_baton;
+
+  /* is this directory a new addition to this revision? */
+  svn_boolean_t added;
+
+  /* has this directory been written to the output stream? */
+  svn_boolean_t written_out;
+
+  /* the absolute path to this directory */
+  const char *path;
+
+  /* the comparison path and revision of this directory.  if both of
+     these are valid, use them as a source against which to compare
+     the directory instead of the default comparison source of PATH in
+     the previous revision. */
+  const char *cmp_path;
+  svn_revnum_t cmp_rev;
+
+  /* hash of paths that need to be deleted, though some -might- be
+     replaced.  maps const char * paths to this dir_baton.  (they're
+     full paths, because that's what the editor driver gives us.  but
+     really, they're all within this directory.) */
+  apr_hash_t *deleted_entries;
+
+  /* pool to be used for deleting the hash items */
+  apr_pool_t *pool;
+};
+
+struct handler_baton
+{
+  svn_txdelta_window_handler_t apply_handler;
+  void *apply_baton;
+  apr_pool_t *pool;
+
+  /* Information about the path of the tempoarary file used */
+  char *temp_filepath;
+  apr_file_t *temp_file;
+  svn_stream_t *temp_filestream;
+
+  /* To fill in the edit baton fields */
+  struct dump_edit_baton *eb;
+};
+
+svn_error_t *
+get_dump_editor(const svn_delta_editor_t **editor,
+                void **edit_baton,
+                svn_revnum_t to_rev,
+                apr_pool_t *pool);
+
+#endif
Index: svnrdump/svnrdump.c
===================================================================
--- svnrdump/svnrdump.c	(revision 0)
+++ svnrdump/svnrdump.c	(working copy)
@@ -0,0 +1,204 @@
+/*
+ * ====================================================================
+ *    Licensed to the Apache Software Foundation (ASF) under one
+ *    or more contributor license agreements.  See the NOTICE file
+ *    distributed with this work for additional information
+ *    regarding copyright ownership.  The ASF licenses this file
+ *    to you under the Apache License, Version 2.0 (the
+ *    "License"); you may not use this file except in compliance
+ *    with the License.  You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ *    Unless required by applicable law or agreed to in writing,
+ *    software distributed under the License is distributed on an
+ *    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
+ *    KIND, either express or implied.  See the License for the
+ *    specific language governing permissions and limitations
+ *    under the License.
+ * ====================================================================
+ */
+
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+#include "svn_repos.h"
+#include "svn_path.h"
+
+#include "svnrdump.h"
+#include "dump_editor.h"
+
+static int verbose = 0;
+static apr_pool_t *pool = NULL;
+static svn_client_ctx_t *ctx = NULL;
+static svn_ra_session_t *session = NULL;
+
+static svn_error_t *
+replay_revstart(svn_revnum_t revision,
+                void *replay_baton,
+                const svn_delta_editor_t **editor,
+                void **edit_baton,
+                apr_hash_t *rev_props,
+                apr_pool_t *pool)
+{
+  /* Editing this revision has just started; dump the revprops
+     before invoking the editor callbacks */
+  svn_stringbuf_t *propstring = svn_stringbuf_create("", pool);
+  svn_stream_t *stdout_stream;
+
+  /* Create an stdout stream */
+  svn_stream_for_stdout(&stdout_stream, pool);
+
+        /* Print revision number and prepare the propstring */
+  SVN_ERR(svn_stream_printf(stdout_stream, pool,
+          SVN_REPOS_DUMPFILE_REVISION_NUMBER
+          ": %ld\n", revision));
+  write_hash_to_stringbuf(rev_props, FALSE, &propstring, pool);
+  svn_stringbuf_appendbytes(propstring, "PROPS-END\n", 10);
+
+  /* prop-content-length header */
+  SVN_ERR(svn_stream_printf(stdout_stream, pool,
+          SVN_REPOS_DUMPFILE_PROP_CONTENT_LENGTH
+          ": %" APR_SIZE_T_FMT "\n", propstring->len));
+
+  /* content-length header */
+  SVN_ERR(svn_stream_printf(stdout_stream, pool,
+          SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+          ": %" APR_SIZE_T_FMT "\n\n", propstring->len));
+
+  /* Print the revprops now */
+  SVN_ERR(svn_stream_write(stdout_stream, propstring->data,
+         &(propstring->len)));
+
+  svn_stream_close(stdout_stream);
+
+  /* Extract editor and editor_baton from the replay_baton and
+     set them so that the editor callbacks can use them */
+  struct replay_baton *rb = replay_baton;
+  *editor = rb->editor;
+  *edit_baton = rb->edit_baton;
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+replay_revend(svn_revnum_t revision,
+              void *replay_baton,
+              const svn_delta_editor_t *editor,
+              void *edit_baton,
+              apr_hash_t *rev_props,
+              apr_pool_t *pool)
+{
+  /* Editor has finished for this revision and close_edit has
+     been called; do nothing: just continue to the next
+     revision */
+  if (verbose)
+    fprintf(stderr, "* Dumped revision %lu\n", revision);
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+open_connection(const char *url)
+{
+  SVN_ERR(svn_config_ensure (NULL, pool));
+  SVN_ERR(svn_client_create_context (&ctx, pool));
+  SVN_ERR(svn_ra_initialize(pool));
+
+  SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
+
+  /* Default authentication providers for non-interactive use */
+  SVN_ERR(svn_cmdline_create_auth_baton(&(ctx->auth_baton), TRUE,
+                NULL, NULL, NULL, FALSE,
+                FALSE, NULL, NULL, NULL,
+                pool));
+  SVN_ERR(svn_client_open_ra_session(&session, url, ctx, pool));
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
+{
+  const svn_delta_editor_t *dump_editor;
+  void *dump_baton;
+
+  SVN_ERR(get_dump_editor(&dump_editor,
+                          &dump_baton, start_revision, pool));
+
+  struct replay_baton *replay_baton = apr_palloc(pool,
+						 sizeof(struct replay_baton));
+  replay_baton->editor = dump_editor;
+  replay_baton->edit_baton = dump_baton;
+  SVN_ERR(svn_cmdline_printf(pool, SVN_REPOS_DUMPFILE_MAGIC_HEADER ": %d\n",
+           SVN_REPOS_DUMPFILE_FORMAT_VERSION));
+  SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
+                              0, TRUE, replay_revstart, replay_revend,
+                              replay_baton, pool));
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+usage(FILE *out_stream)
+{
+  fprintf(out_stream,
+    "usage: svnrdump URL [-r LOWER[:UPPER]]\n\n"
+    "Dump the contents of repository at remote URL to stdout in a 'dumpfile'\n"
+    "v3 portable format.  Dump revisions LOWER rev through UPPER rev.\n"
+    "LOWER defaults to 1 and UPPER defaults to the highest possible revision\n"
+    "if omitted.\n");
+  return SVN_NO_ERROR;
+}
+
+int
+main(int argc, const char **argv)
+{
+  int i;
+  const char *url = NULL;
+  char *revision_cut = NULL;
+  svn_revnum_t start_revision = svn_opt_revision_unspecified;
+  svn_revnum_t end_revision = svn_opt_revision_unspecified;
+
+  if (svn_cmdline_init ("svnrdump", stderr) != EXIT_SUCCESS)
+    return EXIT_FAILURE;
+
+  pool = svn_pool_create(NULL);
+
+  for (i = 1; i < argc; i++) {
+    if (!strncmp("-r", argv[i], 2)) {
+      revision_cut = strchr(argv[i] + 2, ':');
+      if (revision_cut) {
+        start_revision = (svn_revnum_t) strtoul(argv[i] + 2, &revision_cut, 10);
+        end_revision = (svn_revnum_t) strtoul(revision_cut + 1, NULL, 10);
+      }
+      else
+        start_revision = (svn_revnum_t) strtoul(argv[i] + 2, NULL, 10);
+    } else if (!strcmp("-v", argv[i]) || !strcmp("--verbose", argv[i])) {
+      verbose = 1;
+    } else if (!strcmp("help", argv[i]) || !strcmp("--help", argv[i])) {
+      SVN_INT_ERR(usage(stdout));
+      return EXIT_SUCCESS;
+    } else if (*argv[i] == '-' || url) {
+      SVN_INT_ERR(usage(stderr));
+      return EXIT_FAILURE;
+    } else
+      url = argv[i];
+  }
+
+  if (!url || !svn_path_is_url(url)) {
+    usage(stderr);
+    return EXIT_FAILURE;
+  }
+  SVN_INT_ERR(open_connection(url));
+
+  /* Have sane start_revision and end_revision defaults if unspecified */
+  if (start_revision == svn_opt_revision_unspecified)
+    start_revision = 1;
+  if (end_revision == svn_opt_revision_unspecified)
+    SVN_INT_ERR(svn_ra_get_latest_revnum(session, &end_revision, pool));
+
+  SVN_INT_ERR(replay_range(start_revision, end_revision));
+
+  svn_pool_destroy(pool);
+
+  return 0;
+}
Index: svnrdump/svnrdump.h
===================================================================
--- svnrdump/svnrdump.h	(revision 0)
+++ svnrdump/svnrdump.h	(working copy)
@@ -0,0 +1,44 @@
+/*
+ * ====================================================================
+ *    Licensed to the Apache Software Foundation (ASF) under one
+ *    or more contributor license agreements.  See the NOTICE file
+ *    distributed with this work for additional information
+ *    regarding copyright ownership.  The ASF licenses this file
+ *    to you under the Apache License, Version 2.0 (the
+ *    "License"); you may not use this file except in compliance
+ *    with the License.  You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ *    Unless required by applicable law or agreed to in writing,
+ *    software distributed under the License is distributed on an
+ *    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
+ *    KIND, either express or implied.  See the License for the
+ *    specific language governing permissions and limitations
+ *    under the License.
+ * ====================================================================
+ */
+
+#ifndef SVNRDUMP_H_
+#define SVNRDUMP_H_
+
+#include "dump_editor.h"
+
+struct replay_baton {
+  const svn_delta_editor_t *editor;
+  void *edit_baton;
+};
+
+void
+write_hash_to_stringbuf(apr_hash_t *properties,
+                        svn_boolean_t deleted,
+                        svn_stringbuf_t **strbuf,
+                        apr_pool_t *pool);
+
+svn_error_t *
+dump_props(struct dump_edit_baton *eb,
+           svn_boolean_t *trigger_var,
+           svn_boolean_t dump_data_too,
+           apr_pool_t *pool);
+
+#endif
Index: svnrdump/util.c
===================================================================
--- svnrdump/util.c	(revision 0)
+++ svnrdump/util.c	(working copy)
@@ -0,0 +1,131 @@
+/*
+ * ====================================================================
+ *    Licensed to the Apache Software Foundation (ASF) under one
+ *    or more contributor license agreements.  See the NOTICE file
+ *    distributed with this work for additional information
+ *    regarding copyright ownership.  The ASF licenses this file
+ *    to you under the Apache License, Version 2.0 (the
+ *    "License"); you may not use this file except in compliance
+ *    with the License.  You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ *    Unless required by applicable law or agreed to in writing,
+ *    software distributed under the License is distributed on an
+ *    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
+ *    KIND, either express or implied.  See the License for the
+ *    specific language governing permissions and limitations
+ *    under the License.
+ * ====================================================================
+ */
+
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+#include "svn_repos.h"
+
+#include "svnrdump.h"
+
+void
+write_hash_to_stringbuf(apr_hash_t *properties,
+                        svn_boolean_t deleted,
+                        svn_stringbuf_t **strbuf,
+                        apr_pool_t *pool)
+{
+  apr_hash_index_t *this;
+  const void *key;
+  void *val;
+  apr_ssize_t keylen;
+  svn_string_t *value;
+
+  if (!deleted) {
+    for (this = apr_hash_first(pool, properties); this;
+         this = apr_hash_next(this)) {
+      /* Get this key and val. */
+      apr_hash_this(this, &key, &keylen, &val);
+      value = val;
+
+      /* Output name length, then name. */
+      svn_stringbuf_appendcstr(*strbuf,
+             apr_psprintf(pool, "K %" APR_SSIZE_T_FMT "\n",
+                    keylen));
+
+      svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);
+      svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+
+      /* Output value length, then value. */
+      svn_stringbuf_appendcstr(*strbuf,
+             apr_psprintf(pool, "V %" APR_SIZE_T_FMT "\n",
+                    value->len));
+
+      svn_stringbuf_appendbytes(*strbuf, value->data, value->len);
+      svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+    }
+  }
+  else {
+    /* Output a "D " entry for each deleted property */
+    for (this = apr_hash_first(pool, properties); this;
+         this = apr_hash_next(this)) {
+      /* Get this key */
+      apr_hash_this(this, &key, &keylen, NULL);
+
+      /* Output name length, then name */
+      svn_stringbuf_appendcstr(*strbuf,
+             apr_psprintf(pool, "D %" APR_SSIZE_T_FMT "\n",
+                    keylen));
+
+      svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);
+      svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+    }
+  }
+}
+
+svn_error_t *
+dump_props(struct dump_edit_baton *eb,
+           svn_boolean_t *trigger_var,
+           svn_boolean_t dump_data_too,
+           apr_pool_t *pool)
+{
+  if (trigger_var && !*trigger_var)
+    return SVN_NO_ERROR;
+
+  /* Build a propstring to print */
+  svn_stringbuf_setempty(eb->propstring);
+  write_hash_to_stringbuf(eb->properties,
+        FALSE,
+        &(eb->propstring), eb->pool);
+  write_hash_to_stringbuf(eb->del_properties,
+        TRUE,
+        &(eb->propstring), eb->pool);
+  svn_stringbuf_appendbytes(eb->propstring, "PROPS-END\n", 10);
+
+  /* prop-delta header */
+  SVN_ERR(svn_stream_printf(eb->stream, pool,
+          SVN_REPOS_DUMPFILE_PROP_DELTA
+          ": true\n"));
+
+  /* prop-content-length header */
+  SVN_ERR(svn_stream_printf(eb->stream, pool,
+          SVN_REPOS_DUMPFILE_PROP_CONTENT_LENGTH
+          ": %" APR_SIZE_T_FMT "\n", eb->propstring->len));
+
+  if (dump_data_too) {
+    /* content-length header */
+    SVN_ERR(svn_stream_printf(eb->stream, pool,
+            SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+            ": %" APR_SIZE_T_FMT "\n\n",
+            eb->propstring->len));
+
+    /* the properties themselves */
+    SVN_ERR(svn_stream_write(eb->stream, eb->propstring->data,
+           &(eb->propstring->len)));
+
+    /* Cleanup so that data is never dumped twice */
+    apr_hash_clear(eb->properties);
+    apr_hash_clear(eb->del_properties);
+    if (trigger_var)
+      *trigger_var = FALSE;
+  }
+  return SVN_NO_ERROR;
+}
