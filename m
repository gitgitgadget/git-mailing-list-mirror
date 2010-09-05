From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/17] cache-tree: only cache tree within narrow area
Date: Sun,  5 Sep 2010 16:47:36 +1000
Message-ID: <1283669264-15759-10-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:49:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os92v-0008C5-PW
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab0IEGti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:49:38 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:47913 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab0IEGth (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:49:37 -0400
Received: by pxi10 with SMTP id 10so649971pxi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cmQ6EOE1TueICI2CCw2OvfKx0zUUr3SbZSjH8JL81uU=;
        b=MPOCLlP6o8S9tkVAPDwOnu+gCdV61wHmpwpk1TPpBjmd+pvbEyo2Bk/zT9YSAaT/Sj
         DGa9A2zRNcFMVuY7g4mBKiFWRUvulNQrxoanU3BCCKDOKH5t36Xk0AkThXMqAYgGyW3a
         UJdfPLo2hNIlhWDBY0axx+1rW0K8o2zUShprs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Sq8GBcMVy2Nn1JIGgCAJSIEM3VWB4N6SBkpYc/gg39k3/3ZIoOjKHNCv+AHWtNZ6nF
         TyFVYsi1RJ7mwuXM+iLwIqW/21x1Fi6VFz0iC0eD32t2EZngr9jfcwTG7QssP+cMA/Gx
         jktaa7aK0+eF9Hpoha6JuZt9myYUz7D3hj52Q=
Received: by 10.142.59.15 with SMTP id h15mr1121748wfa.101.1283669377496;
        Sat, 04 Sep 2010 23:49:37 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id q23sm1973336wfc.6.2010.09.04.23.49.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:49:36 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:49:28 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155435>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c |   41 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index c60cf91..6aaf265 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -602,7 +602,8 @@ int write_cache_as_tree(unsigned char *sha1, int fl=
ags, const char *prefix)
 	return 0;
 }
=20
-static void prime_cache_tree_rec(struct cache_tree *it, struct tree *t=
ree)
+static void prime_cache_tree_rec(struct cache_tree *it, struct tree *t=
ree,
+				 char *base, int baselen)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -611,17 +612,48 @@ static void prime_cache_tree_rec(struct cache_tre=
e *it, struct tree *tree)
 	hashcpy(it->sha1, tree->object.sha1);
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	cnt =3D 0;
+	if (base && baselen)
+		base[baselen++] =3D '/';
 	while (tree_entry(&desc, &entry)) {
 		if (!S_ISDIR(entry.mode))
 			cnt++;
 		else {
 			struct cache_tree_sub *sub;
-			struct tree *subtree =3D lookup_tree(entry.sha1);
+			struct tree *subtree;
+			int found =3D 2; /* all interesting */
+			const char **p =3D get_narrow_prefix();
+			int len =3D 0;
+
+			if (p) {
+				found =3D 0; /* not interesting */
+				len =3D strlen(entry.path);
+				if (base)
+					memcpy(base+baselen, entry.path, len+1);
+				while (*p) {
+					if (!prefixcmp(entry.path, *p)) {
+						found =3D 2;
+						break;
+					}
+					if (!prefixcmp(*p, entry.path)) {
+						found =3D 1;
+						break;
+					}
+					p++;
+				}
+				if (!found) {
+					cnt++;
+					continue;
+				}
+			}
+
+			subtree =3D lookup_tree(entry.sha1);
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
 			sub =3D cache_tree_sub(it, entry.path);
 			sub->cache_tree =3D cache_tree();
-			prime_cache_tree_rec(sub->cache_tree, subtree);
+			prime_cache_tree_rec(sub->cache_tree, subtree,
+					     found =3D=3D 1 ? base : NULL,
+					     baselen+len);
 			cnt +=3D sub->cache_tree->entry_count;
 		}
 	}
@@ -630,9 +662,10 @@ static void prime_cache_tree_rec(struct cache_tree=
 *it, struct tree *tree)
=20
 void prime_cache_tree(struct cache_tree **it, struct tree *tree)
 {
+	char path[PATH_MAX];
 	cache_tree_free(it);
 	*it =3D cache_tree();
-	prime_cache_tree_rec(*it, tree);
+	prime_cache_tree_rec(*it, tree, get_narrow_prefix() ? path : NULL, 0)=
;
 }
=20
 /*
--=20
1.7.1.rc1.69.g24c2f7
