From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 3/4] cache-tree: fix writing cache-tree when CE_REMOVE is present
Date: Sun, 16 Dec 2012 11:15:27 +0700
Message-ID: <1355631328-26678-4-git-send-email-pclouds@gmail.com>
References: <1355631328-26678-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 05:15:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk5dk-0004QI-FZ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 05:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab2LPEPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Dec 2012 23:15:22 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46284 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2LPEPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 23:15:20 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3304221pad.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 20:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=glLy1+nGnLW7y2LKIHFVqVBJXTVFeXsukbC8XE/TITI=;
        b=0ylMRQgeAw3JES5vWqIEVh7ggoiyIU4Z5J1JgAOcAt/Bh2F5Ct5rZpVwXVk4nLImZD
         eaE+rLskjvC/3aVDIMZq0i9Z/Io3vlfrQjJEnF4E55ORAT+adnqxVT0oq4wwhwCOsSxZ
         8FJZtWzBsyVTG+VSTYy8d5uK0PnhrjKuftivEIBKuZZKRQ41UaFI9YWUuw4om8ZAfpte
         aZ6lFu0FR8AW7K4MrhV+v49yse50RsFzKxFihHfNEiJH7NJjS6IuWWqJkRkBlYRpQT93
         dhgKgjkiyrLfatwhyZ/TV3dBL18GDvzUJ4waCWRnpwdvuGZ8YTZHry2qcMyAxZJ5FXs5
         sbRQ==
Received: by 10.68.232.195 with SMTP id tq3mr30559461pbc.70.1355631319366;
        Sat, 15 Dec 2012 20:15:19 -0800 (PST)
Received: from lanh ([115.74.41.198])
        by mx.google.com with ESMTPS id qr8sm5721067pbc.64.2012.12.15.20.15.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 20:15:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Dec 2012 11:15:56 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1355631328-26678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211577>

entry_count is used in update_one() for two purposes:

1. to skip through the number of processed entries in in-memory index
2. to record the number of entries this cache-tree covers on disk

Unfortunately when CE_REMOVE is present these numbers are not the same
because CE_REMOVE entries are automatically removed before writing to
disk but entry_count is not adjusted and still counts CE_REMOVE
entries.

Separate the two use cases into two different variables. #1 is taken
care by the new field count in struct cache_tree_sub and entry_count
is prepared for #2.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c | 30 +++++++++++++++++++++++-------
 cache-tree.h |  1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 44eed28..2c10b2e 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -238,6 +238,7 @@ static int update_one(struct cache_tree *it,
 		      int entries,
 		      const char *base,
 		      int baselen,
+		      int *skip_count,
 		      int flags)
 {
 	struct strbuf buffer;
@@ -245,6 +246,8 @@ static int update_one(struct cache_tree *it,
 	int dryrun =3D flags & WRITE_TREE_DRY_RUN;
 	int i;
=20
+	*skip_count =3D 0;
+
 	if (0 <=3D it->entry_count && has_sha1_file(it->sha1))
 		return it->entry_count;
=20
@@ -264,7 +267,7 @@ static int update_one(struct cache_tree *it,
 		struct cache_entry *ce =3D cache[i];
 		struct cache_tree_sub *sub;
 		const char *path, *slash;
-		int pathlen, sublen, subcnt;
+		int pathlen, sublen, subcnt, subskip;
=20
 		path =3D ce->name;
 		pathlen =3D ce_namelen(ce);
@@ -289,10 +292,13 @@ static int update_one(struct cache_tree *it,
 				    cache + i, entries - i,
 				    path,
 				    baselen + sublen + 1,
+				    &subskip,
 				    flags);
 		if (subcnt < 0)
 			return subcnt;
 		i +=3D subcnt;
+		sub->count =3D subcnt; /* to be used in the next loop */
+		*skip_count +=3D subskip;
 		sub->used =3D 1;
 	}
=20
@@ -324,7 +330,7 @@ static int update_one(struct cache_tree *it,
 			if (!sub)
 				die("cache-tree.c: '%.*s' in '%s' not found",
 				    entlen, path + baselen, path);
-			i +=3D sub->cache_tree->entry_count;
+			i +=3D sub->count;
 			sha1 =3D sub->cache_tree->sha1;
 			mode =3D S_IFDIR;
 		}
@@ -340,8 +346,18 @@ static int update_one(struct cache_tree *it,
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
 		}
=20
-		if (ce->ce_flags & (CE_REMOVE | CE_INTENT_TO_ADD))
-			continue; /* entry being removed or placeholder */
+		/*
+		 * CE_REMOVE entries are removed before the index is
+		 * written to disk. Skip them to remain consistent
+		 * with the future on-disk index.
+		 */
+		if (ce->ce_flags & CE_REMOVE) {
+			*skip_count =3D *skip_count + 1;
+			continue;
+		}
+
+		if (ce->ce_flags & CE_INTENT_TO_ADD)
+			continue;
=20
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0'=
);
@@ -361,7 +377,7 @@ static int update_one(struct cache_tree *it,
 	}
=20
 	strbuf_release(&buffer);
-	it->entry_count =3D i;
+	it->entry_count =3D i - *skip_count;
 #if DEBUG
 	fprintf(stderr, "cache-tree update-one (%d ent, %d subtree) %s\n",
 		it->entry_count, it->subtree_nr,
@@ -375,11 +391,11 @@ int cache_tree_update(struct cache_tree *it,
 		      int entries,
 		      int flags)
 {
-	int i;
+	int i, skip;
 	i =3D verify_cache(cache, entries, flags);
 	if (i)
 		return i;
-	i =3D update_one(it, cache, entries, "", 0, flags);
+	i =3D update_one(it, cache, entries, "", 0, &skip, flags);
 	if (i < 0)
 		return i;
 	return 0;
diff --git a/cache-tree.h b/cache-tree.h
index d8cb2e9..55d0f59 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -7,6 +7,7 @@
 struct cache_tree;
 struct cache_tree_sub {
 	struct cache_tree *cache_tree;
+	int count;		/* internally used by update_one() */
 	int namelen;
 	int used;
 	char name[FLEX_ARRAY];
--=20
1.8.0.rc2.23.g1fb49df
