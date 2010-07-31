From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/16] subtree: rewrite incoming commits
Date: Sat, 31 Jul 2010 23:18:18 +0700
Message-ID: <1280593105-22015-10-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:39:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOS5-000306-Ga
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab0HACi4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:38:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42790 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab0HACiz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:38:55 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so977126pwi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xbBByvUpOXRIdTc7H3TXabwoYnYlSYJRCbvx0xivScM=;
        b=O2fQ21Uzi8SF0MTLhNvsNr30PhC/walM6KqGkMDLignLjo2J9ojujTahl0210pBjvi
         DooEbkW89khEGN6+QDMS6ty4TtE1CoQuxYBHPdTUlx6Z2rR2YsT2GiPTYO+JJbfd1Poh
         1uqKQA9VpN/OfaC0S8NDMw35ptf7ksySqbtTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DBMAr2RzDTPJQ8DBDZpFwwWsNA7C6Pl8SBbxqw1T0Vfkkm/Yzea0XD5s+WX/jtpx35
         uvMEf6n9dl4nG9XBbR84kSpcMm0i2nKIM4U8tUzvhd2Ed1UmUYgB0s8wbwEG9zMoUg9l
         xRkxohLE8o613hkVfilHOT4BdK7LGR7KRwdI4=
Received: by 10.142.229.13 with SMTP id b13mr3558672wfh.304.1280630335335;
        Sat, 31 Jul 2010 19:38:55 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id 33sm5244684wfg.21.2010.07.31.19.38.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:38:54 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:19:44 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152356>

This adds the main function, subtree_import(), which is intended to be
used by "git clone".

Because subtree packs are not complete. They are barely usable. Git
client will cry out missing objects here and there... Theortically,
client code could be adapted to only look for objects within
subtree. That was painful to try.

Alternatively, subtree_import() rewrites commits to have only the
specified subtree, sealing all broken path. Git client now happily
works with these new commits.

However, users might not, because it's different commit, different
SHA-1. They can't use those SHA-1 to communicate within their team. To
work around this, all original commits are replaced by new commits
using git-replace.

Of course this is still not perfect. Users may be able to send SHA-1
around, which is consistent. They may not do the same with tree SHA-1.

Rewriting/replacing commits takes time and space. For replacing _all_
commits, the current replace mechanism is not suitable, which is why
subtree_lookup_object() was introduced in previous patches.

=46or rewriting, writing a huge number of objects is slow. So
subtree_import() builds a pack for all new objects. These packs are
not optimized. But it does reduce wait time for rewriting.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 subtree.c |  244 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 subtree.h |    1 +
 2 files changed, 245 insertions(+), 0 deletions(-)

diff --git a/subtree.c b/subtree.c
index 601d827..8c075be 100644
--- a/subtree.c
+++ b/subtree.c
@@ -115,3 +115,247 @@ const unsigned char *subtree_lookup_object(const =
unsigned char *sha1)
 		return subtree_commit[pos]->sha1[1];
 	return sha1;
 }
+
+static unsigned long do_compress(void **pptr, unsigned long size)
+{
+	z_stream stream;
+	void *in, *out;
+	unsigned long maxsize;
+
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, Z_DEFAULT_COMPRESSION);
+	maxsize =3D deflateBound(&stream, size);
+
+	in =3D *pptr;
+	out =3D xmalloc(maxsize);
+	*pptr =3D out;
+
+	stream.next_in =3D in;
+	stream.avail_in =3D size;
+	stream.next_out =3D out;
+	stream.avail_out =3D maxsize;
+	while (deflate(&stream, Z_FINISH) =3D=3D Z_OK)
+		; /* nothing */
+	deflateEnd(&stream);
+
+	return stream.total_out;
+}
+
+static int nr_written;
+static int add_sha1_to_pack(int fd, void *buf, unsigned long size, enu=
m object_type type)
+{
+	unsigned long datalen;
+	unsigned hdrlen;
+	unsigned char header[10];
+
+	datalen =3D do_compress(&buf, size);
+	hdrlen =3D encode_in_pack_object_header(type, size, header);
+	write(fd, header, hdrlen);
+	write(fd, buf, datalen);
+	nr_written++;
+	free(buf);
+	return 0;
+}
+
+/*
+ * Take sha1 of a tree, rewrite it to only return the prefix and retur=
n
+ * the newsha1.
+ *
+ * If if is zero, write to object store. If fd is greater than zero,
+ * it's a pack file handle.
+ */
+static int narrow_tree(const unsigned char *sha1, unsigned char *newsh=
a1,
+		       const char *prefix, int fd)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct strbuf buffer;
+	const char *slash;
+	int subtree_len;
+	enum object_type type;
+	unsigned long size;
+	char *tree;
+	struct object *obj;
+
+	slash =3D strchr(prefix, '/');
+	subtree_len =3D slash ? slash - prefix : strlen(prefix);
+
+	tree =3D read_sha1_file(sha1, &type, &size);
+	if (type !=3D OBJ_TREE)
+		die("%s is not a tree", sha1_to_hex(sha1));
+
+	init_tree_desc(&desc, tree, size);
+	strbuf_init(&buffer, 1024);
+	while (tree_entry(&desc, &entry)) {
+		if (!S_ISDIR(entry.mode))
+			continue;
+
+		if (subtree_len =3D=3D strlen(entry.path) &&
+		    !strncmp(entry.path, prefix, subtree_len)) {
+			unsigned char newtree_sha1[20];
+
+			if (slash && slash[1]) /* trailing slash does not count */
+				narrow_tree(entry.sha1, newtree_sha1, prefix+subtree_len+1, fd);
+			else
+				memcpy(newtree_sha1, entry.sha1, 20);
+
+			strbuf_addf(&buffer, "%o %.*s%c", entry.mode, strlen(entry.path), e=
ntry.path, '\0');
+			strbuf_add(&buffer, newtree_sha1, 20);
+			break;
+		}
+	}
+	free(tree);
+
+	if (fd =3D=3D 0) {
+		if (write_sha1_file(buffer.buf, buffer.len, tree_type, newsha1)) {
+			error("Could not write replaced tree for %s", sha1_to_hex(sha1));
+			strbuf_release(&buffer);
+			return 1;
+		}
+		strbuf_release(&buffer);
+		return 0;
+	}
+
+	hash_sha1_file(buffer.buf, buffer.len, tree_type, newsha1);
+	obj =3D (struct object *)lookup_tree(newsha1);
+	if (fd > 0 &&
+	    !(obj->flags & SEEN) &&
+	    add_sha1_to_pack(fd, buffer.buf, buffer.len, OBJ_TREE)) {
+		error("Could not write replaced tree for %s", sha1_to_hex(sha1));
+		strbuf_release(&buffer);
+		return 1;
+	}
+	obj->flags |=3D SEEN;
+
+	strbuf_release(&buffer);
+	return 0;
+}
+
+/*
+ * Take sha1 of a commit, rewrite its tree using narrow_tree(), then
+ * add a replace entry to file pointer fp (which is $GIT_DIR/subtree).
+ *
+ * Also update replace-object database so that the given sha1 can be
+ * replaced with the new one right after this function returns.
+ */
+static int shadow_commit(const unsigned char *sha1, const char *prefix=
, int fd, FILE *fp)
+{
+	unsigned char newsha1[20], treesha1[20];
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+	struct object *obj;
+	int saved_read_replace_refs =3D read_replace_refs;
+
+	read_replace_refs =3D 0;
+	buffer =3D read_sha1_file(sha1, &type, &size);
+	read_replace_refs =3D saved_read_replace_refs;
+	get_sha1_hex(buffer+5, treesha1);
+
+	if (!buffer || type !=3D OBJ_COMMIT ||
+	    narrow_tree(treesha1, newsha1, prefix, fd)) {
+		free(buffer);
+		error("Failed to narrow tree for commit %s", sha1_to_hex(sha1));
+		return 1;
+	}
+
+	/* replace new tree in */
+	memcpy((char*)buffer+5, sha1_to_hex(newsha1), 40);
+
+	if (fd =3D=3D 0) {
+		if (write_sha1_file(buffer, size, commit_type, newsha1)) {
+			free(buffer);
+			error("Could not write replaced commit for %s", sha1_to_hex(sha1));
+			return 1;
+		}
+	}
+	else {
+		hash_sha1_file(buffer, size, commit_type, newsha1);
+		obj =3D (struct object *)lookup_commit(newsha1);
+		if (fd > 0 &&
+		    !(obj->flags & SEEN) &&
+		    add_sha1_to_pack(fd, buffer, size, OBJ_COMMIT)) {
+			free(buffer);
+			error("Could not write replaced commit for %s", sha1_to_hex(sha1));
+			return 1;
+		}
+		obj->flags |=3D SEEN;
+	}
+
+	if (fp) {
+		char buf[82];
+		memcpy(buf, sha1_to_hex(sha1), 40);
+		buf[40] =3D ' ';
+		memcpy(buf+41, sha1_to_hex(newsha1), 40);
+		buf[81] =3D '\n';
+		fwrite(buf, 82, 1, fp);
+	}
+	free(buffer);
+
+	return 0;
+}
+
+/*
+ * Rewrite all reachable commits in repo using shadow_commit().
+ * Write out the pack that contains new tree/commit objects.
+ */
+void subtree_import()
+{
+	const char *args[] =3D {"rev-list", "--all", NULL};
+	struct pack_header hdr;
+	struct progress *ps;
+	struct rev_info revs;
+	struct commit *c;
+	unsigned char sha1[20];
+	unsigned commit_nr =3D 0;
+	char *pack_tmp_name;
+	char tmpname[PATH_MAX];
+	int pack_fd, i;
+	FILE *fp;
+	char cmd[1024];
+
+	/* Packing */
+	init_revisions(&revs, NULL);
+	setup_revisions(2, args, &revs, NULL);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	fp =3D fopen(git_path("subtree"), "w+");
+
+	pack_fd =3D odb_mkstemp(tmpname, sizeof(tmpname), "pack/tmp_pack_XXXX=
XX");
+	pack_tmp_name =3D xstrdup(tmpname);
+
+	hdr.hdr_signature =3D htonl(PACK_SIGNATURE);
+	hdr.hdr_version =3D htonl(PACK_VERSION);
+	hdr.hdr_entries =3D htonl(0);
+	write(pack_fd, &hdr, sizeof(hdr));
+
+	ps =3D start_progress("Preparing subtree commits", 0);
+	while ((c =3D get_revision(&revs)) !=3D NULL) {
+		if (shadow_commit(c->object.sha1, core_subtree, pack_fd, fp))
+			die("Failed to shadow commit %s", c->object.sha1);
+		display_progress(ps, ++commit_nr);
+	}
+	stop_progress(&ps);
+	fclose(fp);
+	fixup_pack_header_footer(pack_fd, sha1, pack_tmp_name, nr_written, NU=
LL, 0);
+	close(pack_fd);
+	sprintf(cmd, "git index-pack --stdin < %s", pack_tmp_name);
+	system(cmd);
+	unlink(pack_tmp_name);
+
+	reprepare_packed_git();
+	if (subtree_commit)
+		free(subtree_commit);
+	prepare_subtree_commit();
+
+	/* Invalidate all replaced commits */
+	for (i =3D 0; i < subtree_commit_nr; i++) {
+		/* lookup_commit() would create new objects, we don't want that */
+		c =3D (struct commit *)lookup_object(subtree_commit[i]->sha1[0]);
+		if (c)
+			invalidate_commit(c);
+	}
+
+	if (revs.pending.nr)
+		free(revs.pending.objects);
+}
diff --git a/subtree.h b/subtree.h
index 157153a..3512e2a 100644
--- a/subtree.h
+++ b/subtree.h
@@ -1,2 +1,3 @@
 void prepare_subtree_commit();
 const unsigned char *subtree_lookup_object(const unsigned char *sha1);
+void subtree_import();
--=20
1.7.1.rc1.69.g24c2f7
