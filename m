From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] Revoke write access to refs and odb after importing another repo's odb
Date: Wed, 23 Jan 2013 20:34:27 +0700
Message-ID: <1358948067-2792-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 14:34:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty0TG-0004xO-Hq
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 14:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab3AWNeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2013 08:34:08 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:42651 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab3AWNeF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 08:34:05 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so3335726pbc.7
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 05:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=4rAAbXL2dHvpzcVP9aGIS5QEajF/R7Aw3FvIpd9QR6I=;
        b=ccyedt9wDrlV0CIqcI14MZynhXg93DT4beWIS5CCApSeYo9ACx9hqB6BahD2lyd09/
         OzU607VnBAVbhe3hEudNiMJnoCssZeTIXst6s/Erqe6DI7HNWiB/Wz5DQoaevi/dDR2A
         17/i0q+uZ/CT18wktl54XivUE7t6dhNPt/o6B5cgZbBRuRU3QzE8f8Tp3P7/VUvBMdIA
         utxRqkUFJJ8xQU47YDG1otgcuR9X0XArMNU9sDSYKLuh+6h6DBZJhUs/H2lcfjC2CwYK
         6oftTsB0v9Jpjjhj0sYnnqPe02nMqS/t06AV5dpWyc0KAvt4zcjf/rerG0/PTmbtvdfT
         acaA==
X-Received: by 10.68.228.2 with SMTP id se2mr3587827pbc.93.1358948045448;
        Wed, 23 Jan 2013 05:34:05 -0800 (PST)
Received: from lanh ([115.74.55.178])
        by mx.google.com with ESMTPS id sk1sm12841009pbc.0.2013.01.23.05.34.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 05:34:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 23 Jan 2013 20:34:29 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214317>

add_submodule_odb() can be used to import objects from another
repository temporarily. After this point we don't know which objects
are ours, which are external. If we create an object that refers to an
external object, next time git runs, it may find a hole in the object
graph because the external repository may not be imported. The same
goes for pointing a ref to an external SHA-1.

To protect ourselves, once add_submodule_odb() is used:

 - trees, tags and commits cannot be created
 - refs cannot be updated

In certain cases that submodule code knows that it's safe to write, it
can turn the readonly flag off.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I think this is a good safety check. It catches at least a case in
 t7405.3. I did not investigate further though.

 cache.h      | 1 +
 refs.c       | 2 ++
 sha1_file.c  | 2 ++
 submodule.c  | 7 +++++++
 5 files changed, 16 insertions(+)

diff --git a/cache.h b/cache.h
index c257953..772d229 100644
--- a/cache.h
+++ b/cache.h
@@ -753,6 +753,7 @@ extern int force_object_loose(const unsigned char *=
sha1, time_t mtime);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *s=
ize);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map,=
 unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
+extern int git_repo_readonly();
=20
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
diff --git a/refs.c b/refs.c
index 541fec2..22b13f4 100644
--- a/refs.c
+++ b/refs.c
@@ -1711,6 +1711,8 @@ struct ref_lock *lock_ref_sha1(const char *refnam=
e, const unsigned char *old_sha
 struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1, int flags)
 {
+	if (git_repo_readonly())
+		die("repository in read-only mode, cannot update refs");
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, NULL);
diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..b9e8b59 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2575,6 +2575,8 @@ int write_sha1_file(const void *buf, unsigned lon=
g len, const char *type, unsign
 	char hdr[32];
 	int hdrlen;
=20
+	if (git_repo_readonly() && strcmp(type, "blob"))
+		die("repository in read-only mode, cannot update object database");
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
diff --git a/submodule.c b/submodule.c
index 2f55436..5eba597 100644
--- a/submodule.c
+++ b/submodule.c
@@ -19,6 +19,7 @@ static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
 static struct sha1_array ref_tips_before_fetch;
 static struct sha1_array ref_tips_after_fetch;
+static int readonly;
=20
 /*
  * The following flag is set if the .gitmodules file is unmerged. We t=
hen
@@ -30,6 +31,11 @@ static struct sha1_array ref_tips_after_fetch;
  */
 static int gitmodules_is_unmerged;
=20
+int git_repo_readonly()
+{
+	return readonly;
+}
+
 static int add_submodule_odb(const char *path)
 {
 	struct strbuf objects_directory =3D STRBUF_INIT;
@@ -67,6 +73,7 @@ static int add_submodule_odb(const char *path)
 	/* add possible alternates from the submodule */
 	read_info_alternates(objects_directory.buf, 0);
 	prepare_alt_odb();
+	readonly =3D 1;
 done:
 	strbuf_release(&objects_directory);
 	return ret;
--=20
1.8.0.rc2.23.g1fb49df
