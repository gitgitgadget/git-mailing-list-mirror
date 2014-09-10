From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 28/32] gc: support prune --worktrees
Date: Thu, 11 Sep 2014 05:42:04 +0700
Message-ID: <1410388928-32265-29-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:44:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqd0-0002Vy-8p
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbaIJWoi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:44:38 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34886 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaIJWoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:44:37 -0400
Received: by mail-pd0-f178.google.com with SMTP id p10so9088172pdj.9
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=p4YlTP1ZloIvgtbeubNbjbIErYSqSv7Stv3Y1npOWeI=;
        b=c/osc/fD7DGHOh+HQkyxEZ/a/6jzkd1ij4/x12rXgD6T0HK9BjUADuacPapGKOanbh
         /XGUZSMMOjTn4kZ5j3acsBNc21bRZO7e4Rc4j9rxAcZjwva6gqj1XbODR+dlTnOPnTLu
         apgOSBTCvfirloWhVFkb12whPLOTGyhCnkvl9rUhKe+NIlT3RDoYws0n5gc+kqnNgvKZ
         91+TWojCL6lz1oSYFHw+kNFRyDI/w2MuYB9s8TGI3jFJNlWlLkCpbjBslSBeKILaZ68C
         DXcGnEn29tZ122gVjxzIjSCkJpyqGC3b9bk/csNg4yHqFLXHQ1kGcwtxNzjNV8FQ2g12
         76ng==
X-Received: by 10.68.68.134 with SMTP id w6mr40484302pbt.110.1410389077392;
        Wed, 10 Sep 2014 15:44:37 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id wi10sm15407124pbc.95.2014.09.10.15.44.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:44:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:44:56 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256805>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt       |  7 +++++++
 Documentation/git-checkout.txt |  2 +-
 builtin/gc.c                   | 11 +++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 286e539..a85f684 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1211,6 +1211,13 @@ gc.pruneexpire::
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
=20
+gc.pruneworktreesexpire::
+	When 'git gc' is run, it will call
+	'prune --worktrees --expire 3.months.ago'.
+	Override the grace period with this config variable. The value
+	"now" may be used to disable the grace period and prune
+	$GIT_DIR/worktrees immediately.
+
 gc.reflogexpire::
 gc.<pattern>.reflogexpire::
 	'git reflog expire' removes reflog entries older than
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index a29748e..23f0c80 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -433,7 +433,7 @@ inside $GIT_DIR. Use `git rev-parse --git-path` to =
get the final path.
=20
 When you are done, simply deleting the linked working directory would
 suffice. $GIT_DIR/worktrees can be cleaned up using `git prune
---worktrees`.
+--worktrees`, which is part of automated garbage collection.
=20
 After you move a linked working directory to another file system, or
 on a file system that does not support hard link, execute any git
diff --git a/builtin/gc.c b/builtin/gc.c
index e38c902..00239ca 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -33,11 +33,13 @@ static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
 static int detach_auto =3D 1;
 static const char *prune_expire =3D "2.weeks.ago";
+static const char *prune_worktrees_expire =3D "3.months.ago";
=20
 static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
 static struct argv_array reflog =3D ARGV_ARRAY_INIT;
 static struct argv_array repack =3D ARGV_ARRAY_INIT;
 static struct argv_array prune =3D ARGV_ARRAY_INIT;
+static struct argv_array prune_worktrees =3D ARGV_ARRAY_INIT;
 static struct argv_array rerere =3D ARGV_ARRAY_INIT;
=20
 static char *pidfile;
@@ -97,6 +99,8 @@ static int gc_config(const char *var, const char *val=
ue, void *cb)
 	}
 	if (!strcmp(var, "gc.pruneexpire"))
 		return git_config_date_string(&prune_expire, var, value);
+	if (!strcmp(var, "gc.pruneworktreesexpire"))
+		return git_config_date_string(&prune_worktrees_expire, var, value);
 	return git_default_config(var, value, cb);
 }
=20
@@ -304,6 +308,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
 	argv_array_pushl(&prune, "prune", "--expire", NULL);
+	argv_array_pushl(&prune_worktrees, "prune", "--worktrees", "--expire"=
, NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
=20
 	git_config(gc_config, NULL);
@@ -373,6 +378,12 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 			return error(FAILED_RUN, prune.argv[0]);
 	}
=20
+	if (prune_worktrees_expire) {
+		argv_array_push(&prune_worktrees, prune_worktrees_expire);
+		if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
+			return error(FAILED_RUN, prune_worktrees.argv[0]);
+	}
+
 	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, rerere.argv[0]);
=20
--=20
2.1.0.rc0.78.gc0d8480
