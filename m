From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/2] cache-tree: invalidate i-t-a paths after generating trees
Date: Thu, 13 Dec 2012 08:39:06 +0700
Message-ID: <1355362747-13474-1-git-send-email-pclouds@gmail.com>
References: <7vip89bz4v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathon Mah <me@JonathonMah.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 02:39:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TixlH-00073g-Mk
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 02:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab2LMBig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 20:38:36 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64700 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076Ab2LMBig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 20:38:36 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so1082801pbc.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 17:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wpvh/l8uFRsz23cmp+FsuwQ0gUAPdnC9LUoUgJHGPds=;
        b=Dx1eLI7N7M+l9FpUsNMjGQXwmv6nsCxrAN9LkiTWrMqmnGMg4j693moNi4Go++xse4
         n6qOzftO86yn5f53C/NRN/+nJHbEFuqz+b1K5QdNNCrWs4f+jbnhfxIYvkn2zyZXo44c
         AhcgmYdnKXp1mKk+EXpL38KVJ4eCo2fgQjscDFVYsHBKizaKdLTg1UBJYVo72Ypds1nu
         R9vIQRr7wwk68qNVanvMPho3avQBBPb8Lqm7d+3/Sf6qHyEYiVyf3oxcxmfewWg4UtKa
         L9rrRvGe9Zgf9WU0jws1gMac83NdU1uWLpP14h+77M88p0GSI+0m8TTLwxw38suE+WDC
         cYUQ==
Received: by 10.68.219.67 with SMTP id pm3mr223026pbc.150.1355362714668;
        Wed, 12 Dec 2012 17:38:34 -0800 (PST)
Received: from lanh ([115.74.41.198])
        by mx.google.com with ESMTPS id oz9sm14913pbb.68.2012.12.12.17.38.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 17:38:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 13 Dec 2012 08:39:08 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <7vip89bz4v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211429>

Intent-to-add entries used to forbid writing trees so it was not a
problem. After commit 3f6d56d (commit: ignore intent-to-add entries
instead of refusing - 2012-02-07), we can generate trees from an index
with i-t-a entries.

However, the commit forgets to invalidate all paths leading to i-t-a
entries. With fully valid cache-tree (e.g. after commit or
write-tree), diff operations may prefer cache-tree to index and not
see i-t-a entries in the index, because cache-tree does not have them.

Reported-by: Jonathon Mah <me@JonathonMah.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This version ensures that entry_count can only be >=3D -1 after
 update_one returns. Not ideal but good enough.

 cache-tree.c          | 40 ++++++++++++++++++++++++++++++++++++----
 t/t2203-add-intent.sh | 20 ++++++++++++++++++++
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 28ed657..1fbc81a 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -248,6 +248,7 @@ static int update_one(struct cache_tree *it,
 	int missing_ok =3D flags & WRITE_TREE_MISSING_OK;
 	int dryrun =3D flags & WRITE_TREE_DRY_RUN;
 	int i;
+	int to_invalidate =3D 0;
=20
 	if (0 <=3D it->entry_count && has_sha1_file(it->sha1))
 		return it->entry_count;
@@ -324,7 +325,14 @@ static int update_one(struct cache_tree *it,
 			if (!sub)
 				die("cache-tree.c: '%.*s' in '%s' not found",
 				    entlen, path + baselen, path);
-			i +=3D sub->cache_tree->entry_count - 1;
+			i--; /* this entry is already counted in "sub" */
+			if (sub->cache_tree->entry_count < 0) {
+				i -=3D sub->cache_tree->entry_count;
+				sub->cache_tree->entry_count =3D -1;
+				to_invalidate =3D 1;
+			}
+			else
+				i +=3D sub->cache_tree->entry_count;
 			sha1 =3D sub->cache_tree->sha1;
 			mode =3D S_IFDIR;
 		}
@@ -339,8 +347,23 @@ static int update_one(struct cache_tree *it,
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
+		if (ce->ce_flags & CE_REMOVE)
+			continue;
+
+		/*
+		 * CE_INTENT_TO_ADD entries exist on on-disk index but
+		 * they are not part of generated trees. Invalidate up
+		 * to root to force cache-tree users to read elsewhere.
+		 */
+		if (ce->ce_flags & CE_INTENT_TO_ADD) {
+			to_invalidate =3D 1;
+			continue;
+		}
=20
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0'=
);
@@ -360,7 +383,7 @@ static int update_one(struct cache_tree *it,
 	}
=20
 	strbuf_release(&buffer);
-	it->entry_count =3D i;
+	it->entry_count =3D to_invalidate ? -i : i;
 #if DEBUG
 	fprintf(stderr, "cache-tree update-one (%d ent, %d subtree) %s\n",
 		it->entry_count, it->subtree_nr,
@@ -381,6 +404,15 @@ int cache_tree_update(struct cache_tree *it,
 	i =3D update_one(it, cache, entries, "", 0, flags);
 	if (i < 0)
 		return i;
+	/*
+	 * update_one() uses negative entry_count as a way to mark an
+	 * entry invalid _and_ pass the number of entries back to
+	 * itself at the parent level. This is for internal use and
+	 * should not be leaked out after the top-level update_one
+	 * exits.
+	 */
+	if (it->entry_count < 0)
+		it->entry_count =3D -1;
 	return 0;
 }
=20
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index ec35409..2a4a749 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -62,5 +62,25 @@ test_expect_success 'can "commit -a" with an i-t-a e=
ntry' '
 	git commit -a -m all
 '
=20
+test_expect_success 'cache-tree invalidates i-t-a paths' '
+	git reset --hard &&
+	mkdir dir &&
+	: >dir/foo &&
+	git add dir/foo &&
+	git commit -m foo &&
+
+	: >dir/bar &&
+	git add -N dir/bar &&
+	git diff --cached --name-only >actual &&
+	echo dir/bar >expect &&
+	test_cmp expect actual &&
+
+	git write-tree >/dev/null &&
+
+	git diff --cached --name-only >actual &&
+	echo dir/bar >expect &&
+	test_cmp expect actual
+'
+
 test_done
=20
--=20
1.8.0.rc2.23.g1fb49df
