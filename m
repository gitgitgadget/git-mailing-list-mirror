From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m?= <grubba@grubba.org>
Subject: [PATCH 4/4] convert: Added core.refilteronadd feature.
Date: Mon,  1 Mar 2010 17:16:58 +0100
Message-ID: <1267460218-1172-4-git-send-email-grubba@grubba.org>
References: <1267460218-1172-1-git-send-email-grubba@grubba.org>
 <1267460218-1172-2-git-send-email-grubba@grubba.org>
 <1267460218-1172-3-git-send-email-grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 17:50:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm8p3-0001P2-Ge
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 17:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461Ab0CAQtz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Mar 2010 11:49:55 -0500
Received: from mail.roxen.com ([212.247.29.220]:38009 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab0CAQty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 11:49:54 -0500
X-Greylist: delayed 1968 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Mar 2010 11:49:53 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 16D436280FD
	for <git@vger.kernel.org>; Mon,  1 Mar 2010 17:17:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1hrZyvla-2sR; Mon,  1 Mar 2010 17:17:05 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id D90A96280ED;
	Mon,  1 Mar 2010 17:17:05 +0100 (CET)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o21GH5mm001233;
	Mon, 1 Mar 2010 17:17:05 +0100 (CET)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o21GH5Mx001232;
	Mon, 1 Mar 2010 17:17:05 +0100 (CET)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <1267460218-1172-3-git-send-email-grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141330>

=46rom: Henrik Grubbstr=C3=B6m (Grubba) <grubba@grubba.org>

When having $Id$ tags in other versioning systems, it is customary
to recalculate the tags in the source on commit or equvivalent.
This commit adds a configuration option to git that causes source
files to pass through a conversion roundtrip when added to the index.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 Documentation/config.txt |    6 +++++
 cache.h                  |    1 +
 config.c                 |    5 ++++
 environment.c            |    1 +
 sha1_file.c              |   57 ++++++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 664de6b..900b095 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -533,6 +533,12 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
=20
+core.refilterOnAdd::
+	Enable "refilter on add" feature. This causes source files to be
+	behave as if they were checked out after a linkgit:git-add[1].
+	This is typically usefull if eg the `ident` attribute is active,
+	in which case the $Id$ tags will be updated.
+
 add.ignore-errors::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
diff --git a/cache.h b/cache.h
index 1c9f491..beb60f9 100644
--- a/cache.h
+++ b/cache.h
@@ -540,6 +540,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_refilter_on_add;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/config.c b/config.c
index 6963fbe..b1db505 100644
--- a/config.c
+++ b/config.c
@@ -523,6 +523,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.refilteronadd")) {
+		core_refilter_on_add =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 739ec27..eed7ef1 100644
--- a/environment.c
+++ b/environment.c
@@ -52,6 +52,7 @@ enum object_creation_mode object_creation_mode =3D OB=
JECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
+int core_refilter_on_add;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
diff --git a/sha1_file.c b/sha1_file.c
index fd8c5df..f2659cb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2459,6 +2459,54 @@ int index_fd(unsigned char *sha1, int fd, struct=
 stat *st, int write_object,
 	return ret;
 }
=20
+static int refilter_fd(int fd, struct stat *st, const char *path)
+{
+	int ret =3D -1;
+	size_t size =3D xsize_t(st->st_size);
+	struct strbuf gbuf =3D STRBUF_INIT;
+
+	if (!S_ISREG(st->st_mode)) {
+		struct strbuf sbuf =3D STRBUF_INIT;
+		if (strbuf_read(&sbuf, fd, 4096) >=3D 0)
+			ret =3D convert_to_git(path, sbuf.buf, sbuf.len, &gbuf, safe_crlf, =
0);
+		else
+			ret =3D -1;
+		strbuf_release(&sbuf);
+	} else if (size) {
+		void *buf =3D xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		ret =3D convert_to_git(path, buf, size, &gbuf, safe_crlf, 0);
+		munmap(buf, size);
+	} else
+		ret =3D -1;
+
+	if (ret > 0) {
+		/* Something happened during conversion to git.
+		 * Now convert it back, and save the result.
+		 */
+		struct strbuf obuf =3D STRBUF_INIT;
+
+		lseek(fd, 0, SEEK_SET);
+
+		if (convert_to_working_tree(path, gbuf.buf, gbuf.len, &obuf)) {
+			if (write_or_whine(fd, obuf.buf, obuf.len, path))
+				ftruncate(fd, obuf.len);
+			else
+				ret =3D -1;
+		} else {
+			if (write_or_whine(fd, gbuf.buf, gbuf.len, path))
+				ftruncate(fd, gbuf.len);
+			else
+				ret =3D -1;
+		}
+
+		strbuf_release(&obuf);
+	}
+	strbuf_release(&gbuf);
+
+	close(fd);
+	return ret;
+}
+
 int index_path(unsigned char *sha1, const char *path, struct stat *st,=
 int write_object)
 {
 	int fd;
@@ -2473,6 +2521,15 @@ int index_path(unsigned char *sha1, const char *=
path, struct stat *st, int write
 		if (index_fd(sha1, fd, st, write_object, OBJ_BLOB, path) < 0)
 			return error("%s: failed to insert into database",
 				     path);
+		if (write_object && core_refilter_on_add) {
+			fd =3D open(path, O_RDWR);
+			if (fd < 0)
+				return error("open(\"%s\"): %s", path,
+					     strerror(errno));
+			if (refilter_fd(fd, st, path) < 0)
+				return error("%s: failed to refilter file",
+					     path);
+		}
 		break;
 	case S_IFLNK:
 		if (strbuf_readlink(&sb, path, st->st_size)) {
--=20
1.6.4.122.g6ffd7
