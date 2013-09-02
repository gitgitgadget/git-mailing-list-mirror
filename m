From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] {fetch,receive}-pack: drop unpack-objects, delay loosing objects until the end
Date: Mon,  2 Sep 2013 10:05:07 +0700
Message-ID: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 05:02:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGKPJ-0004OO-3h
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 05:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757973Ab3IBDCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Sep 2013 23:02:09 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:61279 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757963Ab3IBDCH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 23:02:07 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so4208732pdi.0
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 20:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=HjkkA4xneTc9v7aC37QjpPkRevaY/eQXL+TCAPTJE+U=;
        b=GCyVeLR9kV07ieIIjZATcPmBLxv9NeYjHt+8O0lZ9evccofOPrF4gk96/EvAGHg+L7
         x7fnqv6T/dHY4C4o5ZRizWEomcQR1+zfp4UOKogZmeIiASabvD0P7WUJwmqnMUWTmcIZ
         9meahNuaC/cFQxARDUaDuL6z7rRhzjI7JKZXZvmldvn3tsW5VO5fEmRbrsrcgltPToCO
         IMfjqi4QlAIHUWc+HJxV80IC9bF2H2JKRyivj78lWmr2dCbKzPOqEY2axjAVi959w4vT
         qY8NopX2MUAgR2aK1/EFGP63jgG2/t/cHpAia18tt+Fmko4stJC/0OTXuxdEHrp36BlV
         pNXg==
X-Received: by 10.66.243.196 with SMTP id xa4mr84578pac.174.1378090926281;
        Sun, 01 Sep 2013 20:02:06 -0700 (PDT)
Received: from lanh ([115.73.192.103])
        by mx.google.com with ESMTPSA id yg3sm13717218pab.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 20:02:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 02 Sep 2013 10:05:09 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233596>

Current code peaks into the transfered pack's header, if the number of
objects is under a limit, unpack-objects is called to handle the rest,
otherwise index-pack is. This patch makes fetch-pack use index-pack
unconditionally, then turn objects loose and remove the pack at the
end. unpack-objects is deprecated and may be removed in future.

There are a few reasons for this:

 - down to two code paths to maintain regarding pack reading
   (sha1_file.c and index-pack.c). When .pack v4 comes, we don't need
   to duplicate work in index-pack and unpack-objects.

 - the number of objects should not be the only indicator for
   unpacking. If there are a few large objects in the pack, the pack
   should be kept anyway. Keeping the pack lets us examine the whole
   pack later and make a better decision.

 - by going through index-pack first, then unpack, we pay extra cost
   for completing a thin pack into a full one. But compared to fetch's
   total time, it should not be noticeable because unpack-objects is
   only called when the pack contains a small number of objects.

 - unpack-objects does not support streaming large blobs. Granted
   force_object_loose(), which is used by this patch, does not either.
   But it'll be easier to do so because sha1_file.c interface supports
   streaming.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/receive-pack.c | 120 +++++++++++++----------------------------=
--------
 cache.h                |   1 +
 fetch-pack.c           |  77 +++++++++++--------------------
 sha1_file.c            |  70 ++++++++++++++++++++++++++++-
 4 files changed, 128 insertions(+), 140 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..6eb4ffb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -792,105 +792,49 @@ static struct command *read_head_info(void)
 	return commands;
 }
=20
-static const char *parse_pack_header(struct pack_header *hdr)
-{
-	switch (read_pack_header(0, hdr)) {
-	case PH_ERROR_EOF:
-		return "eof before pack header was fully read";
-
-	case PH_ERROR_PACK_SIGNATURE:
-		return "protocol error (pack signature mismatch detected)";
-
-	case PH_ERROR_PROTOCOL:
-		return "protocol error (pack version unsupported)";
-
-	default:
-		return "unknown error in parse_pack_header";
-
-	case 0:
-		return NULL;
-	}
-}
-
 static const char *pack_lockfile;
=20
 static const char *unpack(int err_fd)
 {
-	struct pack_header hdr;
-	const char *hdr_err;
-	char hdr_arg[38];
 	int fsck_objects =3D (receive_fsck_objects >=3D 0
 			    ? receive_fsck_objects
 			    : transfer_fsck_objects >=3D 0
 			    ? transfer_fsck_objects
 			    : 0);
=20
-	hdr_err =3D parse_pack_header(&hdr);
-	if (hdr_err) {
-		if (err_fd > 0)
-			close(err_fd);
-		return hdr_err;
-	}
-	snprintf(hdr_arg, sizeof(hdr_arg),
-			"--pack_header=3D%"PRIu32",%"PRIu32,
-			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
-
-	if (ntohl(hdr.hdr_entries) < unpack_limit) {
-		int code, i =3D 0;
-		struct child_process child;
-		const char *unpacker[5];
-		unpacker[i++] =3D "unpack-objects";
-		if (quiet)
-			unpacker[i++] =3D "-q";
-		if (fsck_objects)
-			unpacker[i++] =3D "--strict";
-		unpacker[i++] =3D hdr_arg;
-		unpacker[i++] =3D NULL;
-		memset(&child, 0, sizeof(child));
-		child.argv =3D unpacker;
-		child.no_stdout =3D 1;
-		child.err =3D err_fd;
-		child.git_cmd =3D 1;
-		code =3D run_command(&child);
-		if (!code)
-			return NULL;
-		return "unpack-objects abnormal exit";
-	} else {
-		const char *keeper[7];
-		int s, status, i =3D 0;
-		char keep_arg[256];
-		struct child_process ip;
-
-		s =3D sprintf(keep_arg, "--keep=3Dreceive-pack %"PRIuMAX" on ", (uin=
tmax_t) getpid());
-		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
-			strcpy(keep_arg + s, "localhost");
-
-		keeper[i++] =3D "index-pack";
-		keeper[i++] =3D "--stdin";
-		if (fsck_objects)
-			keeper[i++] =3D "--strict";
-		keeper[i++] =3D "--fix-thin";
-		keeper[i++] =3D hdr_arg;
-		keeper[i++] =3D keep_arg;
-		keeper[i++] =3D NULL;
-		memset(&ip, 0, sizeof(ip));
-		ip.argv =3D keeper;
-		ip.out =3D -1;
-		ip.err =3D err_fd;
-		ip.git_cmd =3D 1;
-		status =3D start_command(&ip);
-		if (status) {
-			return "index-pack fork failed";
-		}
-		pack_lockfile =3D index_pack_lockfile(ip.out);
-		close(ip.out);
-		status =3D finish_command(&ip);
-		if (!status) {
-			reprepare_packed_git();
-			return NULL;
-		}
+	const char *keeper[7];
+	int s, status, i =3D 0;
+	char keep_arg[256];
+	struct child_process ip;
+
+	s =3D sprintf(keep_arg, "--keep=3Dreceive-pack %"PRIuMAX" on ", (uint=
max_t) getpid());
+	if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
+		strcpy(keep_arg + s, "localhost");
+
+	keeper[i++] =3D "index-pack";
+	keeper[i++] =3D "--stdin";
+	if (fsck_objects)
+		keeper[i++] =3D "--strict";
+	keeper[i++] =3D "--fix-thin";
+	keeper[i++] =3D keep_arg;
+	keeper[i++] =3D NULL;
+	memset(&ip, 0, sizeof(ip));
+	ip.argv =3D keeper;
+	ip.out =3D -1;
+	ip.err =3D err_fd;
+	ip.git_cmd =3D 1;
+	status =3D start_command(&ip);
+	if (status) {
+		return "index-pack fork failed";
+	}
+	pack_lockfile =3D index_pack_lockfile(ip.out);
+	close(ip.out);
+	status =3D finish_command(&ip);
+	if (status)
 		return "index-pack abnormal exit";
-	}
+	if (!maybe_unpack_objects(pack_lockfile, unpack_limit))
+		pack_lockfile =3D NULL;
+	return NULL;
 }
=20
 static const char *unpack_with_sideband(void)
diff --git a/cache.h b/cache.h
index 85b544f..0fff958 100644
--- a/cache.h
+++ b/cache.h
@@ -789,6 +789,7 @@ extern int hash_sha1_file(const void *buf, unsigned=
 long len, const char *type,
 extern int write_sha1_file(const void *buf, unsigned long len, const c=
har *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, =
unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime)=
;
+extern int maybe_unpack_objects(const char *pack_lockfile, int limit);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *s=
ize);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map,=
 unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
diff --git a/fetch-pack.c b/fetch-pack.c
index f5d99c1..9c81a15 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -687,9 +687,7 @@ static int get_pack(struct fetch_pack_args *args,
 	struct async demux;
 	const char *argv[22];
 	char keep_arg[256];
-	char hdr_arg[256];
 	const char **av;
-	int do_keep =3D args->keep_pack;
 	struct child_process cmd;
 	int ret;
=20
@@ -711,54 +709,29 @@ static int get_pack(struct fetch_pack_args *args,
=20
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.argv =3D argv;
+	cmd.out =3D -1;
 	av =3D argv;
-	*hdr_arg =3D 0;
-	if (!args->keep_pack && unpack_limit) {
-		struct pack_header header;
-
-		if (read_pack_header(demux.out, &header))
-			die("protocol error: bad pack header");
-		snprintf(hdr_arg, sizeof(hdr_arg),
-			 "--pack_header=3D%"PRIu32",%"PRIu32,
-			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
-		if (ntohl(header.hdr_entries) < unpack_limit)
-			do_keep =3D 0;
-		else
-			do_keep =3D 1;
-	}
=20
 	if (alternate_shallow_file) {
 		*av++ =3D "--shallow-file";
 		*av++ =3D alternate_shallow_file;
 	}
=20
-	if (do_keep) {
-		if (pack_lockfile)
-			cmd.out =3D -1;
-		*av++ =3D "index-pack";
-		*av++ =3D "--stdin";
-		if (!args->quiet && !args->no_progress)
-			*av++ =3D "-v";
-		if (args->use_thin_pack)
-			*av++ =3D "--fix-thin";
-		if (args->lock_pack || unpack_limit) {
-			int s =3D sprintf(keep_arg,
-					"--keep=3Dfetch-pack %"PRIuMAX " on ", (uintmax_t) getpid());
-			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
-				strcpy(keep_arg + s, "localhost");
-			*av++ =3D keep_arg;
-		}
-		if (args->check_self_contained_and_connected)
-			*av++ =3D "--check-self-contained-and-connected";
-	}
-	else {
-		*av++ =3D "unpack-objects";
-		if (args->quiet || args->no_progress)
-			*av++ =3D "-q";
-		args->check_self_contained_and_connected =3D 0;
-	}
-	if (*hdr_arg)
-		*av++ =3D hdr_arg;
+	*av++ =3D "index-pack";
+	*av++ =3D "--stdin";
+	if (!args->quiet && !args->no_progress)
+		*av++ =3D "-v";
+	if (args->use_thin_pack)
+		*av++ =3D "--fix-thin";
+	if (args->lock_pack || unpack_limit) {
+		int s =3D sprintf(keep_arg,
+				"--keep=3Dfetch-pack %"PRIuMAX " on ", (uintmax_t) getpid());
+		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
+			strcpy(keep_arg + s, "localhost");
+		*av++ =3D keep_arg;
+	}
+	if (args->check_self_contained_and_connected)
+		*av++ =3D "--check-self-contained-and-connected";
 	if (fetch_fsck_objects >=3D 0
 	    ? fetch_fsck_objects
 	    : transfer_fsck_objects >=3D 0
@@ -771,10 +744,8 @@ static int get_pack(struct fetch_pack_args *args,
 	cmd.git_cmd =3D 1;
 	if (start_command(&cmd))
 		die("fetch-pack: unable to fork off %s", argv[0]);
-	if (do_keep && pack_lockfile) {
-		*pack_lockfile =3D index_pack_lockfile(cmd.out);
-		close(cmd.out);
-	}
+	*pack_lockfile =3D index_pack_lockfile(cmd.out);
+	close(cmd.out);
=20
 	ret =3D finish_command(&cmd);
 	if (!ret || (args->check_self_contained_and_connected && ret =3D=3D 1=
))
@@ -820,11 +791,12 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
 				 struct ref **sought, int nr_sought,
-				 char **pack_lockfile)
+				 char **pack_lockfile_p)
 {
 	struct ref *ref =3D copy_ref_list(orig_ref);
 	unsigned char sha1[20];
 	const char *agent_feature;
+	char *pack_lockfile =3D NULL;
 	int agent_len;
=20
 	sort_ref_list(&ref, ref_compare_name);
@@ -899,9 +871,15 @@ static struct ref *do_fetch_pack(struct fetch_pack=
_args *args,
 		setup_alternate_shallow();
 	else
 		alternate_shallow_file =3D NULL;
-	if (get_pack(args, fd, pack_lockfile))
+	if (get_pack(args, fd, &pack_lockfile))
 		die("git fetch-pack: fetch failed.");
=20
+	if (!maybe_unpack_objects(pack_lockfile,
+				  args->keep_pack ? 0 : unpack_limit))
+		pack_lockfile =3D NULL;
+	if (pack_lockfile_p)
+		*pack_lockfile_p =3D pack_lockfile;
+
  all_done:
 	return ref;
 }
@@ -997,6 +975,5 @@ struct ref *fetch_pack(struct fetch_pack_args *args=
,
 			commit_lock_file(&shallow_lock);
 	}
=20
-	reprepare_packed_git();
 	return ref_cpy;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 8e27db1..a0cdeae 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -61,6 +61,8 @@ static struct cached_object empty_tree =3D {
 };
=20
 static struct packed_git *last_found_pack;
+/* temporarily skip one pack in find_pack_entry() */
+static struct packed_git *skip_this_pack;
=20
 static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
 {
@@ -2376,11 +2378,15 @@ static int find_pack_entry(const unsigned char =
*sha1, struct pack_entry *e)
 	if (!packed_git)
 		return 0;
=20
-	if (last_found_pack && fill_pack_entry(sha1, e, last_found_pack))
+	if (last_found_pack &&
+	    last_found_pack !=3D skip_this_pack &&
+	    fill_pack_entry(sha1, e, last_found_pack))
 		return 1;
=20
 	for (p =3D packed_git; p; p =3D p->next) {
-		if (p =3D=3D last_found_pack || !fill_pack_entry(sha1, e, p))
+		if (p =3D=3D last_found_pack ||
+		    p =3D=3D skip_this_pack ||
+		    !fill_pack_entry(sha1, e, p))
 			continue;
=20
 		last_found_pack =3D p;
@@ -3133,3 +3139,63 @@ void assert_sha1_type(const unsigned char *sha1,=
 enum object_type expect)
 		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
 		    typename(expect));
 }
+
+static int has_sha1_except_in(struct packed_git *p,
+			      const unsigned char *sha1)
+{
+	int has;
+	skip_this_pack =3D p;
+	has =3D has_sha1_file(sha1);
+	skip_this_pack =3D NULL;
+	return has;
+}
+
+/*
+ * Unpack objects if the number of objects in the pack is lower than
+ * specified limit. Otherwise make sure the new pack is registered
+ * (including when pack_lockfile is NULL). Return 0 is the pack is
+ * removed.
+ */
+int maybe_unpack_objects(const char *pack_lockfile, int limit)
+{
+	const char *ext[] =3D { ".pack", ".idx", ".keep", NULL };
+	struct packed_git *p;
+	char *path;
+	int len, ret =3D 0;
+	uint32_t i;
+
+	reprepare_packed_git();
+	if (!pack_lockfile)
+		return -1;
+
+	/* must be enough for any extensions in ext[] */
+	path =3D xstrdup(pack_lockfile);
+	len =3D strlen(pack_lockfile) - strlen(".keep");
+	strcpy(path + len, ".pack");
+	for (p =3D packed_git; p; p =3D p->next)
+		if (!strcmp(p->pack_name, path))
+			break;
+	if (!p || open_pack_index(p))
+		die("unable to find pack %s", path);
+
+	if (p->num_objects >=3D limit) {
+		free(path);
+		return -1;
+	}
+
+	for (i =3D 0; i < p->num_objects; i++) {
+		const unsigned char *sha1 =3D nth_packed_object_sha1(p, i);
+		if (!has_sha1_except_in(p, sha1)) /* skip --fix-thin objects */
+			ret |=3D force_object_loose(sha1, p->mtime);
+	}
+
+	if (!ret) {
+		free_pack_by_name(p->pack_name);
+		for (i =3D 0; ext[i]; i++) {
+			strcpy(path + len, ext[i]);
+			unlink_or_warn(path);
+		}
+	}
+	free(path);
+	return ret;
+}
--=20
1.8.2.83.gc99314b
