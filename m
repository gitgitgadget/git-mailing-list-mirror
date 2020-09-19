Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B495C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 21:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19293222BB
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 21:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="s2Swp8pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgISVXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 17:23:46 -0400
Received: from mout.web.de ([212.227.17.11]:40065 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgISVXp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 17:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600550613;
        bh=1BqCjG+NV2K2dt+nZeUzIxnRFvQJZamXQJ6z8nyhVQs=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=s2Swp8pDDkiPlirUu4yCB37mtESmt1NchGZP/8KorIgVzVh21Tx1t52ftzpNujzDp
         JHhsAuec7a7ZXJ0dl5Rzgd+Mew9APeXUAYsgUmG/sRTr+m47WyQ4pwBRqOZadOEE/3
         3nodkxalqtQbx1a3+R/B3Ud7rfhawKuuAORR2EZc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRYf-1k1nny0FT1-00IYc3; Sat, 19
 Sep 2020 23:23:33 +0200
Subject: [PATCH 1/3] archive: read short blobs in
 archive.c::write_archive_entry()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwo0qk0fw.fsf@gitster.c.googlers.com>
 <b7ef3952-872a-40af-0f2e-c392b031a280@web.de>
Message-ID: <0951939b-7521-cf9b-1459-26d6d6774589@web.de>
Date:   Sat, 19 Sep 2020 23:23:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b7ef3952-872a-40af-0f2e-c392b031a280@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ryVfkt23TDNYCChnlKqSSAB8CBn0ccvzuCOfo8OG00iJri1Emiq
 hdHrOY3kejPG3YM6P36QC7l01S2CpG9EM/ta19YEseW24Xzc61qYGz5/i1VbkPSRWEM9TcM
 IcJHpz1FDhg6AhVvKXhFKdgh/CBePPtImqfg4xYZbkyebBRCt+ifrEbO+CLGIV5L9RSbeW2
 dMi3Lm+M4FEO2iur03hDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5nJTM07cTyM=:+atrjAFr5zXXo4tfcZ0N9w
 cqUXsU1p3/2eyERbhr0jDjb+8yTrN/OT5XK+dp/U1u5QUBYv11TPqYiA2Hlu6wsU4NtfX6Rk4
 iQdV1/B4qpF2XzvkCw3x2swm2iKYE1x4ceFeUzefMruZD/AfTx7yvkzqyJkK0EVVcJwFnzOBM
 0+WgMpXzDWfsgM/1ykz4p68nPFQu0nGqf5V8np+0j7mggZ3voAy75Hc52vBLY/mV92rPVU5zR
 H+Zr1jpeMrHbVw/culna5j9KnbiWFgJjdAc+pbKB6raG5qdVITqAuQbCNBd1Olv8dRhFBZB2a
 Fj4cqnu4Hugd5+4fbT9+28V/g3naqMCP05hLpMfFNNCB4JyZOF2CfGJ0Zd4LLi8mPiSCBUuzg
 SSP4jTPTIBJKZGz/xvtXC9OZKn4Y6gCSScmp2qB8IP06tEB8USEPqLU9jRxeKCCN1NR9MUnqa
 LIe4S7+TTuA5oR+QHhPM/6kvVIxpWzDpnCFP9bv3/J/9Vvo8bnTwt578d77fJ6gIGXLajAXso
 tdtzVmcJXZvJQSz0XlmqVQ1/rztArC8x9SK+2ZwED/phi7evIiMAt/w82KSSEzPrPw7FCmd5b
 YG0eZtag6Z+ildo6zrH9QbsWXMyUglZY2QRcbrgLTuGTUWeU5HerCFHtdXNTw/mWu84tKtDsX
 2iqGzaXItGDok2rGisBQMEQnesV8iWWBTDK58yQ7+2KRXbjyKMqcwv4x20mY17FZyiL0odIRL
 cmWbt4pTsXI+6wSIYkMnqdRc7WpWhKK4oeIT/JZfRYr+LHriw+M1Z40xY8GnaABD6WAeePsH/
 gGhlkMvNOoELUz53jAs+z55OUKBNDS5qbRLB5bLzLmya3WKbE+JW41dsjICN0fi/o3k3yIM/m
 sEUrH18XjTMjl97fNfL7oJ8YxgkDM/GDe7vP/raaJXwzVb+sKjeybzZLeHlhoslfFaO4M33ot
 swJRfXtlbLLvlfIuvXs6LctNcJ1upryV67PTcZfHYuzER10JpqHePLVAc/EvKC+FW8huPrHmD
 pMhszyDBf9kbJVzGy3K+DKOt+Rx/kTYI5v3YvMOTd3SGsKGfA8jC6PKr4XyhUBmRZJ3uXBgwl
 aBRLX8C/Zwr9jdoO+RzRD0jPnCMHCX0fkfo0IqCvr1m4UlLZKxnXiWxa7E0Rc06nALUuZTDUG
 kZJ3htSsT6dZB4kq95GZyyHO3wRYmt1egWDLnXazM8aA/TTef/X4SOGropkmnSI3P3xZhpXjX
 COlHy1FlbrtAFJgwh
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Centralize reading of symlink destinations and the contents of regular
files that are too small to be streamed.  This reduces code duplication
and allows future patches to add support for adding non-tracked files to
archives.  The backends are expected to stream blobs if buffer is NULL.

object_file_to_archive() is only called from archive.c and thus no
longer exported.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c | 22 +++-------------------
 archive-zip.c | 22 +++++-----------------
 archive.c     | 31 ++++++++++++++++++++++++-------
 archive.h     |  7 ++-----
 4 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 5ceec3684b..f1a1447ebd 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -242,13 +242,12 @@ static void write_extended_header(struct archiver_ar=
gs *args,
 static int write_tar_entry(struct archiver_args *args,
 			   const struct object_id *oid,
 			   const char *path, size_t pathlen,
-			   unsigned int mode)
+			   unsigned int mode,
+			   void *buffer, unsigned long size)
 {
 	struct ustar_header header;
 	struct strbuf ext_header =3D STRBUF_INIT;
-	unsigned int old_mode =3D mode;
-	unsigned long size, size_in_header;
-	void *buffer;
+	unsigned long size_in_header;
 	int err =3D 0;

 	memset(&header, 0, sizeof(header));
@@ -282,20 +281,6 @@ static int write_tar_entry(struct archiver_args *args=
,
 	} else
 		memcpy(header.name, path, pathlen);

-	if (S_ISREG(mode) && !args->convert &&
-	    oid_object_info(args->repo, oid, &size) =3D=3D OBJ_BLOB &&
-	    size > big_file_threshold)
-		buffer =3D NULL;
-	else if (S_ISLNK(mode) || S_ISREG(mode)) {
-		enum object_type type;
-		buffer =3D object_file_to_archive(args, path, oid, old_mode, &type, &si=
ze);
-		if (!buffer)
-			return error(_("cannot read %s"), oid_to_hex(oid));
-	} else {
-		buffer =3D NULL;
-		size =3D 0;
-	}
-
 	if (S_ISLNK(mode)) {
 		if (size > sizeof(header.linkname)) {
 			xsnprintf(header.linkname, sizeof(header.linkname),
@@ -326,7 +311,6 @@ static int write_tar_entry(struct archiver_args *args,
 		else
 			err =3D stream_blocked(args->repo, oid);
 	}
-	free(buffer);
 	return err;
 }

diff --git a/archive-zip.c b/archive-zip.c
index e9f426298b..2961e01c75 100644
=2D-- a/archive-zip.c
+++ b/archive-zip.c
@@ -285,7 +285,8 @@ static int entry_is_binary(struct index_state *istate,=
 const char *path,
 static int write_zip_entry(struct archiver_args *args,
 			   const struct object_id *oid,
 			   const char *path, size_t pathlen,
-			   unsigned int mode)
+			   unsigned int mode,
+			   void *buffer, unsigned long size)
 {
 	struct zip_local_header header;
 	uintmax_t offset =3D zip_offset;
@@ -299,10 +300,8 @@ static int write_zip_entry(struct archiver_args *args=
,
 	enum zip_method method;
 	unsigned char *out;
 	void *deflated =3D NULL;
-	void *buffer;
 	struct git_istream *stream =3D NULL;
 	unsigned long flags =3D 0;
-	unsigned long size;
 	int is_binary =3D -1;
 	const char *path_without_prefix =3D path + args->baselen;
 	unsigned int creator_version =3D 0;
@@ -328,13 +327,8 @@ static int write_zip_entry(struct archiver_args *args=
,
 		method =3D ZIP_METHOD_STORE;
 		attr2 =3D 16;
 		out =3D NULL;
-		size =3D 0;
 		compressed_size =3D 0;
-		buffer =3D NULL;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
-		enum object_type type =3D oid_object_info(args->repo, oid,
-							&size);
-
 		method =3D ZIP_METHOD_STORE;
 		attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :
 			(mode & 0111) ? ((mode) << 16) : 0;
@@ -343,21 +337,16 @@ static int write_zip_entry(struct archiver_args *arg=
s,
 		if (S_ISREG(mode) && args->compression_level !=3D 0 && size > 0)
 			method =3D ZIP_METHOD_DEFLATE;

-		if (S_ISREG(mode) && type =3D=3D OBJ_BLOB && !args->convert &&
-		    size > big_file_threshold) {
+		if (!buffer) {
+			enum object_type type;
 			stream =3D open_istream(args->repo, oid, &type, &size,
 					      NULL);
 			if (!stream)
 				return error(_("cannot stream blob %s"),
 					     oid_to_hex(oid));
 			flags |=3D ZIP_STREAM;
-			out =3D buffer =3D NULL;
+			out =3D NULL;
 		} else {
-			buffer =3D object_file_to_archive(args, path, oid, mode,
-							&type, &size);
-			if (!buffer)
-				return error(_("cannot read %s"),
-					     oid_to_hex(oid));
 			crc =3D crc32(crc, buffer, size);
 			is_binary =3D entry_is_binary(args->repo->index,
 						    path_without_prefix,
@@ -511,7 +500,6 @@ static int write_zip_entry(struct archiver_args *args,
 	}

 	free(deflated);
-	free(buffer);

 	if (compressed_size > 0xffffffff || size > 0xffffffff ||
 	    offset > 0xffffffff) {
diff --git a/archive.c b/archive.c
index 0de6048bfc..4fbe5329c5 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -70,10 +70,12 @@ static void format_subst(const struct commit *commit,
 	free(to_free);
 }

-void *object_file_to_archive(const struct archiver_args *args,
-			     const char *path, const struct object_id *oid,
-			     unsigned int mode, enum object_type *type,
-			     unsigned long *sizep)
+static void *object_file_to_archive(const struct archiver_args *args,
+				    const char *path,
+				    const struct object_id *oid,
+				    unsigned int mode,
+				    enum object_type *type,
+				    unsigned long *sizep)
 {
 	void *buffer;
 	const struct commit *commit =3D args->convert ? args->commit : NULL;
@@ -145,6 +147,9 @@ static int write_archive_entry(const struct object_id =
*oid, const char *base,
 	write_archive_entry_fn_t write_entry =3D c->write_entry;
 	int err;
 	const char *path_without_prefix;
+	unsigned long size;
+	void *buffer;
+	enum object_type type;

 	args->convert =3D 0;
 	strbuf_reset(&path);
@@ -167,7 +172,7 @@ static int write_archive_entry(const struct object_id =
*oid, const char *base,
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-		err =3D write_entry(args, oid, path.buf, path.len, mode);
+		err =3D write_entry(args, oid, path.buf, path.len, mode, NULL, 0);
 		if (err)
 			return err;
 		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
@@ -175,7 +180,19 @@ static int write_archive_entry(const struct object_id=
 *oid, const char *base,

 	if (args->verbose)
 		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-	return write_entry(args, oid, path.buf, path.len, mode);
+
+	/* Stream it? */
+	if (S_ISREG(mode) && !args->convert &&
+	    oid_object_info(args->repo, oid, &size) =3D=3D OBJ_BLOB &&
+	    size > big_file_threshold)
+		return write_entry(args, oid, path.buf, path.len, mode, NULL, size);
+
+	buffer =3D object_file_to_archive(args, path.buf, oid, mode, &type, &siz=
e);
+	if (!buffer)
+		return error(_("cannot read %s"), oid_to_hex(oid));
+	err =3D write_entry(args, oid, path.buf, path.len, mode, buffer, size);
+	free(buffer);
+	return err;
 }

 static void queue_directory(const unsigned char *sha1,
@@ -265,7 +282,7 @@ int write_archive_entries(struct archiver_args *args,
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)len, args->base);
 		err =3D write_entry(args, &args->tree->object.oid, args->base,
-				  len, 040777);
+				  len, 040777, NULL, 0);
 		if (err)
 			return err;
 	}
diff --git a/archive.h b/archive.h
index 3bd96bf6bb..d83b41a01f 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -49,12 +49,9 @@ void init_archivers(void);
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
 					const struct object_id *oid,
 					const char *path, size_t pathlen,
-					unsigned int mode);
+					unsigned int mode,
+					void *buffer, unsigned long size);

 int write_archive_entries(struct archiver_args *args, write_archive_entry=
_fn_t write_entry);
-void *object_file_to_archive(const struct archiver_args *args,
-			     const char *path, const struct object_id *oid,
-			     unsigned int mode, enum object_type *type,
-			     unsigned long *sizep);

 #endif	/* ARCHIVE_H */
=2D-
2.28.0

