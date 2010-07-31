From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] read-tree -m -u: always remove relevant files when
 narrowing checkout
Date: Fri, 30 Jul 2010 20:09:20 -0500
Message-ID: <20100731010920.GD5817@burratino>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
 <20100730013534.GB2182@burratino>
 <AANLkTi=3pX=k=Pf5SnWt8s=hbvwAXcZdmcqP_+kgCyE5@mail.gmail.com>
 <20100730195022.GB2448@burratino>
 <20100731010439.GB5817@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 03:10:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of0bC-0007aJ-Hp
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 03:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab0GaBKi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 21:10:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44219 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab0GaBKg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 21:10:36 -0400
Received: by iwn7 with SMTP id 7so1857181iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 18:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Nqz+CB0dV9+BpVYAwayy8SWcSFcQh+tsvnL0T9I+wMQ=;
        b=PXShDbJ/UT2KA2HYoohQg9ZK5c2nzAea4lBqdTgb/gCiNGVzWJ13CiLz+dIV7I8qIH
         9ZcN7Ec7YFH10scf8Vr0WAxMnJHPoghWtudINwRG1GpOYlpyNxn9nMJYFKgWvUcV20nW
         CBrSekC7E/KHEu2aw7subHJJRe/EZhbIyPUcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OQLJsUmNySFtQKJCTzD1ILGI3RjYQStB2hhHWr83qbdNaP1aRau7MnN7WkQAeMAnA9
         NGrJfRcLws0OzcRAxz2hjZuxXyCRU3kDMKKPv2uZC2dhhsyD8+0xtJvaNVIo1cebSuPi
         HwgQM3M6sOedlBRgV0ILsEsJRd4liznl9C1Do=
Received: by 10.231.143.9 with SMTP id s9mr2761236ibu.65.1280538629779;
        Fri, 30 Jul 2010 18:10:29 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 34sm2472644ibi.12.2010.07.30.18.10.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 18:10:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100731010439.GB5817@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152280>

When narrowing the checkout pattern to exclude a file that the merge
was going to delete, read-tree decides two wrongs make a right and
leaves the file behind.

Or that=E2=80=99s what it looks like.  Actually, for some reason
apply_sparse_checkout() is not paying proper attention to entries
removed by the merge, so they look like ordinary deletions outside
the sparse area.

While fixing that, clarify the semantics of the unpack-trees flags:

 - CE_UPDATE marks an entry for which the worktree might need
   to be updated to match.  If CE_UPDATE is not set, changes
   only apply to the index file.

 - CE_REMOVE marks an entry removed by the merge (just like
   it did before).

 - CE_WT_REMOVE marks an entry that no longer matches the sparse
   pattern.

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sorry for the lack of clarity before.  This is just to give the
idea; I have no confidence that I am not breaking something,
especially because I have not checked why the "if" I am removing
in apply_sparse_checkout was added.

 cache.h                              |    3 +-
 t/t1011-read-tree-sparse-checkout.sh |   21 +++++++++++++++++
 unpack-trees.c                       |   42 +++++++++-----------------=
-------
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/cache.h b/cache.h
index 3c7fb6f..c9fa3df 100644
--- a/cache.h
+++ b/cache.h
@@ -179,7 +179,8 @@ struct cache_entry {
 #define CE_UNHASHED  (0x200000)
 #define CE_CONFLICTED (0x800000)
=20
-#define CE_WT_REMOVE (0x400000) /* remove in work directory */
+/* Only remove in work directory, not index */
+#define CE_WT_REMOVE (0x400000)
=20
 #define CE_UNPACKED  (0x1000000)
=20
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 2955071..247f295 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -155,6 +155,27 @@ test_expect_failure 'read-tree adds to worktree, d=
irty case' '
 	grep -q dirty sub/added
 '
=20
+test_expect_success 'narrow checkout while removing file' '
+	echo "H init.t" >expected.swt-after &&
+	printf "%s\n" init.t sub/added | sort >expected.ls-before
+	echo init.t >expected.ls-after &&
+
+	printf "%s\n" init.t sub/added >.git/info/sparse-checkout &&
+	git checkout -f top &&
+	git ls-files -t >index.before &&
+	ls init.t sub/added | sort >worktree.before &&
+
+	echo init.t >.git/info/sparse-checkout &&
+	git read-tree -m -u HEAD^ &&
+	git ls-files -t >index.after &&
+	ls init.t sub/added | sort >worktree.after &&
+
+	test_cmp expected.swt index.before &&
+	test_cmp expected.swt-after index.after &&
+	test_cmp expected.ls-before worktree.before &&
+	test_cmp expected.ls-after worktree.after
+'
+
 test_expect_success 'read-tree --reset removes outside worktree' '
 	>empty &&
 	echo init.t >.git/info/sparse-checkout &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 523e1de..deabfd9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -53,9 +53,6 @@ static void add_entry(struct unpack_trees_options *o,=
 struct cache_entry *ce,
=20
 	clear |=3D CE_HASHED | CE_UNHASHED;
=20
-	if (set & CE_REMOVE)
-		set |=3D CE_WT_REMOVE;
-
 	memcpy(new, ce, size);
 	new->next =3D NULL;
 	new->ce_flags =3D (new->ce_flags & ~clear) | set;
@@ -87,7 +84,7 @@ static int check_updates(struct unpack_trees_options =
*o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
+			if (ce->ce_flags & CE_UPDATE)
 				total++;
 		}
=20
@@ -101,11 +98,12 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
-		if (ce->ce_flags & CE_WT_REMOVE) {
+		if (ce->ce_flags & CE_UPDATE &&
+		    ce->ce_flags & (CE_REMOVE | CE_WT_REMOVE)) {
 			display_progress(progress, ++cnt);
+			ce->ce_flags &=3D ~CE_UPDATE & ~CE_WT_REMOVE;
 			if (o->update)
 				unlink_entry(ce);
-			continue;
 		}
 	}
 	remove_marked_cache_entries(&o->result);
@@ -152,15 +150,6 @@ static int apply_sparse_checkout(struct cache_entr=
y *ce, struct unpack_trees_opt
 	else
 		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
=20
-	/*
-	 * We only care about files getting into the checkout area
-	 * If merge strategies want to remove some, go ahead, this
-	 * flag will be removed eventually in unpack_trees() if it's
-	 * outside checkout area.
-	 */
-	if (ce->ce_flags & CE_REMOVE)
-		return 0;
-
 	if (!was_skip_worktree && ce_skip_worktree(ce)) {
 		/*
 		 * If CE_UPDATE is set, verify_uptodate() must be called already
@@ -169,7 +158,7 @@ static int apply_sparse_checkout(struct cache_entry=
 *ce, struct unpack_trees_opt
 		 */
 		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
 			return -1;
-		ce->ce_flags |=3D CE_WT_REMOVE;
+		ce->ce_flags |=3D CE_WT_REMOVE | CE_UPDATE;
 	}
 	if (was_skip_worktree && !ce_skip_worktree(ce)) {
 		if (verify_absent_sparse(ce, "overwritten", o))
@@ -796,20 +785,13 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
 				goto done;
 			}
 			/*
-			 * Merge strategies may set CE_UPDATE|CE_REMOVE outside checkout
-			 * area as a result of ce_skip_worktree() shortcuts in
-			 * verify_absent() and verify_uptodate().
-			 * Make sure they don't modify worktree.
+			 * Do not modify worktree outside of sparse checkout area,
+			 * except to make the checkout more narrow.
 			 */
-			if (ce_skip_worktree(ce)) {
-				ce->ce_flags &=3D ~CE_UPDATE;
-
-				if (ce->ce_flags & CE_REMOVE)
-					ce->ce_flags &=3D ~CE_WT_REMOVE;
-			}
-			else
+			if (!ce_skip_worktree(ce))
 				empty_worktree =3D 0;
-
+			else if (!(ce->ce_flags & CE_WT_REMOVE))
+				ce->ce_flags &=3D ~CE_UPDATE;
 		}
 		if (o->result.cache_nr && empty_worktree) {
 			ret =3D unpack_failed(o, "Sparse checkout leaves no entry on workin=
g directory");
@@ -968,7 +950,7 @@ static int verify_clean_subdirectory(struct cache_e=
ntry *ce, const char *action,
 		if (!ce_stage(ce2)) {
 			if (verify_uptodate(ce2, o))
 				return -1;
-			add_entry(o, ce2, CE_REMOVE, 0);
+			add_entry(o, ce2, CE_REMOVE|CE_UPDATE, 0);
 			mark_ce_used(ce2, o);
 		}
 		cnt++;
@@ -1138,7 +1120,7 @@ static int deleted_entry(struct cache_entry *ce, =
struct cache_entry *old,
 	}
 	if (!(old->ce_flags & CE_CONFLICTED) && verify_uptodate(old, o))
 		return -1;
-	add_entry(o, ce, CE_REMOVE, 0);
+	add_entry(o, ce, CE_REMOVE|CE_UPDATE, 0);
 	invalidate_ce_path(ce, o);
 	return 1;
 }
--=20
1.7.2.1.544.ga752d.dirty
