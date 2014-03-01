From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 26/27] gc: support prune --repos
Date: Sat,  1 Mar 2014 19:13:02 +0700
Message-ID: <1393675983-3232-27-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:23:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJixA-0002rF-Bd
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbaCAMXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:23:35 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:53501 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbaCAMXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:23:32 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so1857326pdi.7
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cNsndOYnf+YwL0FV1PD32GNjRTpFok0CuE6tfSxpLpQ=;
        b=gzlb8WyRDkyhw5X637wOIOxE9FA0oYPGsjHGtRnDMC4l+PzsWfSADslAI1GtUFsUIT
         virUgOnSiLE5q1K3i7bbebx8D0cbb9PLZWKNtvZGTJUDJxrO5ymsAXfIw46+0uCuGM7I
         LDAW1Y04V/Bdkc/v8JM6AT/5UVZMc6Cc7RMIT3OzZxu2H0bJItf+DU091zc1/pcZCPkO
         +iOtzx5Tdj1UPs06DV2nMxdpjaq2A4JHhV1AwQEYUPwE/AyQmdNEf3IK2R0xl6HIFmav
         BzNx3SMXpMUuBzUhUdLNePWEazDlO5PRkWSnsTfvl2WxaBXr6N/evlWsvlmitExCmzM1
         ajOA==
X-Received: by 10.68.201.226 with SMTP id kd2mr68242pbc.157.1393676611988;
        Sat, 01 Mar 2014 04:23:31 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id x5sm15914114pbw.26.2014.03.01.04.23.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:23:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:23:56 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243090>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  6 ++++++
 builtin/gc.c             | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 313d4b3..438b213 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1183,6 +1183,12 @@ gc.pruneexpire::
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
