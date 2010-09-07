From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH] tree.c: Nuke match_tree_entry(), it just duplicates tree_entry_interesting()
Date: Mon,  6 Sep 2010 19:53:39 -0600
Message-ID: <1283824419-21730-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 03:52:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsnM7-000863-2D
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 03:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675Ab0IGBwO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 21:52:14 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51584 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab0IGBwL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 21:52:11 -0400
Received: by qyk36 with SMTP id 36so2918990qyk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 18:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=jAnT0rabx4i4L8fkPYZus4y/qct1HWq9RUOEAMU9hgQ=;
        b=hoaDMevR101W5Kz5CjEKuh1ZVsB8AfoycLd3mov1UPs8stfL4TUe0lwNvO5aLU4SI1
         kFTL2oohsjQ8QFL7gfp6i+6rNWjntlvC6/viqKZ0HsGK4Z9xyv9L5xVhGUPQ4JOuYW24
         P7PXeftCM2O0TeXrjAn1lhvIMcwk2zEhZEmnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=mdONqkDc03Q8cp3iyVF8qmRAfiHyYpaDUCdKI1+fNOBCHxsIPvxtctP0dTEBKqfjJC
         97xb6cRuXb4QZEAN+A1GNd5EbYODMVSr7j5JZZCi9DPAJFD4pjZE2u9RYRn4BsQ0B+P2
         hb5a1AxmRN9w+x1CI8H9+D5nW4UaI7l88hmzI=
Received: by 10.224.54.143 with SMTP id q15mr13912qag.395.1283824330495;
        Mon, 06 Sep 2010 18:52:10 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r1sm6419859qcq.46.2010.09.06.18.52.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 18:52:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc0.1.g43ab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155661>

WARNING: RFC because: This has a minor conflict with my sparse-clone
series, and a less minor conflict with Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy's updates to
the en/object-list-with-pathspec series.  Duy's changes to
en/object-list-with-pathspec, at least with my additional suggestions,
should probably also be applied to en/tree-walk-optim for
skip_uninteresting.  If all that other stuff is done, this particular p=
atch
could be made smaller and we could nuke the FIXME.  That'd make it into=
 a
simple code cleanup.  I'm sending right now for comments, before I forg=
et
about this simple cleanup.

I'll clean up and resend once Duy is done with his changes.

---
 tree-diff.c |    2 +-
 tree-walk.h |    3 ++
 tree.c      |   77 ++++++++++++++++++---------------------------------=
-------
 3 files changed, 28 insertions(+), 54 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index cd659c6..2fb670b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -91,7 +91,7 @@ static int compare_tree_entry(struct tree_desc *t1, s=
truct tree_desc *t2, const
  *  - zero for no
  *  - negative for "no, and no subsequent entries will be either"
  */
-static int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt)
+int tree_entry_interesting(struct tree_desc *desc, const char *base, i=
nt baselen, struct diff_options *opt)
 {
 	const char *path;
 	const unsigned char *sha1;
diff --git a/tree-walk.h b/tree-walk.h
index 7e3e0b5..e3e0137 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -60,4 +60,7 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
+struct diff_options;
+extern int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt);
+
 #endif
diff --git a/tree.c b/tree.c
index 5ab90af..405f56b 100644
--- a/tree.c
+++ b/tree.c
@@ -5,6 +5,13 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
+/*
+ * FIXME: Shouldn't need diff.h, but need it now for skip_uninterestin=
g and
+ * diff_options; Nguyen's pending update to en/object-list-with-pathsp=
ec may
+ * fix this need, if coupled with my suggestion and a similar fix for
+ * skip_uninteresting...
+ */
+#include "diff.h"
=20
 const char *tree_type =3D "tree";
=20
@@ -45,71 +52,35 @@ static int read_one_entry_quick(const unsigned char=
 *sha1, const char *base, int
 				  ADD_CACHE_JUST_APPEND);
 }
=20
-static int match_tree_entry(const char *base, int baselen, const char =
*path, unsigned int mode, const char **paths)
-{
-	const char *match;
-	int pathlen;
-
-	if (!paths)
-		return 1;
-	pathlen =3D strlen(path);
-	while ((match =3D *paths++) !=3D NULL) {
-		int matchlen =3D strlen(match);
-
-		if (baselen >=3D matchlen) {
-			/* If it doesn't match, move along... */
-			if (strncmp(base, match, matchlen))
-				continue;
-			/* pathspecs match only at the directory boundaries */
-			if (!matchlen ||
-			    baselen =3D=3D matchlen ||
-			    base[matchlen] =3D=3D '/' ||
-			    match[matchlen - 1] =3D=3D '/')
-				return 1;
-			continue;
-		}
-
-		/* Does the base match? */
-		if (strncmp(base, match, baselen))
-			continue;
-
-		match +=3D baselen;
-		matchlen -=3D baselen;
-
-		if (pathlen > matchlen)
-			continue;
-
-		if (matchlen > pathlen) {
-			if (match[pathlen] !=3D '/')
-				continue;
-			if (!S_ISDIR(mode))
-				continue;
-		}
-
-		if (strncmp(path, match, pathlen))
-			continue;
-
-		return 1;
-	}
-	return 0;
-}
-
 int read_tree_recursive(struct tree *tree,
 			const char *base, int baselen,
 			int stage, const char **match,
 			read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
-	struct name_entry entry;
+	struct diff_options diff_opts;
+	int all_interesting;
=20
 	if (parse_tree(tree))
 		return -1;
=20
+	diff_tree_setup_paths(match, &diff_opts);
+	all_interesting =3D diff_opts.nr_paths =3D=3D 0;
+
 	init_tree_desc(&desc, tree->buffer, tree->size);
=20
-	while (tree_entry(&desc, &entry)) {
-		if (!match_tree_entry(base, baselen, entry.path, entry.mode, match))
-			continue;
+	for (; desc.size; update_tree_entry(&desc)) {
+		struct name_entry entry;
+		if (!all_interesting) {
+			int show =3D tree_entry_interesting(&desc, base, baselen, &diff_opt=
s);
+			if (show < 0)
+				return 0;
+			else if (!show)
+				continue;
+			else if (show =3D=3D 2)
+				all_interesting =3D 1;
+		}
+		entry =3D desc.entry;
=20
 		switch (fn(entry.sha1, base, baselen, entry.path, entry.mode, stage,=
 context)) {
 		case 0:
--=20
1.7.3.rc0.1.g43ab
