From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] Introduce index version 4 with global flags
Date: Mon,  6 Feb 2012 12:48:37 +0700
Message-ID: <1328507319-24687-4-git-send-email-pclouds@gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 06:44:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHNI-0002qR-My
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab2BFFoU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 00:44:20 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39009 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab2BFFoT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:44:19 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so4687056pbd.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 21:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FlHXIxwR1xqNZN+53mNH67qK09PcVvEhc6kr1V6PqMI=;
        b=xwF6ogcwWn9HwLI8mbuPUTdHZraxlMdjwWWDXq2lZAdqCIkOTLdudEKv/PdeFL85Nk
         jmeoK13ApuuBmEOe3EqocvzqPZWA3a/9jnlxDNrYK9Bkq6hw1ZKgFnwCgiFlBDQ8tz0e
         25r+tFG6PZJ3QSxBHnBPis+tLlg0PaiIx1KJU=
Received: by 10.68.190.101 with SMTP id gp5mr44390404pbc.31.1328507059557;
        Sun, 05 Feb 2012 21:44:19 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id p9sm36753646pbb.9.2012.02.05.21.44.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 21:44:18 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 06 Feb 2012 12:49:10 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190019>

v4 adds 32-bit field to cache header after 32-bit number of entries.
If this field is zero, fall back to v3.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/index-format.txt |    4 ++-
 cache.h                                  |    6 +++++
 read-cache.c                             |   31 ++++++++++++++++++++++=
-------
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 8930b3f..2b6a38e 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -12,10 +12,12 @@ GIT index format
        The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache")
=20
      4-byte version number:
-       The current supported versions are 2 and 3.
+       The current supported versions are 2, 3 and 4.
=20
      32-bit number of index entries.
=20
+     32-bit flags (version 4 only).
+
    - A number of sorted index entries (see below).
=20
    - Extensions
diff --git a/cache.h b/cache.h
index 9bd8c2d..c2e884a 100644
--- a/cache.h
+++ b/cache.h
@@ -105,6 +105,11 @@ struct cache_header {
 	unsigned int hdr_entries;
 };
=20
+struct ext_cache_header {
+	struct cache_header h;
+	unsigned int hdr_flags;
+};
+
 /*
  * The "cache_time" is just the low 32 bits of the
  * time. It doesn't matter if it overflows - we only
@@ -314,6 +319,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int cache_nr, cache_alloc, cache_changed;
+	unsigned int hdr_flags;
 	struct string_list *resolve_undo;
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
diff --git a/read-cache.c b/read-cache.c
index fe6b0e0..fd21af6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1190,7 +1190,9 @@ static int verify_hdr(struct cache_header *hdr, u=
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
@@ -1320,7 +1322,12 @@ int read_index_from(struct index_state *istate, =
const char *path)
 	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(struct cache_en=
try *));
 	istate->initialized =3D 1;
=20
-	src_offset =3D sizeof(*hdr);
+	if (ntohl(hdr->hdr_version) >=3D 4) {
+		struct ext_cache_header *ehdr =3D mmap;
+		istate->hdr_flags =3D ntohl(ehdr->hdr_flags);
+		src_offset =3D sizeof(*ehdr);
+	} else
+		src_offset =3D sizeof(*hdr);
 	for (i =3D 0; i < istate->cache_nr; i++) {
 		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
@@ -1375,6 +1382,7 @@ int discard_index(struct index_state *istate)
 	resolve_undo_clear_index(istate);
 	istate->cache_nr =3D 0;
 	istate->cache_changed =3D 0;
+	istate->hdr_flags =3D 0;
 	istate->timestamp.sec =3D 0;
 	istate->timestamp.nsec =3D 0;
 	istate->name_hash_initialized =3D 0;
@@ -1531,8 +1539,8 @@ void update_index_if_able(struct index_state *ist=
ate, struct lock_file *lockfile
 int write_index(struct index_state *istate, int newfd)
 {
 	struct sha1file *f;
-	struct cache_header hdr;
-	int i, err, removed;
+	struct ext_cache_header hdr;
+	int i, err, removed, hdr_size;
 	struct cache_entry **cache =3D istate->cache;
 	int entries =3D istate->cache_nr;
 	struct stat st;
@@ -1548,12 +1556,19 @@ int write_index(struct index_state *istate, int=
 newfd)
 		}
 	}
=20
-	hdr.hdr_signature =3D htonl(CACHE_SIGNATURE);
-	hdr.hdr_version =3D htonl(3);
-	hdr.hdr_entries =3D htonl(entries - removed);
+	hdr.h.hdr_signature =3D htonl(CACHE_SIGNATURE);
+	if (istate->hdr_flags) {
+		hdr.h.hdr_version =3D htonl(4);
+		hdr.hdr_flags =3D htonl(istate->hdr_flags);
+		hdr_size =3D sizeof(hdr);
+	} else {
+		hdr.h.hdr_version =3D htonl(3);
+		hdr_size =3D sizeof(hdr.h);
+	}
+	hdr.h.hdr_entries =3D htonl(entries - removed);
=20
 	f =3D sha1fd(newfd, NULL);
-	if (ce_write(f, &hdr, sizeof(hdr)) < 0)
+	if (ce_write(f, &hdr, hdr_size) < 0)
 		return -1;
=20
 	for (i =3D 0; i < entries; i++) {
--=20
1.7.8.36.g69ee2
