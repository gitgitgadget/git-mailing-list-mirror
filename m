From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] Make hash-object more robust against malformed objects
Date: Sat,  5 Feb 2011 17:52:21 +0700
Message-ID: <1296903141-27075-2-git-send-email-pclouds@gmail.com>
References: <1296903141-27075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 11:54:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlfmO-0008M7-Dv
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 11:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab1BEKyF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Feb 2011 05:54:05 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:38725 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab1BEKyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 05:54:03 -0500
Received: by pxi15 with SMTP id 15so566936pxi.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 02:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=7yVLl9nSw7z2EQWhfjLltSLaLeEm3ZVdB+L3/gdDreY=;
        b=GN7nzst/wrkInkd3hxiiYFOp8ScOOkCra+L+nuSFpWBiO4t829o6F/1+e3H3qrM0Up
         vQuRtw2lbZKu8zz/aBi1gAFe6mbF3DQk49FKqMN4dF8zDZSgsL71sYU/VbfPM0KYlRMQ
         ubJ9rWjIoK462JFpAKekQ1jjEzzyL8N0OOI3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cfG/10cawCdUjXipJY/UZ+4w46JGTHXDf7H/8gx5UWQcjzAbNBzSnXhJBmvgOTheuu
         YhIkSbjiBi4B+XJIgkLlTa2iUBGQm34AFHrOB1On+jNGD9vs6/ueOQX5Av4NVZ7ZWtsH
         DslhcJ3B00Y6lqiNNueoZRpcPakoUOEpiL10A=
Received: by 10.142.214.9 with SMTP id m9mr213418wfg.44.1296903243143;
        Sat, 05 Feb 2011 02:54:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id w42sm2389994wfh.3.2011.02.05.02.53.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 02:54:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 05 Feb 2011 17:52:35 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1296903141-27075-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166087>

Commits, trees and tags have structure. Don't let users feed git
with malformed ones. Sooner or later git will die() when
encountering them.

Note that this patch does not check semantics. A tree that points
to non-existent objects is perfectly OK (and should be so, users
may choose to add commit first, then its associated tree for example)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/hash-object.c  |    2 +-
 cache.h                |    2 +-
 read-cache.c           |    2 +-
 sha1_file.c            |   54 ++++++++++++++++++++++++++++++++++++++++=
+------
 t/t1007-hash-object.sh |   13 +++++++++++
 5 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 080af1a..c90acdd 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -15,7 +15,7 @@ static void hash_fd(int fd, const char *type, int wri=
te_object, const char *path
 	struct stat st;
 	unsigned char sha1[20];
 	if (fstat(fd, &st) < 0 ||
-	    index_fd(sha1, fd, &st, write_object, type_from_string(type), pat=
h))
+	    index_fd(sha1, fd, &st, write_object, type_from_string(type), pat=
h, 1))
 		die(write_object
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
diff --git a/cache.h b/cache.h
index d83d68c..9186a56 100644
--- a/cache.h
+++ b/cache.h
@@ -501,7 +501,7 @@ extern int ie_match_stat(const struct index_state *=
, struct cache_entry *, struc
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
 extern int ce_path_match(const struct cache_entry *ce, const char **pa=
thspec);
-extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int =
write_object, enum object_type type, const char *path);
+extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int =
write_object, enum object_type type, const char *path, int format_check=
);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *=
st);
=20
diff --git a/read-cache.c b/read-cache.c
index 4f2e890..fbc12f3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -92,7 +92,7 @@ static int ce_compare_data(struct cache_entry *ce, st=
ruct stat *st)
=20
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, 0, OBJ_BLOB, ce->name))
+		if (!index_fd(sha1, fd, st, 0, OBJ_BLOB, ce->name, 0))
 			match =3D hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
diff --git a/sha1_file.c b/sha1_file.c
index d86a8db..58ca858 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -13,6 +13,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "refs.h"
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
@@ -2471,8 +2472,37 @@ int has_sha1_file(const unsigned char *sha1)
 	return has_loose_object(sha1);
 }
=20
+static void check_tree(const void *buf, size_t size)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+
+	init_tree_desc(&desc, buf, size);
+	while (tree_entry(&desc, &entry))
+		/* do nothing
+		 * tree_entry() will die() on malformed entries */
+		;
+}
+
+static void check_commit(const void *buf, size_t size)
+{
+	struct commit c;
+	memset(&c, 0, sizeof(c));
+	if (parse_commit_buffer(&c, buf, size))
+		die("corrupt commit");
+}
+
+static void check_tag(const void *buf, size_t size)
+{
+	struct tag t;
+	memset(&t, 0, sizeof(t));
+	if (parse_tag_buffer(&t, buf, size))
+		die("corrupt tag");
+}
+
 static int index_mem(unsigned char *sha1, void *buf, size_t size,
-		     int write_object, enum object_type type, const char *path)
+		     int write_object, enum object_type type,
+		     const char *path, int format_check)
 {
 	int ret, re_allocated =3D 0;
=20
@@ -2490,6 +2520,14 @@ static int index_mem(unsigned char *sha1, void *=
buf, size_t size,
 			re_allocated =3D 1;
 		}
 	}
+	if (format_check) {
+		if (type =3D=3D OBJ_TREE)
+			check_tree(buf, size);
+		if (type =3D=3D OBJ_COMMIT)
+			check_commit(buf, size);
+		if (type =3D=3D OBJ_TAG)
+			check_tag(buf, size);
+	}
=20
 	if (write_object)
 		ret =3D write_sha1_file(buf, size, typename(type), sha1);
@@ -2503,7 +2541,7 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
 #define SMALL_FILE_SIZE (32*1024)
=20
 int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_o=
bject,
-	     enum object_type type, const char *path)
+	     enum object_type type, const char *path, int format_check)
 {
 	int ret;
 	size_t size =3D xsize_t(st->st_size);
@@ -2512,23 +2550,25 @@ int index_fd(unsigned char *sha1, int fd, struc=
t stat *st, int write_object,
 		struct strbuf sbuf =3D STRBUF_INIT;
 		if (strbuf_read(&sbuf, fd, 4096) >=3D 0)
 			ret =3D index_mem(sha1, sbuf.buf, sbuf.len, write_object,
-					type, path);
+					type, path, format_check);
 		else
 			ret =3D -1;
 		strbuf_release(&sbuf);
 	} else if (!size) {
-		ret =3D index_mem(sha1, NULL, size, write_object, type, path);
+		ret =3D index_mem(sha1, NULL, size, write_object, type, path,
+				format_check);
 	} else if (size <=3D SMALL_FILE_SIZE) {
 		char *buf =3D xmalloc(size);
 		if (size =3D=3D read_in_full(fd, buf, size))
 			ret =3D index_mem(sha1, buf, size, write_object, type,
-					path);
+					path, format_check);
 		else
 			ret =3D error("short read %s", strerror(errno));
 		free(buf);
 	} else {
 		void *buf =3D xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret =3D index_mem(sha1, buf, size, write_object, type, path);
+		ret =3D index_mem(sha1, buf, size, write_object, type, path,
+				format_check);
 		munmap(buf, size);
 	}
 	close(fd);
@@ -2546,7 +2586,7 @@ int index_path(unsigned char *sha1, const char *p=
ath, struct stat *st, int write
 		if (fd < 0)
 			return error("open(\"%s\"): %s", path,
 				     strerror(errno));
-		if (index_fd(sha1, fd, st, write_object, OBJ_BLOB, path) < 0)
+		if (index_fd(sha1, fd, st, write_object, OBJ_BLOB, path, 0) < 0)
 			return error("%s: failed to insert into database",
 				     path);
 		break;
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index dd32432..6d52b82 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -188,4 +188,17 @@ for args in "-w --stdin-paths" "--stdin-paths -w";=
 do
 	pop_repo
 done
=20
+test_expect_success 'corrupt tree' '
+	echo abc >malformed-tree
+	test_must_fail git hash-object -t tree malformed-tree
+'
+
+test_expect_success 'corrupt commit' '
+	test_must_fail git hash-object -t commit --stdin </dev/null
+'
+
+test_expect_success 'corrupt tag' '
+	test_must_fail git hash-object -t tag --stdin </dev/null
+'
+
 test_done
--=20
1.7.3.4.878.g439c7
