From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] cache-tree: invalidate i-t-a paths after generating trees
Date: Sat,  8 Dec 2012 11:10:03 +0700
Message-ID: <1354939803-8466-1-git-send-email-pclouds@gmail.com>
References: <1352459040-14452-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathon Mah <me@JonathonMah.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 05:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThBkB-0001yY-Ds
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 05:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932999Ab2LHEKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Dec 2012 23:10:08 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38796 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932974Ab2LHEKH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 23:10:07 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so778445pbc.19
        for <git@vger.kernel.org>; Fri, 07 Dec 2012 20:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=m9lBWtseAS+q6n4LF4a92ExiRYFI/fCpi669WdxrH/g=;
        b=zD0OPBd1tJtsQez6MjC8xOaOVlFRMkXyCITcqON4n2HQWGjX1f+18YQGbcbM2HYVhk
         ADq/GnAmtampOeBKK5mzglHouBHI/JjvOS4cF358644k6SrW8IFjQk0qcmR/j610giHh
         p83lXB7zS39DynuE3IWIFN5Mpzs9px/fODIuqMFh6ALiY8XCNHohG12OlNnwCLjy0Lh7
         p3T6fTVIVKQh5kcJF579Oh3SjBwsSLr5LbaH0OzpHIJGNdVTiac7VdxxzKRddmPQ18rX
         /XxK28xtFIi3XbBcM7pb0cqTNnv/DjsANVcwWskmUc+S6V7+7KyXE5rq0g0yZxTYjGoR
         8QOw==
Received: by 10.66.9.2 with SMTP id v2mr18714575paa.18.1354939805801;
        Fri, 07 Dec 2012 20:10:05 -0800 (PST)
Received: from lanh ([115.74.41.198])
        by mx.google.com with ESMTPS id wr4sm7758803pbc.72.2012.12.07.20.10.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Dec 2012 20:10:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Dec 2012 11:10:31 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1352459040-14452-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211208>

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
 Sorry for the late update, I have little time for git these days.
 It turns out that we don't need phony bit and another round for
 invalidation. We can do it in update_one.

 cache-tree.c          | 30 ++++++++++++++++++++++++++----
 t/t2203-add-intent.sh | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 28ed657..989a7ff 100644
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
@@ -324,7 +325,13 @@ static int update_one(struct cache_tree *it,
 			if (!sub)
 				die("cache-tree.c: '%.*s' in '%s' not found",
 				    entlen, path + baselen, path);
-			i +=3D sub->cache_tree->entry_count - 1;
+			i--; /* this entry is already counted in "sub" */
+			if (sub->cache_tree->entry_count < 0) {
+				i -=3D sub->cache_tree->entry_count;
+				to_invalidate =3D 1;
+			}
+			else
+				i +=3D sub->cache_tree->entry_count;
 			sha1 =3D sub->cache_tree->sha1;
 			mode =3D S_IFDIR;
 		}
@@ -339,8 +346,23 @@ static int update_one(struct cache_tree *it,
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
@@ -360,7 +382,7 @@ static int update_one(struct cache_tree *it,
 	}
=20
 	strbuf_release(&buffer);
-	it->entry_count =3D i;
+	it->entry_count =3D to_invalidate ? -i : i;
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
