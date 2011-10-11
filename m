From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] Implement negative pathspec
Date: Wed, 12 Oct 2011 09:44:43 +1100
Message-ID: <1318373083-13840-7-git-send-email-pclouds@gmail.com>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 00:45:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDl50-00073A-3c
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652Ab1JKWpl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 18:45:41 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35345 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab1JKWpl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:45:41 -0400
Received: by mail-vx0-f174.google.com with SMTP id gb30so85726vcb.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=z33httFhO160mC7kpOYlmu/yKd9zI75JMVCG6Q7K8J8=;
        b=TiVtHyDgjCtUryvU1JWVViY+SvLhMtE/BkDVf0wirVjnArcChY4CrJ0eGQ1WvbW9in
         asNLTNWkYXuDp0xfFStz5lY3JETjt+bR8kzJNDGcTpsIdNShOCmN5HPc3PHXPkGp/IOi
         AN15kvCmloNP2TQqdfZ02ipa61qClx3yyYgg0=
Received: by 10.52.75.102 with SMTP id b6mr21000697vdw.90.1318373140820;
        Tue, 11 Oct 2011 15:45:40 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id hl5sm155132vdb.18.2011.10.11.15.45.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 15:45:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 12 Oct 2011 09:45:33 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183340>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I really like the mnemonic ^ but it's regex. ":^Documentation" looks
 nicer than ":~Documentation". Do we plan on supporting regex in
 pathspec too?

 We should mention these magic in a less obscure document. Glossary is
 mostly for developer discussions. git-diff may be a good place
 because it's one of the two frequently used commands (the other one
 is grep) that benefit magic the most (with a short reference from
 git.txt)

 Documentation/glossary-content.txt |    8 +++---
 cache.h                            |    1 +
 dir.c                              |    2 +
 setup.c                            |    1 +
 tree-walk.c                        |   37 ++++++++++++++++++++++++++++=
+++++--
 5 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index 3595b58..9a2765d 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -319,12 +319,12 @@ top `/`;;
 	The magic word `top` (mnemonic: `/`) makes the pattern match
 	from the root of the working tree, even when you are running
 	the command from inside a subdirectory.
+
+exclude `~`;;
+	The magic word `exclude` (mnemonic: `~`) excludes paths that
+	match the pattern.
 --
 +
-Currently only the slash `/` is recognized as the "magic signature",
-but it is envisioned that we will support more types of magic in later
-versions of git.
-+
 A pathspec with only a colon means "there is no pathspec". This form
 should not be combined with other pathspec.
=20
diff --git a/cache.h b/cache.h
index 719d4a3..75fe589 100644
--- a/cache.h
+++ b/cache.h
@@ -541,6 +541,7 @@ extern int ie_modified(const struct index_state *, =
struct cache_entry *, struct
  */
 #define PATHSPEC_FROMTOP    (1<<0)
 #define PATHSPEC_NOGLOB     (1<<1)
+#define PATHSPEC_NEGATE     (1<<2)
=20
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
diff --git a/dir.c b/dir.c
index d38af0f..46dd35f 100644
--- a/dir.c
+++ b/dir.c
@@ -1305,6 +1305,8 @@ int parse_pathspec(struct pathspec *pathspec, con=
st char *prefix,
 				pitem->magic |=3D PATHSPEC_NOGLOB;
 			else
 				pathspec->magic &=3D ~PATHSPEC_NOGLOB;
+			if (pitem->magic & PATHSPEC_NEGATE)
+				pathspec->magic |=3D PATHSPEC_NEGATE;
 			pitem++;
 			dst++;
 		}
diff --git a/setup.c b/setup.c
index b074210..42beb9b 100644
--- a/setup.c
+++ b/setup.c
@@ -111,6 +111,7 @@ static struct pathspec_magic {
 	const char *name;
 } pathspec_magic[] =3D {
 	{ PATHSPEC_FROMTOP, '/', "top" },
+	{ PATHSPEC_NEGATE, '~', "exclude" },
 };
=20
 /*
diff --git a/tree-walk.c b/tree-walk.c
index db07fd6..936b5da 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -580,15 +580,17 @@ static int match_dir_prefix(const char *base, int=
 baselen,
  *  - zero for no
  *  - negative for "no, and no subsequent entries will be either"
  */
-int tree_entry_interesting(const struct name_entry *entry,
-			   struct strbuf *base, int base_offset,
-			   const struct pathspec *ps)
+static int tree_entry_interesting_1(const struct name_entry *entry,
+				    struct strbuf *base, int base_offset,
+				    const struct pathspec *ps, int negative_magic)
 {
 	int i;
 	int pathlen, baselen =3D base->len - base_offset;
 	int never_interesting =3D ps->magic & PATHSPEC_NOGLOB ? -1 : 0;
+	int has_effective_pathspec =3D 0;
=20
 	if (!ps->nr) {
+no_pathspec:
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
 			return 2;
 		return !!within_depth(base->buf + base_offset, baselen,
@@ -604,6 +606,12 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
 		const char *base_str =3D base->buf + base_offset;
 		int matchlen =3D item->len;
=20
+		if ((!negative_magic && !(item->magic & PATHSPEC_NEGATE)) ||
+		    ( negative_magic &&  (item->magic & PATHSPEC_NEGATE)))
+			has_effective_pathspec =3D 1;
+		else
+			continue;
+
 		if (baselen >=3D matchlen) {
 			/* If it doesn't match, move along... */
 			if (!match_dir_prefix(base_str, baselen, match, matchlen))
@@ -663,5 +671,28 @@ match_wildcards:
 		if (ps->recursive && S_ISDIR(entry->mode))
 			return 1;
 	}
+
+	/* the same effect with ps->nr =3D=3D 0 */
+	if (!has_effective_pathspec)
+		goto no_pathspec;
+
 	return never_interesting; /* No matches */
 }
+
+int tree_entry_interesting(const struct name_entry *entry,
+			   struct strbuf *base, int base_offset,
+			   const struct pathspec *ps)
+{
+	int next_ret, ret;
+
+	ret =3D tree_entry_interesting_1(entry, base, base_offset, ps, 0);
+	if (ps->magic & PATHSPEC_NEGATE) {
+		next_ret =3D tree_entry_interesting_1(entry, base, base_offset, ps, =
1);
+		switch (next_ret) {
+		case 2: ret =3D -1; break;
+		case 1: ret =3D 0; break;
+		default: break;
+		}
+	}
+	return ret;
+}
--=20
1.7.3.1.256.g2539c.dirty
