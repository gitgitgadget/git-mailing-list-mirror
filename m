From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Remove empty ref directories while reading loose refs
Date: Fri, 10 Feb 2012 23:25:27 +0700
Message-ID: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 17:19:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvtCA-0003gX-7H
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 17:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380Ab2BJQTa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 11:19:30 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37436 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab2BJQT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 11:19:29 -0500
Received: by pbcun15 with SMTP id un15so2541617pbc.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 08:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=cYGTCm4x6effITxANU/dSdXM8dLut5+7jxOOCWG1tCE=;
        b=M6OjKgRZoyTbsuxwPseZkF0nOnWIIovARK521etz/aY5hVX4Wn5aWVUmH4BAz43/XX
         T3SlbnCpbqJ/lLSHwvL1fWvXVidG1RXF6qtPM7aPAV3YsbloJNnTKbY+CntzYkgzH5lU
         2g0n71MU6ij4zjQlB6IfpOfo4MXe5GmYX/qxk=
Received: by 10.68.223.68 with SMTP id qs4mr17417733pbc.112.1328890768641;
        Fri, 10 Feb 2012 08:19:28 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id b7sm14744302pba.2.2012.02.10.08.19.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 08:19:27 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 10 Feb 2012 23:25:29 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190415>

Empty directories in $GIT_DIR/refs increases overhead at startup.
Removing a ref does not remove its parent directories even if it's the
only file left so empty directories will be hanging around.

pack-refs was taught of cleaning up empty directories in be7c6d4
(pack-refs: remove newly empty directories - 2010-07-06), but it only
checks parent directories of packed refs only. Already empty dirs are
left untouched.

This patch removes empty directories as we see while traversing
$GIT_DIR/refs and reverts be7c6d4 because it's no longer needed.

Some directories, even if empty, are not removed:

 - refs: this one is needed to recognize a git repository
 - refs/heads and refs/tags: these are created by init-db, people may
   expect them to always be there

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I don't think the a few extra rmdir()s from time to time at startup
 are going to cause any problems. Making delete_ref() delete empty
 directories takes more effort and probably not worth it.

 Of course this only works if people do not expect empty directories
 to stay in $GIT_DIR/refs permanently. They now may need to put .keep
 file in to keep parent directories from being removed. Would anyone
 do that?

 pack-refs.c          |   32 --------------------------------
 refs.c               |   14 +++++++++++++-
 t/t3210-pack-refs.sh |    6 ------
 3 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index f09a054..ec9e476 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -60,37 +60,6 @@ static int handle_one_ref(const char *path, const un=
signed char *sha1,
 	return 0;
 }
=20
-/*
- * Remove empty parents, but spare refs/ and immediate subdirs.
- * Note: munges *name.
- */
-static void try_remove_empty_parents(char *name)
-{
-	char *p, *q;
-	int i;
-	p =3D name;
-	for (i =3D 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
-		while (*p && *p !=3D '/')
-			p++;
-		/* tolerate duplicate slashes; see check_refname_format() */
-		while (*p =3D=3D '/')
-			p++;
-	}
-	for (q =3D p; *q; q++)
-		;
-	while (1) {
-		while (q > p && *q !=3D '/')
-			q--;
-		while (q > p && *(q-1) =3D=3D '/')
-			q--;
-		if (q =3D=3D p)
-			break;
-		*q =3D '\0';
-		if (rmdir(git_path("%s", name)))
-			break;
-	}
-}
-
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
@@ -99,7 +68,6 @@ static void prune_ref(struct ref_to_prune *r)
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
 		unlock_ref(lock);
-		try_remove_empty_parents(r->name);
 	}
 }
=20
diff --git a/refs.c b/refs.c
index b8843bb..80ebba3 100644
--- a/refs.c
+++ b/refs.c
@@ -343,6 +343,12 @@ static void get_ref_dir(struct ref_cache *refs, co=
nst char *base,
 		struct dirent *de;
 		int baselen =3D strlen(base);
 		char *refname =3D xmalloc(baselen + 257);
+		int empty_dir =3D 1;
+
+		if (!strcmp(base, "refs") ||
+		    !strcmp(base, "refs/heads") ||
+		    !strcmp(base, "refs/tags"))
+			empty_dir =3D 0;
=20
 		memcpy(refname, base, baselen);
 		if (baselen && base[baselen-1] !=3D '/')
@@ -355,8 +361,12 @@ static void get_ref_dir(struct ref_cache *refs, co=
nst char *base,
 			int namelen;
 			const char *refdir;
=20
-			if (de->d_name[0] =3D=3D '.')
+			if (de->d_name[0] =3D=3D '.') {
+				if (de->d_name[1] !=3D '.' || de->d_name[2])
+					empty_dir =3D 0;
 				continue;
+			}
+			empty_dir =3D 0;
 			namelen =3D strlen(de->d_name);
 			if (namelen > 255)
 				continue;
@@ -387,6 +397,8 @@ static void get_ref_dir(struct ref_cache *refs, con=
st char *base,
 		}
 		free(refname);
 		closedir(dir);
+		if (empty_dir)
+			rmdir(path);
 	}
 }
=20
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index cd04361..5251740 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -60,12 +60,6 @@ test_expect_success 'see if git pack-refs --prune re=
move ref files' '
      ! test -f .git/refs/heads/f
 '
=20
-test_expect_success 'see if git pack-refs --prune removes empty dirs' =
'
-     git branch r/s/t &&
-     git pack-refs --all --prune &&
-     ! test -e .git/refs/heads/r
-'
-
 test_expect_success \
     'git branch g should work when git branch g/h has been deleted' \
     'git branch g/h &&
--=20
1.7.8.36.g69ee2
