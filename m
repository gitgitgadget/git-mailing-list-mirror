From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] Add watchman support to reduce index refresh cost
Date: Sun,  1 Nov 2015 14:55:43 +0100
Message-ID: <1446386146-10438-3-git-send-email-pclouds@gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:56:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zst7G-0002GJ-E3
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbbKAN4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:56:11 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36611 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbbKAN4G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:56:06 -0500
Received: by wicfx6 with SMTP id fx6so35373829wic.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=f5560h+XY3Woj9s4ZZjgBECU2E8C1IzHgp6vithmLvU=;
        b=aYv5xy+FYtFeLPrxwA6Hn4X75AfjJXNl4uVG04AR3EACKt9jOwT+P4xXmB4wEYeMmE
         zGDNUbW9AUOJ5jGJ76luxsDsFPjKrTbkZJRXAT5p2FW6DeuDcRJJGXL+MRwu08sF4j1P
         7XQXf4orbKOGXIMDek4ZWN7jkGb/uHXELjKXAupiTXoiwkB1tV9nGRJJv5WiDbf2qemA
         B4mlpv9OGbsONm8JNXHPBVK5wdeu5t0gLti3wzjWBICBBK0DcpBUqH/uOeGDgL2A20gc
         Ns1SCoWPL8Y6nSXkn7pffWCm9Spw1Ehrn0D2JkH54VDsFn7ySWXvgXc/5ltyOnqfAd2a
         C8EA==
X-Received: by 10.194.8.227 with SMTP id u3mr18532125wja.38.1446386164934;
        Sun, 01 Nov 2015 05:56:04 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id bk2sm17185525wjc.3.2015.11.01.05.56.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:56:03 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280630>

The previous patch has the logic to clear bits in 'WAMA' bitmap. This
patch has logic to set bits as told by watchman. The missing bit,
_using_ these bits, are not here yet.

A lot of this code is written by David Turner originally, mostly from
[1]. I'm just copying and polishing it a bit.

[1] http://article.gmane.org/gmane.comp.version-control.git/248006

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile                 |   7 +++
 cache.h                  |   1 +
 config.c                 |   5 +++
 configure.ac             |   8 ++++
 environment.c            |   3 ++
 watchman-support.c (new) | 108 +++++++++++++++++++++++++++++++++++++++=
++++++++
 watchman-support.h (new) |   8 ++++
 7 files changed, 140 insertions(+)
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

diff --git a/Makefile b/Makefile
index c01cd2e..761acb6 100644
--- a/Makefile
+++ b/Makefile
@@ -1389,6 +1389,12 @@ else
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
@@ -2135,6 +2141,7 @@ GIT-BUILD-OPTIONS: FORCE
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
index a05fd31..572299c 100644
--- a/cache.h
+++ b/cache.h
@@ -648,6 +648,7 @@ extern char *git_replace_ref_base;
=20
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_watchman_sync_timeout;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index 248a21a..6b63f66 100644
--- a/config.c
+++ b/config.c
@@ -881,6 +881,11 @@ static int git_default_core_config(const char *var=
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
index 76170ad..9772f79 100644
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
index 2da7fe2..84df431 100644
--- a/environment.c
+++ b/environment.c
@@ -87,6 +87,9 @@ int auto_comment_line_char;
 /* Parallel index stat data preload? */
 int core_preload_index =3D 1;
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
index 0000000..7f6c0a9
--- /dev/null
+++ b/watchman-support.c
@@ -0,0 +1,108 @@
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
+			istate->cache[i]->ce_flags |=3D CE_NO_WATCH;
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
+		istate->cache[pos]->ce_flags |=3D CE_NO_WATCH;
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
+
+	fs_path =3D get_git_work_tree();
+	if (!fs_path)
+		return -1;
+
+	connection =3D watchman_connect(&wm_error);
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
index 0000000..5610409
--- /dev/null
+++ b/watchman-support.h
@@ -0,0 +1,8 @@
+#ifndef WATCHMAN_SUPPORT_H
+#define WATCHMAN_SUPPORT_H
+
+struct index_state;
+int check_watchman(struct index_state *index);
+
+
+#endif /* WATCHMAN_SUPPORT_H */
--=20
2.2.0.513.g477eb31
