From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 29/32] gc: support prune --repos
Date: Wed,  9 Jul 2014 14:33:14 +0700
Message-ID: <1404891197-18067-30-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:36:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mQE-0004XK-9F
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbaGIHgG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:36:06 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37327 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbaGIHgE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:36:04 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so8624434pdj.29
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0Y/z1lhKE6j8F2O+o6ai7K50rZKph8H0oCKGxVdEGFg=;
        b=MmzT/737hhOwQgzUpy8eBtgGxrmFDC78cwFCWq0XWgiRgYJMDjBNJGSv0UC9A4rP3S
         Jsjl1HMgSZyFbWZ/JLUOTx7bcYpYFEng/AZAus347RVkdnQH6eyoK+n4fLfGE0L+LwQG
         DwSP3t5Vm5V7sivQ41tVEMLzSe4BJNNJ7CDdP6j40kdtEjwH4TrR/aKneYsJAjUmaQox
         uYb8uPFt4bAcaL/JEdpjHoWFLra6RMPpDTG5V25yFKLH3tfCc9IgASLayxV8NzVSc0UI
         8tBzYif+y5G3aZ3+ELbFNg71FZMTUbpGgC5BEnxgV+PNeUoh00dGgTegPBkczePMeFA5
         KjmA==
X-Received: by 10.67.16.67 with SMTP id fu3mr39677669pad.38.1404891363283;
        Wed, 09 Jul 2014 00:36:03 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id fd5sm212602464pad.12.2014.07.09.00.36.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:36:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:36:00 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253104>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  7 +++++++
 builtin/gc.c             | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 286e539..470f979 100644
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
+	"now" may be used to disable the grace period and always prune
+	$GIT_DIR/repos immediately.
+
 gc.reflogexpire::
 gc.<pattern>.reflogexpire::
 	'git reflog expire' removes reflog entries older than
diff --git a/builtin/gc.c b/builtin/gc.c
index 53f1302..1190183 100644
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
@@ -92,6 +94,14 @@ static int gc_config(const char *var, const char *va=
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
@@ -299,6 +309,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
 	argv_array_pushl(&prune, "prune", "--expire", NULL);
+	argv_array_pushl(&prune_repos, "prune", "--repos", "--expire", NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
=20
 	git_config(gc_config, NULL);
@@ -368,6 +379,12 @@ int cmd_gc(int argc, const char **argv, const char=
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
