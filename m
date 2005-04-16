From: simon@himi.org (Simon Fowler)
Subject: Re: Merge with git-pasky II.
Date: Sat, 16 Apr 2005 11:44:42 +1000
Message-ID: <20050416014442.GW4488@himi.org>
References: <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org> <1113559330.12012.292.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4NxgPrvSrIDR5b4"
Cc: David Woodhouse <dwmw2@infradead.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 03:44:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMcLm-0001HN-U9
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 03:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVDPBra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 21:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVDPBra
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 21:47:30 -0400
Received: from dreamcraft.goldweb.com.au ([202.55.152.19]:52877 "EHLO
	dreamcraft.com.au") by vger.kernel.org with ESMTP id S262560AbVDPBou
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 21:44:50 -0400
Received: from private.himi.org (dsl-203-113-232-142.ACT.netspace.net.au [203.113.232.142])
	by dreamcraft.com.au (Postfix) with ESMTP id EAEBC5B986;
	Sat, 16 Apr 2005 11:44:54 +1000 (EST)
Received: by private.himi.org (Postfix, from userid 1000)
	id 93026B6E1; Sat, 16 Apr 2005 11:44:43 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--T4NxgPrvSrIDR5b4
Content-Type: multipart/mixed; boundary="yKkvi6mMqAM+MlBZ"
Content-Disposition: inline


--yKkvi6mMqAM+MlBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2005 at 08:32:46AM -0700, Linus Torvalds wrote:
> In other words, I'm right. I'm always right, but sometimes I'm more right=
=20
> than other times. And dammit, when I say "files don't matter", I'm really=
=20
> really Right(tm).
>=20
You're right, of course (All Hail Linus!), if you can make it work
efficiently enough.

Just to put something else on the table, here's how I'd go about
tracking renames and the like, in another world where Linus /does/
make the odd mistake - it's basically a unique id for files in the
repository, added when the file is first recognised and updated when
update-cache adds a new version to the cache. Renames copy the id
across to the new name, and add it into the cache.

This gives you an O(n) way to tell what file was what across
renames, and it might even be useful in Linus' world, or if someone
wanted to build a traditional SCM on top of a git-a-like.

Attached is a patch, and a rename-file.c to use it.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--yKkvi6mMqAM+MlBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="guid2.patch"
Content-Transfer-Encoding: quoted-printable

COPYING:  fe2a4177a760fd110e78788734f167bd633be8de
Makefile:  ca50293c4f211452d999b81f122e99babb9f2987
--- Makefile
+++ Makefile	2005-04-15 22:17:49.000000000 +1000
@@ -14,7 +14,7 @@
=20
 PROG=3D   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree
+	check-files ls-tree rename-file
=20
 SCRIPT=3D	parent-id tree-id git gitXnormid.sh gitadd.sh gitaddremote.sh \
 	gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlsobj.sh \
@@ -73,6 +73,9 @@
 ls-tree: ls-tree.o read-cache.o
 	$(CC) $(CFLAGS) -o ls-tree ls-tree.o read-cache.o $(LIBS)
=20
+rename-file: rename-file.o read-cache.o
+	$(CC) $(CFLAGS) -o rename-file rename-file.o read-cache.o $(LIBS)
+
 read-cache.o: cache.h
 show-diff.o: cache.h
=20
README:  ded1a3b20e9bbe1f40e487ba5f9361719a1b6b85
VERSION:  c27bd67cd632cc15dd520fbfbf807d482efa2dcf
cache.h:  4d382549041d3281f8d44aa2e52f9f8ec47dd420
--- cache.h
+++ cache.h	2005-04-14 22:35:59.000000000 +1000
@@ -55,6 +55,7 @@
 	unsigned int st_gid;
 	unsigned int st_size;
 	unsigned char sha1[20];
+	unsigned char guid[20];
 	unsigned short namelen;
 	char name[0];
 };
cat-file.c:  45be1badaa8517d4e3a69e0bf1cac2e90191e475
check-files.c:  927b0b9aca742183fc8e7ccd73d73d8d5427e98f
checkout-cache.c:  f06871cdbc1b18ea93bdf4e17126aeb4cca1373e
commit-id:  65c81756c8f10d513d073ecbd741a3244663c4c9
commit-tree.c:  12196c79f31d004dff0df1f50dda67d8204f5568
diff-tree.c:  7dcc9eb7782fa176e27f1677b161ce78ac1d2070
--- diff-tree.c
+++ diff-tree.c	2005-04-16 10:46:52.000000000 +1000
@@ -1,33 +1,144 @@
+#include <sys/param.h>
 #include "cache.h"
=20
-static int recursive =3D 0;
+enum diff_type {
+	REMOVE,
+	ADD,
+	RENAME,
+	MODIFY,
+};
+
+struct guid_cache_entry {
+	enum diff_type diff;
+	unsigned char guid[20];
+	unsigned char sha1[20];
+	struct guid_cache_entry *old;
+	unsigned int mode;
+	unsigned int pathlen;
+	unsigned char path[0];
+};=09
+
+struct guid_cache {
+	unsigned int nr;
+	unsigned int alloc;
+	struct guid_cache_entry **cache;
+};
=20
-static int diff_tree_sha1(const unsigned char *old, const unsigned char *n=
ew, const char *base);
+struct guid_cache guid_cache;
+struct guid_cache *cache =3D &guid_cache;
=20
-static void update_tree_entry(void **bufp, unsigned long *sizep)
+int guid_cache_pos(const char *guid)
 {
-	void *buf =3D *bufp;
-	unsigned long size =3D *sizep;
-	int len =3D strlen(buf) + 1 + 20;
+	int first, last;
=20
-	if (size < len)
-		die("corrupt tree file");
-	*bufp =3D buf + len;
-	*sizep =3D size - len;
+	first =3D 0;
+	last =3D cache->nr;
+	while (last > first) {
+		int next =3D (last + first) >> 1;
+		struct guid_cache_entry *gce =3D cache->cache[next];
+		int cmp =3D memcmp(guid, gce->guid, 20);
+		if (!cmp)
+			return next;
+		if (cmp < 0) {
+			last =3D next;
+			continue;
+		}
+		first =3D next + 1;
+	}
+	return - first-1;
 }
=20
-static const unsigned char *extract(void *tree, unsigned long size, const =
char **pathp, unsigned int *modep)
+int add_guid_cache_entry(struct guid_cache_entry *gce)
+{
+	int pos;
+=09
+	pos =3D guid_cache_pos(gce->guid);
+=09
+	/* if this is a rename or modify, the guid will show up a
+	 * second time */
+	if (pos >=3D 0) {
+		struct guid_cache_entry *old =3D cache->cache[pos];
+		int cmp =3D cache_name_compare(old->path, old->pathlen, gce->path, gce->=
pathlen);
+
+		if (!cmp) {
+			/* pathname matches, so this must be a
+			 * modify. */
+			gce->old =3D old;
+			gce->diff =3D MODIFY;
+			cache->cache[pos] =3D gce;
+		} else {
+			/* the pathnames are different, so the file
+			 * must have been renamed somewhere along the
+			 * line.  */
+			gce->old =3D old;
+			gce->diff =3D RENAME;
+			cache->cache[pos] =3D gce;
+		}
+		return 0;
+	}
+	pos =3D -pos-1;
+
+	if (cache->nr =3D=3D cache->alloc) {
+		cache->alloc =3D alloc_nr(cache->alloc);
+		cache->cache =3D realloc(cache->cache, cache->alloc * sizeof(struct guid=
_cache_entry *));
+	}
+
+	cache->nr++;
+	if (cache->nr > pos)
+		memmove(cache->cache + pos + 1, cache->cache + pos, (cache->nr - pos - 1=
) * sizeof(struct guid_cache_entry *));
+	cache->cache[pos] =3D gce;
+	return 0;
+}
+
+static const unsigned char *extract(void *tree, unsigned long size, const =
char **pathp, unsigned int *modep, const unsigned char **guid)
 {
 	int len =3D strlen(tree)+1;
 	const unsigned char *sha1 =3D tree + len;
 	const char *path =3D strchr(tree, ' ');
=20
-	if (!path || size < len + 20 || sscanf(tree, "%o", modep) !=3D 1)
+	if (!path || size < len + 40 || sscanf(tree, "%o", modep) !=3D 1)
 		die("corrupt tree file");
 	*pathp =3D path+1;
+	*guid =3D tree + len + 20;
 	return sha1;
 }
=20
+static void guid_cache_tree_entry(void *buf, unsigned int len, const char =
*base, enum diff_type diff)
+{
+	unsigned mode;
+	const char *path;
+	const unsigned char *guid;
+	const unsigned char *sha1 =3D extract(buf, len, &path, &mode, &guid);
+	struct guid_cache_entry *gce;
+	int baselen =3D strlen(base);
+=09
+	gce =3D calloc(1, sizeof(struct guid_cache_entry) + baselen + strlen(path=
) + 1);
+	memcpy(gce->guid, guid, 20);
+	memcpy(gce->sha1, sha1, 20);
+	gce->diff =3D diff;
+	gce->mode =3D mode;
+	gce->pathlen =3D snprintf(gce->path, MAXPATHLEN, "%s%s", base, path);
+	gce->path[gce->pathlen + 1] =3D '\0';
+
+	add_guid_cache_entry(gce);
+}
+=09
+static int recursive =3D 0;
+
+static int diff_tree_sha1(const unsigned char *old, const unsigned char *n=
ew, const char *base);
+
+static void update_tree_entry(void **bufp, unsigned long *sizep)
+{
+	void *buf =3D *bufp;
+	unsigned long size =3D *sizep;
+	int len =3D strlen(buf) + 1 + 40;
+
+	if (size < len)
+		die("corrupt tree file");
+	*bufp =3D buf + len;
+	*sizep =3D size - len;
+}
+
 static char *malloc_base(const char *base, const char *path, int pathlen)
 {
 	int baselen =3D strlen(base);
@@ -38,23 +149,24 @@
 	return newbase;
 }
=20
-static void show_file(const char *prefix, void *tree, unsigned long size, =
const char *base);
+static void changed_file(void *tree, unsigned long size, const char *base,=
 enum diff_type diff);
=20
 /* A whole sub-tree went away or appeared */
-static void show_tree(const char *prefix, void *tree, unsigned long size, =
const char *base)
+static void changed_tree(void *tree, unsigned long size, const char *base,=
 enum diff_type diff)
 {
 	while (size) {
-		show_file(prefix, tree, size, base);
+		changed_file(tree, size, base, diff);
 		update_tree_entry(&tree, &size);
 	}
 }
=20
 /* A file entry went away or appeared */
-static void show_file(const char *prefix, void *tree, unsigned long size, =
const char *base)
+static void changed_file(void *tree, unsigned long size, const char *base,=
 enum diff_type diff)
 {
 	unsigned mode;
 	const char *path;
-	const unsigned char *sha1 =3D extract(tree, size, &path, &mode);
+	const unsigned char *guid;
+	const unsigned char *sha1 =3D extract(tree, size, &path, &mode, &guid);
=20
 	if (recursive && S_ISDIR(mode)) {
 		char type[20];
@@ -66,38 +178,96 @@
 		if (!tree || strcmp(type, "tree"))
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
=20
-		show_tree(prefix, tree, size, newbase);
+		changed_tree(tree, size, newbase, diff);
 	=09
 		free(tree);
 		free(newbase);
 		return;
 	}
=20
-	printf("%s%o\t%s\t%s\t%s%s%c", prefix, mode,
-	       S_ISDIR(mode) ? "tree" : "blob",
-	       sha1_to_hex(sha1), base, path, 0);
+	guid_cache_tree_entry(tree, size, base, diff);
 }
=20
+static void show_one_file(struct guid_cache_entry *gce)
+{
+	struct guid_cache_entry *old;
+	char old_sha1[50];
+	char old_sha2[50];
+
+	switch(gce->diff) {
+	case REMOVE:
+		sprintf(old_sha1, "%s", sha1_to_hex(gce->sha1));
+		printf("-%o\t%s\t%s\t%s\t%s%c", gce->mode,
+		       S_ISDIR(gce->mode) ? "tree" : "blob",
+		       old_sha1, sha1_to_hex(gce->guid), gce->path, 0);
+		break;
+	case ADD:
+		sprintf(old_sha1, "%s", sha1_to_hex(gce->sha1));
+		printf("+%o\t%s\t%s\t%s\t%s%c", gce->mode,
+		       S_ISDIR(gce->mode) ? "tree" : "blob",
+		       old_sha1, sha1_to_hex(gce->guid), gce->path, 0);
+		break;
+	case MODIFY:
+		old =3D gce->old;
+		if (old) {
+			sprintf(old_sha1, "%s", sha1_to_hex(old->sha1));
+			sprintf(old_sha2, "%s", sha1_to_hex(gce->sha1));
+		=09
+			printf("*%o->%o\t%s\t%s->%s\t%s\t%s%c", old->mode, gce->mode,
+			       S_ISDIR(old->mode) ? "tree" : "blob",
+			       old_sha1, old_sha2, sha1_to_hex(gce->guid), gce->path, 0);
+		} else {
+			die("diff-tree: internal error");
+		}
+		break;
+	case RENAME:
+		old =3D gce->old;
+		if (old) {
+			sprintf(old_sha1, "%s", sha1_to_hex(gce->sha1));
+			sprintf(old_sha2, "%s", sha1_to_hex(old->sha1));
+		=09
+			printf("r%o->%o\t%s\t%s->%s\t%s\t%s%c", gce->mode, old->mode,
+			       S_ISDIR(old->mode) ? "tree" : "blob",
+			       old_sha1, old_sha2, sha1_to_hex(old->guid), old->path, 0);
+		} else {
+			die("diff-tree: internal error");
+		}
+		break;
+	default:
+		die("diff-tree: internal error");
+	}
+}
+
+/* simply iterate over both caches looking for matching guids,
+ * showing all files in both caches */
+static void show_cache(void)
+{
+	int i;
+
+	for (i =3D 0; i < cache->nr; i++)
+		show_one_file(cache->cache[i]);
+}
+=09
 static int compare_tree_entry(void *tree1, unsigned long size1, void *tree=
2, unsigned long size2, const char *base)
 {
 	unsigned mode1, mode2;
 	const char *path1, *path2;
 	const unsigned char *sha1, *sha2;
+	const unsigned char *guid1, *guid2;
 	int cmp, pathlen1, pathlen2;
-	char old_sha1_hex[50];
=20
-	sha1 =3D extract(tree1, size1, &path1, &mode1);
-	sha2 =3D extract(tree2, size2, &path2, &mode2);
+	sha1 =3D extract(tree1, size1, &path1, &mode1, &guid1);
+	sha2 =3D extract(tree2, size2, &path2, &mode2, &guid2);
=20
 	pathlen1 =3D strlen(path1);
 	pathlen2 =3D strlen(path2);
 	cmp =3D cache_name_compare(path1, pathlen1, path2, pathlen2);
 	if (cmp < 0) {
-		show_file("-", tree1, size1, base);
+		changed_file(tree1, size1, base, REMOVE);
 		return -1;
 	}
 	if (cmp > 0) {
-		show_file("+", tree2, size2, base);
+		changed_file(tree2, size2, base, ADD);
 		return 1;
 	}
 	if (!memcmp(sha1, sha2, 20) && mode1 =3D=3D mode2)
@@ -108,8 +278,8 @@
 	 * file, we need to consider it a remove and an add.
 	 */
 	if (S_ISDIR(mode1) !=3D S_ISDIR(mode2)) {
-		show_file("-", tree1, size1, base);
-		show_file("+", tree2, size2, base);
+		changed_file(tree1, size1, base, REMOVE);
+		changed_file(tree2, size2, base, ADD);
 		return 0;
 	}
=20
@@ -121,10 +291,14 @@
 		return retval;
 	}
=20
-	strcpy(old_sha1_hex, sha1_to_hex(sha1));
-	printf("*%o->%o\t%s\t%s->%s\t%s%s%c", mode1, mode2,
-	       S_ISDIR(mode1) ? "tree" : "blob",
-	       old_sha1_hex, sha1_to_hex(sha2), base, path1, 0);
+	if (!memcmp(guid1, guid2, 20)) {
+		changed_file(tree1, size1, base, MODIFY);
+		changed_file(tree2, size2, base, MODIFY);
+		return 0;
+	}
+=09
+	changed_file(tree1, size1, base, REMOVE);
+	changed_file(tree2, size2, base, ADD);
 	return 0;
 }
=20
@@ -132,12 +306,12 @@
 {
 	while (size1 | size2) {
 		if (!size1) {
-			show_file("+", tree2, size2, base);
+			changed_file(tree2, size2, base, ADD);
 			update_tree_entry(&tree2, &size2);
 			continue;
 		}
 		if (!size2) {
-			show_file("-", tree1, size1, base);
+			changed_file(tree1, size1, base, REMOVE);
 			update_tree_entry(&tree1, &size1);
 			continue;
 		}
@@ -179,6 +353,7 @@
 int main(int argc, char **argv)
 {
 	unsigned char old[20], new[20];
+	int retval;
=20
 	while (argc > 3) {
 		char *arg =3D argv[1];
@@ -193,5 +368,7 @@
=20
 	if (argc !=3D 3 || get_sha1_hex(argv[1], old) || get_sha1_hex(argv[2], ne=
w))
 		usage("diff-tree <tree sha1> <tree sha1>");
-	return diff_tree_sha1(old, new, "");
+	retval =3D  diff_tree_sha1(old, new, "");
+	show_cache();
+	return retval;
 }
fsck-cache.c:  9c900fe458cecd2bdb4c4571a584115b5cf24f22
--- fsck-cache.c
+++ fsck-cache.c	2005-04-15 20:39:49.000000000 +1000
@@ -165,9 +165,10 @@
 	while (size) {
 		int len =3D 1+strlen(data);
 		unsigned char *file_sha1 =3D data + len;
+		unsigned char *guid =3D file_sha1 + 20;
 		char *path =3D strchr(data, ' ');
 		unsigned int mode;
-		if (size < len + 20 || !path || sscanf(data, "%o", &mode) !=3D 1)
+		if (size < len + 40 || !path || sscanf(data, "%o", &mode) !=3D 1)
 			return -1;
=20
 		/* Warn about trees that don't do the recursive thing.. */
@@ -176,8 +177,8 @@
 			warn_old_tree =3D 0;
 		}
=20
-		data +=3D len + 20;
-		size -=3D len + 20;
+		data +=3D len + 40;
+		size -=3D len + 40;
 		mark_needs_sha1(sha1, S_ISDIR(mode) ? "tree" : "blob", file_sha1);
 	}
 	return 0;
git:  2c557dcf2032325acc265b577ee104e605fdaede
gitXnormid.sh:  a5d7a9f4a6e8d4860f35f69500965c2a493d80de
gitadd.sh:  3ed93ea0fcb995673ba9ee1982e0e7abdbe35982
gitaddremote.sh:  bf1f28823da5b5270aa8fa05b321faa514a57a11
gitapply.sh:  d0e3c46e2ce1ee74e1a87ee6137955fa9b35c27b
gitcancel.sh:  ec58f7444a42cd3cbaae919fc68c70a3866420c0
gitcommit.sh:  3629f67bbd3f171d091552814908b67af7537f4d
gitdiff-do:  d6174abceab34d22010c36a8453a6c3f3f184fe0
gitdiff.sh:  5e47c4779d73c3f2f39f6be714c0145175933197
gitexport.sh:  dad00bf251b38ce522c593ea9631f842d8ccc934
gitlntree.sh:  17c4966ea64aeced96ae4f1b00f3775c1904b0f1
gitlog.sh:  177c6d12dd9fa4b4920b08451ffe4badde544a39
gitls.sh:  b6f15d82f16c1e9982c5031f3be22eb5430273af
gitlsobj.sh:  128461d3de6a42cfaaa989fc6401bebdfa885b3f
gitmerge.sh:  23e4a3ff342c6005928ceea598a2f52de6fb9817
gitpull.sh:  0883898dda579e3fa44944b7b1d909257f6dc63e
gitrm.sh:  5c18c38a890c9fd9ad2b866ee7b529539d2f3f8f
gittag.sh:  c8cb31385d5a9622e95a4e0b2d6a4198038a659c
gittrack.sh:  03d6db1fb3a70605ef249c632c04e542457f0808
init-db.c:  aa00fbb1b95624f6c30090a17354c9c08a6ac596
ls-tree.c:  3e2a6c7d183a42e41f1073dfec6794e8f8a5e75c
--- ls-tree.c
+++ ls-tree.c	2005-04-15 15:55:40.000000000 +1000
@@ -10,6 +10,7 @@
 	void *buffer;
 	unsigned long size;
 	char type[20];
+	char old_sha1[50];
=20
 	buffer =3D read_sha1_file(sha1, type, &size);
 	if (!buffer)
@@ -19,19 +20,21 @@
 	while (size) {
 		int len =3D strlen(buffer)+1;
 		unsigned char *sha1 =3D buffer + len;
+		unsigned char *guid =3D buffer + len + 20;
 		char *path =3D strchr(buffer, ' ')+1;
 		unsigned int mode;
 		unsigned char *type;
=20
-		if (size < len + 20 || sscanf(buffer, "%o", &mode) !=3D 1)
+		if (size < len + 40 || sscanf(buffer, "%o", &mode) !=3D 1)
 			die("corrupt 'tree' file");
-		buffer =3D sha1 + 20;
-		size -=3D len + 20;
+		buffer =3D sha1 + 40;
+		size -=3D len + 40;
 		/* XXX: We do some ugly mode heuristics here.
 		 * It seems not worth it to read each file just to get this
 		 * and the file size. -- pasky@ucw.cz */
 		type =3D S_ISDIR(mode) ? "tree" : "blob";
-		printf("%03o\t%s\t%s\t%s\n", mode, type, sha1_to_hex(sha1), path);
+		sprintf(old_sha1, sha1_to_hex(guid));
+		printf("%03o\t%s\t%s\t%s\t%s\n", mode, type, sha1_to_hex(sha1), old_sha1=
, path);
 	}
 	return 0;
 }
parent-id:  1801c6fe426592832e7250f8b760fb9d2e65220f
read-cache.c:  7a6ae8b9b489f6b67c82e065dedd5716a6bfc0ef
--- read-cache.c
+++ read-cache.c	2005-04-16 10:52:51.000000000 +1000
@@ -4,6 +4,8 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include <stdarg.h>
+#include <time.h>
+#include <sys/param.h>
 #include "cache.h"
=20
 const char *sha1_file_directory =3D NULL;
@@ -233,6 +235,22 @@
 	return 0;
 }
=20
+void new_guid(const char *filename, int namelen, unsigned char *returnguid)
+{
+	size_t size;
+	time_t now =3D time(NULL);
+	char buf[MAXPATHLEN + 20];
+	unsigned char guid[20];
+=09
+	size =3D snprintf(buf, MAXPATHLEN + 20, "%ld%s", now, filename) + 1;
+=09
+	SHA1(buf, size, guid);
+
+	if (returnguid)
+		memcpy(returnguid, guid, 20);
+	return;
+}
+
 static inline int collision_check(char *filename, void *buf, unsigned int =
size)
 {
 #ifdef COLLISION_CHECK
@@ -363,11 +381,14 @@
 int add_cache_entry(struct cache_entry *ce, int ok_to_add)
 {
 	int pos;
+	unsigned char guid[20];
=20
 	pos =3D cache_name_pos(ce->name, ce->namelen);
=20
 	/* existing match? Just replace it */
 	if (pos >=3D 0) {
+		struct cache_entry *old_ce =3D active_cache[pos];
+		memcpy(ce->guid, old_ce->guid, 20);
 		active_cache[pos] =3D ce;
 		return 0;
 	}
@@ -376,6 +397,12 @@
 	if (!ok_to_add)
 		return -1;
=20
+	memset(guid, 0, 20);
+	if (!memcmp(ce->guid, guid, 20)) {
+		new_guid(ce->name, ce->namelen, guid);
+		memcpy(ce->guid, guid, 20);
+	}
+
 	/* Make sure the array is big enough .. */
 	if (active_nr =3D=3D active_alloc) {
 		active_alloc =3D alloc_nr(active_alloc);
read-tree.c:  eb548148aa6d212f05c2c622ffbe62a06cd072f9
--- read-tree.c
+++ read-tree.c	2005-04-16 10:41:46.000000000 +1000
@@ -5,7 +5,9 @@
  */
 #include "cache.h"
=20
-static int read_one_entry(unsigned char *sha1, const char *base, int basel=
en, const char *pathname, unsigned mode)
+static int read_one_entry(unsigned char *sha1, unsigned char *guid,=20
+			  const char *base, int baselen,=20
+			  const char *pathname, unsigned mode)
 {
 	int len =3D strlen(pathname);
 	unsigned int size =3D cache_entry_size(baselen + len);
@@ -18,6 +20,7 @@
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	memcpy(ce->sha1, sha1, 20);
+	memcpy(ce->guid, guid, 20);
 	return add_cache_entry(ce, 1);
 }
=20
@@ -35,14 +38,15 @@
 	while (size) {
 		int len =3D strlen(buffer)+1;
 		unsigned char *sha1 =3D buffer + len;
+		unsigned char *guid =3D buffer + len + 20;
 		char *path =3D strchr(buffer, ' ')+1;
 		unsigned int mode;
-
-		if (size < len + 20 || sscanf(buffer, "%o", &mode) !=3D 1)
+	=09
+		if (size < len + 40 || sscanf(buffer, "%o", &mode) !=3D 1)
 			return -1;
=20
-		buffer =3D sha1 + 20;
-		size -=3D len + 20;
+		buffer =3D sha1 + 40;
+		size -=3D len + 40;
=20
 		if (S_ISDIR(mode)) {
 			int retval;
@@ -57,7 +61,7 @@
 				return -1;
 			continue;
 		}
-		if (read_one_entry(sha1, base, baselen, path, mode) < 0)
+		if (read_one_entry(sha1, guid, base, baselen, path, mode) < 0)
 			return -1;
 	}
 	return 0;
rev-tree.c:  395b0b3bfadb0537ae0c62744b25ead4b487f3f6
show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
show-files.c:  a9fa6767a418f870a34b39379f417bf37b17ee18
tree-id:  cb70e2c508a18107abe305633612ed702aa3ee4f
update-cache.c:  62d0a6c41560d40863c44599355af10d9e089312
write-tree.c:  1534477c91169ebddcf953e3f4d2872495477f6b
--- write-tree.c
+++ write-tree.c	2005-04-15 13:46:05.000000000 +1000
@@ -47,6 +47,7 @@
 		const char *pathname =3D ce->name, *filename, *dirname;
 		int pathlen =3D ce->namelen, entrylen;
 		unsigned char *sha1;
+		unsigned char *guid;
 		unsigned int mode;
=20
 		/* Did we hit the end of the directory? Return how many we wrote */
@@ -54,6 +55,7 @@
 			break;
=20
 		sha1 =3D ce->sha1;
+		guid =3D ce->guid;
 		mode =3D ce->st_mode;
=20
 		/* Do we have _further_ subdirectories? */
@@ -86,6 +88,8 @@
 		buffer[offset++] =3D 0;
 		memcpy(buffer + offset, sha1, 20);
 		offset +=3D 20;
+		memcpy(buffer + offset, guid, 20);
+		offset +=3D 20;
 		nr++;
 	} while (nr < maxentries);
=20

--yKkvi6mMqAM+MlBZ
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="rename-file.c"
Content-Transfer-Encoding: quoted-printable

/*
 * rename files in a git repository, keeping the guid.
 *=20
 * Copyright Simon Fowler <simon@dreamcraft.com.au>, 2005.
 */
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>
#include "cache.h"

static int remove_lock =3D 0;

static void remove_lock_file(void)
{
	if (remove_lock)
		unlink(".git/index.lock");
}

int main(int argc, char *argv[])
{
	struct stat stats;
	struct cache_entry *ce, *new;
	int newfd, entries, pos, pos2;

	if (argc !=3D 3)
		usage("rename-file <old> <new>");
	if (stat(argv[1], &stats)) {
		perror("rename-file: ");
		exit(1);
	}
	if (!stat(argv[2], &stats))
		die("rename-file: destination file already exists");
=09
	newfd =3D open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
	if (newfd < 0)
		die("unable to create new cachefile");

	atexit(remove_lock_file);
	remove_lock =3D 1;

	entries =3D read_cache();
	if (entries < 0)
		die("cache corrupted");

	pos =3D cache_name_pos(argv[1], strlen(argv[1]));
	pos2 =3D cache_name_pos(argv[2], strlen(argv[2]));
	=09
	if (pos < 0)=20
		die("original file not in cache");
	if (pos2 >=3D 0)
		die("destination file already in cache");
	ce =3D active_cache[pos];
	new =3D malloc(sizeof(struct cache_entry) + strlen(argv[2]) + 1);
	memcpy(new, ce, sizeof(struct cache_entry));
	new->namelen =3D strlen(argv[2]);
	memcpy(new->name, argv[2], new->namelen);
=09
	if (rename(argv[1], argv[2])) {
		perror("rename-file: ");
		exit(1);
	}

	remove_file_from_cache(argv[1]);
	add_cache_entry(new, 1);

	if (write_cache(newfd, active_cache, active_nr) ||
	    rename(".git/index.lock", ".git/index"))
		die("Unable to write new cachefile");
     =20
	remove_lock =3D 0;
	return 0;
}

--yKkvi6mMqAM+MlBZ--

--T4NxgPrvSrIDR5b4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCYG4JQPlfmRRKmRwRAquqAJ9l6Rjv8tUEmj82pHQi/iw8TytCDgCfROCo
8lvv2zXq3lnXAXs/6hse/CM=
=rHpn
-----END PGP SIGNATURE-----

--T4NxgPrvSrIDR5b4--
