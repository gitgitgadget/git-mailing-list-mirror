From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH 4/4] convert: Added core.refilteronadd feature.
Date: Mon, 15 Mar 2010 16:30:44 +0100
Message-ID: <647b1f10334c85789dcf7ce00844f32044469adc.1268664693.git.grubba@grubba.org>
References: <cover.1268664693.git.grubba@grubba.org>
 <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
 <cff48594f97960444a3cd642dafd7fd4905e6891.1268664693.git.grubba@grubba.org>
 <baa3d958d4885348d3d5a4c30305fce0f026d85c.1268664693.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 16:31:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrCGl-0003Df-Vj
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 16:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941Ab0COPbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 11:31:39 -0400
Received: from mail.roxen.com ([212.247.29.220]:37388 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616Ab0COPbi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 11:31:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 1A0D5628191
	for <git@vger.kernel.org>; Mon, 15 Mar 2010 16:31:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Kui4AfoVMLI; Mon, 15 Mar 2010 16:31:36 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 1134562817D;
	Mon, 15 Mar 2010 16:31:36 +0100 (CET)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o2FFVZFM022027;
	Mon, 15 Mar 2010 16:31:35 +0100 (CET)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o2FFVZIx022026;
	Mon, 15 Mar 2010 16:31:35 +0100 (CET)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <baa3d958d4885348d3d5a4c30305fce0f026d85c.1268664693.git.grubba@grubba.org>
In-Reply-To: <cover.1268664693.git.grubba@grubba.org>
References: <cover.1268664693.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142215>

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
index c80262b..a38b23e 100644
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
index b62c462..8cff256 100644
--- a/cache.h
+++ b/cache.h
@@ -549,6 +549,7 @@ extern int read_replace_refs;
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
index 876c5e5..25e1e47 100644
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
index 992b624..d7cc3ad 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2467,6 +2467,54 @@ int index_fd(unsigned char *sha1, int fd, struct=
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
@@ -2481,6 +2529,15 @@ int index_path(unsigned char *sha1, const char *=
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
index 57812b6..9d98072 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -114,4 +114,39 @@ test_expect_success keywords_not_modified '
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
1.6.4.122.g6ffd7
