From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/7] read-cache: mark cache_entry pointers const
Date: Thu, 30 May 2013 13:34:19 +0200
Message-ID: <1369913664-49734-3-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 13:34:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui180-0006iS-TJ
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 13:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758Ab3E3Leh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 07:34:37 -0400
Received: from india601.server4you.de ([85.25.151.105]:57595 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183Ab3E3Leb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 07:34:31 -0400
Received: from debian.Speedport_W_504V_Typ_A (p579BEB6E.dip0.t-ipconnect.de [87.155.235.110])
	by india601.server4you.de (Postfix) with ESMTPSA id 8CB52432;
	Thu, 30 May 2013 13:34:29 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225960>

ie_match_stat and ie_modified only derefence their struct cache_entry
pointers for reading.  Add const to the parameter declaration here and
do the same for the static helper function used by them, as it's the
same there as well.  This allows callers to pass in const pointers.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 cache.h      |  4 ++--
 read-cache.c | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 43a27e7..01e8760 100644
--- a/cache.h
+++ b/cache.h
@@ -482,8 +482,8 @@ extern void *read_blob_data_from_index(struct index=
_state *, const char *, unsig
 #define CE_MATCH_RACY_IS_DIRTY		02
 /* do stat comparison even if CE_SKIP_WORKTREE is true */
 #define CE_MATCH_IGNORE_SKIP_WORKTREE	04
-extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
-extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
+extern int ie_match_stat(const struct index_state *, const struct cach=
e_entry *, struct stat *, unsigned int);
+extern int ie_modified(const struct index_state *, const struct cache_=
entry *, struct stat *, unsigned int);
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
diff --git a/read-cache.c b/read-cache.c
index 04ed561..e6e0466 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -91,7 +91,7 @@ void fill_stat_cache_info(struct cache_entry *ce, str=
uct stat *st)
 		ce_mark_uptodate(ce);
 }
=20
-static int ce_compare_data(struct cache_entry *ce, struct stat *st)
+static int ce_compare_data(const struct cache_entry *ce, struct stat *=
st)
 {
 	int match =3D -1;
 	int fd =3D open(ce->name, O_RDONLY);
@@ -105,7 +105,7 @@ static int ce_compare_data(struct cache_entry *ce, =
struct stat *st)
 	return match;
 }
=20
-static int ce_compare_link(struct cache_entry *ce, size_t expected_siz=
e)
+static int ce_compare_link(const struct cache_entry *ce, size_t expect=
ed_size)
 {
 	int match =3D -1;
 	void *buffer;
@@ -126,7 +126,7 @@ static int ce_compare_link(struct cache_entry *ce, =
size_t expected_size)
 	return match;
 }
=20
-static int ce_compare_gitlink(struct cache_entry *ce)
+static int ce_compare_gitlink(const struct cache_entry *ce)
 {
 	unsigned char sha1[20];
=20
@@ -143,7 +143,7 @@ static int ce_compare_gitlink(struct cache_entry *c=
e)
 	return hashcmp(sha1, ce->sha1);
 }
=20
-static int ce_modified_check_fs(struct cache_entry *ce, struct stat *s=
t)
+static int ce_modified_check_fs(const struct cache_entry *ce, struct s=
tat *st)
 {
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
@@ -163,7 +163,7 @@ static int ce_modified_check_fs(struct cache_entry =
*ce, struct stat *st)
 	return 0;
 }
=20
-static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st=
)
+static int ce_match_stat_basic(const struct cache_entry *ce, struct st=
at *st)
 {
 	unsigned int changed =3D 0;
=20
@@ -239,7 +239,8 @@ static int ce_match_stat_basic(struct cache_entry *=
ce, struct stat *st)
 	return changed;
 }
=20
-static int is_racy_timestamp(const struct index_state *istate, struct =
cache_entry *ce)
+static int is_racy_timestamp(const struct index_state *istate,
+			     const struct cache_entry *ce)
 {
 	return (!S_ISGITLINK(ce->ce_mode) &&
 		istate->timestamp.sec &&
@@ -255,7 +256,7 @@ static int is_racy_timestamp(const struct index_sta=
te *istate, struct cache_entr
 }
=20
 int ie_match_stat(const struct index_state *istate,
-		  struct cache_entry *ce, struct stat *st,
+		  const struct cache_entry *ce, struct stat *st,
 		  unsigned int options)
 {
 	unsigned int changed;
@@ -311,7 +312,8 @@ int ie_match_stat(const struct index_state *istate,
 }
=20
 int ie_modified(const struct index_state *istate,
-		struct cache_entry *ce, struct stat *st, unsigned int options)
+		const struct cache_entry *ce,
+		struct stat *st, unsigned int options)
 {
 	int changed, changed_fs;
=20
--=20
1.8.3
