From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] unpack-trees: let read-tree -u remove index entries outside sparse area
Date: Sat, 31 Jul 2010 13:14:27 +0700
Message-ID: <1280556869-707-4-git-send-email-pclouds@gmail.com>
References: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 08:15:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of5Lt-0002CK-Cy
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 08:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab0GaGPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 02:15:15 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45174 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab0GaGPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 02:15:13 -0400
Received: by pxi14 with SMTP id 14so799570pxi.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=86OZnmg2BdVOT5qsc6NHPAhongdsBMi7TmgE4g1JgSw=;
        b=MXBw27VaMeKMuUTHOtL+P1FmfjzQLJdFfjgYxKh7uJS04iWDeGVHBDT5a+984RFfSF
         KwvfycMSVTgmwS+7hf+bRp5TPXUSknRPxmNTl6IZ63CW0UU0UiC18A56gnl0vxCG0TSb
         vybrWQ3cIjFNoD7hKj6tL/j56hyRrXitL03ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lM2PSrow2/qb6NKWnXM+dTOOBlEx2xuN4GhkKco5Eed8P3mWjedcxHEa9oLPQnEn5/
         VZA2CW+hx7/NKXfxSeaoZ+UyYn4oraUiiZr5IOc+C7G+IkH/aYAwrufVQGfZXnnxn6FR
         72mhuYGPc1ed/QIZxUX9voqjiTY8/cN0rdE7o=
Received: by 10.114.122.13 with SMTP id u13mr3631823wac.93.1280556912746;
        Fri, 30 Jul 2010 23:15:12 -0700 (PDT)
Received: from dektop ([123.200.231.45])
        by mx.google.com with ESMTPS id k23sm5380629waf.5.2010.07.30.23.15.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 23:15:11 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 13:14:59 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152312>

To avoid touching the worktree outside a sparse checkout,
when the update flag is enabled unpack_trees() clears the
CE_UPDATE and CE_REMOVE flags on entries that do not match the
sparse pattern before actually committing any updates to the
index file or worktree.

The effect on the index was unintentional; sparse checkout was
never meant to prevent index updates outside the area checked
out.  And the result is very confusing: for example, after a
failed merge, currently "git reset --hard" does not reset the
state completely but an additional "git reset --mixed" will.

So stop clearing the CE_REMOVE flag.  Instead, maintain a
CE_WT_REMOVE flag to separately track whether a particular
file removal should apply to the worktree in addition to the
index or not.

The CE_WT_REMOVE flag is used already to mark files that
should be removed because of a narrowing checkout area.  That
usage will still apply; do not clear the CE_WT_REMOVE flag
in that case (detectable because the CE_REMOVE flag is not
set).

This bug masked some other bugs illustrated by the test
suite, which will be addressed by later patches.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
=46ixes: http://bugs.debian.org/583699

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h                              |    3 +--
 t/t1011-read-tree-sparse-checkout.sh |   11 ++++++++++-
 unpack-trees.c                       |   29 +++++++++++++++++++-------=
---
 3 files changed, 30 insertions(+), 13 deletions(-)

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
index 2876daf..3e01c6e 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -146,7 +146,7 @@ test_expect_success 'read-tree adds to worktree, ab=
sent case' '
 	test ! -f sub/added
 '
=20
-test_expect_success 'read-tree adds to worktree, dirty case' '
+test_expect_failure 'read-tree adds to worktree, dirty case' '
 	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f removed &&
 	mkdir sub &&
@@ -167,4 +167,13 @@ test_expect_success 'index removal and worktree na=
rrowing at the same time' '
 	test_cmp empty result
 '
=20
+test_expect_success 'read-tree --reset removes outside worktree' '
+	>empty &&
+	echo init.t >.git/info/sparse-checkout &&
+	git checkout -f top &&
+	git reset --hard removed &&
+	git ls-files sub/added >result &&
+	test_cmp empty result
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 6d0df99..1413872 100644
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
@@ -164,10 +161,22 @@ static int apply_sparse_checkout(struct cache_ent=
ry *ce, struct unpack_trees_opt
 	/*
 	 * Merge strategies may set CE_UPDATE|CE_REMOVE outside checkout
 	 * area as a result of ce_skip_worktree() shortcuts in
-	 * verify_absent() and verify_uptodate(). Clear them.
+	 * verify_absent() and verify_uptodate().
+	 * Make sure they don't modify worktree if they are already
+	 * outside checkout area
 	 */
-	if (was_skip_worktree && ce_skip_worktree(ce))
-		ce->ce_flags &=3D ~(CE_UPDATE | CE_REMOVE);
+	if (was_skip_worktree && ce_skip_worktree(ce)) {
+		ce->ce_flags &=3D ~CE_UPDATE;
+
+		/*
+		 * By default, when CE_REMOVE is on, CE_WT_REMOVE is also
+		 * on to get that file removed from both index and worktree.
+		 * If that file is already outside worktree area, don't
+		 * bother remove it.
+		 */
+		if (ce->ce_flags & CE_REMOVE)
+			ce->ce_flags &=3D ~CE_WT_REMOVE;
+	}
=20
 	if (!was_skip_worktree && ce_skip_worktree(ce)) {
 		/*
--=20
1.7.1.rc1.69.g24c2f7
