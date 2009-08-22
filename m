From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH] ce_uptodate(): discriminate lstat()-based and assume-unchanged uptodate
Date: Sat, 22 Aug 2009 19:43:53 +0700
Message-ID: <1250945033-14059-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 14:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Meq0M-0005Kv-5T
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 14:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbZHVMoD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2009 08:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbZHVMoD
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 08:44:03 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:65005 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbZHVMoA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 08:44:00 -0400
Received: by pzk32 with SMTP id 32so276334pzk.33
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=0YryvAPS385+inyHaBKoqIELxrTo3x4E+9GK5mtW8Z8=;
        b=Etf+EhdU3J3bhTnk/iT0s+LuCZCM4pMzxyVjIDHbEtIOseCxSnygNKAujTrReELgD8
         AI/Gfg2JiMcDIcVPfsZSko0XWQz1U44bO+1LK6KbiKwKF2RGN1JX3q4yhONAXO+f4eYQ
         gtiGRVXyGdQFW/rRRRmAC8Yf2sLlUs+mUf4KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=PoCEXvJkx9O21MOaxLSClE6GCeAmg4lIFXFdqgLkNPnYfNEvANW491lNxFaVBJQlGR
         ImZIkwYmllpzX6Ei7nzVuhuPcdLO2FGINxT7Oh5QCuXG/OzEGyKhV/KBA9VGegQEkkgX
         E/NBp+Fln26rubodGHlFlrbE5tDey+ePE/Kxg=
Received: by 10.114.29.16 with SMTP id c16mr2325841wac.142.1250945041602;
        Sat, 22 Aug 2009 05:44:01 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.218.243])
        by mx.google.com with ESMTPS id k35sm1605768waf.29.2009.08.22.05.43.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Aug 2009 05:44:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 22 Aug 2009 19:43:54 +0700
X-Mailer: git-send-email 1.6.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126810>

Commit 1dcafcc (verify_uptodate(): add ce_uptodate(ce) test) makes me
realize that people might not be well aware of assume-unchanged bit (CE=
_VALID).

Back when there was no assume-unchanged bit, ce_uptodate() means that
entry is really uptodate and has been checked by lstat(). When
assume-unchanged comes into play, it will blindly mark an entry
uptodate if that entry is assume-unchanged.

Even if it is assume-unchanged, it may have local changes that users
may want to keep. Thus when it comes to updating worktree, we may need =
to
know if it is _really_ uptodate regardless assume-unchanged. For that
matter, ce_uptodate() does not help much as it could be a result of
lstat() or assume-unchanged bit.

This patch attempts to make Git developers think twice about that
by.. getting rid of ce_uptodate() in favor of two new macros
ce_maybe_uptodate() and ce_really_uptodate()

 - ce_maybe_uptodate() works as ce_uptodate() does now.
 - ce_really_uptodate() is true only if it is lstat()-based uptodate.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 OK I could not stop looking at CE_VALID :-) I think this is a good
 change. However I may have made mistakes in translating from
 ce_uptodate() to ce_{maybe,really}_uptodate().

 cache.h         |   14 ++++++++++++--
 diff-lib.c      |    6 +++---
 diff.c          |    2 +-
 dir.c           |    4 ++--
 preload-index.c |    4 ++--
 read-cache.c    |   12 ++++++------
 unpack-trees.c  |    4 ++--
 7 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index f793789..24f66ab 100644
--- a/cache.h
+++ b/cache.h
@@ -176,6 +176,7 @@ struct cache_entry {
=20
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
+#define CE_ASSUME_UPTODATE (0x800000)
=20
 /*
  * Extended on-disk flags
@@ -232,8 +233,9 @@ static inline size_t ce_namelen(const struct cache_=
entry *ce)
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT=
)
-#define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
-#define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE)
+#define ce_maybe_uptodate(ce) ((ce)->ce_flags & (CE_UPTODATE | CE_ASSU=
ME_UPTODATE))
+#define ce_really_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
+/* #define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE) */
=20
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
 static inline unsigned int create_ce_mode(unsigned int mode)
@@ -463,6 +465,14 @@ extern int index_name_is_other(const struct index_=
state *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
+static inline void ce_mark_uptodate(struct cache_entry *ce, int option=
s)
+{
+	if ((ce->ce_flags & CE_VALID) && !(options & CE_MATCH_IGNORE_VALID))
+		ce->ce_flags |=3D CE_ASSUME_UPTODATE;
+	else
+		ce->ce_flags |=3D CE_UPTODATE;
+}
+
 extern int ce_path_match(const struct cache_entry *ce, const char **pa=
thspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int =
write_object, enum object_type type, const char *path);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, int write_object);
diff --git a/diff-lib.c b/diff-lib.c
index e7e8e88..9cbfec0 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -159,7 +159,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 				continue;
 		}
=20
-		if (ce_uptodate(ce))
+		if (ce_maybe_uptodate(ce))
 			continue;
=20
 		changed =3D check_removed(ce, &st);
@@ -176,7 +176,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 		}
 		changed =3D ce_match_stat(ce, &st, ce_option);
 		if (!changed) {
-			ce_mark_uptodate(ce);
+			ce_mark_uptodate(ce, ce_option);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 				continue;
 		}
@@ -214,7 +214,7 @@ static int get_stat_data(struct cache_entry *ce,
 	const unsigned char *sha1 =3D ce->sha1;
 	unsigned int mode =3D ce->ce_mode;
=20
-	if (!cached && !ce_uptodate(ce)) {
+	if (!cached && !ce_really_uptodate(ce)) {
 		int changed;
 		struct stat st;
 		changed =3D check_removed(ce, &st);
diff --git a/diff.c b/diff.c
index 91d6ea2..7b94fb9 100644
--- a/diff.c
+++ b/diff.c
@@ -1811,7 +1811,7 @@ static int reuse_worktree_file(const char *name, =
const unsigned char *sha1, int
 	/*
 	 * If ce matches the file in the work tree, we can reuse it.
 	 */
-	if (ce_uptodate(ce) ||
+	if (ce_really_uptodate(ce) ||
 	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
 		return 1;
=20
diff --git a/dir.c b/dir.c
index d0999ba..64f0fc6 100644
--- a/dir.c
+++ b/dir.c
@@ -573,7 +573,7 @@ static int get_index_dtype(const char *path, int le=
n)
=20
 	ce =3D cache_name_exists(path, len, 0);
 	if (ce) {
-		if (!ce_uptodate(ce))
+		if (!ce_maybe_uptodate(ce))
 			return DT_UNKNOWN;
 		if (S_ISGITLINK(ce->ce_mode))
 			return DT_DIR;
@@ -597,7 +597,7 @@ static int get_index_dtype(const char *path, int le=
n)
 			break;
 		if (ce->name[len] < '/')
 			continue;
-		if (!ce_uptodate(ce))
+		if (!ce_maybe_uptodate(ce))
 			break;	/* continue? */
 		return DT_DIR;
 	}
diff --git a/preload-index.c b/preload-index.c
index 9289933..85c31c5 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -47,7 +47,7 @@ static void *preload_thread(void *_data)
=20
 		if (ce_stage(ce))
 			continue;
-		if (ce_uptodate(ce))
+		if (ce_maybe_uptodate(ce))
 			continue;
 		if (!ce_path_match(ce, p->pathspec))
 			continue;
@@ -57,7 +57,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
 			continue;
-		ce_mark_uptodate(ce);
+		ce_mark_uptodate(ce, 0);
 	} while (--nr > 0);
 	return NULL;
 }
diff --git a/read-cache.c b/read-cache.c
index 4e3e272..ac7cdd3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -81,7 +81,7 @@ void fill_stat_cache_info(struct cache_entry *ce, str=
uct stat *st)
 		ce->ce_flags |=3D CE_VALID;
=20
 	if (S_ISREG(st->st_mode))
-		ce_mark_uptodate(ce);
+		ce_mark_uptodate(ce, CE_MATCH_IGNORE_VALID);
 }
=20
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
@@ -605,7 +605,7 @@ int add_to_index(struct index_state *istate, const =
char *path, struct stat *st,
 	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce=
_option)) {
 		/* Nothing changed, really */
 		free(ce);
-		ce_mark_uptodate(alias);
+		ce_mark_uptodate(alias, ce_option);
 		alias->ce_flags |=3D CE_ADDED;
 		return 0;
 	}
@@ -1001,7 +1001,7 @@ static struct cache_entry *refresh_cache_ent(stru=
ct index_state *istate,
 	int changed, size;
 	int ignore_valid =3D options & CE_MATCH_IGNORE_VALID;
=20
-	if (ce_uptodate(ce))
+	if (ce_maybe_uptodate(ce))
 		return ce;
=20
 	/*
@@ -1009,7 +1009,7 @@ static struct cache_entry *refresh_cache_ent(stru=
ct index_state *istate,
 	 * the work tree does not matter and told us not to worry.
 	 */
 	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
-		ce_mark_uptodate(ce);
+		ce_mark_uptodate(ce, options);
 		return ce;
 	}
=20
@@ -1037,7 +1037,7 @@ static struct cache_entry *refresh_cache_ent(stru=
ct index_state *istate,
 			 * because CE_UPTODATE flag is in-core only;
 			 * we are not going to write this change out.
 			 */
-			ce_mark_uptodate(ce);
+			ce_mark_uptodate(ce, options);
 			return ce;
 		}
 	}
@@ -1543,7 +1543,7 @@ int write_index(struct index_state *istate, int n=
ewfd)
 		struct cache_entry *ce =3D cache[i];
 		if (ce->ce_flags & CE_REMOVE)
 			continue;
-		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
+		if (!ce_maybe_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
 		if (ce_write_entry(&c, newfd, ce) < 0)
 			return -1;
diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..c0774d7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -450,7 +450,7 @@ static int verify_uptodate(struct cache_entry *ce,
 {
 	struct stat st;
=20
-	if (o->index_only || o->reset || ce_uptodate(ce))
+	if (o->index_only || o->reset || ce_really_uptodate(ce))
 		return 0;
=20
 	if (!lstat(ce->name, &st)) {
@@ -1004,7 +1004,7 @@ int oneway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
=20
 	if (old && same(old, a)) {
 		int update =3D 0;
-		if (o->reset && !ce_uptodate(old)) {
+		if (o->reset && !ce_really_uptodate(old)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
--=20
1.6.3.GIT
