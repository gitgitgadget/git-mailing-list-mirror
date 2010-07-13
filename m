From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/9] Add debug editor from Subversion trunk
Date: Wed, 14 Jul 2010 01:36:10 +0200
Message-ID: <1279064176-6645-4-git-send-email-artagnon@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 14 01:36:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYp1r-0008BW-8R
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155Ab0GMXga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:36:30 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39996 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab0GMXgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:36:25 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1272362ewy.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5H82URPRDojvm+HUg1UTOUhE/Bu6txWKHEBfrNT/B/o=;
        b=qUGV4+9Q2ElxROgrKsRO5UrT6b1Rxs6kNFHA6tDucU/5DszRrxx/hv8IZCTryM3EIW
         2EaNcfwd06+ROymm/o8y0LcS00FEKKARVhJO51wUEmwT6rPGoVflIp4s2qm6fY5jxN6S
         wjcbGuCskA8gtrezRz4ZTEPgIOjst5gitWC10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Sr4xnSG1pR8EbA6A7T2UMDYuE5Nyehrk9ZJmXygPeHJ0gb0IGO9nSilRfrwYl/WG7D
         Zw6Yg88NDpgV/FZscmg73rKosfZA+8tFhh5HrFTTjhRTLBPF0I7Vao543Vdsgfth3fUV
         HB80LCThsV8tejWPFdhhwuplG/8tr2lvPECwM=
Received: by 10.213.105.207 with SMTP id u15mr491535ebo.94.1279064184224;
        Tue, 13 Jul 2010 16:36:24 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id z55sm51459179eeh.15.2010.07.13.16.36.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:36:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150946>

Add the debug editor from subversion/libsvn_delta/debug_editor.c along
with a header to expose the svn_delta__get_debug_editor function. It
is used for wrapping other editors, and prints the operations it does
to stderr making debugging easier.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile       |    8 +-
 debug_editor.c |  421 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 debug_editor.h |   10 ++
 dump_editor.c  |  144 +++++++++++++++++++
 dump_editor.h  |    8 +
 dumpr_util.h   |    9 ++
 6 files changed, 596 insertions(+), 4 deletions(-)
 create mode 100644 debug_editor.c
 create mode 100644 debug_editor.h
 create mode 100644 dump_editor.c
 create mode 100644 dump_editor.h
 create mode 100644 dumpr_util.h

diff --git a/Makefile b/Makefile
index 55f28e5..3561909 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
-svnrdump: *.c
-	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svnrdump.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
+svnrdump: *.c *.h
+	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svnrdump.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
 
-svnrdump_bench: *.c
-	$(CC) -O2 -o $@ svnrdump.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
+svnrdump_bench: *.c *.h
+	$(CC) -O2 -o $@ svnrdump.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
 
 clean:
 	$(RM) svnrdump svnrdump_bench
diff --git a/debug_editor.c b/debug_editor.c
new file mode 100644
index 0000000..9271c7a
--- /dev/null
+++ b/debug_editor.c
@@ -0,0 +1,421 @@
+/*
+ * debug_editor.c :  An editor that writes the operations it does to stderr.
+ *
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
+
+#include "debug_editor.h"
+
+struct edit_baton
+{
+	const svn_delta_editor_t *wrapped_editor;
+	void *wrapped_edit_baton;
+
+	int indent_level;
+
+	svn_stream_t *out;
+};
+
+struct dir_baton
+{
+	void *edit_baton;
+	void *wrapped_dir_baton;
+};
+
+struct file_baton
+{
+	void *edit_baton;
+	void *wrapped_file_baton;
+};
+
+static svn_error_t *write_indent(struct edit_baton *eb, apr_pool_t *pool)
+{
+	int i;
+
+	for (i = 0; i < eb->indent_level; ++i)
+		SVN_ERR(svn_stream_printf(eb->out, pool, " "));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *set_target_revision(void *edit_baton,
+					svn_revnum_t target_revision,
+					apr_pool_t *pool)
+{
+	struct edit_baton *eb = edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "set_target_revision : %ld\n",
+				  target_revision));
+
+	return eb->wrapped_editor->set_target_revision(eb->wrapped_edit_baton,
+						       target_revision,
+						       pool);
+}
+
+static svn_error_t *open_root(void *edit_baton,
+			      svn_revnum_t base_revision,
+			      apr_pool_t *pool,
+			      void **root_baton)
+{
+	struct edit_baton *eb = edit_baton;
+	struct dir_baton *dir_baton = apr_palloc(pool, sizeof(*dir_baton));
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "open_root : %ld\n",
+				  base_revision));
+	eb->indent_level++;
+
+	SVN_ERR(eb->wrapped_editor->open_root(eb->wrapped_edit_baton,
+					      base_revision,
+					      pool,
+					      &dir_baton->wrapped_dir_baton));
+
+	dir_baton->edit_baton = edit_baton;
+
+	*root_baton = dir_baton;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *delete_entry(const char *path,
+				 svn_revnum_t base_revision,
+				 void *parent_baton,
+				 apr_pool_t *pool)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "delete_entry : %s:%ld\n",
+				  path, base_revision));
+
+	return eb->wrapped_editor->delete_entry(path,
+						base_revision,
+						pb->wrapped_dir_baton,
+						pool);
+}
+
+static svn_error_t *add_directory(const char *path,
+				  void *parent_baton,
+				  const char *copyfrom_path,
+				  svn_revnum_t copyfrom_revision,
+				  apr_pool_t *pool,
+				  void **child_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	struct dir_baton *b = apr_palloc(pool, sizeof(*b));
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool,
+				  "add_directory : '%s' [from '%s':%ld]\n",
+				  path, copyfrom_path, copyfrom_revision));
+	eb->indent_level++;
+
+	SVN_ERR(eb->wrapped_editor->add_directory(path,
+						  pb->wrapped_dir_baton,
+						  copyfrom_path,
+						  copyfrom_revision,
+						  pool,
+						  &b->wrapped_dir_baton));
+
+	b->edit_baton = eb;
+	*child_baton = b;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *open_directory(const char *path,
+				   void *parent_baton,
+				   svn_revnum_t base_revision,
+				   apr_pool_t *pool,
+				   void **child_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	struct dir_baton *db = apr_palloc(pool, sizeof(*db));
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "open_directory : '%s':%ld\n",
+				  path, base_revision));
+	eb->indent_level++;
+
+	SVN_ERR(eb->wrapped_editor->open_directory(path,
+						   pb->wrapped_dir_baton,
+						   base_revision,
+						   pool,
+						   &db->wrapped_dir_baton));
+
+	db->edit_baton = eb;
+	*child_baton = db;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *add_file(const char *path,
+			     void *parent_baton,
+			     const char *copyfrom_path,
+			     svn_revnum_t copyfrom_revision,
+			     apr_pool_t *pool,
+			     void **file_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	struct file_baton *fb = apr_palloc(pool, sizeof(*fb));
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool,
+				  "add_file : '%s' [from '%s':%ld]\n",
+				  path, copyfrom_path, copyfrom_revision));
+
+	eb->indent_level++;
+
+	SVN_ERR(eb->wrapped_editor->add_file(path,
+					     pb->wrapped_dir_baton,
+					     copyfrom_path,
+					     copyfrom_revision,
+					     pool,
+					     &fb->wrapped_file_baton));
+
+	fb->edit_baton = eb;
+	*file_baton = fb;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *open_file(const char *path,
+			      void *parent_baton,
+			      svn_revnum_t base_revision,
+			      apr_pool_t *pool,
+			      void **file_baton)
+{
+	struct dir_baton *pb = parent_baton;
+	struct edit_baton *eb = pb->edit_baton;
+	struct file_baton *fb = apr_palloc(pool, sizeof(*fb));
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "open_file : '%s':%ld\n",
+				  path, base_revision));
+
+	eb->indent_level++;
+
+	SVN_ERR(eb->wrapped_editor->open_file(path,
+					      pb->wrapped_dir_baton,
+					      base_revision,
+					      pool,
+					      &fb->wrapped_file_baton));
+
+	fb->edit_baton = eb;
+	*file_baton = fb;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *apply_textdelta(void *file_baton,
+				    const char *base_checksum,
+				    apr_pool_t *pool,
+				    svn_txdelta_window_handler_t *handler,
+				    void **handler_baton)
+{
+	struct file_baton *fb = file_baton;
+	struct edit_baton *eb = fb->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "apply_textdelta : %s\n",
+				  base_checksum));
+
+	SVN_ERR(eb->wrapped_editor->apply_textdelta(fb->wrapped_file_baton,
+						    base_checksum,
+						    pool,
+						    handler,
+						    handler_baton));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *close_file(void *file_baton,
+			       const char *text_checksum,
+			       apr_pool_t *pool)
+{
+	struct file_baton *fb = file_baton;
+	struct edit_baton *eb = fb->edit_baton;
+
+	eb->indent_level--;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "close_file : %s\n",
+				  text_checksum));
+
+	SVN_ERR(eb->wrapped_editor->close_file(fb->wrapped_file_baton,
+					       text_checksum, pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *absent_file(const char *path,
+				void *file_baton,
+				apr_pool_t *pool)
+{
+	struct file_baton *fb = file_baton;
+	struct edit_baton *eb = fb->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "absent_file : %s\n", path));
+
+	SVN_ERR(eb->wrapped_editor->absent_file(path, fb->wrapped_file_baton,
+						pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *close_directory(void *dir_baton,
+				    apr_pool_t *pool)
+{
+	struct dir_baton *db = dir_baton;
+	struct edit_baton *eb = db->edit_baton;
+
+	eb->indent_level--;
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "close_directory\n"));
+
+	SVN_ERR(eb->wrapped_editor->close_directory(db->wrapped_dir_baton,
+						    pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *absent_directory(const char *path,
+				     void *dir_baton,
+				     apr_pool_t *pool)
+{
+	struct dir_baton *db = dir_baton;
+	struct edit_baton *eb = db->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "absent_directory : %s\n",
+				  path));
+
+	SVN_ERR(eb->wrapped_editor->absent_directory(path, db->wrapped_dir_baton,
+						     pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *change_file_prop(void *file_baton,
+				     const char *name,
+				     const svn_string_t *value,
+				     apr_pool_t *pool)
+{
+	struct file_baton *fb = file_baton;
+	struct edit_baton *eb = fb->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "change_file_prop : %s\n",
+				  name));
+
+	SVN_ERR(eb->wrapped_editor->change_file_prop(fb->wrapped_file_baton,
+						     name,
+						     value,
+						     pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *change_dir_prop(void *dir_baton,
+				    const char *name,
+				    const svn_string_t *value,
+				    apr_pool_t *pool)
+{
+	struct dir_baton *db = dir_baton;
+	struct edit_baton *eb = db->edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "change_dir_prop : %s\n", name));
+
+	SVN_ERR(eb->wrapped_editor->change_dir_prop(db->wrapped_dir_baton,
+						    name,
+						    value,
+						    pool));
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *close_edit(void *edit_baton,
+			       apr_pool_t *pool)
+{
+	struct edit_baton *eb = edit_baton;
+
+	SVN_ERR(write_indent(eb, pool));
+	SVN_ERR(svn_stream_printf(eb->out, pool, "close_edit\n"));
+
+	SVN_ERR(eb->wrapped_editor->close_edit(eb->wrapped_edit_baton, pool));
+
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *svn_delta__get_debug_editor(const svn_delta_editor_t **editor,
+					 void **edit_baton,
+					 const svn_delta_editor_t *wrapped_editor,
+					 void *wrapped_edit_baton,
+					 apr_pool_t *pool)
+{
+	svn_delta_editor_t *tree_editor = svn_delta_default_editor(pool);
+	struct edit_baton *eb = apr_palloc(pool, sizeof(*eb));
+	apr_file_t *errfp;
+	svn_stream_t *out;
+
+	apr_status_t apr_err = apr_file_open_stderr(&errfp, pool);
+	if (apr_err)
+		return svn_error_wrap_apr(apr_err, "Problem opening stderr");
+
+	out = svn_stream_from_aprfile2(errfp, TRUE, pool);
+
+	tree_editor->set_target_revision = set_target_revision;
+	tree_editor->open_root = open_root;
+	tree_editor->delete_entry = delete_entry;
+	tree_editor->add_directory = add_directory;
+	tree_editor->open_directory = open_directory;
+	tree_editor->change_dir_prop = change_dir_prop;
+	tree_editor->close_directory = close_directory;
+	tree_editor->absent_directory = absent_directory;
+	tree_editor->add_file = add_file;
+	tree_editor->open_file = open_file;
+	tree_editor->apply_textdelta = apply_textdelta;
+	tree_editor->change_file_prop = change_file_prop;
+	tree_editor->close_file = close_file;
+	tree_editor->absent_file = absent_file;
+	tree_editor->close_edit = close_edit;
+
+	eb->wrapped_editor = wrapped_editor;
+	eb->wrapped_edit_baton = wrapped_edit_baton;
+	eb->out = out;
+	eb->indent_level = 0;
+
+	*editor = tree_editor;
+	*edit_baton = eb;
+
+	return SVN_NO_ERROR;
+}
diff --git a/debug_editor.h b/debug_editor.h
new file mode 100644
index 0000000..a0d412a
--- /dev/null
+++ b/debug_editor.h
@@ -0,0 +1,10 @@
+#ifndef DEBUG_EDITOR_H_
+#define DEBUG_EDITOR_H_
+
+svn_error_t *svn_delta__get_debug_editor(const svn_delta_editor_t **editor,
+					 void **edit_baton,
+					 const svn_delta_editor_t *wrapped_editor,
+					 void *wrapped_edit_baton,
+					 apr_pool_t *pool);
+
+#endif
diff --git a/dump_editor.c b/dump_editor.c
new file mode 100644
index 0000000..2db3f7e
--- /dev/null
+++ b/dump_editor.c
@@ -0,0 +1,144 @@
+/* Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "svn_pools.h"
+#include "svn_repos.h"
+#include "svn_path.h"
+#include "svn_props.h"
+#include "svn_dirent_uri.h"
+
+#include "dumpr_util.h"
+
+static svn_error_t *open_root(void *edit_baton,
+			      svn_revnum_t base_revision,
+			      apr_pool_t *pool,
+			      void **root_baton)
+{
+	*root_baton = NULL;
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *delete_entry(const char *path,
+				 svn_revnum_t revision,
+				 void *parent_baton,
+				 apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *add_directory(const char *path,
+				  void *parent_baton,
+				  const char *copyfrom_path,
+				  svn_revnum_t copyfrom_rev,
+				  apr_pool_t *pool,
+				  void **child_baton)
+{
+	*child_baton = NULL;
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *open_directory(const char *path,
+				   void *parent_baton,
+				   svn_revnum_t base_revision,
+				   apr_pool_t *pool,
+				   void **child_baton)
+{
+	*child_baton = NULL;
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *close_directory(void *dir_baton,
+				    apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *add_file(const char *path,
+			     void *parent_baton,
+			     const char *copyfrom_path,
+			     svn_revnum_t copyfrom_rev,
+			     apr_pool_t *pool,
+			     void **file_baton)
+{
+	*file_baton = NULL;
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *open_file(const char *path,
+			      void *parent_baton,
+			      svn_revnum_t ancestor_revision,
+			      apr_pool_t *pool,
+			      void **file_baton)
+{
+	*file_baton = NULL;
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *change_dir_prop(void *parent_baton,
+				    const char *name,
+				    const svn_string_t *value,
+				    apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *change_file_prop(void *file_baton,
+				     const char *name,
+				     const svn_string_t *value,
+				     apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *apply_textdelta(void *file_baton, const char *base_checksum,
+				    apr_pool_t *pool,
+				    svn_txdelta_window_handler_t *handler,
+				    void **handler_baton)
+{
+	*handler = svn_delta_noop_window_handler;
+	*handler_baton = NULL;
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *close_file(void *file_baton,
+			       const char *text_checksum,
+			       apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *close_edit(void *edit_baton, apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
+                             void **edit_baton,
+                             svn_revnum_t from_rev,
+                             apr_pool_t *pool)
+{
+	struct dump_edit_baton *eb = apr_pcalloc(pool, sizeof(struct dump_edit_baton));
+	eb->current_rev = from_rev;
+	SVN_ERR(svn_stream_for_stdout(&(eb->stream), pool));
+	svn_delta_editor_t *de = svn_delta_default_editor(pool);
+	
+	de->open_root = open_root;
+	de->delete_entry = delete_entry;
+	de->add_directory = add_directory;
+	de->open_directory = open_directory;
+	de->close_directory = close_directory;
+	de->change_dir_prop = change_dir_prop;
+	de->change_file_prop = change_file_prop;
+	de->apply_textdelta = apply_textdelta;
+	de->add_file = add_file;
+	de->open_file = open_file;
+	de->close_file = close_file;
+	de->close_edit = close_edit;
+
+	/* Set the edit_baton and editor */
+	*edit_baton = eb;
+	*editor = de;
+
+	return SVN_NO_ERROR;
+}
diff --git a/dump_editor.h b/dump_editor.h
new file mode 100644
index 0000000..9c70b74
--- /dev/null
+++ b/dump_editor.h
@@ -0,0 +1,8 @@
+#ifndef DUMP_EDITOR_H_
+#define DUMP_EDITOR_H_
+
+svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
+			     void **edit_baton,
+			     svn_revnum_t to_rev,
+			     apr_pool_t *pool);
+#endif
diff --git a/dumpr_util.h b/dumpr_util.h
new file mode 100644
index 0000000..199c9c4
--- /dev/null
+++ b/dumpr_util.h
@@ -0,0 +1,9 @@
+#ifndef DUMPR_UTIL_H_
+#define DUMPR_UTIL_H_
+
+struct dump_edit_baton {
+	svn_stream_t *stream;
+	svn_revnum_t current_rev;
+};
+
+#endif
-- 
1.7.1
