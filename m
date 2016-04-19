From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 08/15] Add watchman support to reduce index refresh cost
Date: Tue, 19 Apr 2016 19:28:02 -0400
Message-ID: <1461108489-29376-9-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4W-0008N0-N2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbcDSX2f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 19:28:35 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33729 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbcDSX2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:25 -0400
Received: by mail-qg0-f45.google.com with SMTP id v14so19451316qge.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/0pHdIDIvo90pYujwVP8o0w4vfpQuqNryeRygeVqoc=;
        b=xIggIf3SrSxNRFo4Bi+LKQLhROxYFyacGrigPhq8TVJfwwVKoTg5Yg9gdVNPI7q3n5
         kGT0wEb1ReBwEntmTDOrXh5tSVyRes+f07CQtUsUeh9LFBYTvnto0oAOTbR3MocMwvVk
         nG+sFaPkTvEtOqJGiNPjdJANUnXqAISgczp/i44nNCQBr1oSpV1tQuyeYUQr0ua5kC2Y
         t8SpWE5hUHB8xqlJSSQK4GI+/IJjbRBmw0kloE+oRTSM6lp3aIonzJMgCfKiDSLKKQaA
         sy4+LiMD5JQxz4NvGwZMbvvdMpHQgdl5hCImipttAOfaw3TInhRreYt1KpjYQcxTUUAm
         +oOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/0pHdIDIvo90pYujwVP8o0w4vfpQuqNryeRygeVqoc=;
        b=gIzQwumx5vXfRwfzDQ3zent+40LRX/aHQPonA59I2cZ9Uk0Y6yd35pfJFNLgRj81Qh
         wgSazHoYGtHgfz/soSq610StqXf1gWmpFufqehekbYSZ9ud79iGQEv+ZlPPFKbIcYq3p
         +6rCdZeFtxCjs4ZxWuiYbx9sxe9jpnCh6iI/zBkn/AcoQTNN+p/nu9gng3W2LqICeOI+
         bsmGWj6rU/aaCfSvDyiI7dz50ynm/kvyzFXv1RskZU66zQSm4LqvX18kFOBmjgQTzTMt
         0lVGlYINi6KIVdsZnCIuqzSq2y3C9FENuOxqQWkJKQoviY7+D8VXvyv9Br2fFppgFM7b
         yr5Q==
X-Gm-Message-State: AOPr4FXg83x0zLFOYPMO9ZGjBa/xvPwl5Q1hjT0bICyvk8W9YYBkQiiSboOr4/Ie3YbCwg==
X-Received: by 10.140.25.141 with SMTP id 13mr7047202qgt.5.1461108504176;
        Tue, 19 Apr 2016 16:28:24 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291960>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The previous patch has the logic to clear bits in 'WAMA' bitmap. This
patch has logic to set bits as told by watchman. The missing bit,
_using_ these bits, are not here yet.

A lot of this code is written by David Turner originally, mostly from
[1]. I'm just copying and polishing it a bit.

[1] http://article.gmane.org/gmane.comp.version-control.git/248006

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Makefile           |  12 +++++
 cache.h            |   1 +
 config.c           |   5 ++
 configure.ac       |   8 ++++
 environment.c      |   3 ++
 watchman-support.c | 135 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 watchman-support.h |   7 +++
 7 files changed, 171 insertions(+)
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

diff --git a/Makefile b/Makefile
index c8be0e7..65ab0f4 100644
--- a/Makefile
+++ b/Makefile
@@ -451,6 +451,7 @@ MSGFMT =3D msgfmt
 CURL_CONFIG =3D curl-config
 PTHREAD_LIBS =3D -lpthread
 PTHREAD_CFLAGS =3D
+WATCHMAN_LIBS =3D
 GCOV =3D gcov
=20
 export TCL_PATH TCLTK_PATH
@@ -1416,6 +1417,13 @@ else
 	LIB_OBJS +=3D thread-utils.o
 endif
=20
+ifdef USE_WATCHMAN
+	LIB_H +=3D watchman-support.h
+	LIB_OBJS +=3D watchman-support.o
+	WATCHMAN_LIBS =3D -lwatchman
+	BASIC_CFLAGS +=3D -DUSE_WATCHMAN
+endif
+
 ifdef HAVE_PATHS_H
 	BASIC_CFLAGS +=3D -DHAVE_PATHS_H
 endif
@@ -2025,6 +2033,9 @@ git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAG=
S $(GITLIBS) $(VCSSVN_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS) \
 	$(VCSSVN_LIB)
=20
+git-index-helper$X: index-helper.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS) $(WATCHMAN_LIBS)
+
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
@@ -2164,6 +2175,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PYTHON=3D\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' =
>>$@+
 	@echo NO_UNIX_SOCKETS=3D\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SO=
CKETS)))'\' >>$@+
 	@echo NO_MMAP=3D\''$(subst ','\'',$(subst ','\'',$(NO_MMAP)))'\' >>$@=
+
+	@echo USE_WATCHMAN=3D\''$(subst ','\'',$(subst ','\'',$(USE_WATCHMAN)=
))'\' >>$@+
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=3D\''$(subst ','\'',$(subst ','\'',$(TEST=
_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/cache.h b/cache.h
index f4f7eef..37f211b 100644
--- a/cache.h
+++ b/cache.h
@@ -687,6 +687,7 @@ extern char *git_replace_ref_base;
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
index 0cd9f46..334d63b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1099,6 +1099,14 @@ AC_COMPILE_IFELSE([BSD_SYSCTL_SRC],
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
index 0000000..b168e88
--- /dev/null
+++ b/watchman-support.c
@@ -0,0 +1,135 @@
+#include "cache.h"
+#include "watchman-support.h"
+#include "strbuf.h"
+#include "dir.h"
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
+		if (S_ISDIR(wm->mode) ||
+		    !strncmp(wm->name, ".git/", 5) ||
+		    strstr(wm->name, "/.git/"))
+			continue;
+
+		pos =3D index_name_pos(istate, wm->name, strlen(wm->name));
+		if (pos < 0) {
+			if (istate->untracked) {
+				char *name =3D xstrdup(wm->name);
+				char *dname =3D dirname(name);
+
+				/*
+				 * dirname() returns '.' for the root,
+				 * but we call it ''.
+				 */
+				if (dname[0] =3D=3D '.' && dname[1] =3D=3D 0)
+					string_list_append(&istate->untracked->invalid_untracked, "");
+				else
+					string_list_append(&istate->untracked->invalid_untracked,
+							   dname);
+				free(name);
+			}
+			continue;
+		}
+		/* FIXME: ignore staged entries and gitlinks too? */
+
+		istate->cache[pos]->ce_flags |=3D CE_WATCHMAN_DIRTY;
+	}
+
+done:
+	free(istate->last_update);
+	istate->last_update    =3D xstrdup(result->clock);
+	istate->cache_changed |=3D WATCHMAN_CHANGED;
+	if (istate->untracked)
+		string_list_remove_duplicates(&istate->untracked->invalid_untracked,=
 0);
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
