From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 25/25] gc: support prune --repos
Date: Tue, 18 Feb 2014 20:40:14 +0700
Message-ID: <1392730814-19656-26-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:43:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkxa-0002Ii-L7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbaBRNmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:42:47 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39595 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773AbaBRNmo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:42:44 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so16253717pde.13
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Pj/wb3WgrgevZTDp5s39pnTz8i/PJVZGaClvHK7Sogg=;
        b=SYqh4IB1c70Pml1DdoKGwxq5vH+5VwmWmR7uRo+sJuV1qHNPB4zNujKZ3IYNfg4/cM
         mPKlcMqTs7O100XDHJvmHxEyxweR8gw4Al9bNxJ343iJHXhLGc/KNwM5grZ9r7eqIDrg
         sbqjTXizVuAd8oyySyHJSyNGVxNPCX+dtF2c8mvPq2JYXkG5m6z2XsKPF8h5kCA7ybpH
         vY7UWlxQtUrL4qYJbmrxhDHZE5HEIawWNhNMD0b4H7dMPw5JhzwrsiL3wq4rMTGXv2H0
         225c3OyisutwCsU7qX91OB3Zklw3iq/z0ivuMKODtSjks27+Vd7bqwOpG6ZDENN+rhCF
         f5ig==
X-Received: by 10.66.250.202 with SMTP id ze10mr10212319pac.153.1392730964154;
        Tue, 18 Feb 2014 05:42:44 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id qh2sm142635495pab.13.2014.02.18.05.42.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:42:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:42:56 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242322>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  6 ++++++
 builtin/gc.c             | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cbf4d97..eec2d05 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1182,6 +1182,12 @@ gc.pruneexpire::
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
=20
+gc.prunereposexpire::
+	When 'git gc' is run, it will call 'prune --repos --expire 3.months.a=
go'.
+	Override the grace period with this config variable.  The value
+	"now" may be used to disable this  grace period and always prune
+	$GIT_DIR/repos immediately.
+
 gc.reflogexpire::
 gc.<pattern>.reflogexpire::
 	'git reflog expire' removes reflog entries older than
diff --git a/builtin/gc.c b/builtin/gc.c
index c19545d..fbeba86 100644
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
 	argv_array_pushl(&prune, "prune", "--expire", NULL );
+	argv_array_pushl(&prune_repos, "prune", "--repos", "--expire", NULL )=
;
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
1.8.5.2.240.g8478abd
