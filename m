From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/32] gc: support prune --repos
Date: Sat, 30 Aug 2014 15:33:58 +0700
Message-ID: <1409387642-24492-29-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:36:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe99-0003IS-GQ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbaH3IgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:36:25 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51105 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbaH3IgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:36:23 -0400
Received: by mail-pa0-f53.google.com with SMTP id fa1so8199362pad.12
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NFArePrS2PPKHFh3TNiXPFYZK4cK/6XvVFcA+Y8zSyY=;
        b=l7ZQDFhm4SuZrx27j2nAkkeZ+Ya+sV0tdAr2R0+dcCKeJfbwIYSL4klpdp1lNwAQOC
         KfLzDd/IxdJzdRrORHJmW7T4Pd9bxcpveHD9mSI/JQPFiOyNWqsJUDgLIkn0w3IjCLN3
         bG5wkPzd58XLhpDbZdTamQx7DPT4kDiZu0n+OomDXsVTHroTTfGRg4e3awZgvm/cVAjP
         WVUeET0nsJcWisT+yrcmPXe6yhgNwCAbgkcq3S53e4am15dT5u7qoaiSkOJhLPCO0XTv
         wcve653cn5IxEa8RhxXGlJ/l4KbHc3N2ht2hSbDV1zPhDVruETmewJnrOzNFqnDGXZVj
         qwaw==
X-Received: by 10.66.139.36 with SMTP id qv4mr22320501pab.53.1409387783005;
        Sat, 30 Aug 2014 01:36:23 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id aa4sm7668016pad.0.2014.08.30.01.36.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:36:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:36:32 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256237>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480
