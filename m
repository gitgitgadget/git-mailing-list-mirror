From: David Turner <dturner@twopensource.com>
Subject: [PATCH 11/19] Add watchman support to reduce index refresh cost
Date: Wed,  9 Mar 2016 13:36:14 -0500
Message-ID: <1457548582-28302-12-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiys-0007PD-RK
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933867AbcCIShF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:37:05 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34195 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933828AbcCISgo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:44 -0500
Received: by mail-qg0-f49.google.com with SMTP id w104so49419625qge.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWwllwpfG+dRyA8B4sr0OFfpBcvEkfMk3WUQTbB2OKg=;
        b=BSPn2GTLrkcyv7XDG1UwsCnxxv005gzYgxNiMNi89ocnjSr35+7OOrmxyaAizu8E5w
         8UpTIcwVk0OgxxXUzgPZZ+4SLaivsPeB7QalbhGWBC/qSmgM6O8wFCxvZ9W5l00+gPCd
         0Buk6mVrd/CSaPCrNruogffzapMDgch+fN25iCc3Hh9wqdDbx9IlB5BtPzLDOHFLjsiO
         O56jmTyXL727Sd7ZO0qovwrGuUsEKniArqLYzCQF9mFTcpJm9wvEvnapXfx6QrK1e4z0
         SSSLNQxNOH8zyg/Vx+vdAhVxATaxwlLNMknQZP+prYGO0isvVPviJx54dsX3i1fT0pDp
         0Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWwllwpfG+dRyA8B4sr0OFfpBcvEkfMk3WUQTbB2OKg=;
        b=KRREbNiwTeF1icXAGn0xIwCbAw2Jm+mleA5RF8Q3EPKcAtQDMmXwJGN3Hdr6qgHgCF
         kgbBkXjqhGWvz1tCQ3XY1u/j0Ax8bob4z7GI+zkhwqIDUPk1SchhQUJW/x8IvncJ8b7g
         sJXT9AHlVZBy/Z1p4jdaF/VGfYuoPq4w11YVgS+cDWIeozTzvj9+Z84p/9pDC/A8gH9+
         nbh+g02QFbVBINcTe4ERiJBhigecYPa/Yh3icR5b2uxqjEXyJNBIeKgYaFpDlTLpFFes
         BrvwxYR916VF9ZQuA0Qcn5A/Zj27+mgJGdbNM/Ir83Yetc1JB7yEuuRzwPVOn+XWXJ9k
         XEZQ==
X-Gm-Message-State: AD7BkJJP+W1Z23Jy1QmvrsQSjHUuqKceRFXKE0dCl0fe3cXIkLd6x3ekAV4UJ0zl+yPvGg==
X-Received: by 10.140.27.228 with SMTP id 91mr43200005qgx.43.1457548603246;
        Wed, 09 Mar 2016 10:36:43 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:42 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288561>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The previous patch has the logic to clear bits in 'WAMA' bitmap. This
patch has logic to set bits as told by watchman. The missing bit,
_using_ these bits, are not here yet.

A lot of this code is written by David Turner originally, mostly from
[1]. I'm just copying and polishing it a bit.

[1] http://article.gmane.org/gmane.comp.version-control.git/248006

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile           |   7 ++++
 cache.h            |   1 +
 config.c           |   5 +++
 configure.ac       |   8 ++++
 environment.c      |   3 ++
 watchman-support.c | 115 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 watchman-support.h |   7 ++++
 7 files changed, 146 insertions(+)
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

diff --git a/Makefile b/Makefile
index a6c668b..e51331c 100644
--- a/Makefile
+++ b/Makefile
@@ -1416,6 +1416,12 @@ else
 	LIB_OBJS +=3D thread-utils.o
 endif
=20
+ifdef USE_WATCHMAN
+	LIB_H +=3D watchman-support.h
+	LIB_OBJS +=3D watchman-support.o
+	BASIC_CFLAGS +=3D -DUSE_WATCHMAN
+endif
+
 ifdef HAVE_PATHS_H
 	BASIC_CFLAGS +=3D -DHAVE_PATHS_H
 endif
@@ -2164,6 +2170,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=3D\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@=
+
 	@echo NO_PYTHON=3D\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' =
>>$@+
 	@echo NO_UNIX_SOCKETS=3D\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SO=
CKETS)))'\' >>$@+
+	@echo USE_WATCHMAN=3D\''$(subst ','\'',$(subst ','\'',$(USE_WATCHMAN)=
))'\' >>$@+
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=3D\''$(subst ','\'',$(subst ','\'',$(TEST=
_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/cache.h b/cache.h
index 8f7b4b1..bf20652 100644
--- a/cache.h
+++ b/cache.h
@@ -688,6 +688,7 @@ extern char *git_replace_ref_base;
=20
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_watchman_sync_timeout;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index 9ba40bc..e6dc141 100644
--- a/config.c
+++ b/config.c
@@ -882,6 +882,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.watchmansynctimeout")) {
+		core_watchman_sync_timeout =3D git_config_int(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.createobject")) {
 		if (!strcmp(value, "rename"))
 			object_creation_mode =3D OBJECT_CREATION_USES_RENAMES;
diff --git a/configure.ac b/configure.ac
index 89e2590..6f10a15 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1092,6 +1092,14 @@ AC_COMPILE_IFELSE([BSD_SYSCTL_SRC],
 	HAVE_BSD_SYSCTL=3D])
 GIT_CONF_SUBST([HAVE_BSD_SYSCTL])
=20
+#
+# Check for watchman client library
+
+AC_CHECK_LIB([watchman], [watchman_connect],
+	[USE_WATCHMAN=3DYesPlease],
+	[USE_WATCHMAN=3D])
+GIT_CONF_SUBST([USE_WATCHMAN])
+
 ## Other checks.
 # Define USE_PIC if you need the main git objects to be built with -fP=
IC
 # in order to build and link perl/Git.so.  x86-64 seems to need this.
diff --git a/environment.c b/environment.c
index 6dec9d0..35e03c7 100644
--- a/environment.c
+++ b/environment.c
@@ -94,6 +94,9 @@ int core_preload_index =3D 1;
  */
 int ignore_untracked_cache_config;
=20
+int core_watchman_sync_timeout =3D 300;
+
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() *=
/
 char *git_work_tree_cfg;
 static char *work_tree;
diff --git a/watchman-support.c b/watchman-support.c
new file mode 100644
index 0000000..08e37ae
--- /dev/null
+++ b/watchman-support.c
@@ -0,0 +1,115 @@
+#include "cache.h"
+#include "watchman-support.h"
+#include "strbuf.h"
+#include <watchman.h>
+
+static struct watchman_query *make_query(const char *last_update)
+{
+	struct watchman_query *query =3D watchman_query();
+	watchman_query_set_fields(query, WATCHMAN_FIELD_NAME |
+					 WATCHMAN_FIELD_EXISTS |
+					 WATCHMAN_FIELD_NEWER);
+	watchman_query_set_empty_on_fresh(query, 1);
+	query->sync_timeout =3D core_watchman_sync_timeout;
+	if (*last_update)
+		watchman_query_set_since_oclock(query, last_update);
+	return query;
+}
+
+static struct watchman_query_result* query_watchman(
+	struct index_state *istate, struct watchman_connection *connection,
+	const char *fs_path, const char *last_update)
+{
+	struct watchman_error wm_error;
+	struct watchman_query *query;
+	struct watchman_expression *expr;
+	struct watchman_query_result *result;
+
+	query =3D make_query(last_update);
+	expr =3D watchman_true_expression();
+	result =3D watchman_do_query(connection, fs_path, query, expr, &wm_er=
ror);
+	watchman_free_query(query);
+	watchman_free_expression(expr);
+
+	if (!result)
+		warning("Watchman query error: %s (at %s)",
+			wm_error.message,
+			*last_update ? last_update : "the beginning");
+
+	return result;
+}
+
+static void update_index(struct index_state *istate,
+			 struct watchman_query_result *result)
+{
+	int i;
+
+	if (result->is_fresh_instance) {
+		/* let refresh clear them later */
+		for (i =3D 0; i < istate->cache_nr; i++)
+			istate->cache[i]->ce_flags |=3D CE_WATCHMAN_DIRTY;
+		goto done;
+	}
+
+	for (i =3D 0; i < result->nr; i++) {
+		struct watchman_stat *wm =3D result->stats + i;
+		int pos;
+
+		if (!strncmp(wm->name, ".git/", 5) ||
+		    strstr(wm->name, "/.git/"))
+			continue;
+
+		pos =3D index_name_pos(istate, wm->name, strlen(wm->name));
+		if (pos < 0)
+			continue;
+		/* FIXME: ignore staged entries and gitlinks too? */
+
+		istate->cache[pos]->ce_flags |=3D CE_WATCHMAN_DIRTY;
+	}
+
+done:
+	free(istate->last_update);
+	istate->last_update    =3D xstrdup(result->clock);
+	istate->cache_changed |=3D WATCHMAN_CHANGED;
+}
+
+int check_watchman(struct index_state *istate)
+{
+	struct watchman_error wm_error;
+	struct watchman_connection *connection;
+	struct watchman_query_result *result;
+	const char *fs_path;
+	struct timeval timeout;
+	/*
+	 * Convert core_watchman_sync_timeout, in milliseconds, to
+	 * struct timeval, in seconds and microseconds.
+	 */
+
+	fs_path =3D get_git_work_tree();
+	if (!fs_path)
+		return -1;
+
+	timeout.tv_sec =3D core_watchman_sync_timeout / 1000;
+	timeout.tv_usec =3D (core_watchman_sync_timeout % 1000) * 1000;
+	connection =3D watchman_connect(timeout, &wm_error);
+
+	if (!connection) {
+		warning("Watchman watch error: %s", wm_error.message);
+		return -1;
+	}
+
+	if (watchman_watch(connection, fs_path, &wm_error)) {
+		warning("Watchman watch error: %s", wm_error.message);
+		watchman_connection_close(connection);
+		return -1;
+	}
+
+
+	result =3D query_watchman(istate, connection, fs_path, istate->last_u=
pdate);
+	watchman_connection_close(connection);
+	if (!result)
+		return -1;
+	update_index(istate, result);
+	watchman_free_query_result(result);
+	return 0;
+}
diff --git a/watchman-support.h b/watchman-support.h
new file mode 100644
index 0000000..ee1ef2c
--- /dev/null
+++ b/watchman-support.h
@@ -0,0 +1,7 @@
+#ifndef WATCHMAN_SUPPORT_H
+#define WATCHMAN_SUPPORT_H
+
+struct index_state;
+int check_watchman(struct index_state *index);
+
+#endif /* WATCHMAN_SUPPORT_H */
--=20
2.4.2.767.g62658d5-twtrsrc
