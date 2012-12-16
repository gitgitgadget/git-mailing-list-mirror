From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 4/4] cache-tree: invalidate i-t-a paths after generating trees
Date: Sun, 16 Dec 2012 11:15:28 +0700
Message-ID: <1355631328-26678-5-git-send-email-pclouds@gmail.com>
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
	id 1Tk5dl-0004QI-42
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 05:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab2LPEP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Dec 2012 23:15:28 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41181 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2LPEP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 23:15:26 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3258731pbc.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 20:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nH5Xhj44TodyLU4SKUNJym3eN0UjDmuvDuDFW4/sOVU=;
        b=v1J0DLajEwHft8byoZEzE5WErkQMjpCWTVJBK4HlE6t1MFAuLzn897m5H2pe2vJJ1i
         CIxFiQaTjvy5jvHTkSKbCs/gTMRly06ijKbFIwPR1KBlWaj+rT0sVumy9seutXBiZrcM
         Pig8hu6vBp9nPzzk4RaJbwqRNqDDls8gvTeY5E2kS4G0lVmQA44fmOTWdmktVbMSjuGT
         DqyMKFRI9PdtPj+scyqzFdia0Ly7XBdszpSshmVuGAxtD381DZNfpSRyoIUuutvWejxp
         OGzrpAubFL2nVDS9yemhTvgmoiY4O5CcG+Zyv4a/6c+gFZE16ouvKwRw6tnrJVNohFSP
         SlsQ==
Received: by 10.68.242.225 with SMTP id wt1mr30208416pbc.65.1355631325168;
        Sat, 15 Dec 2012 20:15:25 -0800 (PST)
Received: from lanh ([115.74.41.198])
        by mx.google.com with ESMTPS id i1sm6051269pav.35.2012.12.15.20.15.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 20:15:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Dec 2012 11:16:02 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1355631328-26678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211578>

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
 cache-tree.c          | 14 ++++++++++++--
 t/t2203-add-intent.sh | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 2c10b2e..37e4d00 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -244,6 +244,7 @@ static int update_one(struct cache_tree *it,
 	struct strbuf buffer;
 	int missing_ok =3D flags & WRITE_TREE_MISSING_OK;
 	int dryrun =3D flags & WRITE_TREE_DRY_RUN;
+	int to_invalidate =3D 0;
 	int i;
=20
 	*skip_count =3D 0;
@@ -333,6 +334,8 @@ static int update_one(struct cache_tree *it,
 			i +=3D sub->count;
 			sha1 =3D sub->cache_tree->sha1;
 			mode =3D S_IFDIR;
+			if (sub->cache_tree->entry_count < 0)
+				to_invalidate =3D 1;
 		}
 		else {
 			sha1 =3D ce->sha1;
@@ -356,8 +359,15 @@ static int update_one(struct cache_tree *it,
 			continue;
 		}
=20
-		if (ce->ce_flags & CE_INTENT_TO_ADD)
+		/*
+		 * CE_INTENT_TO_ADD entries exist on on-disk index but
+		 * they are not part of generated trees. Invalidate up
+		 * to root to force cache-tree users to read elsewhere.
+		 */
+		if (ce->ce_flags & CE_INTENT_TO_ADD) {
+			to_invalidate =3D 1;
 			continue;
+		}
=20
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0'=
);
@@ -377,7 +387,7 @@ static int update_one(struct cache_tree *it,
 	}
=20
 	strbuf_release(&buffer);
-	it->entry_count =3D i - *skip_count;
+	it->entry_count =3D to_invalidate ? -1 : i - *skip_count;
 #if DEBUG
 	fprintf(stderr, "cache-tree update-one (%d ent, %d subtree) %s\n",
 		it->entry_count, it->subtree_nr,
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
