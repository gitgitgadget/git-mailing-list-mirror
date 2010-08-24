From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/32] cache-tree: abstract out write_sha1_file from cache_tree_update()
Date: Wed, 25 Aug 2010 08:19:52 +1000
Message-ID: <1282688422-7738-3-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1ss-0001Xh-5A
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302Ab0HXWVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:21:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47096 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300Ab0HXWVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:21:08 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so2824689pzk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6gQcGXRwlSFRHbhu4XjuRAUjX+QmHTpf2ghUGBHXB/s=;
        b=m00oySSZkXNQnQUYndSZvUp4dWuTPTNUNQPPhlR6glymAvCe0f41g9jSfeUYZxiE/E
         V8gx0qu5E9FzXsgdJKeY7glhpdr8OIMbXmcnKlOdc9i75/SkR7Xc2qJc9OrWPJFkn8OQ
         ZNVmHUI8r3LYaLkfOKTut00HGmAgxbH5pSxTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OKbW3tBizax8MEuzT5vilIaf8m8cw1kS78htcCoMnSNo3fG3sQr5KDQo3l8GNkH8Kf
         ZGTBuh2MjHvL2tN+1tdz73x4vaNd7zFOULoTNVp1kvOjjjjYMkg0a9ibXMOmpJD5PFkt
         ihcFj5glpjsIzlQHgS5mz+0PXXJf8suzuEa/g=
Received: by 10.114.175.14 with SMTP id x14mr8460027wae.152.1282688467772;
        Tue, 24 Aug 2010 15:21:07 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id 33sm948486wad.6.2010.08.24.15.21.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:21:05 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:20:58 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154351>

This allows cache-tree to produce trees directly in a pack, for instanc=
e.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c |   18 +++++++++++++++---
 cache-tree.h |    3 +++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index c60cf91..7fd7203 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -237,6 +237,7 @@ static int update_one(struct cache_tree *it,
 		      int entries,
 		      const char *base,
 		      int baselen,
+		      write_tree_fn write_tree,
 		      int missing_ok,
 		      int dryrun)
 {
@@ -284,6 +285,7 @@ static int update_one(struct cache_tree *it,
 				    cache + i, entries - i,
 				    path,
 				    baselen + sublen + 1,
+				    write_tree,
 				    missing_ok,
 				    dryrun);
 		if (subcnt < 0)
@@ -349,7 +351,7 @@ static int update_one(struct cache_tree *it,
=20
 	if (dryrun)
 		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
-	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1)=
) {
+	else if (write_tree(buffer.buf, buffer.len, tree_type, it->sha1)) {
 		strbuf_release(&buffer);
 		return -1;
 	}
@@ -364,9 +366,10 @@ static int update_one(struct cache_tree *it,
 	return i;
 }
=20
-int cache_tree_update(struct cache_tree *it,
+int cache_tree_update_fn(struct cache_tree *it,
 		      struct cache_entry **cache,
 		      int entries,
+		      write_tree_fn write_tree,
 		      int missing_ok,
 		      int dryrun)
 {
@@ -374,12 +377,21 @@ int cache_tree_update(struct cache_tree *it,
 	i =3D verify_cache(cache, entries);
 	if (i)
 		return i;
-	i =3D update_one(it, cache, entries, "", 0, missing_ok, dryrun);
+	i =3D update_one(it, cache, entries, "", 0, write_tree, missing_ok, d=
ryrun);
 	if (i < 0)
 		return i;
 	return 0;
 }
=20
+int cache_tree_update(struct cache_tree *it,
+		      struct cache_entry **cache,
+		      int entries,
+		      int missing_ok,
+		      int dryrun)
+{
+	return cache_tree_update_fn(it, cache, entries, write_sha1_file, miss=
ing_ok, dryrun);
+}
+
 static void write_one(struct strbuf *buffer, struct cache_tree *it,
                       const char *path, int pathlen)
 {
diff --git a/cache-tree.h b/cache-tree.h
index 3df641f..b32ae41 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -20,6 +20,8 @@ struct cache_tree {
 	struct cache_tree_sub **down;
 };
=20
+typedef int (*write_tree_fn)(const void *, unsigned long, const char *=
, unsigned char *);
+
 struct cache_tree *cache_tree(void);
 void cache_tree_free(struct cache_tree **);
 void cache_tree_invalidate_path(struct cache_tree *, const char *);
@@ -29,6 +31,7 @@ void cache_tree_write(struct strbuf *, struct cache_t=
ree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long s=
ize);
=20
 int cache_tree_fully_valid(struct cache_tree *);
+int cache_tree_update_fn(struct cache_tree *, struct cache_entry **, i=
nt, write_tree_fn, int, int);
 int cache_tree_update(struct cache_tree *, struct cache_entry **, int,=
 int, int);
=20
 /* bitmasks to write_cache_as_tree flags */
--=20
1.7.1.rc1.69.g24c2f7
