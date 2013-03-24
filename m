From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] checkout: avoid unnecessary match_pathspec calls
Date: Sun, 24 Mar 2013 19:55:25 +0700
Message-ID: <1364129725-29597-1-git-send-email-pclouds@gmail.com>
References: <7vr4j52t0z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 13:55:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJkSr-0003J3-LL
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 13:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656Ab3CXMza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 08:55:30 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:43246 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab3CXMz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 08:55:28 -0400
Received: by mail-da0-f48.google.com with SMTP id p8so2823629dan.21
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=CAiPUfPAuX/Gyl0fB9mNifJVRD62dsMxXYYwPA0cwB8=;
        b=XxTUB0gQqrQESSiweSl2otiYGn+NSE8tXMjy4IgQAkJKSv0c3v2h8LWhEr/6nHAIVC
         dmWI9RmMZQd3QMZdsxH/FMhwKiBIOnIonFATTmEMJ8V7c2Ez5kjjFJZ+onr/LLdLDOTA
         uD6QS3/njxU+J/HPzLGukPUbAmVV0cHNfKdrKhm/D5dpn5BGyg8bLhukQtVW82/vckPO
         pX3nE4/ucZtHeno+BBf+QFkB+g/sumh/Lul31/08m9Jc5t1Yfrvjy4G71OVSXMx7qApB
         tOA6NoF/sDIsYN3l1hYlyiCEmt4CLbnmzf0XpJ0qzwCTJzr8Be1vdps8xRBGozeEa2cG
         /H1Q==
X-Received: by 10.66.163.37 with SMTP id yf5mr12752791pab.115.1364129728267;
        Sun, 24 Mar 2013 05:55:28 -0700 (PDT)
Received: from lanh ([115.74.57.124])
        by mx.google.com with ESMTPS id m18sm10691580pad.17.2013.03.24.05.55.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 05:55:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 24 Mar 2013 19:55:26 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <7vr4j52t0z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218955>

In checkout_paths() we do this

 - for all updated items, call match_pathspec
 - for all items, call match_pathspec (inside unmerge_cache)
 - for all items, call match_pathspec (for showing "path .. is unmerged=
)
 - for updated items, call match_pathspec and update paths

That's a lot of duplicate match_pathspec(s) and the function is not
exactly cheap to be called so many times, especially on large indexes.
This patch makes it call match_pathspec once per updated index entry,
save the result in ce_flags and reuse the results in the following
loops.

The changes in 0a1283b (checkout $tree $path: do not clobber local
changes in $path not in $tree - 2011-09-30) limit the affected paths
to ones we read from $tree. We do not do anything to other modified
entries in this case, so the "for all items" above could be modified
to "for all updated items". But..

The command's behavior now is modified slightly: unmerged entries that
match $path, but not updated by $tree, are now NOT touched.  Although
this should be considered a bug fix, not a regression.

And while at there, free ps_matched after use.

The following command is tested on webkit, 215k entries. The pattern
is chosen mainly to make match_pathspec sweat:

git checkout -- "*[a-zA-Z]*[a-zA-Z]*[a-zA-Z]*"

        before      after
real    0m3.493s    0m2.737s
user    0m2.239s    0m1.586s
sys     0m1.252s    0m1.151s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 > and worry about larger ones later, so if there were another choice,
 > i.e.
 >
 >  - eject nd/magic-pathspecs for now, cook this (and other small
 >    independent and clear improvements you may come up with, some of
 >    which might come out of nd/magic-pathspecs itself) and let it
 >    graduate first, and later revisit rerolld nd/magic-pathspecs
 >
 > that would be the ideal among the given choices ;-).

 Whichever is easier for you.

 > The above is a faithful rewrite, but I have to wonder why you need
 > two separate loops.
 >
 > Do you understand what the original loop is doing with ps_matched,
 > and why the code excludes certain paths while doing so?

 Nope, I did not dig that deep. I expected you to do it ;-) j/k

 > After commenting on the above, it makes me wonder if we even need to
 > bother marking entries that were in the index that did not come from
 > the tree-ish we are checking paths out of, though.  What breaks if
 > you did not do the rewrite above and dropped the second loop in your
 > patch?

 The test suite says none. There is a behavior change regarding
 unmerged entries as mentioned in the commit message. But I think it's
 a good change.

 builtin/checkout.c | 34 +++++++++++++++++++++++++++-------
 cache.h            |  1 +
 resolve-undo.c     | 19 ++++++++++++++++++-
 resolve-undo.h     |  1 +
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..359b983 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -271,24 +271,46 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
 		;
 	ps_matched =3D xcalloc(1, pos);
=20
+	/*
+	 * Make sure all pathspecs participated in locating the paths
+	 * to be checked out.
+	 */
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
+		ce->ce_flags &=3D ~CE_MATCHED;
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
+			/*
+			 * "git checkout tree-ish -- path", but this entry
+			 * is in the original index; it will not be checked
+			 * out to the working tree and it does not matter
+			 * if pathspec matched this entry.  We will not do
+			 * anything to this entry at all.
+			 */
 			continue;
-		match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, ps_match=
ed);
+		/*
+		 * Either this entry came from the tree-ish we are
+		 * checking the paths out of, or we are checking out
+		 * of the index.
+		 */
+		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce),
+				   0, ps_matched))
+			ce->ce_flags |=3D CE_MATCHED;
 	}
=20
-	if (report_path_error(ps_matched, opts->pathspec, opts->prefix))
+	if (report_path_error(ps_matched, opts->pathspec, opts->prefix)) {
+		free(ps_matched);
 		return 1;
+	}
+	free(ps_matched);
=20
 	/* "checkout -m path" to recreate conflicted state */
 	if (opts->merge)
-		unmerge_cache(opts->pathspec);
+		unmerge_marked_index(&the_index);
=20
 	/* Any unmerged paths? */
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
-		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL=
)) {
+		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce))
 				continue;
 			if (opts->force) {
@@ -313,9 +335,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 	state.refresh_cache =3D 1;
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
-		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
-			continue;
-		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL=
)) {
+		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce)) {
 				errs |=3D checkout_entry(ce, &state, NULL);
 				continue;
diff --git a/cache.h b/cache.h
index c56315c..04e6090 100644
--- a/cache.h
+++ b/cache.h
@@ -161,6 +161,7 @@ struct cache_entry {
=20
 #define CE_UNPACKED          (1 << 24)
 #define CE_NEW_SKIP_WORKTREE (1 << 25)
+#define CE_MATCHED           (1 << 26)
=20
 /*
  * Extended on-disk flags
diff --git a/resolve-undo.c b/resolve-undo.c
index 72b4612..639eb9c 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -118,7 +118,7 @@ int unmerge_index_entry_at(struct index_state *ista=
te, int pos)
 	struct cache_entry *ce;
 	struct string_list_item *item;
 	struct resolve_undo_info *ru;
-	int i, err =3D 0;
+	int i, err =3D 0, matched;
=20
 	if (!istate->resolve_undo)
 		return pos;
@@ -137,6 +137,7 @@ int unmerge_index_entry_at(struct index_state *ista=
te, int pos)
 	ru =3D item->util;
 	if (!ru)
 		return pos;
+	matched =3D ce->ce_flags & CE_MATCHED;
 	remove_index_entry_at(istate, pos);
 	for (i =3D 0; i < 3; i++) {
 		struct cache_entry *nce;
@@ -144,6 +145,8 @@ int unmerge_index_entry_at(struct index_state *ista=
te, int pos)
 			continue;
 		nce =3D make_cache_entry(ru->mode[i], ru->sha1[i],
 				       ce->name, i + 1, 0);
+		if (matched)
+			nce->ce_flags |=3D CE_MATCHED;
 		if (add_index_entry(istate, nce, ADD_CACHE_OK_TO_ADD)) {
 			err =3D 1;
 			error("cannot unmerge '%s'", ce->name);
@@ -156,6 +159,20 @@ int unmerge_index_entry_at(struct index_state *ist=
ate, int pos)
 	return unmerge_index_entry_at(istate, pos);
 }
=20
+void unmerge_marked_index(struct index_state *istate)
+{
+	int i;
+
+	if (!istate->resolve_undo)
+		return;
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce =3D istate->cache[i];
+		if (ce->ce_flags & CE_MATCHED)
+			i =3D unmerge_index_entry_at(istate, i);
+	}
+}
+
 void unmerge_index(struct index_state *istate, const char **pathspec)
 {
 	int i;
diff --git a/resolve-undo.h b/resolve-undo.h
index 8458769..7a30206 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -12,5 +12,6 @@ extern struct string_list *resolve_undo_read(const ch=
ar *, unsigned long);
 extern void resolve_undo_clear_index(struct index_state *);
 extern int unmerge_index_entry_at(struct index_state *, int);
 extern void unmerge_index(struct index_state *, const char **);
+extern void unmerge_marked_index(struct index_state *);
=20
 #endif
--=20
1.8.2.83.gc99314b
