From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/13] Add skeleton dump editor
Date: Wed,  7 Jul 2010 02:14:44 +0200
Message-ID: <1278461693-3828-5-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 02:14:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWIHV-00057s-BO
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 02:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab0GGANc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 20:13:32 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39519 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312Ab0GGAN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 20:13:29 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1968051ewy.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 17:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/huR/SpZDx3dj3kSHPAwcxfmJEmFyUWgeKE5zTeHsDY=;
        b=SW/YwS42PYLhVosLAIZ94s4rOgiq2O2NdGulejVlQUcSZxSr0jEUmo1aJHFH3OAjIE
         7gxSuov0Nj6nnNwmioMlaoo/CQZqH2/cAe5baVLMHjySKHvGjg61zRExX0q7BnPiWPnY
         wfMA+O3ZruT/yW5VshmihZRsfR8UCWt8Y1Leg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pP2dG1pfhbd5oot7nXQugq8X0FZJBsJCvOMCp3QiyczZ1ztja1aXxjrwIx9fxbIa1t
         BIOGpTeqbD9AZgrtHKNiZjwyuHrB9G2S1vCWQ5AUS/fK+BGEXQ3f76HxBv2xwuJOCDxj
         ZBnixbin+1UWnpXPFvKCLHMt5C3gEIKfQT4Ac=
Received: by 10.213.10.147 with SMTP id p19mr4605932ebp.66.1278461608744;
        Tue, 06 Jul 2010 17:13:28 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id v8sm55873279eeh.8.2010.07.06.17.13.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150434>

Add a dump editor and write out skeleton callback functions according
to the API documentation of svn_delta_editor_t. Also expose
get_dump_editor through a header.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile      |    4 +-
 dump_editor.c |  143 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dump_editor.h |    8 +++
 dumpr_util.h  |   29 ++++++++++++
 4 files changed, 182 insertions(+), 2 deletions(-)
 create mode 100644 dump_editor.c
 create mode 100644 dump_editor.h
 create mode 100644 dumpr_util.h

diff --git a/Makefile b/Makefile
index e4d106e..fea646e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 svndumpr: *.c *.h
-	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svndumpr.c debug_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
+	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svndumpr.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
 
 svndumpr_bench: *.c *.h
-	$(CC) -O2 -o $@ svndumpr.c debug_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
+	$(CC) -O2 -o $@ svndumpr.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
 
 clean:
 	$(RM) svndumpr svndumpr_bench
diff --git a/dump_editor.c b/dump_editor.c
new file mode 100644
index 0000000..2fdf93c
--- /dev/null
+++ b/dump_editor.c
@@ -0,0 +1,143 @@
+/* Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
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
+#include "dumpr_util.h"
+
+svn_error_t *open_root(void *edit_baton,
+                       svn_revnum_t base_revision,
+                       apr_pool_t *pool,
+                       void **root_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *delete_entry(const char *path,
+                          svn_revnum_t revision,
+                          void *parent_baton,
+                          apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *add_directory(const char *path,
+                           void *parent_baton,
+                           const char *copyfrom_path,
+                           svn_revnum_t copyfrom_rev,
+                           apr_pool_t *pool,
+                           void **child_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *open_directory(const char *path,
+                            void *parent_baton,
+                            svn_revnum_t base_revision,
+                            apr_pool_t *pool,
+                            void **child_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *close_directory(void *dir_baton,
+                             apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *add_file(const char *path,
+                      void *parent_baton,
+                      const char *copyfrom_path,
+                      svn_revnum_t copyfrom_rev,
+                      apr_pool_t *pool,
+                      void **file_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *open_file(const char *path,
+                       void *parent_baton,
+                       svn_revnum_t ancestor_revision,
+                       apr_pool_t *pool,
+                       void **file_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *change_dir_prop(void *parent_baton,
+                             const char *name,
+                             const svn_string_t *value,
+                             apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *change_file_prop(void *file_baton,
+                              const char *name,
+                              const svn_string_t *value,
+                              apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *apply_textdelta(void *file_baton, const char *base_checksum,
+                             apr_pool_t *pool,
+                             svn_txdelta_window_handler_t *handler,
+                             void **handler_baton)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *close_file(void *file_baton,
+			const char *text_checksum,
+			apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *close_edit(void *edit_baton, apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
+                             void **edit_baton,
+                             svn_revnum_t from_rev,
+                             apr_pool_t *pool)
+{
+	struct edit_baton *eb = apr_pcalloc(pool, sizeof(struct edit_baton));
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
+ 
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
index 0000000..d206c19
--- /dev/null
+++ b/dumpr_util.h
@@ -0,0 +1,29 @@
+#ifndef DUMPR_UTIL_H_
+#define DUMPR_UTIL_H_
+
+struct edit_baton {
+	/* The stream to dump to: stdout */
+	svn_stream_t *stream;
+
+	/* pool is for per-edit-session allocations */
+	apr_pool_t *pool;
+
+	svn_revnum_t current_rev;
+	
+	/* Store the properties that changed */
+	apr_hash_t *properties;
+	apr_hash_t *del_properties; /* Value is always 0x1 */
+	svn_stringbuf_t *propstring;
+
+	/* Path of changed file */
+	const char *changed_path;
+
+	/* Was a copy command issued? */
+	svn_boolean_t is_copy;
+
+	/* Temporary file to write delta to along with its checksum */
+	char *temp_filepath;
+	svn_checksum_t *checksum;
+};
+
+#endif
-- 
1.7.1
