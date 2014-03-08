From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 27/28] gc: support prune --repos
Date: Sat,  8 Mar 2014 09:48:19 +0700
Message-ID: <1394246900-31535-28-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:50:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7LY-0006O7-SE
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbaCHCui convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:50:38 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37880 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbaCHCuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:50:37 -0500
Received: by mail-pa0-f50.google.com with SMTP id kq14so4953315pab.37
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XGkPvBtfByjiBqGjmf6X0K9B/cw4WoKakArUgB4a47Q=;
        b=oaJuIOlZqY+/LPhysPGGYMMlwdcLWuYxAHrhc7LbCmRe/87EszMjhbos4eqzL4UCKu
         mQoDYfO+n1SFp3IzpiXMV95TofzfEhgKhDnpglH0POXIyo3xFvZKbrG1bmU8Hij6ohOb
         nUxiUzpI5VtjgBSP26TiyTiZYOvTItUi4xBr8PBC8YuOdQTYslGN+Ka+OwCj1m560dTn
         pAh04WBkOXp11gXoJigplbAhG/tH3vxRPu30DKBopsNie1vsx5mhyCk9NXhYD59DiYVJ
         GbiQRzku9QT8MTVS9MT3Ul6qMmZex4OkDuI23SGBliKCXGVcN83nEk+RcW8INO1ggsmF
         DP0A==
X-Received: by 10.66.141.197 with SMTP id rq5mr26426443pab.64.1394247036725;
        Fri, 07 Mar 2014 18:50:36 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id qw8sm42173821pbb.27.2014.03.07.18.50.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:50:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:51:09 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243668>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  7 +++++++
 builtin/gc.c             | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 313d4b3..c635b8d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1183,6 +1183,13 @@ gc.pruneexpire::
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
=20
+gc.prunereposexpire::
+	When 'git gc' is run, it will call
+	'prune --repos --expire 3.months.ago'.
+	Override the grace period with this config variable. The value
+	"now" may be used to disable the grace period and always prune
+	$GIT_DIR/repos immediately.
+
 gc.reflogexpire::
 gc.<pattern>.reflogexpire::
 	'git reflog expire' removes reflog entries older than
diff --git a/builtin/gc.c b/builtin/gc.c
index 39d9b27..85c3c0c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -30,11 +30,13 @@ static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
 static const char *prune_expire =3D "2.weeks.ago";
+static const char *prune_repos_expire =3D "3.months.ago";
=20
 static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
 static struct argv_array reflog =3D ARGV_ARRAY_INIT;
 static struct argv_array repack =3D ARGV_ARRAY_INIT;
 static struct argv_array prune =3D ARGV_ARRAY_INIT;
+static struct argv_array prune_repos =3D ARGV_ARRAY_INIT;
 static struct argv_array rerere =3D ARGV_ARRAY_INIT;
=20
 static char *pidfile;
@@ -81,6 +83,14 @@ static int gc_config(const char *var, const char *va=
lue, void *cb)
 		}
 		return git_config_string(&prune_expire, var, value);
 	}
+	if (!strcmp(var, "gc.prunereposexpire")) {
+		if (value && strcmp(value, "now")) {
+			unsigned long now =3D approxidate("now");
+			if (approxidate(value) >=3D now)
+				return error(_("Invalid %s: '%s'"), var, value);
+		}
+		return git_config_string(&prune_repos_expire, var, value);
+	}
 	return git_default_config(var, value, cb);
 }
=20
@@ -274,6 +284,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
 	argv_array_pushl(&prune, "prune", "--expire", NULL);
+	argv_array_pushl(&prune_repos, "prune", "--repos", "--expire", NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
=20
 	git_config(gc_config, NULL);
@@ -334,6 +345,12 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 			return error(FAILED_RUN, prune.argv[0]);
 	}
=20
+	if (prune_repos_expire) {
+		argv_array_push(&prune_repos, prune_repos_expire);
+		if (run_command_v_opt(prune_repos.argv, RUN_GIT_CMD))
+			return error(FAILED_RUN, prune_repos.argv[0]);
+	}
+
 	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, rerere.argv[0]);
=20
--=20
1.9.0.40.gaa8c3ea
