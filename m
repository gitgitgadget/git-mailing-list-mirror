From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/32] index: make narrow index incompatible with older git
Date: Wed, 25 Aug 2010 08:19:59 +1000
Message-ID: <1282688422-7738-10-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1sy-0001Xh-09
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329Ab0HXWV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:21:59 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37012 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270Ab0HXWV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:21:58 -0400
Received: by pxi10 with SMTP id 10so2813054pxi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=85jeBexQVouSD8FPL6DNTZnNECqh55YqcwxzES8UUKA=;
        b=BmrnAms8P08XIMheNZ49v+eV57bvJWygQpmLMAQjAPuykVLQPn1VlG9ALf3IOXlPNU
         c92i1Gu2gCkujVB4u64bRwH/bKCsuGsJSiZa6n9MgHCZL2ZocfRerNkaJ16z4CtDi+h0
         MPyf0kZJypSOoMUeGmyjxtoRnKsG08ztqcZyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ckBUe8Y7DssYGD8h8XueXkp6melx2yYpnsS0RQzQC0T9deDkE5pIC/rbEipNx1ciLc
         4rxf2e8tv7YUqq8MKbwKjX5g9o5dNZojHN1mnEKIj35AeA5flqJyI/g9JtdoPHYXc5h8
         gKu9Riv5P5bsgAqv8pk/KRvGcIjuCwtqV5Ufg=
Received: by 10.114.123.9 with SMTP id v9mr908666wac.130.1282688515582;
        Tue, 24 Aug 2010 15:21:55 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id x9sm952331waj.3.2010.08.24.15.21.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:21:54 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:21:49 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154352>

Index in narrow repos is not a full index and should not be used
to create commits without modification (to be explained later on).

Also save narrow prefix inside index and check against
$GIT_DIR/narrow, just in case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h                |    1 +
 read-cache.c           |   35 +++++++++++++++++++++++++++++++----
 t/t6060-narrow-tree.sh |   28 ++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)
 create mode 100755 t/t6060-narrow-tree.sh

diff --git a/cache.h b/cache.h
index ff401ec..6bc80b3 100644
--- a/cache.h
+++ b/cache.h
@@ -293,6 +293,7 @@ struct index_state {
 	struct string_list *resolve_undo;
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
+	char *narrow_prefix;
 	void *alloc;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
diff --git a/read-cache.c b/read-cache.c
index 881dd93..20b619c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,8 +25,9 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce, int reall
  */
=20
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
-#define CACHE_EXT_TREE 0x54524545	/* "TREE" */
+#define CACHE_EXT_TREE 0x54524545	  /* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+#define CACHE_EXT_NARROW 0x4e415257	  /* "NARW" */
=20
 struct index_state the_index;
=20
@@ -1168,7 +1169,9 @@ static int verify_hdr(struct cache_header *hdr, u=
nsigned long size)
=20
 	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
 		return error("bad signature");
-	if (hdr->hdr_version !=3D htonl(2) && hdr->hdr_version !=3D htonl(3))
+	if (hdr->hdr_version !=3D htonl(2) &&
+	    hdr->hdr_version !=3D htonl(3) &&
+	    hdr->hdr_version !=3D htonl(4))
 		return error("bad index version");
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
@@ -1188,6 +1191,9 @@ static int read_index_extension(struct index_stat=
e *istate,
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo =3D resolve_undo_read(data, sz);
 		break;
+	case CACHE_EXT_NARROW:
+		istate->narrow_prefix =3D xstrdup(data);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand=
",
@@ -1352,6 +1358,16 @@ int read_index_from(struct index_state *istate, =
const char *path)
 		src_offset +=3D extsize;
 	}
 	munmap(mmap, mmap_size);
+
+	if ((!get_narrow_prefix() && !istate->narrow_prefix) ||
+	    (get_narrow_prefix() && istate->narrow_prefix &&
+	     !strcmp(get_narrow_prefix(), istate->narrow_prefix)))
+		;		/* good */
+	else
+		die("Incompatible index and narrow mode (%s/%s)",
+		    get_narrow_prefix(),
+		    istate->narrow_prefix);
+
 	return istate->cache_nr;
=20
 unmap:
@@ -1549,7 +1565,7 @@ int write_index(struct index_state *istate, int n=
ewfd)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
-	int i, err, removed, extended;
+	int i, err, removed, extended, ver;
 	struct cache_entry **cache =3D istate->cache;
 	int entries =3D istate->cache_nr;
 	struct stat st;
@@ -1568,7 +1584,11 @@ int write_index(struct index_state *istate, int =
newfd)
=20
 	hdr.hdr_signature =3D htonl(CACHE_SIGNATURE);
 	/* for extended format, increase version so older git won't try to re=
ad it */
-	hdr.hdr_version =3D htonl(extended ? 3 : 2);
+	ver =3D extended ? 3 : 2;
+	if (get_narrow_prefix() && ver < 4)
+		ver =3D 4;	/* narrow-unaware git should to touch this index */
+
+	hdr.hdr_version =3D htonl(ver);
 	hdr.hdr_entries =3D htonl(entries - removed);
=20
 	git_SHA1_Init(&c);
@@ -1607,6 +1627,13 @@ int write_index(struct index_state *istate, int =
newfd)
 		if (err)
 			return -1;
 	}
+	if (get_narrow_prefix()) {
+		int len =3D strlen(get_narrow_prefix())+1;
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_NARROW, len) < 0=
 ||
+			ce_write(&c, newfd, get_narrow_prefix(), len) < 0;
+		if (err)
+			return -1;
+	}
=20
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
diff --git a/t/t6060-narrow-tree.sh b/t/t6060-narrow-tree.sh
new file mode 100755
index 0000000..0e561c8
--- /dev/null
+++ b/t/t6060-narrow-tree.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description=3D'narrow-tree tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	: >test
+'
+
+test_expect_success 'index ver 4 in narrow mode' '
+	echo foo >.git/narrow &&
+	git update-index --add test &&
+	echo 4 >expected &&
+	test-index-version < .git/index >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'index ver < 4 when narrow mode is gone' '
+	rm .git/narrow &&
+	rm .git/index &&
+	git update-index --add test &&
+	echo 2 >expected &&
+	test-index-version < .git/index >result &&
+	test_cmp expected result
+'
+
+test_done
--=20
1.7.1.rc1.69.g24c2f7
