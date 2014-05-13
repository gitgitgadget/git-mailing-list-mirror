From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 9/8] even faster loading time with index version 254
Date: Tue, 13 May 2014 18:20:19 +0700
Message-ID: <1399980019-8706-1-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAkz-00073m-2L
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760674AbaEMLUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:20:18 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:65122 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760098AbaEMLUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:20:16 -0400
Received: by mail-pb0-f42.google.com with SMTP id rp16so167627pbb.29
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NpQqpm42FBFBLvHShGPIe+2VdhkAtWDh0pVEfPNf2/4=;
        b=XBZHhTDI/OY0oWW+5IRfmNqFul4EakIj+/6PuMguAv6vXXsrsVpNZbHJwg1CPAMzvY
         3PnHIurDENOhN6tvJ+yNx8izJuCMG+rZol2gvpc+HzrohRQTv4Ren5vSmenDFiZ2yJ6L
         5AZgmW5ZqelIp3RZS0Sx5906hgyaj5UbEM1n9XfrNz7EoTftw6yMnYqbhKYvZudmXfJO
         zL54loq93ZlnH6S/M2eCCFEgv4r1yWAnbXRm2cY2rvz9bvBJYMN0Oh5ZQLgIF0TBxBxk
         wjJTwdCIM7m1+SdXBLberCRvQ+6sJrCJf/rFyDaiO6/hVWEgznoSt2zyCQprY09Bdk6B
         8EGg==
X-Received: by 10.66.192.225 with SMTP id hj1mr64077341pac.142.1399980015282;
        Tue, 13 May 2014 04:20:15 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id ci4sm27739328pbb.50.2014.05.13.04.20.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:20:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:20:20 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248771>

This dirty (and likely buggy) patch shows a direction of lowering load
time even more. Basically the shared memory now contains a clean
memory dump that a git process could use with little preparation
(which also means it's tied to C Git, other implementations can't use
this)

Memory is actually shared, git won't malloc and copy over, so even if
the v254 is 235 MB (larger than v2 199MB), we use less memory.

With this patch, we can get as low as 256.442ms (compared to 663ms in
0/8) at 800 MHz, or 91ms at 2.5 GHz. Index load time should be a
solved problem.

But I'm not going to polish this patch and try to get it merged. I'd
rather see a real world repository of this size first to justify
messing up read-cache.c even more.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h              |   2 +
 read-cache--daemon.c |  31 +++++------
 read-cache.c         | 154 ++++++++++++++++++++++++++++++++++++++++++-=
--------
 split-index.c        |   3 +
 4 files changed, 149 insertions(+), 41 deletions(-)

diff --git a/cache.h b/cache.h
index c246dee..7f0ef1e 100644
--- a/cache.h
+++ b/cache.h
@@ -297,6 +297,8 @@ struct index_state {
 	unsigned char sha1[20];
 	void *mmap;
 	size_t mmap_size;
+	int mmap_fd;
+	void *(*allocate_254)(struct index_state *, size_t);
 };
=20
 extern struct index_state the_index;
diff --git a/read-cache--daemon.c b/read-cache--daemon.c
index bd6d84f..a44bd09 100644
--- a/read-cache--daemon.c
+++ b/read-cache--daemon.c
@@ -34,10 +34,19 @@ static void cleanup_socket_on_signal(int sig)
 	raise(sig);
 }
=20
+static void *allocate_254(struct index_state *istate, unsigned long si=
ze)
+{
+	ftruncate(istate->mmap_fd, size);
+	istate->mmap_size =3D size;
+	istate->mmap =3D xmmap(NULL, istate->mmap_size, PROT_READ | PROT_WRIT=
E,
+			     MAP_SHARED, istate->mmap_fd, 0);
+	return istate->mmap !=3D MAP_FAILED ? istate->mmap : NULL;
+}
+
+extern int do_write_index(struct index_state *istate, int newfd, int s=
trip_extensions);
 static int do_share_index(struct index_state *istate, struct strbuf *s=
hm_path)
 {
 	struct strbuf sb =3D STRBUF_INIT;
-	void *map;
 	int fd;
=20
 	strbuf_addf(&sb, "/git-index-%s", sha1_to_hex(istate->sha1));
@@ -48,21 +57,16 @@ static int do_share_index(struct index_state *istat=
e, struct strbuf *shm_path)
 		shm_unlink(shm_path->buf);
 		strbuf_reset(shm_path);
 	}
-	if (ftruncate(fd, istate->mmap_size)) {
-		close(fd);
-		shm_unlink(shm_path->buf);
-		return -1;
-	}
+	istate->version =3D 254;
+	istate->allocate_254 =3D allocate_254;
+	istate->mmap_fd =3D fd;
+	do_write_index(istate, -1, 0);
 	strbuf_addbuf(shm_path, &sb);
-	map =3D xmmap(NULL, istate->mmap_size, PROT_READ | PROT_WRITE,
-		    MAP_SHARED, fd, 0);
-	if (map =3D=3D MAP_FAILED) {
+	if (istate->mmap =3D=3D MAP_FAILED) {
 		close(fd);
 		shm_unlink(shm_path->buf);
 		return -1;
 	}
-	memcpy(map, istate->mmap, istate->mmap_size);
-	munmap(map, istate->mmap_size);
 	fchmod(fd, 0400);
 	close(fd);
 	return 0;
@@ -88,13 +92,9 @@ static void share_index(struct index_state *istate, =
struct strbuf *shm_path)
=20
 static void refresh()
 {
-	the_index.keep_mmap =3D 1;
 	if (read_cache() < 0)
 		die("could not read index");
 	share_index(&the_index, &shm_index);
-	if (the_index.split_index &&
-	    the_index.split_index->base)
-		share_index(the_index.split_index->base, &shm_sharedindex);
 	discard_index(&the_index);
 }
=20
@@ -145,7 +145,6 @@ static void serve_cache(const char *socket_path, in=
t detach)
 	if (fd < 0)
 		die_errno("unable to bind to '%s'", socket_path);
=20
-	use_read_cache_daemon =3D -1;
 	refresh();
 	if (detach && daemonize(&daemonized))
 		die_errno("unable to detach");
diff --git a/read-cache.c b/read-cache.c
index d5c9247..4db1c30 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -61,7 +61,8 @@ static void replace_index_entry(struct index_state *i=
state, int nr, struct cache
=20
 	replace_index_entry_in_base(istate, old, ce);
 	remove_name_hash(istate, old);
-	free(old);
+	if (old->index !=3D 0xffffffff) /* special mark by v254 entry writing=
 code */
+		free(old);
 	set_index_entry(istate, nr, ce);
 	ce->ce_flags |=3D CE_UPDATE_IN_BASE;
 	istate->cache_changed |=3D CE_ENTRY_CHANGED;
@@ -1333,9 +1334,11 @@ static int verify_hdr(struct cache_header *hdr, =
unsigned long size)
 	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
 		return error("bad signature");
 	hdr_version =3D ntohl(hdr->hdr_version);
-	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
+	if (!size && hdr_version =3D=3D 254)
+		fprintf(stderr, "yeah\n");		/* go on */
+	else if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_versi=
on)
 		return error("bad index version %d", hdr_version);
-	if (!size)
+	if (!size || hdr_version =3D=3D 254)
 		return 0;
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
@@ -1499,7 +1502,8 @@ static void *try_shm(void *mmap, size_t *mmap_siz=
e)
 		close(fd);
 		return mmap;
 	}
-	new_mmap =3D xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	new_mmap =3D xmmap(NULL, st.st_size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (new_mmap =3D=3D MAP_FAILED)
 		return mmap;
@@ -1519,6 +1523,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	void *mmap, *old_mmap;
 	size_t mmap_size;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	int ver_254 =3D 0;
=20
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1561,7 +1566,13 @@ int do_read_index(struct index_state *istate, co=
nst char *path, int must_exist)
 	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(*istate->cache)=
);
 	istate->initialized =3D 1;
=20
-	if (istate->version =3D=3D 4)
+	if (istate->version =3D=3D 254) {
+		istate->version =3D 4;
+		ver_254 =3D 1;
+		istate->keep_mmap =3D 1;
+		istate->mmap =3D mmap;
+		istate->mmap_size =3D mmap_size;
+	} else if (istate->version =3D=3D 4)
 		previous_name =3D &previous_name_buf;
 	else
 		previous_name =3D NULL;
@@ -1573,7 +1584,14 @@ int do_read_index(struct index_state *istate, co=
nst char *path, int must_exist)
 		unsigned long consumed;
=20
 		disk_ce =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset)=
;
-		ce =3D create_from_disk(disk_ce, &consumed, previous_name);
+		if (ver_254) {
+			ce =3D mmap + src_offset;
+			consumed =3D
+				offsetof(struct cache_entry, name) +
+				ce_namelen(ce) + 1;
+			consumed =3D (consumed + 7) & ~7;
+		} else
+			ce =3D create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
=20
 		src_offset +=3D consumed;
@@ -1655,6 +1673,8 @@ int discard_index(struct index_state *istate)
 	int i;
=20
 	for (i =3D 0; i < istate->cache_nr; i++) {
+		if (istate->cache[i]->index =3D=3D 0xffffffff)
+			continue;
 		if (istate->cache[i]->index &&
 		    istate->split_index &&
 		    istate->split_index->base &&
@@ -1696,13 +1716,51 @@ int unmerged_index(const struct index_state *is=
tate)
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
=20
+struct file_block {
+	struct file_block *next;
+	char buf[1];
+};
+static struct file_block *start, *end;
+static unsigned long file_block_size;
+#define FB_ALLOC_SIZE 65536
+#define FB_USABLE_SIZE (FB_ALLOC_SIZE - sizeof(struct file_block *))
+
+static void fill_file_block(const unsigned char *buffer, unsigned int =
len)
+{
+	if (!start) {
+		start =3D end =3D xmalloc(FB_ALLOC_SIZE);
+		start->next =3D NULL;
+	}
+
+	while (len) {
+		unsigned long used =3D file_block_size % FB_USABLE_SIZE;
+		unsigned long remaining =3D FB_USABLE_SIZE - used;
+		if (len < remaining) {
+			memcpy(end->buf + used, buffer, len);
+			file_block_size +=3D len;
+			return;
+		}
+		memcpy(end->buf + used, buffer, remaining);
+		file_block_size +=3D remaining;
+		buffer		+=3D remaining;
+		len		-=3D remaining;
+		end->next	 =3D xmalloc(FB_ALLOC_SIZE);
+		end		 =3D end->next;
+		end->next	 =3D NULL;
+	}
+}
+
 static int ce_write_flush(git_SHA_CTX *context, int fd)
 {
 	unsigned int buffered =3D write_buffer_len;
 	if (buffered) {
-		git_SHA1_Update(context, write_buffer, buffered);
-		if (write_in_full(fd, write_buffer, buffered) !=3D buffered)
-			return -1;
+		if (context) {
+			git_SHA1_Update(context, write_buffer, buffered);
+			if (write_in_full(fd, write_buffer, buffered) !=3D buffered)
+				return -1;
+		} else {
+			fill_file_block(write_buffer, buffered);
+		}
 		write_buffer_len =3D 0;
 	}
 	return 0;
@@ -1745,7 +1803,8 @@ static int ce_flush(git_SHA_CTX *context, int fd,=
 unsigned char *sha1)
=20
 	if (left) {
 		write_buffer_len =3D 0;
-		git_SHA1_Update(context, write_buffer, left);
+		if (context)
+			git_SHA1_Update(context, write_buffer, left);
 	}
=20
 	/* Flush first if not enough space for SHA1 signature */
@@ -1756,10 +1815,18 @@ static int ce_flush(git_SHA_CTX *context, int f=
d, unsigned char *sha1)
 	}
=20
 	/* Append the SHA1 signature at the end */
-	git_SHA1_Final(write_buffer + left, context);
+	if (context)
+		git_SHA1_Final(write_buffer + left, context);
+	else
+		hashclr(write_buffer + left);
 	hashcpy(sha1, write_buffer + left);
 	left +=3D 20;
-	return (write_in_full(fd, write_buffer, left) !=3D left) ? -1 : 0;
+	if (context)
+		return (write_in_full(fd, write_buffer, left) !=3D left) ? -1 : 0;
+	else {
+		fill_file_block(write_buffer, left);
+		return 0;
+	}
 }
=20
 static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
@@ -1921,10 +1988,9 @@ void update_index_if_able(struct index_state *is=
tate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
=20
-static int do_write_index(struct index_state *istate, int newfd,
-			  int strip_extensions)
+int do_write_index(struct index_state *istate, int newfd, int strip_ex=
tensions)
 {
-	git_SHA_CTX c;
+	git_SHA_CTX c, *c_p;
 	struct cache_header hdr;
 	int i, err, removed, extended, hdr_version;
 	struct cache_entry **cache =3D istate->cache;
@@ -1960,8 +2026,14 @@ static int do_write_index(struct index_state *is=
tate, int newfd,
 	hdr.hdr_version =3D htonl(hdr_version);
 	hdr.hdr_entries =3D htonl(entries - removed);
=20
-	git_SHA1_Init(&c);
-	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
+	if (istate->version =3D=3D 254)
+		c_p =3D NULL;
+	else {
+		c_p =3D &c;
+		git_SHA1_Init(c_p);
+	}
+
+	if (ce_write(c_p, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
=20
 	previous_name =3D (hdr_version =3D=3D 4) ? &previous_name_buf : NULL;
@@ -1982,7 +2054,21 @@ static int do_write_index(struct index_state *is=
tate, int newfd,
 			else
 				return error(msg, ce->name);
 		}
-		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
+		if (!c_p) {
+			static unsigned padding[8];
+			unsigned sz =3D offsetof(struct cache_entry, name) + ce_namelen(ce)=
 + 1;
+			unsigned int ce_flags =3D ce->ce_flags;
+			struct hashmap_entry he =3D ce->ent;
+			ce->index =3D 0xffffffff;
+			memset(&ce->ent, 0, sizeof(ce->ent));
+			ce->ce_flags &=3D CE_VALID | CE_EXTENDED_FLAGS;
+			ce_write(NULL, 0, ce, sz);
+			ce->ce_flags =3D ce_flags;
+			memcpy(&ce->ent, &he, sizeof(he));
+			ce->index =3D 0;
+			if (sz % 8)
+				ce_write(NULL, 0, padding, 8 - (sz % 8));
+		} else if (ce_write_entry(c_p, newfd, ce, previous_name) < 0)
 			return -1;
 	}
 	strbuf_release(&previous_name_buf);
@@ -1992,9 +2078,9 @@ static int do_write_index(struct index_state *ist=
ate, int newfd,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		err =3D write_link_extension(&sb, istate) < 0 ||
-			write_index_ext_header(&c, newfd, CACHE_EXT_LINK,
+			write_index_ext_header(c_p, newfd, CACHE_EXT_LINK,
 					       sb.len) < 0 ||
-			ce_write(&c, newfd, sb.buf, sb.len) < 0;
+			ce_write(c_p, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -2003,8 +2089,8 @@ static int do_write_index(struct index_state *ist=
ate, int newfd,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		cache_tree_write(&sb, istate->cache_tree);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < =
0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err =3D write_index_ext_header(c_p, newfd, CACHE_EXT_TREE, sb.len) <=
 0
+			|| ce_write(c_p, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -2013,16 +2099,34 @@ static int do_write_index(struct index_state *i=
state, int newfd,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		resolve_undo_write(&sb, istate->resolve_undo);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
+		err =3D write_index_ext_header(c_p, newfd, CACHE_EXT_RESOLVE_UNDO,
 					     sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+			|| ce_write(c_p, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
 			return -1;
 	}
=20
-	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
+	if (ce_flush(c_p, newfd, istate->sha1) || (c_p && fstat(newfd, &st)))
 		return -1;
+	if (!c_p) {
+		unsigned char *p =3D NULL;
+		if (istate->allocate_254)
+			p =3D istate->allocate_254(istate, file_block_size);
+		while (file_block_size) {
+			struct file_block *to_free =3D start;
+			int len =3D file_block_size > FB_USABLE_SIZE ? FB_USABLE_SIZE : fil=
e_block_size;
+			if (p) {
+				memcpy(p, start->buf, len);
+				p +=3D len;
+			} else
+				write_or_die(newfd, start->buf, len);
+			file_block_size -=3D len;
+			start =3D start->next;
+			free(to_free);
+		}
+		start =3D end =3D NULL;
+	}
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
 	return 0;
diff --git a/split-index.c b/split-index.c
index 21485e2..a47f805 100644
--- a/split-index.c
+++ b/split-index.c
@@ -302,6 +302,9 @@ void discard_split_index(struct index_state *istate=
)
=20
 void save_or_free_index_entry(struct index_state *istate, struct cache=
_entry *ce)
 {
+	if (ce->index =3D=3D 0xffffffff)
+		return;
+
 	if (ce->index &&
 	    istate->split_index &&
 	    istate->split_index->base &&
--=20
1.9.1.346.ga2b5940
