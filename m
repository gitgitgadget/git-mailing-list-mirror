From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/5] Add convenient function to do automatic garbage collection
Date: Wed, 16 May 2012 19:29:33 +0700
Message-ID: <1337171377-26960-2-git-send-email-pclouds@gmail.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
 <1337171377-26960-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Fernando Vezzosi <buccia@repnz.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 14:33:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUdQI-0002H5-Vi
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665Ab2EPMdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:33:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45919 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133Ab2EPMdl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:33:41 -0400
Received: by dady13 with SMTP id y13so927067dad.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yj6d0I+wx73m6yyY8TdFgFjYeWbOz2lFBNPPD5s5rxk=;
        b=N8JV9FLet3SzVI8Y9GCAdcWc4h0IB0FkTzwk+YhQEEqW9djkxA3pdZxYgdWDsUA78g
         /x/je57izE0q2YRP1Bk6GvWEmXdW6jTM+ekgrnhUiGPP7yfvXwYrCpeKn4QFwYjhmx9F
         X9bG6Q+5xnvbR8o0aI01xaj3sS7QLLOyUDVNuuq5VGxMjuw9ICnv9Mv/gtxKjhui3o4X
         VlFlFwAjsMgS8sLzUiF1bhq6DKOiyPk/YLJWsJ0dcaDvnQO01Y7PnKKd3t2femYUt5Gp
         ywnNogP7qLgfyCo1uI3Ba8P0YSPe8Bmpki95qBWkIXuIpgF89wKkQ/NnGhNDEErMhDdE
         tEpw==
Received: by 10.68.242.67 with SMTP id wo3mr10608394pbc.91.1337171620498;
        Wed, 16 May 2012 05:33:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id iw4sm5352061pbc.7.2012.05.16.05.33.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:33:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:29:49 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1337171377-26960-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197874>

This function also avoids forking most of the time by performing some
check in process.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c           |   27 +++++++++++++++++++++++++--
 builtin/gc.h           |    8 ++++++++
 builtin/merge.c        |    8 ++------
 builtin/receive-pack.c |   14 ++------------
 4 files changed, 37 insertions(+), 20 deletions(-)
 create mode 100644 builtin/gc.h

diff --git a/builtin/gc.c b/builtin/gc.c
index 9b4232c..ce60225 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -15,6 +15,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "argv-array.h"
+#include "gc.h"
=20
 #define FAILED_RUN "failed to run %s"
=20
@@ -28,6 +29,7 @@ static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
 static const char *prune_expire =3D "2.weeks.ago";
+static int auto_gc =3D 1;
=20
 static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
 static struct argv_array reflog =3D ARGV_ARRAY_INIT;
@@ -64,6 +66,10 @@ static int gc_config(const char *var, const char *va=
lue, void *cb)
 		}
 		return git_config_string(&prune_expire, var, value);
 	}
+	if (cb && !strcmp(var, cb)) {
+		auto_gc =3D git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
=20
@@ -162,11 +168,24 @@ static int need_to_gc(void)
 	else if (!too_many_loose_objects())
 		return 0;
=20
-	if (run_hook(NULL, "pre-auto-gc", NULL))
-		return 0;
 	return 1;
 }
=20
+int gc(const char *cmd, int flags)
+{
+	const char *av[] =3D { "gc", "--auto", NULL, NULL };
+	int ac =3D 2;
+
+	git_config(gc_config, (void*)cmd);
+
+	if (!auto_gc || !need_to_gc())
+		return 0;
+
+	if (flags & GC_QUIET)
+		av[ac++] =3D "--quiet";
+	return run_command_v_opt(av, RUN_GIT_CMD);
+}
+
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int aggressive =3D 0;
@@ -217,6 +236,10 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
+
+		if (run_hook(NULL, "pre-auto-gc", NULL))
+			return 0;
+
 		if (quiet)
 			fprintf(stderr, _("Auto packing the repository for optimum performa=
nce.\n"));
 		else
diff --git a/builtin/gc.h b/builtin/gc.h
new file mode 100644
index 0000000..3482e92
--- /dev/null
+++ b/builtin/gc.h
@@ -0,0 +1,8 @@
+#ifndef GC_H
+#define GC_H
+
+#define GC_QUIET  1
+
+extern int gc(const char *cmd, int flags);
+
+#endif
diff --git a/builtin/merge.c b/builtin/merge.c
index 470fc57..940259d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -28,6 +28,7 @@
 #include "remote.h"
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
+#include "gc.h"
=20
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -385,15 +386,10 @@ static void finish(struct commit *head_commit,
 		if (verbosity >=3D 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
 		else {
-			const char *argv_gc_auto[] =3D { "gc", "--auto", NULL };
 			update_ref(reflog_message.buf, "HEAD",
 				new_head, head, 0,
 				DIE_ON_ERR);
-			/*
-			 * We ignore errors in 'gc --auto', since the
-			 * user should see them.
-			 */
-			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+			gc(NULL, 0);
 		}
 	}
 	if (new_head && show_diffstat) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0afb8b2..0c1fe25 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -12,6 +12,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "connected.h"
+#include "gc.h"
=20
 static const char receive_pack_usage[] =3D "git receive-pack <git-dir>=
";
=20
@@ -36,7 +37,6 @@ static int use_sideband;
 static int quiet;
 static int prefer_ofs_delta =3D 1;
 static int auto_update_server_info;
-static int auto_gc =3D 1;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
@@ -108,11 +108,6 @@ static int receive_pack_config(const char *var, co=
nst char *value, void *cb)
 		return 0;
 	}
=20
-	if (strcmp(var, "receive.autogc") =3D=3D 0) {
-		auto_gc =3D git_config_bool(var, value);
-		return 0;
-	}
-
 	return git_default_config(var, value, cb);
 }
=20
@@ -973,12 +968,7 @@ int cmd_receive_pack(int argc, const char **argv, =
const char *prefix)
 			report(commands, unpack_status);
 		run_receive_hook(commands, post_receive_hook, 1);
 		run_update_post_hook(commands);
-		if (auto_gc) {
-			const char *argv_gc_auto[] =3D {
-				"gc", "--auto", "--quiet", NULL,
-			};
-			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
-		}
+		gc("receive.autogc", GC_QUIET);
 		if (auto_update_server_info)
 			update_server_info(0);
 	}
--=20
1.7.8.36.g69ee2
