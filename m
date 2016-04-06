From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 08/16] Add watchman support to reduce index refresh cost
Date: Wed,  6 Apr 2016 18:11:54 -0400
Message-ID: <1459980722-4836-9-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:12:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvh0-0004mU-1O
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbcDFWMr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 18:12:47 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35700 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbcDFWMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:45 -0400
Received: by mail-qk0-f177.google.com with SMTP id o6so23604511qkc.2
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kK3961eorNxM4lj9kYWmSj90jPI1PLhvK9paSEcnVxg=;
        b=f9DHy3gsjm7bVKGWTPilK+E90NlrYtyyvto2VpqId4zYomUFl7dTpY6+4MjJHOz0R/
         RLtPs7S5gUZjD3ayHED2Xpww/cuCJkscPGLDSL24LEuOOHU7MAL6RXDe2MUDVSD+8jPg
         vJELXwW8YvXu9fn9pr338ymZ9ErH7fd2fYZGy2EoG6CD9dCuzC+P4VH5txLCFhATIIf/
         RdUKbB9ZN6I946pId/WBw3VRzKeuZciFCBYfXdfCVHMyonvl8fPe0oMrw/vaocQSi+rx
         H+/iFgg1iVgFIfJRM+0XSF5xN98/P2WTAPGQ5wJeZQPQutwt9SqJm9WIxn/Rv0H4rLvC
         A+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kK3961eorNxM4lj9kYWmSj90jPI1PLhvK9paSEcnVxg=;
        b=Oc+DrhqWwcsbQRBCTjMmwNxiqc4d9j083qojV54mG5G66xyTV+vzUq+yxE9W1yqyEC
         Dpp2WEz1CIfSieOGmvmi+J4PtnxosUr3JGBrDSmjsaaiSfgAHddr+JGp9FDZZjVwJmFn
         UqcSx0v+v4aldqBMjzc3/+57XkgM8/9vplG+YFBKYwt5U2RybIJZgFp5Wn9Wxth9Bx1j
         pgo9kZrq7r0Pdo6lADc/s+9NQIYIGx1mkxd9Yw4TvbmThMWAI2rwMvQ84ugC0pgRPyj7
         fGInLkbN6DiQkRCK9NKaoaSUtsqJFY+bPnXfos0n7xhc0QdewKKeOtiMPmNSwC/9UVVd
         31GA==
X-Gm-Message-State: AD7BkJJnIDo8LhpotUzrZJG4IlIclFt45k7bJ1BQI5bAxT/jNnQlD3hNDrgnQJWBNK3kvw==
X-Received: by 10.55.73.74 with SMTP id w71mr51216374qka.60.1459980764085;
        Wed, 06 Apr 2016 15:12:44 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290874>

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
index 24d6c0e..8ad8e1f 100644
--- a/Makefile
+++ b/Makefile
@@ -453,6 +453,7 @@ MSGFMT =3D msgfmt
 CURL_CONFIG =3D curl-config
 PTHREAD_LIBS =3D -lpthread
 PTHREAD_CFLAGS =3D
+WATCHMAN_LIBS =3D
 GCOV =3D gcov
=20
 export TCL_PATH TCLTK_PATH
@@ -1419,6 +1420,13 @@ else
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
@@ -2030,6 +2038,9 @@ git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAG=
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
@@ -2169,6 +2180,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PYTHON=3D\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' =
>>$@+
 	@echo NO_UNIX_SOCKETS=3D\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SO=
CKETS)))'\' >>$@+
 	@echo HAVE_SHM=3D\''$(subst ','\'',$(subst ','\'',$(HAVE_SHM)))'\' >>=
$@+
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
