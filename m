From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: support --pack-stream to concatenate packs
Date: Sun,  9 Jan 2011 14:45:21 +0700
Message-ID: <1294559121-19048-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 09 08:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbpzI-0007ws-5R
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 08:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156Ab1AIHqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jan 2011 02:46:46 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47843 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab1AIHqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 02:46:45 -0500
Received: by pwj3 with SMTP id 3so2540977pwj.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 23:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Wj/5Z15ROeDjy/KTV9o5+9Ft+ATl8tVA601EpfxFAaE=;
        b=lOVz3R/6ouWmN0ZwfEFI7yM7tEnP2RFVtLaN9r2W/8xKJMo13yEkOg/YisuzZRLXUu
         793yvmjuPh66+U9EWXehByKNmPFab9GODIAK4PC00lNeZFnEuk2QZ1/B0YlgI5hb55Q1
         KQa3XwLo7yzcrFGc4l/NNkJFCLlbZH3iSzNKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=bqlenuY+0CggmmoDfygB87GQJKsw702m/vAwhS2iRB2pw0KMY0DZYJPk9h7JgEUzon
         bqkGqn90h17UWb07hQJH4ke4bEAxCQr35apbyyK9odtGXGmyFV9LjxdQcUWwXzEagNn9
         ZkaMJ4tUNBKQZyRp5UqnJkXhDM+NRrvGWBsJY=
Received: by 10.142.171.17 with SMTP id t17mr3337193wfe.88.1294559204224;
        Sat, 08 Jan 2011 23:46:44 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.219.19])
        by mx.google.com with ESMTPS id v19sm5605087wfh.12.2011.01.08.23.46.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 23:46:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 09 Jan 2011 14:45:23 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164846>

--pack-stream --stdin assumes stdin is a stream of packs and creates
a single pack containing all objects of the stream.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Don't know if it's useful for anybody else. Might be a cheaper way
 than git-repack to reduce the number of packs.

 builtin/index-pack.c |  119 ++++++++++++++++++++++++++++++++++++++++++=
--------
 1 files changed, 101 insertions(+), 18 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8dc5c0b..4864913 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -59,6 +59,7 @@ static int nr_deltas;
 static int nr_resolved_deltas;
=20
 static int from_stdin;
+static int pack_stream;
 static int strict;
 static int verbose;
=20
@@ -68,7 +69,7 @@ static struct progress *progress;
 static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
-static git_SHA_CTX input_ctx;
+static git_SHA_CTX input_ctx, pack_stream_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
=20
@@ -115,23 +116,35 @@ static void check_objects(void)
=20
=20
 /* Discard current buffer used content. */
-static void flush(void)
+static void flush_1(int in_pack_stream)
 {
 	if (input_offset) {
-		if (output_fd >=3D 0)
-			write_or_die(output_fd, input_buffer, input_offset);
+		if (output_fd >=3D 0 &&
+		    (!pack_stream || (pack_stream && in_pack_stream)))
+				write_or_die(output_fd, input_buffer, input_offset);
+
 		git_SHA1_Update(&input_ctx, input_buffer, input_offset);
+		if (pack_stream && in_pack_stream)
+			git_SHA1_Update(&pack_stream_ctx, input_buffer, input_offset);
 		memmove(input_buffer, input_buffer + input_offset, input_len);
 		input_offset =3D 0;
 	}
 }
=20
+static void flush(void)
+{
+	flush_1(1);
+}
+
 /*
  * Make sure at least "min" bytes are available in the buffer, and
  * return the pointer to the buffer.
  */
-static void *fill(int min)
+static void *fill_gently(int min, int *got_eof)
 {
+	if (got_eof)
+		*got_eof =3D 0;
+
 	if (min <=3D input_len)
 		return input_buffer + input_offset;
 	if (min > sizeof(input_buffer))
@@ -141,9 +154,16 @@ static void *fill(int min)
 		ssize_t ret =3D xread(input_fd, input_buffer + input_len,
 				sizeof(input_buffer) - input_len);
 		if (ret <=3D 0) {
-			if (!ret)
-				die("early EOF");
-			die_errno("read error on input");
+			if (!ret) {
+				if (!got_eof)
+					die("early EOF");
+				else {
+					*got_eof =3D 1;
+					return NULL;
+				}
+			}
+			else
+				die_errno("read error on input");
 		}
 		input_len +=3D ret;
 		if (from_stdin)
@@ -152,6 +172,11 @@ static void *fill(int min)
 	return input_buffer;
 }
=20
+static void *fill(int min)
+{
+	return fill_gently(min, NULL);
+}
+
 static void use(int bytes)
 {
 	if (bytes > input_len)
@@ -188,6 +213,8 @@ static const char *open_pack_file(const char *pack_=
name)
 		pack_fd =3D input_fd;
 	}
 	git_SHA1_Init(&input_ctx);
+	if (pack_stream)
+		git_SHA1_Init(&pack_stream_ctx);
 	return pack_name;
 }
=20
@@ -202,7 +229,7 @@ static void parse_pack_header(void)
 		die("pack version %"PRIu32" unsupported",
 			ntohl(hdr->hdr_version));
=20
-	nr_objects =3D ntohl(hdr->hdr_entries);
+	nr_objects +=3D ntohl(hdr->hdr_entries);
 	use(sizeof(struct pack_header));
 }
=20
@@ -590,10 +617,10 @@ static int compare_delta_entry(const void *a, con=
st void *b)
 }
=20
 /* Parse all objects and return the pack content SHA1 hash */
-static void parse_pack_objects(unsigned char *sha1)
+static void parse_pack_objects(unsigned char *sha1, int start_object)
 {
 	int i;
-	struct delta_entry *delta =3D deltas;
+	struct delta_entry *delta =3D deltas + nr_deltas;
 	struct stat st;
=20
 	/*
@@ -606,7 +633,7 @@ static void parse_pack_objects(unsigned char *sha1)
 		progress =3D start_progress(
 				from_stdin ? "Receiving objects" : "Indexing objects",
 				nr_objects);
-	for (i =3D 0; i < nr_objects; i++) {
+	for (i =3D start_object; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
 		void *data =3D unpack_raw_entry(obj, &delta->base);
 		obj->real_type =3D obj->type;
@@ -630,11 +657,13 @@ static void parse_pack_objects(unsigned char *sha=
1)
 	use(20);
=20
 	/* If input_fd is a file, we should have reached its end now. */
-	if (fstat(input_fd, &st))
-		die_errno("cannot fstat packfile");
-	if (S_ISREG(st.st_mode) &&
-			lseek(input_fd, 0, SEEK_CUR) - input_len !=3D st.st_size)
-		die("pack has junk at the end");
+	if (!pack_stream) {
+		if (fstat(input_fd, &st))
+			die_errno("cannot fstat packfile");
+		if (S_ISREG(st.st_mode) &&
+		    lseek(input_fd, 0, SEEK_CUR) - input_len !=3D st.st_size)
+			die("pack has junk at the end");
+	}
=20
 	if (!nr_deltas)
 		return;
@@ -871,6 +900,54 @@ static int git_index_pack_config(const char *k, co=
nst char *v, void *cb)
 	return git_default_config(k, v, cb);
 }
=20
+static void parse_following_packs(unsigned char *pack_sha1,
+				  const char *curr_pack,
+				  int fix_thin_pack)
+{
+	unsigned char sha1[20];
+
+	for (;;) {
+		int got_eof;
+		int last_nr_objects =3D nr_objects;
+
+		/* SHA1 trailer of the previous pack */
+		consumed_bytes -=3D 20;
+		flush_1(0);
+
+		fill_gently(sizeof(struct pack_header), &got_eof);
+		if (got_eof) {
+			/*
+			 * pretend we also consume the trailer like in
+			 * single pack case, a new trailer will be
+			 * rewritten by fixup_pack_header_footer().
+			 */
+			consumed_bytes +=3D 20;
+			break;
+		}
+
+		git_SHA1_Init(&input_ctx);
+		parse_pack_header();
+		/* un-use() pack headers */
+		consumed_bytes -=3D sizeof(struct pack_header);
+		flush_1(0);
+
+		objects =3D xrealloc(objects, (nr_objects + 1) * sizeof(struct objec=
t_entry));
+		deltas =3D xrealloc(deltas, nr_objects * sizeof(struct delta_entry))=
;
+		parse_pack_objects(sha1, last_nr_objects);
+	}
+	git_SHA1_Final(pack_sha1, &pack_stream_ctx);
+
+	if (!fix_thin_pack ||
+	    (nr_deltas - nr_resolved_deltas) =3D=3D 0) {
+		unsigned char read_sha1[20];
+
+		hashcpy(read_sha1, pack_sha1);
+		fixup_pack_header_footer(output_fd, pack_sha1,
+					 curr_pack, nr_objects,
+					 read_sha1, consumed_bytes-20);
+	}
+}
+
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack =3D 0;
@@ -898,6 +975,8 @@ int cmd_index_pack(int argc, const char **argv, con=
st char *prefix)
 				from_stdin =3D 1;
 			} else if (!strcmp(arg, "--fix-thin")) {
 				fix_thin_pack =3D 1;
+			} else if (!strcmp(arg, "--pack-stream")) {
+				pack_stream =3D 1;
 			} else if (!strcmp(arg, "--strict")) {
 				strict =3D 1;
 			} else if (!strcmp(arg, "--keep")) {
@@ -946,6 +1025,8 @@ int cmd_index_pack(int argc, const char **argv, co=
nst char *prefix)
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
 		die("--fix-thin cannot be used without --stdin");
+	if (pack_stream && !from_stdin)
+		die("--pack-stream cannot be used without --stdin");
 	if (!index_name && pack_name) {
 		int len =3D strlen(pack_name);
 		if (!has_extension(pack_name, ".pack"))
@@ -971,7 +1052,9 @@ int cmd_index_pack(int argc, const char **argv, co=
nst char *prefix)
 	parse_pack_header();
 	objects =3D xmalloc((nr_objects + 1) * sizeof(struct object_entry));
 	deltas =3D xmalloc(nr_objects * sizeof(struct delta_entry));
-	parse_pack_objects(pack_sha1);
+	parse_pack_objects(pack_sha1, 0);
+	if (pack_stream)
+		parse_following_packs(pack_sha1, curr_pack, fix_thin_pack);
 	if (nr_deltas =3D=3D nr_resolved_deltas) {
 		stop_progress(&progress);
 		/* Flush remaining pack final 20-byte SHA1. */
--=20
1.7.2.2
