From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] setup: do not change to work tree prematurely
Date: Sun, 23 May 2010 02:07:19 +0200
Message-ID: <20100523000719.GA32380@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 23 02:10:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFymI-0005a5-Pd
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 02:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab0EWAHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 May 2010 20:07:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58298 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab0EWAHn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 20:07:43 -0400
Received: by fxm5 with SMTP id 5so1687795fxm.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 17:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=9VQQdTNQIxyme2ESYQWXnoXGNv4jLRYpd4mZHWmuRho=;
        b=OiOwiUbONz8etQOJ8E5QVhIcCIAMURmmkTV0/KJG4iVx22a2HUDkf6RRvmVO2mjTEQ
         P0UIZk51SbkylQY8a5rsk9qLri4ZweQKcWrM2RkTonT+d/5SWg6d0eFWgM1JEpze7/+N
         no5AwZZivHtlq+ELrf6Ip60JquMR65vwflVc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=H3jpsW29PKR3usi3a590motuXh28OW/VQBg1ZvDlIC5Q44j6K54wfzKt6UZnI+qOr8
         /mmDT0x7vX9lo+B0j4qq2x1k1Ev+a+78mn12vRaT4ulvHN+qHKGrj7lQTRTCwsfeRyVj
         hVIAN/kV62cc8OZQxDKryJqdccYc0bFNDaLco=
Received: by 10.223.5.81 with SMTP id 17mr3160508fau.42.1274573262008;
        Sat, 22 May 2010 17:07:42 -0700 (PDT)
Received: from darc.lan (p549A5187.dip.t-dialin.net [84.154.81.135])
        by mx.google.com with ESMTPS id z12sm11789157fah.21.2010.05.22.17.07.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 17:07:41 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OFyit-0008Sd-LZ; Sun, 23 May 2010 02:07:19 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147552>

If the work tree is known and a git command is invoked from within
a git directory, git_setup_directory() will try to find the
relative path from the work tree to the git dir. After doing so it
changes directories to the work tree. It fails to update the
relative path to the git directory, however.

Instead, do not change the working directory at this point and wait
for git_setup_work_tree() to handle this correctly.

This fixes the following bug.

$ cd .git
$ git --work-tree=3D/tmp/git symbolic-ref HEAD
fatal: ref HEAD is not a symbolic ref

Reported-by: Fr=E9d=E9ric Bri=E8re <fbriere@fbriere.net>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I am not 100% certain that my analysis is correct, since I still do
not understand the setup code. But as far as setup_git_directory()
is concerned, I think this is the intended behavior.

Clemens

 dir.c   |   33 +++++++++++++++++++--------------
 dir.h   |    1 +
 setup.c |   14 +++++++++-----
 3 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/dir.c b/dir.c
index cb83332..7bf208d 100644
--- a/dir.c
+++ b/dir.c
@@ -926,6 +926,24 @@ int file_exists(const char *f)
 	return lstat(f, &sb) =3D=3D 0;
 }
=20
+char *get_relative_path(char *cwd, const char *dir)
+{
+	if (!dir)
+		return NULL;
+	if (!is_absolute_path(dir))
+		dir =3D make_absolute_path(dir);
+
+	while (*dir && *dir =3D=3D *cwd) {
+		dir++;
+		cwd++;
+	}
+	if (*dir)
+		return NULL;
+	if (*cwd =3D=3D '/')
+		return cwd + 1;
+	return cwd;
+}
+
 /*
  * get_relative_cwd() gets the prefix of the current working directory
  * relative to 'dir'.  If we are not inside 'dir', it returns NULL.
@@ -942,25 +960,12 @@ int file_exists(const char *f)
  */
 char *get_relative_cwd(char *buffer, int size, const char *dir)
 {
-	char *cwd =3D buffer;
-
 	if (!dir)
 		return NULL;
 	if (!getcwd(buffer, size))
 		die_errno("can't find the current directory");
=20
-	if (!is_absolute_path(dir))
-		dir =3D make_absolute_path(dir);
-
-	while (*dir && *dir =3D=3D *cwd) {
-		dir++;
-		cwd++;
-	}
-	if (*dir)
-		return NULL;
-	if (*cwd =3D=3D '/')
-		return cwd + 1;
-	return cwd;
+	return get_relative_path(buffer, dir);
 }
=20
 int is_inside_dir(const char *dir)
diff --git a/dir.h b/dir.h
index 3bead5f..3bcda1f 100644
--- a/dir.h
+++ b/dir.h
@@ -79,6 +79,7 @@ extern void add_exclude(const char *string, const cha=
r *base,
 			int baselen, struct exclude_list *which);
 extern int file_exists(const char *);
=20
+extern char *get_relative_path(char *cwd, const char *dir);
 extern char *get_relative_cwd(char *buffer, int size, const char *dir)=
;
 extern int is_inside_dir(const char *dir);
=20
diff --git a/setup.c b/setup.c
index 5716d90..67b5122 100644
--- a/setup.c
+++ b/setup.c
@@ -525,13 +525,17 @@ const char *setup_git_directory(void)
=20
 	/* If the work tree is not the default one, recompute prefix */
 	if (inside_work_tree < 0) {
+		const char *work_tree =3D get_git_work_tree();
 		static char buffer[PATH_MAX + 1];
 		char *rel;
-		if (retval && chdir(retval))
-			die_errno ("Could not jump back into original cwd");
-		rel =3D get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
-		if (rel && *rel && chdir(get_git_work_tree()))
-			die_errno ("Could not jump to working directory");
+		if (retval) {
+			if (!is_absolute_path(retval))
+				retval =3D make_absolute_path(retval);
+			strncpy(buffer, retval, PATH_MAX);
+			buffer[PATH_MAX] =3D '\0';
+			rel =3D get_relative_path(buffer, work_tree);
+		} else
+			rel =3D get_relative_cwd(buffer, PATH_MAX, work_tree);
 		return rel && *rel ? strcat(rel, "/") : NULL;
 	}
=20
--=20
1.7.0.5.3.ga76e
