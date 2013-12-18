From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/12] Replace some use of starts_with() with skip_prefix()
Date: Wed, 18 Dec 2013 21:53:49 +0700
Message-ID: <1387378437-20646-5-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:54:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIW9-0003P2-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab3LROy3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:54:29 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:40182 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab3LROy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:54:28 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so8340122pdj.11
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LyRIuR6kgt67tI+hT4sWGy3Wzl8IMXYQctGMmsSgr8s=;
        b=ladIDugS+cCfCjzbdpliIhptnr+8EiLFzAEadmKzaRz9hGmZmitG7NPM1g6xaPTcqz
         IaZgUSbg+p+Aef2rKZbEiIYyy5TY/4od61b9OjPQCDe/LGYb2kBEPevonWtXb1NmulNJ
         juS8CH9dbUy0m5s96boslUXDC2l+HP0lMOWAB3s0I+8XYCUScvMUBVQV2vNiNMDWWzWO
         meYNzgWj66uEp/OECxXdFzcXOLoxsF6KY7SWqBexxKMFKD3UCnze7MOxJPlOjs/KKGTE
         DJg7O83v+cxmxHNQFZpqsbEEixfVooGemw6kyJhBz3Z5Qs6AhdmAbxlfSHloTyg7+8nO
         rUnw==
X-Received: by 10.68.236.35 with SMTP id ur3mr28590350pbc.137.1387378468091;
        Wed, 18 Dec 2013 06:54:28 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id yd4sm561497pbc.13.2013.12.18.06.54.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:54:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:54:25 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239441>

All the changes follow the pattern

  if (!starts_with(foo, "bar"))
    return;
  foo +=3D 3;

which is turned into

  if ((foo =3D skip_prefix(foo, "bar")) =3D=3D NULL)
    return;

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c | 3 +--
 pretty.c         | 3 +--
 setup.c          | 3 +--
 tag.c            | 7 +++----
 wt-status.c      | 3 +--
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b4d7716..d063de2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -868,9 +868,8 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 	if (!strcmp(head, "HEAD")) {
 		detached =3D 1;
 	} else {
-		if (!starts_with(head, "refs/heads/"))
+		if ((head =3D skip_prefix(head, "refs/heads/")) =3D=3D NULL)
 			die(_("HEAD not found below refs/heads!"));
-		head +=3D 11;
 	}
 	hashcpy(merge_filter_ref, head_sha1);
=20
diff --git a/pretty.c b/pretty.c
index 87db08b..08e30ec 100644
--- a/pretty.c
+++ b/pretty.c
@@ -40,10 +40,9 @@ static int git_pretty_formats_config(const char *var=
, const char *value, void *c
 	const char *fmt;
 	int i;
=20
-	if (!starts_with(var, "pretty."))
+	if ((name =3D skip_prefix(var, "pretty.")) =3D=3D NULL)
 		return 0;
=20
-	name =3D var + strlen("pretty.");
 	for (i =3D 0; i < builtin_formats_len; i++) {
 		if (!strcmp(commit_formats[i].name, name))
 			return 0;
diff --git a/setup.c b/setup.c
index 6c3f85f..debfaab 100644
--- a/setup.c
+++ b/setup.c
@@ -304,14 +304,13 @@ const char *read_gitfile(const char *path)
 	if (len !=3D st.st_size)
 		die("Error reading %s", path);
 	buf[len] =3D '\0';
-	if (!starts_with(buf, "gitdir: "))
+	if ((dir =3D (char *)skip_prefix(buf, "gitdir: ")) =3D=3D NULL)
 		die("Invalid gitfile format: %s", path);
 	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
 		len--;
 	if (len < 9)
 		die("No path in gitfile: %s", path);
 	buf[len] =3D '\0';
-	dir =3D buf + 8;
=20
 	if (!is_absolute_path(dir) && (slash =3D strrchr(path, '/'))) {
 		size_t pathlen =3D slash+1 - path;
diff --git a/tag.c b/tag.c
index 7b07921..9b63d1b 100644
--- a/tag.c
+++ b/tag.c
@@ -86,9 +86,8 @@ int parse_tag_buffer(struct tag *item, const void *da=
ta, unsigned long size)
 		return -1;
 	bufptr +=3D 48; /* "object " + sha1 + "\n" */
=20
-	if (!starts_with(bufptr, "type "))
+	if ((bufptr =3D skip_prefix(bufptr, "type ")) =3D=3D NULL)
 		return -1;
-	bufptr +=3D 5;
 	nl =3D memchr(bufptr, '\n', tail - bufptr);
 	if (!nl || sizeof(type) <=3D (nl - bufptr))
 		return -1;
@@ -109,11 +108,11 @@ int parse_tag_buffer(struct tag *item, const void=
 *data, unsigned long size)
 		item->tagged =3D NULL;
 	}
=20
-	if (bufptr + 4 < tail && starts_with(bufptr, "tag "))
+	if (bufptr + 4 < tail &&
+	    (bufptr =3D skip_prefix(bufptr, "tag ")) !=3D NULL)
 		; 		/* good */
 	else
 		return -1;
-	bufptr +=3D 4;
 	nl =3D memchr(bufptr, '\n', tail - bufptr);
 	if (!nl)
 		return -1;
diff --git a/wt-status.c b/wt-status.c
index 1f65039..185fa81 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1145,9 +1145,8 @@ static int grab_1st_switch(unsigned char *osha1, =
unsigned char *nsha1,
 	struct grab_1st_switch_cbdata *cb =3D cb_data;
 	const char *target =3D NULL, *end;
=20
-	if (!starts_with(message, "checkout: moving from "))
+	if ((message =3D skip_prefix(message, "checkout: moving from ")) =3D=3D=
 NULL)
 		return 0;
-	message +=3D strlen("checkout: moving from ");
 	target =3D strstr(message, " to ");
 	if (!target)
 		return 0;
--=20
1.8.5.1.208.g019362e
