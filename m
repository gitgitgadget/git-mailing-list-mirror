From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] ie_match_stat(): do not ignore skip-worktree bit with CE_MATCH_IGNORE_VALID
Date: Mon, 14 Dec 2009 18:43:58 +0700
Message-ID: <1260791039-12316-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Dec 14 12:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK9MC-0003NU-Ro
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 12:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983AbZLNLos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 06:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756981AbZLNLos
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 06:44:48 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:61101 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756970AbZLNLor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 06:44:47 -0500
Received: by pxi4 with SMTP id 4so1727463pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 03:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=NCodpQ5bAWZlRTX7UknK6TQsrh/CYfjENS4IHhczlas=;
        b=A4/0ihNx4dZj7SuBnZt2WiczYADeoLk4Uedd6rXMXivMmo9JiKKRPP3r1IuM0Tu8Tv
         21WdDysIhA+AGvu3V0ryrtLryw/hp5UANUwQv/XgOfJwtardwGXFFeDUwxU68Rc69Np1
         koXMHeszRgvg2ibUphysM5TBkKTt/7gXV2BXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=tPWo4A5Mjh+0T48tVkTbnGX7Qk6C1V/uLMN2RXwWeOVgkNQCcwPfKWKVKbAByMInnO
         iZwaSMkuP9UJVh5u5gTcjqwbbdFU6Qy7RKHqBJj1YN8UICekif6ix3LyPP4r5Xhoes4z
         u1b+E+TBlbWdET2HDsVdWlsv598QojD5ZoBFs=
Received: by 10.115.102.5 with SMTP id e5mr3071328wam.210.1260791087040;
        Mon, 14 Dec 2009 03:44:47 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 22sm4946850pzk.14.2009.12.14.03.44.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 03:44:46 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 18:44:05 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135203>

Previously CE_MATCH_IGNORE_VALID flag is used by both valid and
skip-worktree bits. While the two bits have similar behaviour, sharing
this flag means "git update-index --really-refresh" will ignore
skip-worktree while it should not. Instead another flag is
introduced to ignore skip-worktree bit, CE_MATCH_IGNORE_VALID only
applies to valid bit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-apply.c |    2 +-
 cache.h         |    4 +++-
 entry.c         |    2 +-
 read-cache.c    |   21 ++++++++++++++++++---
 unpack-trees.c  |    6 +++---
 5 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 36e2f9d..541493e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2666,7 +2666,7 @@ static int verify_index_match(struct cache_entry =
*ce, struct stat *st)
 			return -1;
 		return 0;
 	}
-	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID);
+	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SK=
IP_WORKTREE);
 }
=20
 static int check_preimage(struct patch *patch, struct cache_entry **ce=
, struct stat *st)
diff --git a/cache.h b/cache.h
index 0e69384..1341475 100644
--- a/cache.h
+++ b/cache.h
@@ -469,7 +469,9 @@ extern int index_name_is_other(const struct index_s=
tate *, const char *, int);
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
 /* do not check the contents but report dirty on racily-clean entries =
*/
-#define CE_MATCH_RACY_IS_DIRTY	02
+#define CE_MATCH_RACY_IS_DIRTY		02
+/* do stat comparison even if CE_SKIP_WORKTREE is true */
+#define CE_MATCH_IGNORE_SKIP_WORKTREE	04
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
diff --git a/entry.c b/entry.c
index 06d24f1..9d5b232 100644
--- a/entry.c
+++ b/entry.c
@@ -206,7 +206,7 @@ int checkout_entry(struct cache_entry *ce, const st=
ruct checkout *state, char *t
 	len +=3D ce_namelen(ce);
=20
 	if (!check_path(path, len, &st, state->base_dir_len)) {
-		unsigned changed =3D ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
+		unsigned changed =3D ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE=
_MATCH_IGNORE_SKIP_WORKTREE);
 		if (!changed)
 			return 0;
 		if (!state->force) {
diff --git a/read-cache.c b/read-cache.c
index 7a2385b..b5c66f9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -259,13 +259,18 @@ int ie_match_stat(const struct index_state *istat=
e,
 {
 	unsigned int changed;
 	int ignore_valid =3D options & CE_MATCH_IGNORE_VALID;
+	int ignore_skip_worktree =3D options & CE_MATCH_IGNORE_SKIP_WORKTREE;
 	int assume_racy_is_modified =3D options & CE_MATCH_RACY_IS_DIRTY;
=20
 	/*
 	 * If it's marked as always valid in the index, it's
 	 * valid whatever the checked-out copy says.
+	 *
+	 * skip-worktree has the same effect with higher precedence
 	 */
-	if (!ignore_valid && ((ce->ce_flags & CE_VALID) || ce_skip_worktree(c=
e)))
+	if (!ignore_skip_worktree && ce_skip_worktree(ce))
+		return 0;
+	if (!ignore_valid && (ce->ce_flags & CE_VALID))
 		return 0;
=20
 	/*
@@ -564,7 +569,7 @@ int add_to_index(struct index_state *istate, const =
char *path, struct stat *st,
 	int size, namelen, was_same;
 	mode_t st_mode =3D st->st_mode;
 	struct cache_entry *ce, *alias;
-	unsigned ce_option =3D CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
+	unsigned ce_option =3D CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WOR=
KTREE|CE_MATCH_RACY_IS_DIRTY;
 	int verbose =3D flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
 	int pretend =3D flags & ADD_CACHE_PRETEND;
 	int intent_only =3D flags & ADD_CACHE_INTENT;
@@ -1000,11 +1005,21 @@ static struct cache_entry *refresh_cache_ent(st=
ruct index_state *istate,
 	struct cache_entry *updated;
 	int changed, size;
 	int ignore_valid =3D options & CE_MATCH_IGNORE_VALID;
+	int ignore_skip_worktree =3D options & CE_MATCH_IGNORE_SKIP_WORKTREE;
=20
 	if (ce_uptodate(ce))
 		return ce;
=20
-	if (!ignore_valid && ((ce->ce_flags & CE_VALID) || ce_skip_worktree(c=
e))) {
+	/*
+	 * CE_VALID or CE_SKIP_WORKTREE means the user promised us
+	 * that the change to the work tree does not matter and told
+	 * us not to worry.
+	 */
+	if (!ignore_skip_worktree && ce_skip_worktree(ce)) {
+		ce_mark_uptodate(ce);
+		return ce;
+	}
+	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
 		ce_mark_uptodate(ce);
 		return ce;
 	}
diff --git a/unpack-trees.c b/unpack-trees.c
index ae1de3f..7570475 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -569,7 +569,7 @@ static int verify_uptodate_1(struct cache_entry *ce=
,
 		return 0;
=20
 	if (!lstat(ce->name, &st)) {
-		unsigned changed =3D ie_match_stat(o->src_index, ce, &st, CE_MATCH_I=
GNORE_VALID);
+		unsigned changed =3D ie_match_stat(o->src_index, ce, &st, CE_MATCH_I=
GNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 		if (!changed)
 			return 0;
 		/*
@@ -701,7 +701,7 @@ static int icase_exists(struct unpack_trees_options=
 *o, struct cache_entry *dst,
 	struct cache_entry *src;
=20
 	src =3D index_name_exists(o->src_index, dst->name, ce_namelen(dst), 1=
);
-	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_V=
ALID);
+	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_V=
ALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
=20
 /*
@@ -1152,7 +1152,7 @@ int oneway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
 		if (o->reset && !ce_uptodate(old) && !ce_skip_worktree(old)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
-			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
+			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_=
MATCH_IGNORE_SKIP_WORKTREE))
 				update |=3D CE_UPDATE;
 		}
 		add_entry(o, old, update, 0);
--=20
1.6.5.2.216.g9c1ec
