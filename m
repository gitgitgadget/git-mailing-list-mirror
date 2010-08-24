From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/32] cache-tree: only cache tree within narrow area
Date: Wed, 25 Aug 2010 08:20:06 +1000
Message-ID: <1282688422-7738-17-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uK-00030j-Gh
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337Ab0HXWWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:22:44 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58634 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181Ab0HXWWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:22:42 -0400
Received: by pzk26 with SMTP id 26so2825136pzk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NoaAZhgsZwUF9AbMmzjLpYb1iVa4DrvioJd4il/MMHE=;
        b=OO4r5wc6al6q13tKt3PmiXfX4UaxEe4pKQpvweO5kZRuVPRrZzaKBiIdrqOc+1Ga2x
         hDE0P/7A+9fCY2rFI39vrRu4OEpnP9qStldEg/Ku5tDgSI48LF9UgWvr8C4K+rK/achv
         C/X06+hnWAn58Jg7ZaynEIpRyKjQrWQoEKgc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VJ8ArDNjBp9wtjyRDwNd2bEP8pqbZL05k/nBhQ444TX40xdCNWfqVuRQRoXE+7rtUn
         Poo8MtTi+I7hghUMVfOAme9lzuf2G5nA3CP9He2sTslalvSfwqSNnXnHVzy4yMzexLrI
         toYNBFRFmHjoMEI1UBna+tPaCfoZyg7GVvRtg=
Received: by 10.142.134.12 with SMTP id h12mr6204677wfd.185.1282688561720;
        Tue, 24 Aug 2010 15:22:41 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id v38sm640507wfh.12.2010.08.24.15.22.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:22:40 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:22:36 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154358>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 03952c7..69ce0a2 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -616,11 +616,17 @@ int write_cache_as_tree(unsigned char *sha1, int =
flags, const char *prefix)
 	return 0;
 }
=20
-static void prime_cache_tree_rec(struct cache_tree *it, struct tree *t=
ree)
+static void prime_cache_tree_rec(struct cache_tree *it, struct tree *t=
ree, const char *path)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
-	int cnt;
+	const char *slash;
+	int len =3D 0, cnt;
+
+	if (path) {
+		slash =3D strchr(path, '/');
+		len =3D slash ? slash - path : strlen(path);
+	}
=20
 	hashcpy(it->sha1, tree->object.sha1);
 	init_tree_desc(&desc, tree->buffer, tree->size);
@@ -628,6 +634,8 @@ static void prime_cache_tree_rec(struct cache_tree =
*it, struct tree *tree)
 	while (tree_entry(&desc, &entry)) {
 		if (!S_ISDIR(entry.mode))
 			cnt++;
+		else if (get_narrow_prefix() && len && strncmp(entry.path, path, len=
))
+			cnt++;
 		else {
 			struct cache_tree_sub *sub;
 			struct tree *subtree =3D lookup_tree(entry.sha1);
@@ -635,7 +643,8 @@ static void prime_cache_tree_rec(struct cache_tree =
*it, struct tree *tree)
 				parse_tree(subtree);
 			sub =3D cache_tree_sub(it, entry.path);
 			sub->cache_tree =3D cache_tree();
-			prime_cache_tree_rec(sub->cache_tree, subtree);
+			prime_cache_tree_rec(sub->cache_tree, subtree,
+					     slash ? slash+1 : NULL);
 			cnt +=3D sub->cache_tree->entry_count;
 		}
 	}
@@ -646,7 +655,7 @@ void prime_cache_tree(struct cache_tree **it, struc=
t tree *tree)
 {
 	cache_tree_free(it);
 	*it =3D cache_tree();
-	prime_cache_tree_rec(*it, tree);
+	prime_cache_tree_rec(*it, tree, get_narrow_prefix());
 }
=20
 /*
--=20
1.7.1.rc1.69.g24c2f7
