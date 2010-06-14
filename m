From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH] Add a skeleton RA SVN client
Date: Mon, 14 Jun 2010 18:19:24 +0200
Message-ID: <1276532364-6993-2-git-send-email-artagnon@gmail.com>
References: <1276532364-6993-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonas Gehring <jonas.gehring@boolsoft.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 18:18:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCMS-0006c6-7Q
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab0FNQSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:18:01 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:45553 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0FNQR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:17:59 -0400
Received: by wwb18 with SMTP id 18so3995167wwb.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=H6ip+gkMFwU3+GkY3QK6UXr5Hf6ABw+7MQ9kbPzRDDk=;
        b=nnFP+XKR+WC53xFZKxjwirAraXfSff/9/cXPUlz+PDzqfkvRD/qlsea6hT8E45sYgH
         hGI0P+yrucrhLrX3wibD9etiVlJ0kF/kfcwmRgbgRezuPFIW/B43jwGojm1Zq9CrVx12
         jV7MdTOMERHCWXoTqMoF2RJNJPltte67JQ8KE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dCLnADXSFWXvF2mML5nMbWb4sKkGkauqAwyzKkiOAJrprT29FnUAPpn3iehbv0tLl/
         +EXDMKHr5ve2+oJnp3tFXfgetfX8/qlBNW6FTEkJav6njfE0XLrQ7jvDh9E/Y9VYHWW3
         R0hih1JuCwSFkvTljfpXvsThuzGrI6NSyRYAM=
Received: by 10.227.146.21 with SMTP id f21mr5886943wbv.172.1276532275705;
        Mon, 14 Jun 2010 09:17:55 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id p17sm30422408wbe.14.2010.06.14.09.17.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:17:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1276532364-6993-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149121>

The SVN client uses the RA API to connect to a remote server and
replay revisions. In future, it will dump the data in every revision
to stdout in dumpfile format (hopefully) without resorting to the FS
API and svn_repos_dump_fs2.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile       |    2 +
 delta_editor.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++
 delta_editor.h |   66 +++++++++++++++++++++++++++
 svnclient_ra.c |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 315 insertions(+), 0 deletions(-)
 create mode 100644 Makefile
 create mode 100644 delta_editor.c
 create mode 100644 delta_editor.h
 create mode 100644 svnclient_ra.c

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..662061b
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,2 @@
+svnclient_ra: svnclient_ra.c
+	cc -Wall -Werror -ggdb -O1 -o $@ -lsvn_client-1 svnclient_ra.c delta_editor.c -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
diff --git a/delta_editor.c b/delta_editor.c
new file mode 100644
index 0000000..8c722cd
--- /dev/null
+++ b/delta_editor.c
@@ -0,0 +1,112 @@
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+
+#include "delta_editor.h"
+
+svn_error_t *set_target_revision(void *edit_baton,
+                                 svn_revnum_t target_revision,
+                                 apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+
+svn_error_t *open_root(void *edit_baton, svn_revnum_t base_revision,
+                       apr_pool_t *dir_pool, void **root_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *delete_entry(const char *path, svn_revnum_t revision,
+                          void *parent_baton, apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *add_directory(const char *path, void *parent_baton,
+                           const char *copyfrom_path,
+                           svn_revnum_t copyfrom_revision,
+                           apr_pool_t *dir_pool, void **child_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+
+svn_error_t *open_directory(const char *path, void *parent_baton,
+                            svn_revnum_t base_revision,
+                            apr_pool_t *dir_pool, void **child_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *change_dir_prop(void *dir_baton, const char *name,
+                             const svn_string_t *value, apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *close_directory(void *dir_baton, apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *absent_directory(const char *path, void *parent_baton,
+                              apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *add_file(const char *path, void *parent_baton,
+                      const char *copyfrom_path,
+                      svn_revnum_t copyfrom_revision,
+                      apr_pool_t *file_pool, void **file_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *open_file(const char *path, void *parent_baton,
+                       svn_revnum_t base_revision, apr_pool_t *file_pool,
+                       void **file_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *apply_textdelta(void *file_baton,
+                             const char *base_checksum,
+                             apr_pool_t *pool,
+                             svn_txdelta_window_handler_t *handler,
+                             void **handler_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *change_file_prop(void *file_baton, const char *name,
+                              const svn_string_t *value,
+                              apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *close_file(void *file_baton, const char *text_checksum,
+                        apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *absent_file(const char *path, void *parent_baton,
+                         apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *close_edit(void *edit_baton, apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *abort_edit(void *edit_baton, apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
diff --git a/delta_editor.h b/delta_editor.h
new file mode 100644
index 0000000..49652d7
--- /dev/null
+++ b/delta_editor.h
@@ -0,0 +1,66 @@
+#ifndef DELTA_EDITOR_H_
+#define DELTA_EDITOR_H_
+
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+
+svn_error_t *set_target_revision(void *edit_baton,
+                                 svn_revnum_t target_revision,
+                                 apr_pool_t *pool);
+
+svn_error_t *open_root(void *edit_baton, svn_revnum_t base_revision,
+                       apr_pool_t *dir_pool, void **root_baton);
+
+svn_error_t *delete_entry(const char *path, svn_revnum_t revision,
+                          void *parent_baton, apr_pool_t *pool);
+
+svn_error_t *add_directory(const char *path, void *parent_baton,
+                           const char *copyfrom_path,
+                           svn_revnum_t copyfrom_revision,
+                           apr_pool_t *dir_pool, void **child_baton);
+
+
+svn_error_t *open_directory(const char *path, void *parent_baton,
+                            svn_revnum_t base_revision,
+                            apr_pool_t *dir_pool, void **child_baton);
+
+svn_error_t *change_dir_prop(void *dir_baton, const char *name,
+                             const svn_string_t *value, apr_pool_t *pool);
+
+svn_error_t *close_directory(void *dir_baton, apr_pool_t *pool);
+
+svn_error_t *absent_directory(const char *path, void *parent_baton,
+                              apr_pool_t *pool);
+
+svn_error_t *add_file(const char *path, void *parent_baton,
+                      const char *copyfrom_path,
+                      svn_revnum_t copyfrom_revision,
+                      apr_pool_t *file_pool, void **file_baton);
+
+svn_error_t *open_file(const char *path, void *parent_baton,
+                       svn_revnum_t base_revision, apr_pool_t *file_pool,
+                       void **file_baton);
+
+svn_error_t *apply_textdelta(void *file_baton,
+                             const char *base_checksum,
+                             apr_pool_t *pool,
+                             svn_txdelta_window_handler_t *handler,
+                             void **handler_baton);
+
+svn_error_t *change_file_prop(void *file_baton, const char *name,
+                              const svn_string_t *value,
+                              apr_pool_t *pool);
+
+svn_error_t *close_file(void *file_baton, const char *text_checksum,
+                        apr_pool_t *pool);
+
+svn_error_t *absent_file(const char *path, void *parent_baton,
+                         apr_pool_t *pool);
+
+svn_error_t *close_edit(void *edit_baton, apr_pool_t *pool);
+
+svn_error_t *abort_edit(void *edit_baton, apr_pool_t *pool);
+
+#endif
diff --git a/svnclient_ra.c b/svnclient_ra.c
new file mode 100644
index 0000000..a754494
--- /dev/null
+++ b/svnclient_ra.c
@@ -0,0 +1,135 @@
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+
+#include "delta_editor.h"
+
+static apr_pool_t *pool = NULL;
+static svn_client_ctx_t *ctx = NULL;
+static svn_ra_session_t *session = NULL;
+
+static svn_error_t *setup_delta_editor(svn_delta_editor_t **editor)
+{
+	*editor = svn_delta_default_editor(pool);
+	(*editor)->set_target_revision = set_target_revision;
+	(*editor)->open_root = open_root;
+	(*editor)->delete_entry = delete_entry;
+	(*editor)->add_directory = add_directory;
+	(*editor)->open_directory = open_directory;
+	(*editor)->add_file = add_file;
+	(*editor)->open_file = open_file;
+	(*editor)->apply_textdelta = apply_textdelta;
+	(*editor)->close_file = close_file;
+	(*editor)->close_directory = close_directory;
+	(*editor)->change_file_prop = change_file_prop;
+	(*editor)->change_dir_prop = change_dir_prop;
+	(*editor)->close_edit = close_edit;
+	(*editor)->absent_directory = absent_directory;
+	(*editor)->absent_file = absent_file;
+	(*editor)->abort_edit = abort_edit;
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *replay_revstart(svn_revnum_t revision,
+                                    void *replay_baton,
+                                    const svn_delta_editor_t **editor,
+                                    void **edit_baton,
+                                    apr_hash_t *rev_props,
+                                    apr_pool_t *pool)
+{
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
+	SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
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
+	svn_delta_editor_t *editor;
+	svn_error_t *err;
+	SVN_ERR(svn_ra_get_latest_revnum(session, &latest_revision, pool));
+	printf("%ld\n", latest_revision);
+	SVN_ERR(setup_delta_editor(&editor));
+	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
+	                            0, TRUE, replay_revstart, replay_revend, NULL, pool));
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
+	const char url[] = "http://svn.apache.org/repos/asf/subversion/trunk";
+	svn_revnum_t start_revision = 0, end_revision = 5;
+	if (svn_cmdline_init ("svnclient_ra", stderr) != EXIT_SUCCESS)
+		return EXIT_FAILURE;
+	pool = svn_pool_create(NULL);
+
+	if(open_connection(url) != SVN_NO_ERROR)
+		return 1;
+	if(replay_range(start_revision, end_revision) != SVN_NO_ERROR)
+		return 1;
+
+	close_connection();
+	return 0;
+}
-- 
1.7.1
