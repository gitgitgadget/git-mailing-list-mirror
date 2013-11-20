From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] diff: restrict pathspec limitations to diff b/f case only
Date: Wed, 20 Nov 2013 08:26:41 +0700
Message-ID: <1384910801-11125-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 02:27:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViwZI-0006mv-H2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 02:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab3KTB0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Nov 2013 20:26:53 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:65461 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab3KTB0u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 20:26:50 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so5931231pdi.38
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 17:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=OJM4Tdvp75hybJj8zKCz82BfbUZIcgpMFPUTytlQtm0=;
        b=qGcDEu211s08UXyzYdkjvKk9o1dPEdbXLADzLPjeE0qPA/Aam5aq84gl9eeBRYFrPu
         K5qi3XhDEAR31KE33kxJz3DI/u5/obzASy8U4qEoZ5nXxTgRBPn/lZv/I1It75b9DzOn
         VxF74+97lfrijZFUUhbQkw9YB4m3dRh9PLjPhwlUUBpF3Tq+BZoJw5M1vjxDMvLjd6XT
         Wbf9kZ5qs+zd5POQPUzkIfql13g7b6r5RZQOVuoGJ9jkkimBWVA/ukdYj4pINSOfF0Zi
         li3iaedVBgXipizzkl5NMhzEexhtDmCaus4gjv8fvT5l3VSauXSszyTt+gXSGOoY0HS1
         LG9g==
X-Received: by 10.66.145.4 with SMTP id sq4mr59980pab.178.1384910809916;
        Tue, 19 Nov 2013 17:26:49 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id wp8sm33560536pbc.26.2013.11.19.17.26.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 19 Nov 2013 17:26:49 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 20 Nov 2013 08:26:44 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238060>

builtin_diff_b_f() needs a path, not pathspec. Other modes in diff
can deal with pathspec just fine. But because of the current
GUARD_PATHSPEC() location, other modes also reject :(glob) and
:(icase).

Move GUARD_PATHSPEC(), and the "path" assignment statement, which is
the reason of this GUARD_PATHSPEC(), inside builtin_diff_b_f().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/diff.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index adb93a9..fe0cc7f 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -64,15 +64,18 @@ static void stuff_change(struct diff_options *opt,
=20
 static int builtin_diff_b_f(struct rev_info *revs,
 			    int argc, const char **argv,
-			    struct blobinfo *blob,
-			    const char *path)
+			    struct blobinfo *blob)
 {
 	/* Blob vs file in the working tree*/
 	struct stat st;
+	const char *path;
=20
 	if (argc > 1)
 		usage(builtin_diff_usage);
=20
+	GUARD_PATHSPEC(&revs->prune_data, PATHSPEC_FROMTOP | PATHSPEC_LITERAL=
);
+	path =3D revs->prune_data.items[0].match;
+
 	if (lstat(path, &st))
 		die_errno(_("failed to stat '%s'"), path);
 	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
@@ -255,7 +258,6 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	struct rev_info rev;
 	struct object_array ent =3D OBJECT_ARRAY_INIT;
 	int blobs =3D 0, paths =3D 0;
-	const char *path =3D NULL;
 	struct blobinfo blob[2];
 	int nongit;
 	int result =3D 0;
@@ -366,13 +368,8 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
 			die(_("unhandled object '%s' given."), name);
 		}
 	}
-	if (rev.prune_data.nr) {
-		/* builtin_diff_b_f() */
-		GUARD_PATHSPEC(&rev.prune_data, PATHSPEC_FROMTOP | PATHSPEC_LITERAL)=
;
-		if (!path)
-			path =3D rev.prune_data.items[0].match;
+	if (rev.prune_data.nr)
 		paths +=3D rev.prune_data.nr;
-	}
=20
 	/*
 	 * Now, do the arguments look reasonable?
@@ -385,7 +382,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 		case 1:
 			if (paths !=3D 1)
 				usage(builtin_diff_usage);
-			result =3D builtin_diff_b_f(&rev, argc, argv, blob, path);
+			result =3D builtin_diff_b_f(&rev, argc, argv, blob);
 			break;
 		case 2:
 			if (paths)
--=20
1.8.2.82.gc24b958
