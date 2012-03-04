From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/10] archive: support streaming large files to a tar archive
Date: Sun,  4 Mar 2012 19:59:55 +0700
Message-ID: <1330865996-2069-10-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 14:03:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4B64-0003pj-Lt
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 14:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab2CDND2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 08:03:28 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40475 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab2CDND1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 08:03:27 -0500
Received: by mail-pw0-f46.google.com with SMTP id un15so1801665pbc.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 05:03:27 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.134.33 as permitted sender) client-ip=10.68.134.33;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.134.33 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.134.33])
        by 10.68.134.33 with SMTP id ph1mr20759119pbb.81.1330866207117 (num_hops = 1);
        Sun, 04 Mar 2012 05:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CQk/Bd0ThitPQyIdqTnXqJDX97CiZsLD8N7iQiPRSqY=;
        b=QGxjE4iOjCZj45CEroBaJq4TNu1RRyBBGPXjhoVyab+jnQPTcSrxHk2prXjnTQVCxk
         fySQCUAnzZrhoTSAk3HeR+K8pT1ZtmoERbiZmGdjs32d/UT27F8QLSwlJ2aH6Vj3qmSS
         3N4OKh4RN77AJzqrOWPOvXJCXLPMLLE7ZsCPPIhGMuxk22wU4rPqQHuCw5JD9tc0dKNJ
         U1izo7DeWh/9MnIwnHrmafVL+bkGd67MQYN6pKMRJdR3nQD7nDVtMD8Hy0abiVR2QVhr
         PGajhB8uhkKlETTSa7W3ixIs6HZ+HtPgLyOB1pIsHzTYFgApvS++9eBU7k50GHBal99E
         yh4g==
Received: by 10.68.134.33 with SMTP id ph1mr17990726pbb.81.1330866207079;
        Sun, 04 Mar 2012 05:03:27 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.34.94])
        by mx.google.com with ESMTPS id j3sm10446585pbb.29.2012.03.04.05.03.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 05:03:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 04 Mar 2012 20:01:19 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192160>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-tar.c    |   35 ++++++++++++++++++++++++++++-------
 archive-zip.c    |    9 +++++----
 archive.c        |   51 ++++++++++++++++++++++++++++++++++------------=
-----
 archive.h        |   11 +++++++++--
 t/t1050-large.sh |    2 +-
 5 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 20af005..5bffe49 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -5,6 +5,7 @@
 #include "tar.h"
 #include "archive.h"
 #include "run-command.h"
+#include "streaming.h"
=20
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
@@ -123,9 +124,29 @@ static size_t get_path_prefix(const char *path, si=
ze_t pathlen, size_t maxlen)
 	return i;
 }
=20
+static void write_file(struct git_istream *stream, const void *buffer,
+		       unsigned long size)
+{
+	if (!stream) {
+		write_blocked(buffer, size);
+		return;
+	}
+	for (;;) {
+		char buf[1024 * 16];
+		ssize_t readlen;
+
+		readlen =3D read_istream(stream, buf, sizeof(buf));
+
+		if (!readlen)
+			break;
+		write_blocked(buf, readlen);
+	}
+}
+
 static int write_tar_entry(struct archiver_args *args,
-		const unsigned char *sha1, const char *path, size_t pathlen,
-		unsigned int mode, void *buffer, unsigned long size)
+			   const unsigned char *sha1, const char *path,
+			   size_t pathlen, unsigned int mode, void *buffer,
+			   struct git_istream *stream, unsigned long size)
 {
 	struct ustar_header header;
 	struct strbuf ext_header =3D STRBUF_INIT;
@@ -200,14 +221,14 @@ static int write_tar_entry(struct archiver_args *=
args,
=20
 	if (ext_header.len > 0) {
 		err =3D write_tar_entry(args, sha1, NULL, 0, 0, ext_header.buf,
-				ext_header.len);
+				      NULL, ext_header.len);
 		if (err)
 			return err;
 	}
 	strbuf_release(&ext_header);
 	write_blocked(&header, sizeof(header));
-	if (S_ISREG(mode) && buffer && size > 0)
-		write_blocked(buffer, size);
+	if (S_ISREG(mode) && size > 0)
+		write_file(stream, buffer, size);
 	return err;
 }
=20
@@ -219,7 +240,7 @@ static int write_global_extended_header(struct arch=
iver_args *args)
=20
 	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 4=
0);
 	err =3D write_tar_entry(args, NULL, NULL, 0, 0, ext_header.buf,
-			ext_header.len);
+			      NULL, ext_header.len);
 	strbuf_release(&ext_header);
 	return err;
 }
@@ -308,7 +329,7 @@ static int write_tar_archive(const struct archiver =
*ar,
 	if (args->commit_sha1)
 		err =3D write_global_extended_header(args);
 	if (!err)
-		err =3D write_archive_entries(args, write_tar_entry);
+		err =3D write_archive_entries(args, write_tar_entry, 1);
 	if (!err)
 		write_trailer();
 	return err;
diff --git a/archive-zip.c b/archive-zip.c
index 02d1f37..4a1e917 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -120,9 +120,10 @@ static void *zlib_deflate(void *data, unsigned lon=
g size,
 	return buffer;
 }
=20
-static int write_zip_entry(struct archiver_args *args,
-		const unsigned char *sha1, const char *path, size_t pathlen,
-		unsigned int mode, void *buffer, unsigned long size)
+int write_zip_entry(struct archiver_args *args,
+			   const unsigned char *sha1, const char *path,
+			   size_t pathlen, unsigned int mode, void *buffer,
+			   struct git_istream *stream, unsigned long size)
 {
 	struct zip_local_header header;
 	struct zip_dir_header dirent;
@@ -271,7 +272,7 @@ static int write_zip_archive(const struct archiver =
*ar,
 	zip_dir =3D xmalloc(ZIP_DIRECTORY_MIN_SIZE);
 	zip_dir_size =3D ZIP_DIRECTORY_MIN_SIZE;
=20
-	err =3D write_archive_entries(args, write_zip_entry);
+	err =3D write_archive_entries(args, write_zip_entry, 0);
 	if (!err)
 		write_zip_trailer(args->commit_sha1);
=20
diff --git a/archive.c b/archive.c
index 1ee837d..257eadf 100644
--- a/archive.c
+++ b/archive.c
@@ -5,6 +5,7 @@
 #include "archive.h"
 #include "parse-options.h"
 #include "unpack-trees.h"
+#include "streaming.h"
=20
 static char const * const archive_usage[] =3D {
 	"git archive [options] <tree-ish> [<path>...]",
@@ -59,26 +60,35 @@ static void format_subst(const struct commit *commi=
t,
 	free(to_free);
 }
=20
-static void *sha1_file_to_archive(const char *path, const unsigned cha=
r *sha1,
-		unsigned int mode, enum object_type *type,
-		unsigned long *sizep, const struct commit *commit)
+void sha1_file_to_archive(void **buffer, struct git_istream **stream,
+			  const char *path, const unsigned char *sha1,
+			  unsigned int mode, enum object_type *type,
+			  unsigned long *sizep,
+			  const struct commit *commit)
 {
-	void *buffer;
+	if (stream) {
+		struct stream_filter *filter;
+		filter =3D get_stream_filter(path, sha1);
+		if (!commit && S_ISREG(mode) && is_null_stream_filter(filter)) {
+			*buffer =3D NULL;
+			*stream =3D open_istream(sha1, type, sizep, NULL);
+			return;
+		}
+		*stream =3D NULL;
+	}
=20
-	buffer =3D read_sha1_file(sha1, type, sizep);
-	if (buffer && S_ISREG(mode)) {
+	*buffer =3D read_sha1_file(sha1, type, sizep);
+	if (*buffer && S_ISREG(mode)) {
 		struct strbuf buf =3D STRBUF_INIT;
 		size_t size =3D 0;
=20
-		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
+		strbuf_attach(&buf, *buffer, *sizep, *sizep + 1);
 		convert_to_working_tree(path, buf.buf, buf.len, &buf);
 		if (commit)
 			format_subst(commit, buf.buf, buf.len, &buf);
-		buffer =3D strbuf_detach(&buf, &size);
+		*buffer =3D strbuf_detach(&buf, &size);
 		*sizep =3D size;
 	}
-
-	return buffer;
 }
=20
 static void setup_archive_check(struct git_attr_check *check)
@@ -97,6 +107,7 @@ static void setup_archive_check(struct git_attr_chec=
k *check)
 struct archiver_context {
 	struct archiver_args *args;
 	write_archive_entry_fn_t write_entry;
+	int stream_ok;
 };
=20
 static int write_archive_entry(const unsigned char *sha1, const char *=
base,
@@ -109,6 +120,7 @@ static int write_archive_entry(const unsigned char =
*sha1, const char *base,
 	write_archive_entry_fn_t write_entry =3D c->write_entry;
 	struct git_attr_check check[2];
 	const char *path_without_prefix;
+	struct git_istream *stream =3D NULL;
 	int convert =3D 0;
 	int err;
 	enum object_type type;
@@ -133,25 +145,29 @@ static int write_archive_entry(const unsigned cha=
r *sha1, const char *base,
 		strbuf_addch(&path, '/');
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-		err =3D write_entry(args, sha1, path.buf, path.len, mode, NULL, 0);
+		err =3D write_entry(args, sha1, path.buf, path.len, mode, NULL, NULL=
, 0);
 		if (err)
 			return err;
 		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 	}
=20
-	buffer =3D sha1_file_to_archive(path_without_prefix, sha1, mode,
-			&type, &size, convert ? args->commit : NULL);
-	if (!buffer)
+	sha1_file_to_archive(&buffer, c->stream_ok ? &stream : NULL,
+			     path_without_prefix, sha1, mode,
+			     &type, &size, convert ? args->commit : NULL);
+	if (!buffer && !stream)
 		return error("cannot read %s", sha1_to_hex(sha1));
 	if (args->verbose)
 		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-	err =3D write_entry(args, sha1, path.buf, path.len, mode, buffer, siz=
e);
+	err =3D write_entry(args, sha1, path.buf, path.len, mode, buffer, str=
eam, size);
+	if (stream)
+		close_istream(stream);
 	free(buffer);
 	return err;
 }
=20
 int write_archive_entries(struct archiver_args *args,
-		write_archive_entry_fn_t write_entry)
+			  write_archive_entry_fn_t write_entry,
+			  int stream_ok)
 {
 	struct archiver_context context;
 	struct unpack_trees_options opts;
@@ -167,13 +183,14 @@ int write_archive_entries(struct archiver_args *a=
rgs,
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)len, args->base);
 		err =3D write_entry(args, args->tree->object.sha1, args->base,
-				len, 040777, NULL, 0);
+				  len, 040777, NULL, NULL, 0);
 		if (err)
 			return err;
 	}
=20
 	context.args =3D args;
 	context.write_entry =3D write_entry;
+	context.stream_ok =3D stream_ok;
=20
 	/*
 	 * Setup index and instruct attr to read index only
diff --git a/archive.h b/archive.h
index 2b0884f..370cca9 100644
--- a/archive.h
+++ b/archive.h
@@ -27,9 +27,16 @@ extern void register_archiver(struct archiver *);
 extern void init_tar_archiver(void);
 extern void init_zip_archiver(void);
=20
-typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, co=
nst unsigned char *sha1, const char *path, size_t pathlen, unsigned int=
 mode, void *buffer, unsigned long size);
+struct git_istream;
+typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
+					const unsigned char *sha1,
+					const char *path, size_t pathlen,
+					unsigned int mode,
+					void *buffer,
+					struct git_istream *stream,
+					unsigned long size);
=20
-extern int write_archive_entries(struct archiver_args *args, write_arc=
hive_entry_fn_t write_entry);
+extern int write_archive_entries(struct archiver_args *args, write_arc=
hive_entry_fn_t write_entry, int stream_ok);
 extern int write_archive(int argc, const char **argv, const char *pref=
ix, int setup_prefix, const char *name_hint, int remote);
=20
 const char *archive_format_from_filename(const char *filename);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index c749ecb..1e64692 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -149,7 +149,7 @@ test_expect_success 'repack' '
 	git repack -ad
 '
=20
-test_expect_failure 'tar achiving' '
+test_expect_success 'tar achiving' '
 	git archive --format=3Dtar HEAD >/dev/null
 '
=20
--=20
1.7.8.36.g69ee2
