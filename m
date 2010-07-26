From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] Fix sparse checkout not removing files from index
Date: Mon, 26 Jul 2010 16:08:28 +0700
Message-ID: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 11:52:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdKMk-0008WJ-2L
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 11:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135Ab0GZJww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 05:52:52 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56285 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab0GZJwv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 05:52:51 -0400
Received: by pzk26 with SMTP id 26so908691pzk.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=7nOvwm6e2d6HE/Ug7Numur1q8M6rNhGBZ04NXSGGk6M=;
        b=YVPYygw47euOJSlSEOwKeIe7FhfbQGxZbODLroOjxzHZld5aNwRE09tfWfpn859Nrz
         q5a+XJ9wtKLq4Zt5YqxfKxAv7TtPstXunwJICWCnfcFUXmlURK753MnLhKB+kgdICGlS
         tAm/QM/6IbYWG1/pdZ5X4ph7yLKAbq2ZGDGRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=uH2jm4cBVzWKVer/VFUkXr7M2aM9rHbesD9jAI7WIllTqtW8Vlc/EAFTeJQktrmVCh
         HIoXrWt9oKofbtjLEDOmrOW2rV8wPT32/hiT7xvo/FaRnrk+5963+9dGhyw6oXkTFJt7
         ENVdO0GByZaqjmZVEulEyfvqMV8Q8tiBU8XBY=
Received: by 10.114.183.11 with SMTP id g11mr11094161waf.33.1280137971398;
        Mon, 26 Jul 2010 02:52:51 -0700 (PDT)
Received: from dektop ([121.91.36.254])
        by mx.google.com with ESMTPS id q6sm6314369waj.22.2010.07.26.02.52.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 02:52:50 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 26 Jul 2010 16:08:31 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151823>

When unpack_trees() nearly completes, sparse pattern is applied and
will prevent any updates (CE_UPDATE, CE_WT_REMOVE, CE_REMOVE) outside
sparse checkout area by clearing these flags.

Unfortunately CE_REMOVE also instructs write_index() to remove files fr=
om
the index. By clearing this flag, index may keep unwanted files.

This patch turns CE_REMOVE in unpack-trees.c to CE_REMOVE|CE_WT_REMOVE
and only remove files from worktree if CE_WT_REMOVE is set. CE_REMOVE
is now only meaningful to index operations and CE_WT_REMOVE to
worktree ones.

This fault made the test suite itself faulty. With this fault fixed,
two other faults are revealed :(

Reported in http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D583699

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h                              |    3 +--
 t/t1011-read-tree-sparse-checkout.sh |    9 ++++++++-
 unpack-trees.c                       |   22 ++++++++++++----------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 0d101e4..4e7bb62 100644
--- a/cache.h
+++ b/cache.h
@@ -179,8 +179,7 @@ struct cache_entry {
 #define CE_UNHASHED  (0x200000)
 #define CE_CONFLICTED (0x800000)
=20
-/* Only remove in work directory, not index */
-#define CE_WT_REMOVE (0x400000)
+#define CE_WT_REMOVE (0x400000) /* remove in work directory */
=20
 #define CE_UNPACKED  (0x1000000)
=20
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 62246db..885578a 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -138,7 +138,7 @@ test_expect_success 'read-tree adds to worktree, ab=
sent case' '
 	test ! -f sub/added
 '
=20
-test_expect_success 'read-tree adds to worktree, dirty case' '
+test_expect_failure 'read-tree adds to worktree, dirty case' '
 	echo init.t > .git/info/sparse-checkout &&
 	git checkout -f removed &&
 	mkdir sub &&
@@ -147,4 +147,11 @@ test_expect_success 'read-tree adds to worktree, d=
irty case' '
 	grep -q dirty sub/added
 '
=20
+test_expect_success 'read-tree --reset removes outside worktree' '
+	echo init.t > .git/info/sparse-checkout &&
+	git checkout -f top &&
+	git reset --hard removed &&
+	test -z "$(git ls-files sub/added)"
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index e8f03f5..f2d148c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -53,6 +53,9 @@ static void add_entry(struct unpack_trees_options *o,=
 struct cache_entry *ce,
=20
 	clear |=3D CE_HASHED | CE_UNHASHED;
=20
+	if (set & CE_REMOVE)
+		set |=3D CE_WT_REMOVE;
+
 	memcpy(new, ce, size);
 	new->next =3D NULL;
 	new->ce_flags =3D (new->ce_flags & ~clear) | set;
@@ -84,7 +87,7 @@ static int check_updates(struct unpack_trees_options =
*o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE | CE_WT_REMOVE))
+			if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
 				total++;
 		}
=20
@@ -104,12 +107,6 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 				unlink_entry(ce);
 			continue;
 		}
-
-		if (ce->ce_flags & CE_REMOVE) {
-			display_progress(progress, ++cnt);
-			if (o->update)
-				unlink_entry(ce);
-		}
 	}
 	remove_marked_cache_entries(&o->result);
 	remove_scheduled_dirs();
@@ -799,10 +796,15 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
 			/*
 			 * Merge strategies may set CE_UPDATE|CE_REMOVE outside checkout
 			 * area as a result of ce_skip_worktree() shortcuts in
-			 * verify_absent() and verify_uptodate(). Clear them.
+			 * verify_absent() and verify_uptodate().
+			 * Make sure they don't modify worktree.
 			 */
-			if (ce_skip_worktree(ce))
-				ce->ce_flags &=3D ~(CE_UPDATE | CE_REMOVE);
+			if (ce_skip_worktree(ce)) {
+				ce->ce_flags &=3D ~CE_UPDATE;
+
+				if (ce->ce_flags & CE_REMOVE)
+					ce->ce_flags &=3D ~CE_WT_REMOVE;
+			}
 			else
 				empty_worktree =3D 0;
=20
--=20
1.7.1.rc1.69.g24c2f7
