From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v4 5/8] convert: Added core.refilteronadd feature.
Date: Tue,  6 Apr 2010 14:46:41 +0200
Message-ID: <748069c7f90d80cc881d4be495b138f4f16a94f2.1270554878.git.grubba@grubba.org>
References: <cover.1270554878.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 14:47:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz8Bn-0004uy-T3
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 14:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab0DFMrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 08:47:21 -0400
Received: from mail.roxen.com ([212.247.29.220]:44442 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755422Ab0DFMqy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 08:46:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id DCA5462818C
	for <git@vger.kernel.org>; Tue,  6 Apr 2010 14:46:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ji8r+qPXBsmt; Tue,  6 Apr 2010 14:46:51 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id B4398628173;
	Tue,  6 Apr 2010 14:46:51 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o36CkpOO028658;
	Tue, 6 Apr 2010 14:46:51 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o36Ckp8i028657;
	Tue, 6 Apr 2010 14:46:51 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3.316.g33b5e
In-Reply-To: <cover.1270554878.git.grubba@grubba.org>
In-Reply-To: <cover.1270554878.git.grubba@grubba.org>
References: <cover.1270554878.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144137>

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
 t/t0021-conversion.sh    |   35 ++++++++++++++++++++++++++++
 6 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4eb3ab3..5225047 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -535,6 +535,12 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
=20
+core.refilterOnAdd::
+	Enable "refilter on add" feature. This causes source files to be
+	behave as if they were checked out after a linkgit:git-add[1].
+	This is typically usefull if eg the `ident` attribute is active,
+	in which case the $Id$ tags will be updated.
+
 core.refilterOnDiff::
 	Enable "refilter on diff" feature. This causes source files that
 	have only changed from the committed version as a side effect of
diff --git a/cache.h b/cache.h
index cd2bca4..1bd8484 100644
--- a/cache.h
+++ b/cache.h
@@ -552,6 +552,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_refilter_on_add;
 extern int core_refilter_on_diff;
=20
 enum safe_crlf {
diff --git a/config.c b/config.c
index 4954797..d284897 100644
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
 	if(!strcmp(var, "core.refilterondiff")) {
 		core_refilter_on_diff =3D git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 1b52bed..4b4c966 100644
--- a/environment.c
+++ b/environment.c
@@ -52,6 +52,7 @@ enum object_creation_mode object_creation_mode =3D OB=
JECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
+int core_refilter_on_add;
 int core_refilter_on_diff;
=20
 /* Parallel index stat data preload? */
diff --git a/sha1_file.c b/sha1_file.c
index a08a9d0..2aa800e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2466,6 +2466,54 @@ int index_fd(unsigned char *sha1, int fd, struct=
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
+			ret =3D convert_to_git(path, sbuf.buf, sbuf.len, &gbuf, safe_crlf);
+		else
+			ret =3D -1;
+		strbuf_release(&sbuf);
+	} else if (size) {
+		void *buf =3D xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		ret =3D convert_to_git(path, buf, size, &gbuf, safe_crlf);
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
@@ -2480,6 +2528,15 @@ int index_path(unsigned char *sha1, const char *=
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
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 48ae8bb..9ddbde3 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -118,4 +118,39 @@ test_expect_success keywords_not_modified '
 	test "x`git status --porcelain -- expanded-keywords2`" =3D x
 '
=20
+# Check that keywords are expanded on add when refilter is enabled.
+test_expect_success expanded_on_add '
+	git config --add core.refilteronadd true
+
+	echo "expanded-keywords3 ident" >> .gitattributes &&
+
+	{
+		echo "File with keyword"
+		echo "\$Id\$"
+	} > expanded-keywords3 &&
+
+	{
+		echo "File with keyword"
+		echo "\$Id: 0661580d6f976fe7cc1e4512f8db3f2ddb8d93cc \$"
+	} > expected-output3 &&
+
+	git add expanded-keywords3 &&
+
+	cat expanded-keywords3 &&
+	cmp expanded-keywords3 expected-output3
+'
+
+# Check that keywords are expanded on commit when refilter is enabled.
+test_expect_success expanded_on_commit '
+	{
+		echo "File with keyword"
+		echo "\$Id\$"
+	} > expanded-keywords3 &&
+
+	git commit -m "File with keyword" expanded-keywords3 &&
+
+	cat expanded-keywords3 &&
+	cmp expanded-keywords3 expected-output3
+'
+
 test_done
--=20
1.7.0.3.316.g33b5e
