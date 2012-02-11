From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] pack-refs: remove all empty directories under $GIT_DIR/refs
Date: Sat, 11 Feb 2012 14:55:06 +0700
Message-ID: <1328946907-31650-1-git-send-email-pclouds@gmail.com>
References: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 08:49:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw7hp-0002AJ-Kb
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 08:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab2BKHtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 02:49:07 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34463 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab2BKHtG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 02:49:06 -0500
Received: by daed14 with SMTP id d14so2970903dae.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 23:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vSrBEEwLjEqZb5da2NoGpcy4CI05/SaFr/nuaTYcCTs=;
        b=BYAir6aEv4punb+uJ79mOdQdCifRZniFNsODjjs9L0M8ep9+OQXk9XFfWQihjAfC7T
         7l2powT5KUB4xc4K2OFfM3OCnWI0MXdlUtAKhY44APby2NKSeoU/drNK5R+5YtCHZvyc
         RrWZbz3qNNRjpAJy+p+WyV7DtiprSkO2/sU6Y=
Received: by 10.68.74.134 with SMTP id t6mr23684581pbv.26.1328946544965;
        Fri, 10 Feb 2012 23:49:04 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id x8sm19988507pbr.11.2012.02.10.23.49.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 23:49:04 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 11 Feb 2012 14:55:15 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190495>

Deleting refs does not remove parent directories if they are empty.
Empty directories add extra overhead to startup time of most of git
commands because they have to traverse $GIT_DIR/refs.

Some directories are kept by this patch even if they are empty (refs,
refs/heads and refs/tags). The first one is one of git repository
signature. The rest is created by init-db, one may expect them to alway=
s
be there.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v2, no more refs code change.

 Part of the reason I do not want to update delete_ref() is because it
 won't remove empty directories in existing repositories.

 pack-refs.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index f09a054..bb3a9c4 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -91,6 +91,58 @@ static void try_remove_empty_parents(char *name)
 	}
 }
=20
+static int prune_empty_dirs(const char *path)
+{
+	int nr_entries =3D 0, pathlen =3D strlen(path);
+	DIR *dir;
+	struct dirent *de;
+	char *subpath;
+
+	dir =3D opendir(git_path("%s", path));
+
+	if (!dir)
+		return 0;
+
+	subpath =3D xmalloc(pathlen + 257);
+	memcpy(subpath, path, pathlen);
+	if (pathlen && path[pathlen-1] !=3D '/')
+		subpath[pathlen++] =3D '/';
+
+	while ((de =3D readdir(dir)) !=3D NULL) {
+		struct stat st;
+		int namelen;
+
+		if (de->d_name[0] =3D=3D '.') {
+			if (strcmp(de->d_name, "..") && strcmp(de->d_name, "."))
+				nr_entries++;
+			continue;
+		}
+		nr_entries++;
+		namelen =3D strlen(de->d_name);
+		if (namelen > 255)
+			continue;
+		if (has_extension(de->d_name, ".lock"))
+			continue;
+		memcpy(subpath + pathlen, de->d_name, namelen+1);
+		if (stat(git_path("%s", subpath), &st) < 0)
+			continue;
+		if (S_ISDIR(st.st_mode)) {
+			int removed =3D prune_empty_dirs(subpath);
+			if (removed)
+				nr_entries--;
+			continue;
+		}
+	}
+	free(subpath);
+	closedir(dir);
+	if (nr_entries =3D=3D 0 &&
+	    strcmp(path, "refs") &&
+	    strcmp(path, "refs/heads") &&
+	    strcmp(path, "refs/tags"))
+		return rmdir(git_path("%s", path)) =3D=3D 0;
+	return 0;
+}
+
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
@@ -109,6 +161,7 @@ static void prune_refs(struct ref_to_prune *r)
 		prune_ref(r);
 		r =3D r->next;
 	}
+	prune_empty_dirs("refs");
 }
=20
 static struct lock_file packed;
--=20
1.7.8.36.g69ee2
