From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 19/26] Wrap CE_VALID test with ce_valid()
Date: Mon,  3 Feb 2014 11:29:07 +0700
Message-ID: <1391401754-15347-20-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:31:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABBi-0001Sr-OE
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbaBCEbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:31:09 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:44789 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbaBCEbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:31:08 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so6580393pbc.16
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FCLnD++9EMAQrKpXEPkQ7r1fDTIoJ+wgyM8SgDfGiTo=;
        b=E36fz58RrbIhVOEwwLVrM7uVkRU5cKxY3KUZ/FfXIs7OIYfDs/r7Dv1XySfLw+Tt5+
         mrcjWIDGIkGxPjHC1ZJQu1r+kLdIQCl/LqyJOWV5uF7No3XJ0bPWAxmpQZcTDy9jk9nG
         q5WhOX8gTxnuv9xl0mZEOIcwnmZOVuO3tUBupccQ6yFRWM9TGptax/Nsdy4U3OrWU2uH
         NVYBKmCSXbkdqs3guZYhHMtQojd1n3G5eqSnylgfAXgdTt67KGnvGVE2i4z/KMR1b/pl
         nD+ojjscXrZ5yiW2kkC35yO6jU2urNFHTfPibRnTE95rau+55t23ah2jmWqhyf3Ofp48
         tShw==
X-Received: by 10.68.241.198 with SMTP id wk6mr35120108pbc.11.1391401868205;
        Sun, 02 Feb 2014 20:31:08 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id ei4sm51419588pbb.42.2014.02.02.20.31.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:31:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:31:06 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241414>

The next patch wants to ignore CE_VALID under some condition but not
really clears it. Centralizing its access makes such a change easier.

Not all "ce_flags & CE_VALID" is converted though. The tests that
really mean _bit_ CE_VALID remains so. The tests that mean "ignore
worktree" are converted.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 2 +-
 cache.h        | 4 ++++
 diff-lib.c     | 4 ++--
 diff.c         | 2 +-
 read-cache.c   | 6 +++---
 unpack-trees.c | 2 +-
 6 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 63f8603..00526a1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -386,7 +386,7 @@ static int grep_cache(struct grep_opt *opt, const s=
truct pathspec *pathspec, int
 		 * are identical, even if worktree file has been modified, so use
 		 * cache version instead
 		 */
-		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
+		if (cached || ce_valid(ce) || ce_skip_worktree(ce)) {
 			if (ce_stage(ce))
 				continue;
 			hit |=3D grep_sha1(opt, ce->sha1, ce->name, 0, ce->name);
diff --git a/cache.h b/cache.h
index 9f7d952..c229bf9 100644
--- a/cache.h
+++ b/cache.h
@@ -222,6 +222,10 @@ static inline unsigned create_ce_flags(unsigned st=
age)
 #define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE)
+static inline int ce_valid(const struct cache_entry *ce)
+{
+	return ce->ce_flags & CE_VALID;
+}
=20
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
 static inline unsigned int create_ce_mode(unsigned int mode)
diff --git a/diff-lib.c b/diff-lib.c
index 346cac6..dcda7f3 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -198,7 +198,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 			continue;
=20
 		/* If CE_VALID is set, don't look at workdir for file removal */
-		changed =3D (ce->ce_flags & CE_VALID) ? 0 : check_removed(ce, &st);
+		changed =3D ce_valid(ce) ? 0 : check_removed(ce, &st);
 		if (changed) {
 			if (changed < 0) {
 				perror(ce->name);
@@ -369,7 +369,7 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
=20
 	/* if the entry is not checked out, don't examine work tree */
 	cached =3D o->index_only ||
-		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
+		(idx && (ce_valid(idx) || ce_skip_worktree(idx)));
 	/*
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but "match_missing".
diff --git a/diff.c b/diff.c
index 8e4a6a9..22c73fe 100644
--- a/diff.c
+++ b/diff.c
@@ -2636,7 +2636,7 @@ static int reuse_worktree_file(const char *name, =
const unsigned char *sha1, int
 	 * If ce is marked as "assume unchanged", there is no
 	 * guarantee that work tree matches what we are looking for.
 	 */
-	if ((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce))
+	if (ce_valid(ce) || ce_skip_worktree(ce))
 		return 0;
=20
 	/*
diff --git a/read-cache.c b/read-cache.c
index 5540b06..95c9ccb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -289,8 +289,8 @@ int ie_match_stat(const struct index_state *istate,
 	 */
 	if (!ignore_skip_worktree && ce_skip_worktree(ce))
 		return 0;
-	if (!ignore_valid && (ce->ce_flags & CE_VALID))
-		return 0;
+	if (!ignore_valid && ce_valid(ce))
+			return 0;
=20
 	/*
 	 * Intent-to-add entries have not been added, so the index entry
@@ -1047,7 +1047,7 @@ static struct cache_entry *refresh_cache_ent(stru=
ct index_state *istate,
 		ce_mark_uptodate(ce);
 		return ce;
 	}
-	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
+	if (!ignore_valid && ce_valid(ce)) {
 		ce_mark_uptodate(ce);
 		return ce;
 	}
diff --git a/unpack-trees.c b/unpack-trees.c
index 164354d..61c3f35 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1215,7 +1215,7 @@ static int verify_uptodate_1(const struct cache_e=
ntry *ce,
 	 * if this entry is truly up-to-date because this file may be
 	 * overwritten.
 	 */
-	if ((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce))
+	if (ce_valid(ce) || ce_skip_worktree(ce))
 		; /* keep checking */
 	else if (o->reset || ce_uptodate(ce))
 		return 0;
--=20
1.8.5.2.240.g8478abd
