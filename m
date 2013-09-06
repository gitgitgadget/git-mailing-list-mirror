From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] index-pack: add --unpack-limit to unpack objects
Date: Fri,  6 Sep 2013 07:46:01 +0700
Message-ID: <1378428363-14086-1-git-send-email-pclouds@gmail.com>
References: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 06 02:43:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHk8o-0000Mj-0i
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 02:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab3IFAnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 20:43:06 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:56486 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab3IFAnE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 20:43:04 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so2507630pdj.7
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 17:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uKdGr6u68cJFlG/JTjjptCpjzjVrMO4OM0afOyDZ464=;
        b=iUyIeMIpqxIDNIP7I2e2JvY33ZqqAMp4tzbDZfT1MkpF/CIBC5MaPNJmcQPBneJe7S
         o1VmENGxo2FeFDoHCkGzK8mmssyNSpfOftuY9x5mwbyxdxOxU9gzyet8kSwzhnAo7TD6
         FHpd9lyK4GttyrNMJxGpfYrFDoBUDrj+Hc/BGuucJCE+x6FDkLIbBd+nnBIHKJMEm4dr
         IgH24rn1xgqymvGeQQkfJYc+Oa2F11YCHHDZx7xF1ls2UY1tpaC4zjcOwMNy55caaTlQ
         7hzXMOAadxxzruDmEjRvpgp0p9a1AH+wVPisOClUrELvsEgwiSIvpbCEqbv+7hOpL8KB
         tCfQ==
X-Received: by 10.68.234.102 with SMTP id ud6mr12162295pbc.50.1378428183733;
        Thu, 05 Sep 2013 17:43:03 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id oc10sm38486294pbb.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Sep 2013 17:43:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 06 Sep 2013 07:46:10 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234009>

If the number of objects in the given pack is less than the limit, all
objects in the pack will be unpacked, and the pack will not be created
if it's streamed in. It's intended to replace unpack-objects.

Unlike unpack-objects, this operation requires writing the stream to
disk for delta resolution. Base objects are not appended to the
temporary pack though. Given that unpack limit is usually small, the
I/O overhead should be unnoticeable.

When large blobs are present in the stream, things will be
different. Right now, those blobs are uncompressed in memory for
simplicity. But in future bulk-checkin should be used for streaming
large blobs to a new pack (and not written to the temp pack to reduce
I/O overhead).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I had something that could unpack without writing to temp pack file
 but I scraped it and chose this way because it follows closely how
 index-pack works. It's a good thing imo because .pack v4 is coming
 and I don't know how v4 may impact this unpack code path. Once things
 are settled, we can revisit and open a separate code path if it's
 still a good idea.

 builtin/index-pack.c | 136 +++++++++++++++++++++++++++++++++++++++++++=
++------
 1 file changed, 122 insertions(+), 14 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9c1cfac..a5b69e4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -81,6 +81,7 @@ static int do_fsck_object;
 static int verbose;
 static int show_stat;
 static int check_self_contained_and_connected;
+static int unpack;
=20
 static struct progress *progress;
=20
@@ -93,6 +94,21 @@ static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
=20
+/*
+ * When unpacking under --strict mode, objects whose reachability are
+ * suspect are kept in core without getting written in the object
+ * store.
+ */
+struct obj_buffer {
+	char *buffer;
+	unsigned long size;
+	enum object_type type;
+	unsigned char sha1[20];
+};
+
+struct obj_buffer *obj_buffers;
+int nr_object_buffers;
+
 #ifndef NO_PTHREADS
=20
 static struct thread_local *thread_data;
@@ -209,6 +225,23 @@ static unsigned check_object(struct object *obj)
 	return 0;
 }
=20
+static void write_cached_objects(void)
+{
+	unsigned char parano_sha1[20];
+	int i;
+	for (i =3D 0; i < nr_object_buffers; i++) {
+		struct obj_buffer *obj_buf =3D obj_buffers + i;
+		if (write_sha1_file(obj_buf->buffer, obj_buf->size,
+				    typename(obj_buf->type), parano_sha1) < 0)
+			die(_("failed to write object %s"),
+			    sha1_to_hex(obj_buf->sha1));
+		if (hashcmp(obj_buf->sha1, parano_sha1))
+			die(_("confused by unstable object source data for %s"),
+			    sha1_to_hex(obj_buf->sha1));
+		free(obj_buf->buffer);
+	}
+}
+
 static unsigned check_objects(void)
 {
 	unsigned i, max, foreign_nr =3D 0;
@@ -424,7 +457,18 @@ static void *unpack_entry_data(unsigned long offse=
t, unsigned long size,
 		git_SHA1_Update(&c, hdr, hdrlen);
 	} else
 		sha1 =3D NULL;
-	if (type =3D=3D OBJ_BLOB && size > big_file_threshold)
+	if (type =3D=3D OBJ_BLOB && size > big_file_threshold &&
+	    /*
+	     * In future we should use bulk-checkin instead of forcing
+	     * large blobs in core like this.
+	     *
+	     * If we do so, in --stdin mode, we might also want to
+	     * update flush() to do seek() instead of write() on large
+	     * blobs to reduce I/O and disk consumption (because we
+	     * need the temp pack with other objects at correct
+	     * position for delta resolution)
+	     */
+	    !unpack)
 		buf =3D fixed_buf;
 	else
 		buf =3D xmalloc(size);
@@ -700,17 +744,18 @@ static int check_collison(struct object_entry *en=
try)
 	return 0;
 }
=20
-static void sha1_object(const void *data, struct object_entry *obj_ent=
ry,
-			unsigned long size, enum object_type type,
-			const unsigned char *sha1)
+static void *sha1_object(void *data, struct object_entry *obj_entry,
+			 unsigned long size, enum object_type type,
+			 const unsigned char *sha1)
 {
 	void *new_data =3D NULL;
 	int collision_test_needed;
+	int queued =3D 0;
=20
 	assert(data || obj_entry);
=20
 	read_lock();
-	collision_test_needed =3D has_sha1_file(sha1);
+	collision_test_needed =3D unpack ? 0 : has_sha1_file(sha1);
 	read_unlock();
=20
 	if (collision_test_needed && !data) {
@@ -776,11 +821,36 @@ static void sha1_object(const void *data, struct =
object_entry *obj_entry,
 				commit->buffer =3D NULL;
 			}
 			obj->flags |=3D FLAG_CHECKED;
+			if (unpack) {
+				obj_buffers[nr_object_buffers].buffer =3D data;
+				obj_buffers[nr_object_buffers].size =3D size;
+				obj_buffers[nr_object_buffers].type =3D type;
+				hashcpy(obj_buffers[nr_object_buffers].sha1, sha1);
+				nr_object_buffers++;
+				data =3D NULL;
+				queued =3D 1;
+			}
 		}
 		read_unlock();
 	}
=20
+	if (unpack && !queued) {
+		unsigned char parano_sha1[20];
+
+		read_lock(); /* because write_sha1_file calls has_sha1_file */
+		if (write_sha1_file(data, size, typename(type),
+				    parano_sha1))
+			die(_("failed to unpack object at offset %lu"),
+			    obj_entry->idx.offset);
+		read_unlock();
+
+		if (hashcmp(sha1, parano_sha1))
+			die(_("confused by unstable object source data for %s"),
+			    sha1_to_hex(sha1));
+	}
+
 	free(new_data);
+	return data =3D=3D new_data ? NULL : data;
 }
=20
 /*
@@ -1021,7 +1091,8 @@ static void parse_pack_objects(unsigned char *sha=
1)
 			obj->real_type =3D OBJ_BAD;
 			nr_delays++;
 		} else
-			sha1_object(data, NULL, obj->size, obj->type, obj->idx.sha1);
+			data =3D sha1_object(data, NULL, obj->size,
+					   obj->type, obj->idx.sha1);
 		free(data);
 		display_progress(progress, i+1);
 	}
@@ -1188,6 +1259,18 @@ static struct object_entry *append_obj_to_pack(s=
truct sha1file *f,
 	unsigned long s =3D size;
 	int n =3D 0;
 	unsigned char c =3D (type << 4) | (s & 15);
+	if (unpack) {
+		/*
+		 * Just enough info to make find_unresolved_deltas()
+		 * happy. We do not need to actually append the object
+		 * in unpack case.
+		 */
+		obj[0].size =3D size;
+		obj[0].type =3D type;
+		obj[0].real_type =3D type;
+		hashcpy(obj->idx.sha1, sha1);
+		return obj;
+	}
 	s >>=3D 4;
 	while (s) {
 		header[n++] =3D c | 0x80;
@@ -1277,7 +1360,11 @@ static void final(const char *final_pack_name, c=
onst char *curr_pack_name,
 		err =3D close(output_fd);
 		if (err)
 			die_errno(_("error while closing pack file"));
+		if (unpack)
+			unlink(curr_pack_name);
 	}
+	if (unpack)
+		return;
=20
 	if (keep_msg) {
 		int keep_fd, keep_msg_len =3D strlen(keep_msg);
@@ -1489,14 +1576,14 @@ static void show_pack_info(int stat_only)
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0;
-	const char *curr_pack, *curr_index;
+	const char *curr_pack, *curr_index =3D NULL;
 	const char *index_name =3D NULL, *pack_name =3D NULL;
 	const char *keep_name =3D NULL, *keep_msg =3D NULL;
 	char *index_name_buf =3D NULL, *keep_name_buf =3D NULL;
-	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
 	unsigned char pack_sha1[20];
 	unsigned foreign_nr =3D 1;	/* zero is a "good" value, assume bad */
+	int unpack_limit =3D 0;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
@@ -1574,6 +1661,11 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 					opts.off32_limit =3D strtoul(c+1, &c, 0);
 				if (*c || opts.off32_limit & 0x80000000)
 					die(_("bad %s"), arg);
+			} else if (!prefixcmp(arg, "--unpack-limit=3D")) {
+				char *end;
+				unpack_limit =3D strtoul(arg+15, &end, 0);
+				if (!arg[15] || *end || unpack_limit < 0)
+					usage(index_pack_usage);
 			} else
 				usage(index_pack_usage);
 			continue;
@@ -1628,23 +1720,39 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
=20
 	curr_pack =3D open_pack_file(pack_name);
 	parse_pack_header();
+
+	if (nr_objects < unpack_limit) {
+		unpack =3D 1;
+		if (strict)
+			obj_buffers =3D xcalloc(nr_objects, sizeof(*obj_buffers));
+	}
+
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
 	deltas =3D xcalloc(nr_objects, sizeof(struct delta_entry));
 	parse_pack_objects(pack_sha1);
 	resolve_deltas();
 	conclude_pack(fix_thin_pack, curr_pack, pack_sha1);
 	free(deltas);
-	if (strict)
+	if (strict) {
 		foreign_nr =3D check_objects();
+		if (unpack) {
+			write_cached_objects();
+			free(obj_buffers);
+		}
+	}
=20
 	if (show_stat)
 		show_pack_info(stat_only);
=20
-	idx_objects =3D xmalloc((nr_objects) * sizeof(struct pack_idx_entry *=
));
-	for (i =3D 0; i < nr_objects; i++)
-		idx_objects[i] =3D &objects[i].idx;
-	curr_index =3D write_idx_file(index_name, idx_objects, nr_objects, &o=
pts, pack_sha1);
-	free(idx_objects);
+	if (!unpack) {
+		struct pack_idx_entry **idx_objects;
+		idx_objects =3D xmalloc((nr_objects) * sizeof(struct pack_idx_entry =
*));
+		for (i =3D 0; i < nr_objects; i++)
+			idx_objects[i] =3D &objects[i].idx;
+		curr_index =3D write_idx_file(index_name, idx_objects,
+					    nr_objects, &opts, pack_sha1);
+		free(idx_objects);
+	}
=20
 	if (!verify)
 		final(pack_name, curr_pack,
--=20
1.8.2.83.gc99314b
