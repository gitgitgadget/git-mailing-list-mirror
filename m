From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH 2/2] Add stripped dump editor
Date: Fri, 18 Jun 2010 20:42:11 +0200
Message-ID: <1276886531-19037-3-git-send-email-artagnon@gmail.com>
References: <1276886531-19037-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 18 20:43:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPgX1-0007NE-Q0
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 20:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab0FRSm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 14:42:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46512 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab0FRSm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 14:42:57 -0400
Received: by mail-wy0-f174.google.com with SMTP id 33so855525wyb.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QZ2Lwe3UUx062A5Zh/zE4EoEv4Ars3+MVJkRxzTT35M=;
        b=vyDtcrjz/LplrODcIgXJz3aQ8gYYHNouamrdI5UW4s8gXieFrGWzpn8lTb+U3wt1pL
         zE6zyCIBTfvRVHhYTCLGFwqMnQcMdTgJEtkOEzp4AlUuDuaGutz8npkskh8EfwbCdYx3
         tmRPXzO6CrlvOXK1AauP7TSZF4CSfw7rrVj2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GDipcRoA7whV+zhvo6lGVHdVA7Yd6zCmjYygLVk0bwhNuOk8F9W+BX283LZLAbfBWP
         EzTbQVhyn2iO0NbZq1dioxW1jauplEYAJhLDDcIuR3aKRqSpCB+2xP/MbX4dcdrzNpcT
         eJ28kiKb3xcAL3D+vLnToLAKSQiEZO5JaSqLc=
Received: by 10.227.147.193 with SMTP id m1mr1408036wbv.23.1276886576926;
        Fri, 18 Jun 2010 11:42:56 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id p17sm1645561wbe.20.2010.06.18.11.42.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 11:42:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1276886531-19037-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149358>

Replace the default editor with a dump editor from libsvn_repos/dump.c
after stripping off filesystem dependencies. Currently, the dump
editor does nothing, but will dump some revision information to stdout
in future.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile       |    2 +-
 dump_editor.c  |  365 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dump_editor.h  |   10 ++
 svnclient_ra.c |   19 ++-
 4 files changed, 389 insertions(+), 7 deletions(-)
 create mode 100644 dump_editor.c
 create mode 100644 dump_editor.h

diff --git a/Makefile b/Makefile
index c3c695c..269c406 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,4 @@
 svnclient_ra: *.c *.h
-	$(CC) -Wall -Werror -ggdb3 -O0 -o $@ svnclient_ra.c debug_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
+	$(CC) -Wall -ggdb3 -O0 -o $@ svnclient_ra.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
 clean:
 	$(RM) svnclient_ra
diff --git a/dump_editor.c b/dump_editor.c
new file mode 100644
index 0000000..f5353b0
--- /dev/null
+++ b/dump_editor.c
@@ -0,0 +1,365 @@
+#include "svn_pools.h"
+#include "svn_error.h"
+#include "svn_iter.h"
+#include "svn_repos.h"
+#include "svn_string.h"
+#include "svn_dirent_uri.h"
+#include "svn_path.h"
+#include "svn_time.h"
+#include "svn_checksum.h"
+#include "svn_props.h"
+
+#define ARE_VALID_COPY_ARGS(p,r) ((p) && SVN_IS_VALID_REVNUM(r))
+/*----------------------------------------------------------------------*/
+/** An editor which dumps node-data in 'dumpfile format' to a file. **/
+
+/* Look, mom!  No file batons! */
+
+struct edit_baton
+{
+	/* The stream to dump to: stdout */
+	svn_stream_t *stream;
+	
+	svn_revnum_t current_rev;
+	
+	/* reusable buffer for writing file contents */
+	char buffer[SVN__STREAM_CHUNK_SIZE];
+	apr_size_t bufsize;
+};
+
+struct dir_baton
+{
+	struct edit_baton *edit_baton;
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
+};
+
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
+struct dir_baton *
+make_dir_baton(const char *path,
+               const char *cmp_path,
+               svn_revnum_t cmp_rev,
+               void *edit_baton,
+               void *parent_dir_baton,
+               svn_boolean_t added,
+               apr_pool_t *pool)
+{
+	struct edit_baton *eb = edit_baton;
+	struct dir_baton *pb = parent_dir_baton;
+	struct dir_baton *new_db = apr_pcalloc(pool, sizeof(*new_db));
+	const char *full_path;
+
+	/* A path relative to nothing?  I don't think so. */
+	SVN_ERR_ASSERT_NO_RETURN(!path || pb);
+
+	/* Construct the full path of this node. */
+	if (pb)
+		full_path = svn_path_join("/", path, pool);
+	else
+		full_path = apr_pstrdup(pool, "/");
+
+	/* Remove leading slashes from copyfrom paths. */
+	if (cmp_path)
+		cmp_path = ((*cmp_path == '/') ? cmp_path + 1 : cmp_path);
+
+	new_db->edit_baton = eb;
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
+
+svn_error_t *
+open_root(void *edit_baton,
+          svn_revnum_t base_revision,
+          apr_pool_t *pool,
+          void **root_baton)
+{
+	*root_baton = make_dir_baton(NULL, NULL, SVN_INVALID_REVNUM,
+	                             edit_baton, NULL, FALSE, pool);
+	return SVN_NO_ERROR;
+}
+
+
+svn_error_t *
+delete_entry(const char *path,
+             svn_revnum_t revision,
+             void *parent_baton,
+             apr_pool_t *pool)
+{
+	struct dir_baton *pb = parent_baton;
+	const char *mypath = apr_pstrdup(pb->pool, path);
+
+	/* remember this path needs to be deleted. */
+	apr_hash_set(pb->deleted_entries, mypath, APR_HASH_KEY_STRING, pb);
+
+	return SVN_NO_ERROR;
+}
+
+
+svn_error_t *
+add_directory(const char *path,
+              void *parent_baton,
+              const char *copyfrom_path,
+              svn_revnum_t copyfrom_rev,
+              apr_pool_t *pool,
+              void **child_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	void *val;
+	svn_boolean_t is_copy = FALSE;
+	struct dir_baton *new_db
+		= make_dir_baton(path, copyfrom_path, copyfrom_rev, eb, pb, TRUE, pool);
+
+	/* This might be a replacement -- is the path already deleted? */
+	val = apr_hash_get(pb->deleted_entries, path, APR_HASH_KEY_STRING);
+
+	/* Detect an add-with-history. */
+	is_copy = ARE_VALID_COPY_ARGS(copyfrom_path, copyfrom_rev);
+
+	/* Dump the node. */
+	/* SVN_ERR(dump_node(eb, path, */
+	/*                   svn_node_dir, */
+	/*                   val ? svn_node_action_replace : svn_node_action_add, */
+	/*                   is_copy, */
+	/*                   is_copy ? copyfrom_path : NULL, */
+	/*                   is_copy ? copyfrom_rev : SVN_INVALID_REVNUM, */
+	/*                   pool)); */
+
+	if (val)
+		/* Delete the path, it's now been dumped. */
+		apr_hash_set(pb->deleted_entries, path, APR_HASH_KEY_STRING, NULL);
+
+	new_db->written_out = TRUE;
+
+	*child_baton = new_db;
+	return SVN_NO_ERROR;
+}
+
+
+svn_error_t *
+open_directory(const char *path,
+               void *parent_baton,
+               svn_revnum_t base_revision,
+               apr_pool_t *pool,
+               void **child_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	struct dir_baton *new_db;
+	const char *cmp_path = NULL;
+	svn_revnum_t cmp_rev = SVN_INVALID_REVNUM;
+
+	/* If the parent directory has explicit comparison path and rev,
+	   record the same for this one. */
+	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev))
+	{
+		cmp_path = svn_path_join(pb->cmp_path,
+		                         svn_dirent_basename(path, pool), pool);
+		cmp_rev = pb->cmp_rev;
+	}
+
+	new_db = make_dir_baton(path, cmp_path, cmp_rev, eb, pb, FALSE, pool);
+	*child_baton = new_db;
+	return SVN_NO_ERROR;
+}
+
+
+svn_error_t *
+close_directory(void *dir_baton,
+                apr_pool_t *pool)
+{
+	struct dir_baton *db = dir_baton;
+	struct edit_baton *eb = db->edit_baton;
+	apr_hash_index_t *hi;
+	apr_pool_t *subpool = svn_pool_create(pool);
+
+	for (hi = apr_hash_first(pool, db->deleted_entries);
+	     hi;
+	     hi = apr_hash_next(hi))
+	{
+		const void *key;
+		const char *path;
+		apr_hash_this(hi, &key, NULL, NULL);
+		path = key;
+
+		svn_pool_clear(subpool);
+
+		/* By sending 'svn_node_unknown', the Node-kind: header simply won't
+		   be written out.  No big deal at all, really.  The loader
+		   shouldn't care.  */
+		/* SVN_ERR(dump_node(eb, path, */
+		/*                   svn_node_unknown, svn_node_action_delete, */
+		/*                   FALSE, NULL, SVN_INVALID_REVNUM, subpool)); */
+	}
+
+	svn_pool_destroy(subpool);
+	return SVN_NO_ERROR;
+}
+
+
+svn_error_t *
+add_file(const char *path,
+         void *parent_baton,
+         const char *copyfrom_path,
+         svn_revnum_t copyfrom_rev,
+         apr_pool_t *pool,
+         void **file_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	void *val;
+	svn_boolean_t is_copy = FALSE;
+
+	/* This might be a replacement -- is the path already deleted? */
+	val = apr_hash_get(pb->deleted_entries, path, APR_HASH_KEY_STRING);
+
+	/* Detect add-with-history. */
+	is_copy = ARE_VALID_COPY_ARGS(copyfrom_path, copyfrom_rev);
+
+	/* Dump the node. */
+	/* SVN_ERR(dump_node(eb, path, */
+	/*                   svn_node_file, */
+	/*                   val ? svn_node_action_replace : svn_node_action_add, */
+	/*                   is_copy, */
+	/*                   is_copy ? copyfrom_path : NULL, */
+	/*                   is_copy ? copyfrom_rev : SVN_INVALID_REVNUM, */
+	/*                   pool)); */
+
+	if (val)
+		/* delete the path, it's now been dumped. */
+		apr_hash_set(pb->deleted_entries, path, APR_HASH_KEY_STRING, NULL);
+
+	*file_baton = NULL;  /* muhahahaha */
+	return SVN_NO_ERROR;
+}
+
+
+svn_error_t *
+open_file(const char *path,
+          void *parent_baton,
+          svn_revnum_t ancestor_revision,
+          apr_pool_t *pool,
+          void **file_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	const char *cmp_path = NULL;
+	svn_revnum_t cmp_rev = SVN_INVALID_REVNUM;
+
+	/* If the parent directory has explicit comparison path and rev,
+	   record the same for this one. */
+	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev))
+	{
+		cmp_path = svn_path_join(pb->cmp_path,
+		                         svn_dirent_basename(path, pool), pool);
+		cmp_rev = pb->cmp_rev;
+	}
+
+	/* SVN_ERR(dump_node(eb, path, */
+	/*                   svn_node_file, svn_node_action_change, */
+	/*                   FALSE, cmp_path, cmp_rev, pool)); */
+
+	*file_baton = NULL;  /* muhahahaha again */
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *
+change_dir_prop(void *parent_baton,
+                const char *name,
+                const svn_string_t *value,
+                apr_pool_t *pool)
+{
+	struct dir_baton *db = parent_baton;
+	struct edit_baton *eb = db->edit_baton;
+
+	/* This function is what distinguishes between a directory that is
+	   opened to merely get somewhere, vs. one that is opened because it
+	   *actually* changed by itself.  */
+	if (! db->written_out)
+	{
+		/* SVN_ERR(dump_node(eb, db->path, */
+		/*                   svn_node_dir, svn_node_action_change, */
+		/*                   FALSE, db->cmp_path, db->cmp_rev, pool)); */
+		db->written_out = TRUE;
+	}
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *
+get_dump_editor(const svn_delta_editor_t **editor,
+                void **edit_baton,
+                svn_revnum_t to_rev,
+                apr_pool_t *pool)
+{
+	/* Allocate an edit baton to be stored in every directory baton.
+	   Set it up for the directory baton we create here, which is the
+	   root baton. */
+	struct edit_baton *eb = apr_pcalloc(pool, sizeof(*eb));
+	svn_delta_editor_t *dump_editor = svn_delta_default_editor(pool);
+
+	/* Set up the edit baton. */
+	svn_stream_for_stdout(&(eb->stream), pool);
+	eb->bufsize = sizeof(eb->buffer);
+	eb->current_rev = to_rev;
+
+
+	/* Set up the editor. */
+	dump_editor->open_root = open_root;
+	dump_editor->delete_entry = delete_entry;
+	dump_editor->add_directory = add_directory;
+	dump_editor->open_directory = open_directory;
+	dump_editor->close_directory = close_directory;
+	dump_editor->change_dir_prop = change_dir_prop;
+	dump_editor->add_file = add_file;
+	dump_editor->open_file = open_file;
+
+	*edit_baton = eb;
+	*editor = dump_editor;
+
+	return SVN_NO_ERROR;
+}
diff --git a/dump_editor.h b/dump_editor.h
new file mode 100644
index 0000000..5e84223
--- /dev/null
+++ b/dump_editor.h
@@ -0,0 +1,10 @@
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+
+svn_error_t *
+get_dump_editor(const svn_delta_editor_t **editor,
+                void **edit_baton,
+                svn_revnum_t to_rev,
+                apr_pool_t *pool);
diff --git a/svnclient_ra.c b/svnclient_ra.c
index 2ed04af..24d99cb 100644
--- a/svnclient_ra.c
+++ b/svnclient_ra.c
@@ -4,6 +4,7 @@
 #include "svn_ra.h"
 
 #include "debug_editor.h"
+#include "dump_editor.h"
 
 static apr_pool_t *pool = NULL;
 static svn_client_ctx_t *ctx = NULL;
@@ -92,16 +93,22 @@ svn_error_t *open_connection(const char *url)
 
 svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
 {
+	svn_delta_editor_t *dump_editor, *debug_editor;
+	void *debug_baton, *dump_baton;
+	
 	svn_revnum_t latest_revision;
-	svn_delta_editor_t *editor, *debug_editor;
-	replay_baton_t *replay_baton = apr_palloc(pool, sizeof(replay_baton_t));
-	void *debug_baton;
 	SVN_ERR(svn_ra_get_latest_revnum(session, &latest_revision, pool));
 	printf("%ld\n", latest_revision);
-	editor = svn_delta_default_editor(pool);
+	
+	SVN_ERR(get_dump_editor((const svn_delta_editor_t **)&dump_editor,
+	                        &dump_baton, end_revision, pool));
+
 	SVN_ERR(svn_delta__get_debug_editor((const svn_delta_editor_t **)&debug_editor,
-	                                    &debug_baton, editor,
-	                                    NULL, pool));
+	                                    &debug_baton,
+	                                    (const svn_delta_editor_t *)dump_editor,
+	                                    dump_baton, pool));
+	
+	replay_baton_t *replay_baton = apr_palloc(pool, sizeof(replay_baton_t));
 	replay_baton->editor = debug_editor;
 	replay_baton->baton = debug_baton;
 	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
-- 
1.7.1
