From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/12] dir.c: refactor is_path_excluded()
Date: Mon, 15 Oct 2012 13:28:01 +0700
Message-ID: <1350282486-4646-7-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:29:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeB4-0001Hl-1W
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab2JOG3P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:29:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44799 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2JOG3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:29:14 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4627017pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5sljU33cYlcTYHyd0BvZlfA+mQO5HIMA8gIM0OAcHyY=;
        b=o56REfQKPsyd3sDtliGWLNGTuZE5B5Ve18m/OtybkdoWDal5SPS93GaxLWHnjVtFEd
         oDL6Vmrxd+58PTpO0bazWnCKLkIHAHcOhWohvm4MpkLMTsW2ptN/6T7O1xRiGtD0I52+
         mMzhC9ZnECPeJVNH0GFcQAfQusUUtlZlFmnE1w580hv1I0u5dSeZ5nISkuv7G8uV2IWz
         UnVpaa+kBlhC8u2YmbfGUk8LHT1yWeRai/zaVbnEO96TLpZ7hAKANKriHXD9LU0/6hYA
         +7E3BdMNeGZovKXfrQaaU9ZX7w1CwlIq6V2GmKcnsfS8j/ghBFU67Flj/4ZoBlqabTiP
         LjBg==
Received: by 10.66.78.104 with SMTP id a8mr30295001pax.38.1350282554004;
        Sun, 14 Oct 2012 23:29:14 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id rz10sm8580018pbc.32.2012.10.14.23.29.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:29:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:29:04 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207718>

=46rom: Adam Spiers <git@adamspiers.org>

In a similar way to the previous commit, this extracts a new helper
function last_exclude_matching_path() which return the last
exclude_list element which matched, or NULL if no match was found.
is_path_excluded() becomes a wrapper around this, and just returns 0
or 1 depending on whether any matching exclude_list element was found.

This allows callers to find out _why_ a given path was excluded,
rather than just whether it was or not, paving the way for a new git
sub-command which allows users to test their exclude lists from the
command line.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 dir.h |  3 +++
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index c91a2f6..84ab826 100644
--- a/dir.c
+++ b/dir.c
@@ -703,6 +703,7 @@ void path_exclude_check_init(struct path_exclude_ch=
eck *check,
 			     struct dir_struct *dir)
 {
 	check->dir =3D dir;
+	check->exclude =3D NULL;
 	strbuf_init(&check->path, 256);
 }
=20
@@ -712,18 +713,21 @@ void path_exclude_check_clear(struct path_exclude=
_check *check)
 }
=20
 /*
- * Is this name excluded?  This is for a caller like show_files() that
- * do not honor directory hierarchy and iterate through paths that are
- * possibly in an ignored directory.
+ * For each subdirectory in name, starting with the top-most, checks
+ * to see if that subdirectory is excluded, and if so, returns the
+ * corresponding exclude structure.  Otherwise, checks whether name
+ * itself (which is presumably a file) is excluded.
  *
  * A path to a directory known to be excluded is left in check->path t=
o
  * optimize for repeated checks for files in the same excluded directo=
ry.
  */
-int is_path_excluded(struct path_exclude_check *check,
-		     const char *name, int namelen, int *dtype)
+struct exclude *last_exclude_matching_path(struct path_exclude_check *=
check,
+					   const char *name, int namelen,
+					   int *dtype)
 {
 	int i;
 	struct strbuf *path =3D &check->path;
+	struct exclude *exclude;
=20
 	/*
 	 * we allow the caller to pass namelen as an optimization; it
@@ -733,11 +737,17 @@ int is_path_excluded(struct path_exclude_check *c=
heck,
 	if (namelen < 0)
 		namelen =3D strlen(name);
=20
+	/*
+	 * If path is non-empty, and name is equal to path or a
+	 * subdirectory of path, name should be excluded, because
+	 * it's inside a directory which is already known to be
+	 * excluded and was previously left in check->path.
+	 */
 	if (path->len &&
 	    path->len <=3D namelen &&
 	    !memcmp(name, path->buf, path->len) &&
 	    (!name[path->len] || name[path->len] =3D=3D '/'))
-		return 1;
+		return check->exclude;
=20
 	strbuf_setlen(path, 0);
 	for (i =3D 0; name[i]; i++) {
@@ -745,8 +755,12 @@ int is_path_excluded(struct path_exclude_check *ch=
eck,
=20
 		if (ch =3D=3D '/') {
 			int dt =3D DT_DIR;
-			if (is_excluded(check->dir, path->buf, &dt))
-				return 1;
+			exclude =3D last_exclude_matching(check->dir,
+							path->buf, &dt);
+			if (exclude) {
+				check->exclude =3D exclude;
+				return exclude;
+			}
 		}
 		strbuf_addch(path, ch);
 	}
@@ -754,7 +768,22 @@ int is_path_excluded(struct path_exclude_check *ch=
eck,
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
=20
-	return is_excluded(check->dir, name, dtype);
+	return last_exclude_matching(check->dir, name, dtype);
+}
+
+/*
+ * Is this name excluded?  This is for a caller like show_files() that
+ * do not honor directory hierarchy and iterate through paths that are
+ * possibly in an ignored directory.
+ */
+int is_path_excluded(struct path_exclude_check *check,
+		  const char *name, int namelen, int *dtype)
+{
+	struct exclude *exclude =3D
+		last_exclude_matching_path(check, name, namelen, dtype);
+	if (exclude)
+		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
+	return 0;
 }
=20
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
diff --git a/dir.h b/dir.h
index 4b887cc..02ac0bf 100644
--- a/dir.h
+++ b/dir.h
@@ -97,10 +97,13 @@ extern int match_pathname(const char *, int,
  */
 struct path_exclude_check {
 	struct dir_struct *dir;
+	struct exclude *exclude;
 	struct strbuf path;
 };
 extern void path_exclude_check_init(struct path_exclude_check *, struc=
t dir_struct *);
 extern void path_exclude_check_clear(struct path_exclude_check *);
+extern struct exclude *last_exclude_matching_path(struct path_exclude_=
check *, const char *,
+						  int namelen, int *dtype);
 extern int is_path_excluded(struct path_exclude_check *, const char *,=
 int namelen, int *dtype);
=20
=20
--=20
1.8.0.rc0.29.g1fdd78f
