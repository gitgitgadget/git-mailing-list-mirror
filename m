From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH 1/2] Add skeleton RA svnclient
Date: Fri, 18 Jun 2010 20:42:10 +0200
Message-ID: <1276886531-19037-2-git-send-email-artagnon@gmail.com>
References: <1276886531-19037-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 18 20:43:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPgX0-0007NE-JH
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 20:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab0FRSm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 14:42:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46512 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab0FRSmy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 14:42:54 -0400
Received: by wyb33 with SMTP id 33so855525wyb.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jnQN2sTqboUU84tkLtouzFj5BeszKpBF1AIlc7GHyu4=;
        b=QP8ADJKlEwXZRsa0uzhfV6IzwpcT/di0JirZA3RcdRkp2sy3LNisLXxWKTZPA6G6E5
         8/20pGxnbVm1T/6/K8+7gl/JXX1vA1co3hHahDnSg5ZkECrnjmkylETuoD41UWsUhHql
         DhVDtffMBYh7oSiKXw4hamLZAFs4FEHNpfL6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VwRrgQKJcLLpUlS58jkR1TYCJ1a4T4HNiNk+qqfzlfF71hcqDc8tQKB/6kmmc2J8gS
         rgfjGQWlBVgx9RylN8AUzwXq7UyfWz8OexrPVsLwGcvv4QypsR5+xgS5AmYoRmxjHDlb
         xbnhqf2JCsuxaucLorEJtChlf8d78o/escyAU=
Received: by 10.227.152.196 with SMTP id h4mr1423876wbw.61.1276886572832;
        Fri, 18 Jun 2010 11:42:52 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id u36sm2415318wbv.0.2010.06.18.11.42.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 11:42:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1276886531-19037-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149359>

The SVN client uses the RA API to connect to a remote server and
replay revisions. Currently, it wraps a debug editor to print out some
tree information. In future, it will dump the data in every revision
to stdout in dumpfile format (hopefully) without resorting to the FS
API.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile       |    4 +
 debug_editor.c |  413 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 debug_editor.h |    6 +
 svnclient_ra.c |  131 ++++++++++++++++++
 4 files changed, 554 insertions(+), 0 deletions(-)
 create mode 100644 Makefile
 create mode 100644 debug_editor.c
 create mode 100644 debug_editor.h
 create mode 100644 svnclient_ra.c

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..c3c695c
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,4 @@
+svnclient_ra: *.c *.h
+	$(CC) -Wall -Werror -ggdb3 -O0 -o $@ svnclient_ra.c debug_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
+clean:
+	$(RM) svnclient_ra
diff --git a/debug_editor.c b/debug_editor.c
new file mode 100644
index 0000000..ef77e44
--- /dev/null
+++ b/debug_editor.c
@@ -0,0 +1,413 @@
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+
+struct edit_baton
+{
+  const svn_delta_editor_t *wrapped_editor;
+  void *wrapped_edit_baton;
+
+  int indent_level;
+
+  svn_stream_t *out;
+};
+
+struct dir_baton
+{
+  void *edit_baton;
+  void *wrapped_dir_baton;
+};
+
+struct file_baton
+{
+  void *edit_baton;
+  void *wrapped_file_baton;
+};
+
+static svn_error_t *
+write_indent(struct edit_baton *eb, apr_pool_t *pool)
+{
+  int i;
+
+  for (i = 0; i < eb->indent_level; ++i)
+    SVN_ERR(svn_stream_printf(eb->out, pool, " "));
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+set_target_revision(void *edit_baton,
+                    svn_revnum_t target_revision,
+                    apr_pool_t *pool)
+{
+  struct edit_baton *eb = edit_baton;
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "set_target_revision : %ld\n",
+                            target_revision));
+
+  return eb->wrapped_editor->set_target_revision(eb->wrapped_edit_baton,
+                                                 target_revision,
+                                                 pool);
+}
+
+static svn_error_t *
+open_root(void *edit_baton,
+          svn_revnum_t base_revision,
+          apr_pool_t *pool,
+          void **root_baton)
+{
+  struct edit_baton *eb = edit_baton;
+  struct dir_baton *dir_baton = apr_palloc(pool, sizeof(*dir_baton));
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "open_root : %ld\n",
+                            base_revision));
+  eb->indent_level++;
+
+  SVN_ERR(eb->wrapped_editor->open_root(eb->wrapped_edit_baton,
+                                        base_revision,
+                                        pool,
+                                        &dir_baton->wrapped_dir_baton));
+
+  dir_baton->edit_baton = edit_baton;
+
+  *root_baton = dir_baton;
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+delete_entry(const char *path,
+             svn_revnum_t base_revision,
+             void *parent_baton,
+             apr_pool_t *pool)
+{
+  struct dir_baton *pb = parent_baton;
+  struct edit_baton *eb = pb->edit_baton;
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "delete_entry : %s:%ld\n",
+                            path, base_revision));
+
+  return eb->wrapped_editor->delete_entry(path,
+                                          base_revision,
+                                          pb->wrapped_dir_baton,
+                                          pool);
+}
+
+static svn_error_t *
+add_directory(const char *path,
+              void *parent_baton,
+              const char *copyfrom_path,
+              svn_revnum_t copyfrom_revision,
+              apr_pool_t *pool,
+              void **child_baton)
+{
+  struct dir_baton *pb = parent_baton;
+  struct edit_baton *eb = pb->edit_baton;
+  struct dir_baton *b = apr_palloc(pool, sizeof(*b));
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool,
+                            "add_directory : '%s' [from '%s':%ld]\n",
+                            path, copyfrom_path, copyfrom_revision));
+  eb->indent_level++;
+
+  SVN_ERR(eb->wrapped_editor->add_directory(path,
+                                            pb->wrapped_dir_baton,
+                                            copyfrom_path,
+                                            copyfrom_revision,
+                                            pool,
+                                            &b->wrapped_dir_baton));
+
+  b->edit_baton = eb;
+  *child_baton = b;
+
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
+  struct edit_baton *eb = pb->edit_baton;
+  struct dir_baton *db = apr_palloc(pool, sizeof(*db));
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "open_directory : '%s':%ld\n",
+                            path, base_revision));
+  eb->indent_level++;
+
+  SVN_ERR(eb->wrapped_editor->open_directory(path,
+                                             pb->wrapped_dir_baton,
+                                             base_revision,
+                                             pool,
+                                             &db->wrapped_dir_baton));
+
+  db->edit_baton = eb;
+  *child_baton = db;
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+add_file(const char *path,
+         void *parent_baton,
+         const char *copyfrom_path,
+         svn_revnum_t copyfrom_revision,
+         apr_pool_t *pool,
+         void **file_baton)
+{
+  struct dir_baton *pb = parent_baton;
+  struct edit_baton *eb = pb->edit_baton;
+  struct file_baton *fb = apr_palloc(pool, sizeof(*fb));
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool,
+                            "add_file : '%s' [from '%s':%ld]\n",
+                            path, copyfrom_path, copyfrom_revision));
+
+  eb->indent_level++;
+
+  SVN_ERR(eb->wrapped_editor->add_file(path,
+                                       pb->wrapped_dir_baton,
+                                       copyfrom_path,
+                                       copyfrom_revision,
+                                       pool,
+                                       &fb->wrapped_file_baton));
+
+  fb->edit_baton = eb;
+  *file_baton = fb;
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+open_file(const char *path,
+          void *parent_baton,
+          svn_revnum_t base_revision,
+          apr_pool_t *pool,
+          void **file_baton)
+{
+  struct dir_baton *pb = parent_baton;
+  struct edit_baton *eb = pb->edit_baton;
+  struct file_baton *fb = apr_palloc(pool, sizeof(*fb));
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "open_file : '%s':%ld\n",
+                            path, base_revision));
+
+  eb->indent_level++;
+
+  SVN_ERR(eb->wrapped_editor->open_file(path,
+                                        pb->wrapped_dir_baton,
+                                        base_revision,
+                                        pool,
+                                        &fb->wrapped_file_baton));
+
+  fb->edit_baton = eb;
+  *file_baton = fb;
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+apply_textdelta(void *file_baton,
+                const char *base_checksum,
+                apr_pool_t *pool,
+                svn_txdelta_window_handler_t *handler,
+                void **handler_baton)
+{
+  struct file_baton *fb = file_baton;
+  struct edit_baton *eb = fb->edit_baton;
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "apply_textdelta : %s\n",
+                            base_checksum));
+
+  SVN_ERR(eb->wrapped_editor->apply_textdelta(fb->wrapped_file_baton,
+                                              base_checksum,
+                                              pool,
+                                              handler,
+                                              handler_baton));
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+close_file(void *file_baton,
+           const char *text_checksum,
+           apr_pool_t *pool)
+{
+  struct file_baton *fb = file_baton;
+  struct edit_baton *eb = fb->edit_baton;
+
+  eb->indent_level--;
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "close_file : %s\n",
+                            text_checksum));
+
+  SVN_ERR(eb->wrapped_editor->close_file(fb->wrapped_file_baton,
+                                         text_checksum, pool));
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+absent_file(const char *path,
+            void *file_baton,
+            apr_pool_t *pool)
+{
+  struct file_baton *fb = file_baton;
+  struct edit_baton *eb = fb->edit_baton;
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "absent_file : %s\n", path));
+
+  SVN_ERR(eb->wrapped_editor->absent_file(path, fb->wrapped_file_baton,
+                                          pool));
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+close_directory(void *dir_baton,
+                apr_pool_t *pool)
+{
+  struct dir_baton *db = dir_baton;
+  struct edit_baton *eb = db->edit_baton;
+
+  eb->indent_level--;
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "close_directory\n"));
+
+  SVN_ERR(eb->wrapped_editor->close_directory(db->wrapped_dir_baton,
+                                              pool));
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+absent_directory(const char *path,
+                 void *dir_baton,
+                 apr_pool_t *pool)
+{
+  struct dir_baton *db = dir_baton;
+  struct edit_baton *eb = db->edit_baton;
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "absent_directory : %s\n",
+                            path));
+
+  SVN_ERR(eb->wrapped_editor->absent_directory(path, db->wrapped_dir_baton,
+                                               pool));
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+change_file_prop(void *file_baton,
+                 const char *name,
+                 const svn_string_t *value,
+                 apr_pool_t *pool)
+{
+  struct file_baton *fb = file_baton;
+  struct edit_baton *eb = fb->edit_baton;
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "change_file_prop : %s\n",
+                            name));
+
+  SVN_ERR(eb->wrapped_editor->change_file_prop(fb->wrapped_file_baton,
+                                               name,
+                                               value,
+                                               pool));
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+change_dir_prop(void *dir_baton,
+                const char *name,
+                const svn_string_t *value,
+                apr_pool_t *pool)
+{
+  struct dir_baton *db = dir_baton;
+  struct edit_baton *eb = db->edit_baton;
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "change_dir_prop : %s\n", name));
+
+  SVN_ERR(eb->wrapped_editor->change_dir_prop(db->wrapped_dir_baton,
+                                              name,
+                                              value,
+                                              pool));
+
+  return SVN_NO_ERROR;
+}
+
+static svn_error_t *
+close_edit(void *edit_baton,
+           apr_pool_t *pool)
+{
+  struct edit_baton *eb = edit_baton;
+
+  SVN_ERR(write_indent(eb, pool));
+  SVN_ERR(svn_stream_printf(eb->out, pool, "close_edit\n"));
+
+  SVN_ERR(eb->wrapped_editor->close_edit(eb->wrapped_edit_baton, pool));
+
+  return SVN_NO_ERROR;
+}
+
+svn_error_t *
+svn_delta__get_debug_editor(const svn_delta_editor_t **editor,
+                            void **edit_baton,
+                            const svn_delta_editor_t *wrapped_editor,
+                            void *wrapped_edit_baton,
+                            apr_pool_t *pool)
+{
+  svn_delta_editor_t *tree_editor = svn_delta_default_editor(pool);
+  struct edit_baton *eb = apr_palloc(pool, sizeof(*eb));
+  apr_file_t *errfp;
+  svn_stream_t *out;
+
+  apr_status_t apr_err = apr_file_open_stderr(&errfp, pool);
+  if (apr_err)
+    return svn_error_wrap_apr(apr_err, "Problem opening stderr");
+
+  out = svn_stream_from_aprfile2(errfp, TRUE, pool);
+
+  tree_editor->set_target_revision = set_target_revision;
+  tree_editor->open_root = open_root;
+  tree_editor->delete_entry = delete_entry;
+  tree_editor->add_directory = add_directory;
+  tree_editor->open_directory = open_directory;
+  tree_editor->change_dir_prop = change_dir_prop;
+  tree_editor->close_directory = close_directory;
+  tree_editor->absent_directory = absent_directory;
+  tree_editor->add_file = add_file;
+  tree_editor->open_file = open_file;
+  tree_editor->apply_textdelta = apply_textdelta;
+  tree_editor->change_file_prop = change_file_prop;
+  tree_editor->close_file = close_file;
+  tree_editor->absent_file = absent_file;
+  tree_editor->close_edit = close_edit;
+
+  eb->wrapped_editor = wrapped_editor;
+  eb->wrapped_edit_baton = wrapped_edit_baton;
+  eb->out = out;
+  eb->indent_level = 0;
+
+  *editor = tree_editor;
+  *edit_baton = eb;
+
+  return SVN_NO_ERROR;
+}
diff --git a/debug_editor.h b/debug_editor.h
new file mode 100644
index 0000000..ae87c36
--- /dev/null
+++ b/debug_editor.h
@@ -0,0 +1,6 @@
+svn_error_t *
+svn_delta__get_debug_editor(const svn_delta_editor_t **editor,
+                            void **edit_baton,
+                            const svn_delta_editor_t *wrapped_editor,
+                            void *wrapped_edit_baton,
+                            apr_pool_t *pool);
diff --git a/svnclient_ra.c b/svnclient_ra.c
new file mode 100644
index 0000000..2ed04af
--- /dev/null
+++ b/svnclient_ra.c
@@ -0,0 +1,131 @@
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+
+#include "debug_editor.h"
+
+static apr_pool_t *pool = NULL;
+static svn_client_ctx_t *ctx = NULL;
+static svn_ra_session_t *session = NULL;
+
+typedef struct {
+	void *editor, *baton;
+} replay_baton_t;
+
+static svn_error_t *replay_revstart(svn_revnum_t revision,
+                                    void *replay_baton,
+                                    const svn_delta_editor_t **editor,
+                                    void **edit_baton,
+                                    apr_hash_t *rev_props,
+                                    apr_pool_t *pool)
+{
+	*editor = ((replay_baton_t *) replay_baton)->editor;
+	*edit_baton = ((replay_baton_t *) replay_baton)->baton;
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *replay_revend(svn_revnum_t revision,
+                                  void *replay_baton,
+                                  const svn_delta_editor_t *editor,
+                                  void *edit_baton,
+                                  apr_hash_t *rev_props,
+                                  apr_pool_t *pool)
+{
+	SVN_ERR(editor->close_edit(edit_baton, pool));
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *build_auth_baton()
+{
+	svn_auth_provider_object_t *provider;
+	apr_array_header_t *providers
+		= apr_array_make (pool, 4, sizeof (svn_auth_provider_object_t *));
+
+	svn_auth_get_simple_prompt_provider (&provider,
+	                                     NULL,
+	                                     NULL,
+	                                     2,
+	                                     pool);
+	APR_ARRAY_PUSH (providers, svn_auth_provider_object_t *) = provider;
+
+	svn_auth_get_username_prompt_provider (&provider,
+	                                       NULL,
+	                                       NULL,
+	                                       2,
+	                                       pool);
+	APR_ARRAY_PUSH (providers, svn_auth_provider_object_t *) = provider;
+
+	svn_auth_open (&ctx->auth_baton, providers, pool);
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *populate_context()
+{
+	const char *http_library;
+	
+	SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
+	
+	http_library = getenv("SVN_HTTP_LIBRARY");
+	if (http_library)
+		svn_config_set(apr_hash_get(ctx->config, "servers", APR_HASH_KEY_STRING),
+		               "global", "http-library", http_library);
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *open_connection(const char *url)
+{
+	SVN_ERR(svn_config_ensure (NULL, pool));
+	SVN_ERR(svn_client_create_context (&ctx, pool));
+	SVN_ERR(svn_ra_initialize(pool));
+
+#if defined(WIN32) || defined(__CYGWIN__)
+	if (getenv("SVN_ASP_DOT_NET_HACK"))
+		SVN_ERR(svn_wc_set_adm_dir("_svn", pool));
+#endif
+
+	SVN_ERR(populate_context());
+	SVN_ERR(build_auth_baton());
+	SVN_ERR(svn_client_open_ra_session(&session, url, ctx, pool));
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
+{
+	svn_revnum_t latest_revision;
+	svn_delta_editor_t *editor, *debug_editor;
+	replay_baton_t *replay_baton = apr_palloc(pool, sizeof(replay_baton_t));
+	void *debug_baton;
+	SVN_ERR(svn_ra_get_latest_revnum(session, &latest_revision, pool));
+	printf("%ld\n", latest_revision);
+	editor = svn_delta_default_editor(pool);
+	SVN_ERR(svn_delta__get_debug_editor((const svn_delta_editor_t **)&debug_editor,
+	                                    &debug_baton, editor,
+	                                    NULL, pool));
+	replay_baton->editor = debug_editor;
+	replay_baton->baton = debug_baton;
+	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
+	                            0, TRUE, replay_revstart, replay_revend,
+	                            replay_baton, pool));
+	return SVN_NO_ERROR;
+}
+
+void close_connection()
+{
+	svn_pool_destroy(pool);
+}
+
+int main()
+{
+	const char url[] = "http://svn.apache.org/repos/asf";
+	svn_revnum_t start_revision = 1, end_revision = 5;
+	if (svn_cmdline_init ("svnclient_ra", stderr) != EXIT_SUCCESS)
+		return 1;
+	pool = svn_pool_create(NULL);
+
+	SVN_INT_ERR(open_connection(url));
+	SVN_INT_ERR(replay_range(start_revision, end_revision));
+
+	close_connection();
+	return 0;
+}
-- 
1.7.1
