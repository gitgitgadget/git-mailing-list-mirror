From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] checkout: avoid unncessary match_pathspec calls
Date: Sat, 23 Mar 2013 17:55:42 +0700
Message-ID: <1364036142-3031-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 11:56:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJM7S-0003lm-Lw
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 11:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660Ab3CWKzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Mar 2013 06:55:47 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:51781 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab3CWKzq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 06:55:46 -0400
Received: by mail-pd0-f171.google.com with SMTP id 10so1968413pdc.30
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Jz/qzKhWnEcLgOhxoZu1Jbh9CosrmhPsrtqaidPY+yA=;
        b=ZtKeBRXPa8+a2nOSlPTOykq/7PT/gJmQQqvVkx0m3cqfAu4WL5T1wb9OylgwoG/ZQW
         oh0f7F6ojxqTWsE8ryHcS+1r4yI/ZvCXqAtdGIdPD+HtiS4+xZpFpIEbCZ1bUvL5eb/H
         x/hobk1XxWVd7pAuQt2a9ZNd85VZ2C0DTJmS3XwAYen0mmLaQ+qIdcG8FlQIy2PT7zik
         iMimllUdvPSro4kh+XsgbGZN+HNuK9FRqUqJBsC3+ILHGoWbeS2S/GQNp8cR52DZbGBn
         EMJeP2XEiJGkwukes10nvVKBeBAUwIY4IfTSh9zM11e4Xn5r3zrq5WCwDNzdewUV6Qk6
         v4dg==
X-Received: by 10.66.241.106 with SMTP id wh10mr7872856pac.143.1364036145622;
        Sat, 23 Mar 2013 03:55:45 -0700 (PDT)
Received: from lanh ([115.74.37.60])
        by mx.google.com with ESMTPS id z1sm5795897pbw.19.2013.03.23.03.55.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Mar 2013 03:55:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 23 Mar 2013 17:55:44 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218907>

In checkout_paths() we do this

 - for i =3D 0..active_nr, if not updated, call match_pathspec
 - for ..., call match_pathspec (inside unmerge_cache)
 - for ..., call match_pathspec (for showing "path .. is unmerged)
 - for ..., if not updated, call match_pathspec and update paths

That's a lot of duplicate match_pathspec(s) and the function is not
exactly cheap to be called so many times, especially on large indexes.
This patch makes it call match_pathspec once per index entry, save the
result in ce_flags and reuse the results in the following loops.

This command is used on webkit, 215k entries. The pattern is chosen
mainly to make match_pathspec sweat:

git checkout -- "*[a-zA-Z]*[a-zA-Z]*[a-zA-Z]*"

        before      after
real    0m3.493s    0m2.737s
user    0m2.239s    0m1.586s
sys     0m1.252s    0m1.151s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Junio, this patch clearly conflicts wih nd/magic-pathspecs. Do you
 want me to:

  - hold it off until nd/magic-pathspecs graduates
  - rebase on top of nd/magic-pathspecs and repost
  - leave it to you to handle conflicts

 ?

 builtin/checkout.c | 23 +++++++++++++++++++----
 cache.h            |  1 +
 resolve-undo.c     | 19 ++++++++++++++++++-
 resolve-undo.h     |  1 +
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..fadc11b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -273,22 +273,37 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
=20
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
+		ce->ce_flags &=3D ~CE_MATCHED;
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
-		match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, ps_match=
ed);
+		if (match_pathspec(opts->pathspec, ce->name,
+				   ce_namelen(ce), 0, ps_matched))
+			ce->ce_flags |=3D CE_MATCHED;
 	}
=20
 	if (report_path_error(ps_matched, opts->pathspec, opts->prefix))
 		return 1;
=20
+	/*
+	 * call match_pathspec on the remaining entries that have not
+	 * been done in the previous loop
+	 */
+	for (pos =3D 0; pos < active_nr; pos++) {
+		struct cache_entry *ce =3D active_cache[pos];
+		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE) &&
+		    match_pathspec(opts->pathspec, ce->name,
+				   ce_namelen(ce), 0, ps_matched))
+			ce->ce_flags |=3D CE_MATCHED;
+	}
+
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
@@ -315,7 +330,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		struct cache_entry *ce =3D active_cache[pos];
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
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
