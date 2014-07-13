From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 28/31] gc: support prune --repos
Date: Sun, 13 Jul 2014 11:51:05 +0700
Message-ID: <1405227068-25506-29-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:55:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BpD-0001lU-7q
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbaGMEzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:55:43 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:49159 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbaGMEzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:55:42 -0400
Received: by mail-pd0-f169.google.com with SMTP id ft15so3484825pdb.14
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xZROWAEk6gkmjFZZNAHbJYB2Hjz6cQWRwjeW0Gpk568=;
        b=y+iDZKwSgLww+NbSOrbBtIXnoOAcjKYijJrP9sv9NA22l+yVXfYt7CTvEs5Um9wuVk
         1gTK7vBsJXuvll0Gty4cV1E0ih0haa+5rfKopAPMstCPtWlD/kDzPVV0wZdId1K8X7+U
         4sOLhj9UVNVfGuyg65HZT43Egq0kfXD5dtITeX9p1s9HxfVbMY1Lvu8vhDi3niP89ON7
         IQTrZ4qQTc9V3CC2zc4HfSXA4d4kz6+sECCodSN/t4aDJBnIweKyEwMlBy6HQgnxm30v
         WkBVy45YCjNerE6VCxh+7YUkMISuGEnFXa2MZqJRVv37nJHQrg+FHbvGiSqHquXv110T
         mb8g==
X-Received: by 10.68.172.193 with SMTP id be1mr8822661pbc.31.1405227341829;
        Sat, 12 Jul 2014 21:55:41 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id pu5sm6765939pbb.4.2014.07.12.21.55.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:55:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:55:42 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253431>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  7 +++++++
 builtin/gc.c             | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 286e539..57999fa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1211,6 +1211,13 @@ gc.pruneexpire::
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
=20
+gc.prunereposexpire::
+	When 'git gc' is run, it will call
+	'prune --repos --expire 3.months.ago'.
+	Override the grace period with this config variable. The value
+	"now" may be used to disable the grace period and prune
+	$GIT_DIR/repos immediately.
+
 gc.reflogexpire::
 gc.<pattern>.reflogexpire::
 	'git reflog expire' removes reflog entries older than
diff --git a/builtin/gc.c b/builtin/gc.c
index e38c902..0c65808 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -33,11 +33,13 @@ static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
 static int detach_auto =3D 1;
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
@@ -97,6 +99,8 @@ static int gc_config(const char *var, const char *val=
ue, void *cb)
 	}
 	if (!strcmp(var, "gc.pruneexpire"))
 		return git_config_date_string(&prune_expire, var, value);
+	if (!strcmp(var, "gc.prunereposexpire"))
+		return git_config_date_string(&prune_repos_expire, var, value);
 	return git_default_config(var, value, cb);
 }
=20
@@ -304,6 +308,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
 	argv_array_pushl(&prune, "prune", "--expire", NULL);
+	argv_array_pushl(&prune_repos, "prune", "--repos", "--expire", NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
=20
 	git_config(gc_config, NULL);
@@ -373,6 +378,12 @@ int cmd_gc(int argc, const char **argv, const char=
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
1.9.1.346.ga2b5940
