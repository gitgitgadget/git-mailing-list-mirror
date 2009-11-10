From: Esben Mose Hansen <kde@mosehansen.dk>
Subject: Re: [LIBGIT2 PATCH] git_odb_open ckeck for valid path to database
Date: Tue, 10 Nov 2009 22:07:04 +0100
Message-ID: <200911102207.04135.kde@mosehansen.dk>
References: <1257510729-6803-1-git-send-email-kde@mosehansen.dk> <4AF86A7F.1010500@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4Xd+KlPTJfZNjEy"
Cc: ae@op5.com, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 10 22:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7xw2-0000cg-7O
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 22:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758179AbZKJVHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 16:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758159AbZKJVHT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 16:07:19 -0500
Received: from 1503033659.dong.dbnet.dk ([89.150.121.59]:47389 "EHLO
	mosehansen.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758140AbZKJVHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 16:07:17 -0500
Received: from sneppe.localnet (unknown [192.168.0.6])
	by mosehansen.dk (Postfix) with ESMTPSA id 7CD49BFA024;
	Tue, 10 Nov 2009 22:07:05 +0100 (CET)
User-Agent: KMail/1.12.3 (Linux/2.6.31-14-generic; KDE/4.3.3; i686; ; )
In-Reply-To: <4AF86A7F.1010500@ramsay1.demon.co.uk>
X-MailScanner-ID: 7CD49BFA024.7BFEE
X-mosehansen.dk-MailScanner: Found to be clean
X-mosehansen.dk-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-4.399, required 6, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -2.60)
X-mosehansen.dk-MailScanner-From: kde@mosehansen.dk
MailScanner-NULL-Check: 1258492025.61102@75OUtqraQ7oGsIC9EbMfXw
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132599>

--Boundary-00=_4Xd+KlPTJfZNjEy
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Monday 09 November 2009 20:16:15 Ramsay Jones wrote:

I have made 2 new patchsets: One 
0001-git_odb_open-check-for-valid-path-to-database.patch

which is simply the patch before with fixups, and another series

0001-Add-gitfo_is_diretory.patch
0002-git_odb_open-ckeck-for-valid-path-to-database-using-.patch

which adds a gitfo_is_directory (0001) and then uses this new function from 
git_odb_open (0002).

I hope I have done this git/email stuff correctly.

> This should be declared at the head of the function (or generally at the
>  start of a block/scope); ie we don't use this C99 facility. This breaks
>  MSVC, which does not understand C99.

C89 (?) is a tough monster, I see :)

> 
> > +	if (stat(db->objects_dir, &objects_dir_stat)) {
> > +		free(db);
> > +		return GIT_EOSERR;
> > +	}
> > +	if (!S_ISDIR(objects_dir_stat.st_mode)) {
> 
> This breaks on MSVC, since the MS headers do not define S_ISDIR. It's not
>  difficult to add; it's on my TODO list. (Andreas, I can add this later if
>  you like)

I have not fixed this. 


> (I think Andreas would prefer to see libgit2 somewhere in the subject,
>  perhaps like [LIBGIT2 PATCH], otherwise he may miss you email

OK.

Thanks for looking at my code.

-- 
Kind regards, Esben

--Boundary-00=_4Xd+KlPTJfZNjEy
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-git_odb_open-check-for-valid-path-to-database.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-git_odb_open-check-for-valid-path-to-database.patch"

=46rom bb29cbb2fc42ce46bd8a53ad02d291aa833846fa Mon Sep 17 00:00:00 2001
=46rom: Esben Mose Hansen <kde@mosehansen.dk>
Date: Fri, 6 Nov 2009 10:32:16 +0100
Subject: [PATCH] git_odb_open check for valid path to database

=2D--
 src/errors.c                |    1 +
 src/git/common.h            |    3 +++
 src/odb.c                   |    9 +++++++++
 tests/t0204-opendb_errors.c |   38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 tests/t0204-opendb_errors.c

diff --git a/src/errors.c b/src/errors.c
index f348997..074c01c 100644
=2D-- a/src/errors.c
+++ b/src/errors.c
@@ -36,6 +36,7 @@ static struct {
 	{ GIT_ENOTOID, "Not a git oid" },
 	{ GIT_ENOTFOUND, "Object does not exist in the scope searched" },
 	{ GIT_ENOMEM, "Not enough space" },
+	{ GIT_ENOTDIR, "Not a directory" }
 };
=20
 const char *git_strerror(int num)
diff --git a/src/git/common.h b/src/git/common.h
index c470e0e..96f2971 100644
=2D-- a/src/git/common.h
+++ b/src/git/common.h
@@ -65,6 +65,9 @@
 /** Consult the OS error information. */
 #define GIT_EOSERR (GIT_ERROR - 4)
=20
+/** The path is not a directory */
+#define GIT_ENOTDIR (GIT_ERROR - 5)
+
 GIT_BEGIN_DECL
=20
 /** A revision traversal pool. */
diff --git a/src/odb.c b/src/odb.c
index 6d646a4..a588c1b 100644
=2D-- a/src/odb.c
+++ b/src/odb.c
@@ -1014,6 +1014,7 @@ int git_odb_exists(git_odb *db, const git_oid *id)
=20
 int git_odb_open(git_odb **out, const char *objects_dir)
 {
+	struct stat objects_dir_stat;
 	git_odb *db =3D git__calloc(1, sizeof(*db));
 	if (!db)
 		return GIT_ERROR;
@@ -1023,6 +1024,14 @@ int git_odb_open(git_odb **out, const char *objects_=
dir)
 		free(db);
 		return GIT_ERROR;
 	}
+	if (stat(db->objects_dir, &objects_dir_stat)) {
+		free(db);
+		return GIT_EOSERR;
+	}
+	if (!S_ISDIR(objects_dir_stat.st_mode)) {
+		free(db);
+		return GIT_ENOTDIR;
+	}
=20
 	gitlck_init(&db->lock);
=20
diff --git a/tests/t0204-opendb_errors.c b/tests/t0204-opendb_errors.c
new file mode 100644
index 0000000..e9b52c9
=2D-- /dev/null
+++ b/tests/t0204-opendb_errors.c
@@ -0,0 +1,38 @@
+#include "test_lib.h"
+#include "test_helpers.h"
+#include <git/odb.h>
+#include "fileops.h"
+
+static char *odb_dir =3D "test-objects";
+
+static unsigned char one_bytes[] =3D {
+    0x31, 0x78, 0x9c, 0xe3, 0x02, 0x00, 0x00, 0x0b,
+    0x00, 0x0b,
+};
+
+static unsigned char one_data[] =3D {
+    0x0a,
+};
+
+static object_data one =3D {
+    one_bytes,
+    sizeof(one_bytes),
+    "8b137891791fe96927ad78e64b0aad7bded08bdc",
+    "blob",
+    "test-objects/8b",
+    "test-objects/8b/137891791fe96927ad78e64b0aad7bded08bdc",
+    one_data,
+    sizeof(one_data),
+};
+
+BEGIN_TEST(opendb_errors)
+    git_odb *db;
+    int error =3D git_odb_open(&db, odb_dir);
+    must_be_true(error =3D=3D GIT_EOSERR);
+    must_be_true(errno =3D=3D ENOENT);
+    must_pass(write_object_files(odb_dir, &one));
+    error =3D git_odb_open(&db, one.file);
+    must_be_true(error =3D=3D GIT_ENOTDIR);
+
+    must_pass(remove_object_files(odb_dir, &one));
+END_TEST
=2D-=20
1.6.3.3


--Boundary-00=_4Xd+KlPTJfZNjEy
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Add-gitfo_is_diretory.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Add-gitfo_is_diretory.patch"

=46rom d1eb250c11a35e30aaaf0652a24daa27b6b90b8f Mon Sep 17 00:00:00 2001
=46rom: Esben Mose Hansen <kde@mosehansen.dk>
Date: Tue, 10 Nov 2009 21:58:04 +0100
Subject: [PATCH 1/2] Add gitfo_is_diretory

=2D--
 src/errors.c     |    1 +
 src/fileops.c    |   11 +++++++++++
 src/fileops.h    |    5 +++++
 src/git/common.h |    3 +++
 4 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/errors.c b/src/errors.c
index f348997..074c01c 100644
=2D-- a/src/errors.c
+++ b/src/errors.c
@@ -36,6 +36,7 @@ static struct {
 	{ GIT_ENOTOID, "Not a git oid" },
 	{ GIT_ENOTFOUND, "Object does not exist in the scope searched" },
 	{ GIT_ENOMEM, "Not enough space" },
+	{ GIT_ENOTDIR, "Not a directory" }
 };
=20
 const char *git_strerror(int num)
diff --git a/src/fileops.c b/src/fileops.c
index 5de89cb..47a8681 100644
=2D-- a/src/fileops.c
+++ b/src/fileops.c
@@ -274,3 +274,14 @@ int gitfo_dirent(
 	closedir(dir);
 	return GIT_SUCCESS;
 }
+
+int gitfo_is_directory(const char* path) {
+	struct stat path_stat;
+	if (stat(path, &path_stat)) {
+		return GIT_EOSERR;
+	}
+	if (!S_ISDIR(path_stat.st_mode)) {
+		return GIT_ENOTDIR;
+	}
+	return GIT_SUCCESS;
+}
diff --git a/src/fileops.h b/src/fileops.h
index 02e4e5b..73eb72c 100644
=2D-- a/src/fileops.h
+++ b/src/fileops.h
@@ -126,4 +126,9 @@ extern int gitfo_write_cached(gitfo_cache *ioc, void *b=
uf, size_t len);
 extern int gitfo_flush_cached(gitfo_cache *ioc);
 extern int gitfo_close_cached(gitfo_cache *ioc);
=20
+/**
+ * Check if path is a directory
+ */
+extern int gitfo_is_directory(const char* path);
+
 #endif /* INCLUDE_fileops_h__ */
diff --git a/src/git/common.h b/src/git/common.h
index c470e0e..96f2971 100644
=2D-- a/src/git/common.h
+++ b/src/git/common.h
@@ -65,6 +65,9 @@
 /** Consult the OS error information. */
 #define GIT_EOSERR (GIT_ERROR - 4)
=20
+/** The path is not a directory */
+#define GIT_ENOTDIR (GIT_ERROR - 5)
+
 GIT_BEGIN_DECL
=20
 /** A revision traversal pool. */
=2D-=20
1.6.3.3


--Boundary-00=_4Xd+KlPTJfZNjEy
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-git_odb_open-ckeck-for-valid-path-to-database-using-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-git_odb_open-ckeck-for-valid-path-to-database-using-.patch"

=46rom 4db79e006b722291d645f05a2340cd7d26a3d777 Mon Sep 17 00:00:00 2001
=46rom: Esben Mose Hansen <kde@mosehansen.dk>
Date: Tue, 10 Nov 2009 21:58:36 +0100
Subject: [PATCH 2/2] git_odb_open ckeck for valid path to database using gi=
tfo_is_directory

=2D--
 src/odb.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/odb.c b/src/odb.c
index 6d646a4..709fe58 100644
=2D-- a/src/odb.c
+++ b/src/odb.c
@@ -1014,6 +1014,7 @@ int git_odb_exists(git_odb *db, const git_oid *id)
=20
 int git_odb_open(git_odb **out, const char *objects_dir)
 {
+	int status;
 	git_odb *db =3D git__calloc(1, sizeof(*db));
 	if (!db)
 		return GIT_ERROR;
@@ -1023,6 +1024,10 @@ int git_odb_open(git_odb **out, const char *objects_=
dir)
 		free(db);
 		return GIT_ERROR;
 	}
+	if ((status =3D gitfo_is_directory(db->objects_dir))) {
+		free(db);
+		return status;
+	}
=20
 	gitlck_init(&db->lock);
=20
=2D-=20
1.6.3.3


--Boundary-00=_4Xd+KlPTJfZNjEy--
