From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] prune: handle --progress/no-progress
Date: Wed,  9 Nov 2011 11:23:17 +0700
Message-ID: <1320812597-11175-1-git-send-email-pclouds@gmail.com>
References: <20111108053407.GA16852@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 09 05:23:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNzhL-00042F-Lx
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 05:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab1KIEXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 23:23:30 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55101 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1KIEX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 23:23:29 -0500
Received: by pzk2 with SMTP id 2so623352pzk.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 20:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lQYC6HeBcvp4Y/U+b/oT77hxYudtjcR13rFsB7BGLh4=;
        b=n/yTWZ5Rz9Oa+ebcc6vudaz5v2AJ1+sWWJ7kXJ/LMeQaQSLSLllMKAicPqVcKI0v6A
         Qzj7hiap1jpCTU6aDfS8QdA3TU11chbpYfG+JlPQnQCiJiqeUC9AdWCm3Smt4RPme4c+
         GxnebYZii+efA/tzmMrVUv8y+RPNpRV8eXg9g=
Received: by 10.68.36.37 with SMTP id n5mr1985383pbj.105.1320812609030;
        Tue, 08 Nov 2011 20:23:29 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id b8sm9619777pba.16.2011.11.08.20.23.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Nov 2011 20:23:27 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Nov 2011 11:23:19 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <20111108053407.GA16852@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185144>

=46rom: Jeff King <peff@peff.net>

And have "git gc" pass no-progress when quiet.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Added documentation.

 Documentation/git-prune.txt |    9 ++++++++-
 builtin/gc.c                |    4 +++-
 builtin/prune.c             |   11 +++++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 80d01b0..6da99e2 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -9,7 +9,7 @@ git-prune - Prune all unreachable objects from the obje=
ct database
 SYNOPSIS
 --------
 [verse]
-'git prune' [-n] [-v] [--expire <expire>] [--] [<head>...]
+'git prune' [-n] [-v] [--expire <expire>] [--[no-]progress] [--] [<hea=
d>...]
=20
 DESCRIPTION
 -----------
@@ -46,6 +46,13 @@ OPTIONS
 --expire <time>::
 	Only expire loose objects older than <time>.
=20
+--progress::
+--no-progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless --no-progress
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
+
 <head>...::
 	In addition to objects
 	reachable from any of our references, keep objects
diff --git a/builtin/gc.c b/builtin/gc.c
index 0498094..271376d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,7 +32,7 @@ static const char *prune_expire =3D "2.weeks.ago";
 static const char *argv_pack_refs[] =3D {"pack-refs", "--all", "--prun=
e", NULL};
 static const char *argv_reflog[] =3D {"reflog", "expire", "--all", NUL=
L};
 static const char *argv_repack[MAX_ADD] =3D {"repack", "-d", "-l", NUL=
L};
-static const char *argv_prune[] =3D {"prune", "--expire", NULL, NULL};
+static const char *argv_prune[] =3D {"prune", "--expire", NULL, NULL, =
NULL};
 static const char *argv_rerere[] =3D {"rerere", "gc", NULL};
=20
 static int gc_config(const char *var, const char *value, void *cb)
@@ -243,6 +243,8 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
=20
 	if (prune_expire) {
 		argv_prune[2] =3D prune_expire;
+		if (quiet)
+			argv_prune[3] =3D "--no-progress";
 		if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
 			return error(FAILED_RUN, argv_prune[0]);
 	}
diff --git a/builtin/prune.c b/builtin/prune.c
index 6b39d3f..58d7cb8 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -15,6 +15,7 @@ static const char * const prune_usage[] =3D {
 static int show_only;
 static int verbose;
 static unsigned long expire;
+static int show_progress =3D -1;
=20
 static int prune_tmp_object(const char *path, const char *filename)
 {
@@ -125,10 +126,11 @@ static void remove_temporary_files(const char *pa=
th)
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-	struct progress *progress;
+	struct progress *progress =3D NULL;
 	const struct option options[] =3D {
 		OPT__DRY_RUN(&show_only, "do not remove, show only"),
 		OPT__VERBOSE(&verbose, "report pruned objects"),
+		OPT_BOOL(0, "progress", &show_progress, "show progress"),
 		OPT_DATE(0, "expire", &expire,
 			 "expire objects older than <time>"),
 		OPT_END()
@@ -154,7 +156,12 @@ int cmd_prune(int argc, const char **argv, const c=
har *prefix)
 		else
 			die("unrecognized argument: %s", name);
 	}
-	progress =3D start_progress_delay("Checking connectivity", 0, 0, 2);
+
+	if (show_progress =3D=3D -1)
+		show_progress =3D isatty(2);
+	if (show_progress)
+		progress =3D start_progress_delay("Checking connectivity", 0, 0, 2);
+
 	mark_reachable_objects(&revs, 1, progress);
 	stop_progress(&progress);
 	prune_object_dir(get_object_directory());
--=20
1.7.3.1.256.g2539c.dirty
