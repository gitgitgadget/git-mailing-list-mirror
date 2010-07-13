From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/9] Dump the revprops at the start of every revision
Date: Wed, 14 Jul 2010 01:36:12 +0200
Message-ID: <1279064176-6645-6-git-send-email-artagnon@gmail.com>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 01:36:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYp1r-0008BW-TC
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239Ab0GMXgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:36:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43675 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757126Ab0GMXga (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:36:30 -0400
Received: by mail-ey0-f174.google.com with SMTP id 25so898848eya.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wlDQFbWXXc6VTjboBipHjjmypHflXFz1gd/HO0yYGqU=;
        b=XmZCw2MPJukMg4uAWo9mk9tvBWazEoJrv2tDPHFOzNQkYcP7j1ga8tV2xY4evYgJqR
         BXZCmsKAeY5P8VsrU1T2Yt8wtdwtgaCJxJBpm2Ow1pdJbyABehHdB5KFNiH9AOB78BXm
         yIncLudi9fDcYSBejne8oCTD/t0Yg3uWXiRZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WtXlGmkyeJv2PYQ59ZRCBMH2dtJg9ViYn0NDu9OIuaRebu7vM7y5PgjIxABtPjDuE8
         +IQHgpZatfpE3EifWwtSaD2dcGsuuYHjHTXzqz+bqnZbTxoV4D/hRzYvhr1/vFFPFfts
         1X91imK43ltmWhvXYxQCULxl8yP5KI4/qc9kA=
Received: by 10.213.98.73 with SMTP id p9mr5701762ebn.89.1279064189645;
        Tue, 13 Jul 2010 16:36:29 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id z55sm51476201eeh.9.2010.07.13.16.36.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:36:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150945>

Fill in replay_revstart to dump the revprops at the start of every
revision. Add an additional write_hash_to_stringbuf helper function.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile      |    4 +-
 dump_editor.c |  207 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 dumpr_util.c  |  112 +++++++++++++++++++++++++++++++
 dumpr_util.h  |   63 +++++++++++++++++
 svnrdump.c    |   40 +++++++++++-
 5 files changed, 421 insertions(+), 5 deletions(-)
 create mode 100644 dumpr_util.c

diff --git a/Makefile b/Makefile
index 3561909..6a5a101 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 svnrdump: *.c *.h
-	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svnrdump.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
+	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svnrdump.c debug_editor.c dump_editor.c dumpr_util.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
 
 svnrdump_bench: *.c *.h
-	$(CC) -O2 -o $@ svnrdump.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
+	$(CC) -O2 -o $@ svnrdump.c debug_editor.c dump_editor.c dumpr_util.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
 
 clean:
 	$(RM) svnrdump svnrdump_bench
diff --git a/dump_editor.c b/dump_editor.c
index 2db3f7e..0506966 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -10,12 +10,213 @@
 
 #include "dumpr_util.h"
 
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
+static struct dir_baton *make_dir_baton(const char *path,
+					const char *cmp_path,
+					svn_revnum_t cmp_rev,
+					void *edit_baton,
+					void *parent_dir_baton,
+					svn_boolean_t added,
+					apr_pool_t *pool)
+{
+	struct dump_edit_baton *eb = edit_baton;
+	struct dir_baton *pb = parent_dir_baton;
+	struct dir_baton *new_db = apr_pcalloc(pool, sizeof(*new_db));
+	const char *full_path;
+	apr_array_header_t *compose_path = apr_array_make(pool, 2, sizeof(const char *));
+
+	/* A path relative to nothing?  I don't think so. */
+	SVN_ERR_ASSERT_NO_RETURN(!path || pb);
+
+	/* Construct the full path of this node. */
+	if (pb) {
+		APR_ARRAY_PUSH(compose_path, const char *) = "/";
+		APR_ARRAY_PUSH(compose_path, const char *) = path;
+		full_path = svn_path_compose(compose_path, pool);
+	}
+	else
+		full_path = apr_pstrdup(pool, "/");
+
+	/* Remove leading slashes from copyfrom paths. */
+	if (cmp_path)
+		cmp_path = ((*cmp_path == '/') ? cmp_path + 1 : cmp_path);
+
+	new_db->eb = eb;
+	new_db->parent_dir_baton = pb;
+	new_db->path = full_path;
+	new_db->cmp_path = cmp_path ? apr_pstrdup(pool, cmp_path) : NULL;
+	new_db->cmp_rev = cmp_rev;
+	new_db->added = added;
+	new_db->written_out = FALSE;
+	new_db->deleted_entries = apr_hash_make(pool);
+	new_db->pool = pool;
+
+	return new_db;
+}
+
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
+static svn_error_t *dump_node(struct dump_edit_baton *eb,
+			      const char *path,    /* an absolute path. */
+			      svn_node_kind_t kind,
+			      enum svn_node_action action,
+			      const char *cmp_path,
+			      svn_revnum_t cmp_rev,
+			      apr_pool_t *pool)
+{
+	/* Write out metadata headers for this file node. */
+	SVN_ERR(svn_stream_printf(eb->stream, pool,
+				  SVN_REPOS_DUMPFILE_NODE_PATH ": %s\n",
+				  (*path == '/') ? path + 1 : path));
+
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
+
+	switch (action) {
+		/* Appropriately handle the four svn_node_action actions */
+
+	case svn_node_action_change:
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION
+		                          ": change\n"));
+		break;
+
+	case svn_node_action_replace:
+		if (!eb->is_copy) {
+			/* a simple delete+add, implied by a single 'replace' action. */
+			SVN_ERR(svn_stream_printf(eb->stream, pool,
+			                          SVN_REPOS_DUMPFILE_NODE_ACTION
+			                          ": replace\n"));
+
+			eb->dump_props_pending = TRUE;
+			break;
+		}
+		/* More complex case: eb->is_copy is true, and
+		   cmp_path/ cmp_rev are present: delete the original,
+		   and then re-add it */
+
+		/* the path & kind headers have already been printed;  just
+		   add a delete action, and end the current record.*/
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION
+		                          ": delete\n\n"));
+
+		/* recurse:  print an additional add-with-history record. */
+		SVN_ERR(dump_node(eb, path, kind, svn_node_action_add,
+		                  cmp_path, cmp_rev, pool));
+
+		/* we can leave this routine quietly now, don't need to dump
+		   any content;  that was already done in the second record. */
+		eb->must_dump_props = FALSE;
+		eb->is_copy = FALSE;
+		break;
+
+	case svn_node_action_delete:
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION
+		                          ": delete\n"));
+
+		/* we can leave this routine quietly now, don't need to dump
+		   any content. */
+		SVN_ERR(svn_stream_printf(eb->stream, pool, "\n\n"));
+		eb->must_dump_props = FALSE;
+		break;
+
+	case svn_node_action_add:
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION ": add\n"));
+
+		if (!eb->is_copy) {
+			/* eb->dump_props_pending for files is handled in
+			   close_file which is called immediately.
+			   However, directories are not closed until
+			   all the work inside them have been done;
+			   eb->dump_props_pending for directories is
+			   handled in all the functions that can
+			   possibly be called after add_directory:
+			   add_directory, open_directory,
+			   delete_entry, close_directory, add_file,
+			   open_file and change_dir_prop;
+			   change_dir_prop is a special case
+			   ofcourse */
+
+			eb->dump_props_pending = TRUE;
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
+		/* Dump the text only if apply_textdelta sets
+		   eb->must_dump_text */
+
+		/* UGLY hack: If a directory was copied from a
+		   previous revision, nothing else can be done, and
+		   close_file won't be called to write two blank
+		   lines; write them here */
+		if (kind == svn_node_dir)
+			SVN_ERR(svn_stream_printf(eb->stream, pool, "\n\n"));
+
+		eb->is_copy = FALSE;
+
+		break;
+	}
+
+	/* Dump property headers */
+	SVN_ERR(dump_props(eb, &(eb->must_dump_props), FALSE, pool));
+
+	return SVN_NO_ERROR;
+}
+
 static svn_error_t *open_root(void *edit_baton,
 			      svn_revnum_t base_revision,
 			      apr_pool_t *pool,
 			      void **root_baton)
 {
-	*root_baton = NULL;
+	/* Allocate a special pool for the edit_baton to avoid pool
+	   lifetime issues */
+	struct dump_edit_baton *eb = edit_baton;
+	eb->pool = svn_pool_create(pool);
+	eb->properties = apr_hash_make(eb->pool);
+	eb->del_properties = apr_hash_make(eb->pool);
+	eb->propstring = svn_stringbuf_create("", eb->pool);
+	eb->is_copy = FALSE;
+
+	*root_baton = make_dir_baton(NULL, NULL, SVN_INVALID_REVNUM,
+	                             edit_baton, NULL, FALSE, pool);
 	return SVN_NO_ERROR;
 }
 
@@ -110,6 +311,10 @@ static svn_error_t *close_file(void *file_baton,
 
 static svn_error_t *close_edit(void *edit_baton, apr_pool_t *pool)
 {
+	struct dump_edit_baton *eb = edit_baton;
+	svn_pool_destroy(eb->pool);
+	(eb->current_rev) ++;
+
 	return SVN_NO_ERROR;
 }
 
diff --git a/dumpr_util.c b/dumpr_util.c
new file mode 100644
index 0000000..33dc74a
--- /dev/null
+++ b/dumpr_util.c
@@ -0,0 +1,112 @@
+/* Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+#include "svn_repos.h"
+
+#include "dumpr_util.h"
+
+void write_hash_to_stringbuf(apr_hash_t *properties,
+			     svn_boolean_t deleted,
+			     svn_stringbuf_t **strbuf,
+			     apr_pool_t *pool)
+{
+	apr_hash_index_t *this;
+	const void *key;
+	void *val;
+	apr_ssize_t keylen;
+	svn_string_t *value;
+
+	if (!deleted) {
+		for (this = apr_hash_first(pool, properties); this;
+		     this = apr_hash_next(this)) {
+			/* Get this key and val. */
+			apr_hash_this(this, &key, &keylen, &val);
+			value = val;
+
+			/* Output name length, then name. */
+			svn_stringbuf_appendcstr(*strbuf,
+						 apr_psprintf(pool, "K %" APR_SSIZE_T_FMT "\n",
+							      keylen));
+
+			svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);
+			svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+
+			/* Output value length, then value. */
+			svn_stringbuf_appendcstr(*strbuf,
+						 apr_psprintf(pool, "V %" APR_SIZE_T_FMT "\n",
+							      value->len));
+
+			svn_stringbuf_appendbytes(*strbuf, value->data, value->len);
+			svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+		}
+	}
+	else {
+		/* Output a "D " entry for each deleted property */
+		for (this = apr_hash_first(pool, properties); this;
+		     this = apr_hash_next(this)) {
+			/* Get this key */
+			apr_hash_this(this, &key, &keylen, NULL);
+
+			/* Output name length, then name */
+			svn_stringbuf_appendcstr(*strbuf,
+						 apr_psprintf(pool, "D %" APR_SSIZE_T_FMT "\n",
+							      keylen));
+
+			svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);
+			svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+		}
+	}
+}
+
+svn_error_t *dump_props(struct dump_edit_baton *eb,
+			svn_boolean_t *trigger_var,
+			svn_boolean_t dump_data_too,
+			apr_pool_t *pool)
+{
+	if (trigger_var && !*trigger_var)
+		return SVN_NO_ERROR;
+
+	/* Build a propstring to print */
+	svn_stringbuf_setempty(eb->propstring);
+	write_hash_to_stringbuf(eb->properties,
+				FALSE,
+				&(eb->propstring), eb->pool);
+	write_hash_to_stringbuf(eb->del_properties,
+				TRUE,
+				&(eb->propstring), eb->pool);
+	svn_stringbuf_appendbytes(eb->propstring, "PROPS-END\n", 10);
+
+	/* prop-delta header */
+	SVN_ERR(svn_stream_printf(eb->stream, pool,
+				  SVN_REPOS_DUMPFILE_PROP_DELTA
+				  ": true\n"));
+
+	/* prop-content-length header */
+	SVN_ERR(svn_stream_printf(eb->stream, pool,
+				  SVN_REPOS_DUMPFILE_PROP_CONTENT_LENGTH
+				  ": %" APR_SIZE_T_FMT "\n", eb->propstring->len));
+
+	if (dump_data_too) {
+		/* content-length header */
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+					  SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+					  ": %" APR_SIZE_T_FMT "\n\n",
+					  eb->propstring->len));
+
+		/* the properties themselves */
+		SVN_ERR(svn_stream_write(eb->stream, eb->propstring->data,
+					 &(eb->propstring->len)));
+
+		/* Cleanup so that data is never dumped twice */
+		apr_hash_clear(eb->properties);
+		apr_hash_clear(eb->del_properties);
+		if (trigger_var)
+			*trigger_var = FALSE;
+	}
+	return SVN_NO_ERROR;
+}
diff --git a/dumpr_util.h b/dumpr_util.h
index 8f494c1..4b0d5b0 100644
--- a/dumpr_util.h
+++ b/dumpr_util.h
@@ -9,6 +9,69 @@ struct replay_baton {
 struct dump_edit_baton {
 	svn_stream_t *stream;
 	svn_revnum_t current_rev;
+
+	/* pool is for per-edit-session allocations */
+	apr_pool_t *pool;
+
+	/* Store the properties that changed */
+	apr_hash_t *properties;
+	apr_hash_t *del_properties; /* Value is always 0x1 */
+	svn_stringbuf_t *propstring;
+
+	/* Was a copy command issued? */
+	svn_boolean_t is_copy;
+
+	/* Path of changed file */
+	const char *changed_path;
+
+	/* Temporary file to write delta to along with its checksum */
+	char *temp_filepath;
+	svn_checksum_t *checksum;
+
+	/* Flags to trigger dumping props and text */
+	svn_boolean_t must_dump_props;
+	svn_boolean_t must_dump_text;
+	svn_boolean_t dump_props_pending;
+};
+
+struct dir_baton {
+	struct dump_edit_baton *eb;
+	struct dir_baton *parent_dir_baton;
+
+	/* is this directory a new addition to this revision? */
+	svn_boolean_t added;
+
+	/* has this directory been written to the output stream? */
+	svn_boolean_t written_out;
+
+	/* the absolute path to this directory */
+	const char *path;
+
+	/* the comparison path and revision of this directory.  if both of
+	   these are valid, use them as a source against which to compare
+	   the directory instead of the default comparison source of PATH in
+	   the previous revision. */
+	const char *cmp_path;
+	svn_revnum_t cmp_rev;
+
+	/* hash of paths that need to be deleted, though some -might- be
+	   replaced.  maps const char * paths to this dir_baton.  (they're
+	   full paths, because that's what the editor driver gives us.  but
+	   really, they're all within this directory.) */
+	apr_hash_t *deleted_entries;
+
+	/* pool to be used for deleting the hash items */
+	apr_pool_t *pool;
 };
 
+void write_hash_to_stringbuf(apr_hash_t *properties,
+			     svn_boolean_t deleted,
+			     svn_stringbuf_t **strbuf,
+			     apr_pool_t *pool);
+
+svn_error_t *dump_props(struct dump_edit_baton *eb,
+			svn_boolean_t *trigger_var,
+			svn_boolean_t dump_data_too,
+			apr_pool_t *pool);
+
 #endif
diff --git a/svnrdump.c b/svnrdump.c
index e184fee..d7c1eea 100644
--- a/svnrdump.c
+++ b/svnrdump.c
@@ -25,6 +25,39 @@ static svn_error_t *replay_revstart(svn_revnum_t revision,
                                     apr_hash_t *rev_props,
                                     apr_pool_t *pool)
 {
+	/* Editing this revision has just started; dump the revprops
+	   before invoking the editor callbacks */
+	svn_stringbuf_t *propstring = svn_stringbuf_create("", pool);
+	svn_stream_t *stdout_stream;
+
+	/* Create an stdout stream */
+	svn_stream_for_stdout(&stdout_stream, pool);
+
+        /* Print revision number and prepare the propstring */
+	SVN_ERR(svn_stream_printf(stdout_stream, pool,
+				  SVN_REPOS_DUMPFILE_REVISION_NUMBER
+				  ": %ld\n", revision));
+	write_hash_to_stringbuf(rev_props, FALSE, &propstring, pool);
+	svn_stringbuf_appendbytes(propstring, "PROPS-END\n", 10);
+
+	/* prop-content-length header */
+	SVN_ERR(svn_stream_printf(stdout_stream, pool,
+				  SVN_REPOS_DUMPFILE_PROP_CONTENT_LENGTH
+				  ": %" APR_SIZE_T_FMT "\n", propstring->len));
+
+	/* content-length header */
+	SVN_ERR(svn_stream_printf(stdout_stream, pool,
+				  SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+				  ": %" APR_SIZE_T_FMT "\n\n", propstring->len));
+
+	/* Print the revprops now */
+	SVN_ERR(svn_stream_write(stdout_stream, propstring->data,
+				 &(propstring->len)));
+
+	svn_stream_close(stdout_stream);
+
+	/* Extract editor and editor_baton from the replay_baton and
+	   set them so that the editor callbacks can use them */
 	struct replay_baton *rb = replay_baton;
 	*editor = rb->editor;
 	*edit_baton = rb->edit_baton;
@@ -39,6 +72,9 @@ static svn_error_t *replay_revend(svn_revnum_t revision,
                                   apr_hash_t *rev_props,
                                   apr_pool_t *pool)
 {
+	/* Editor has finished for this revision and close_edit has
+	   been called; do nothing: just continue to the next
+	   revision */
 	return SVN_NO_ERROR;
 }
 
@@ -73,8 +109,8 @@ static svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_r
 	                                    dump_baton, pool));
 
 	struct replay_baton *replay_baton = apr_palloc(pool, sizeof(struct replay_baton));
-	replay_baton->editor = debug_editor;
-	replay_baton->edit_baton = debug_baton;
+	replay_baton->editor = dump_editor;
+	replay_baton->edit_baton = dump_baton;
 	SVN_ERR(svn_cmdline_printf(pool, SVN_REPOS_DUMPFILE_MAGIC_HEADER ": %d\n",
 				   SVN_REPOS_DUMPFILE_FORMAT_VERSION));
 	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
-- 
1.7.1
