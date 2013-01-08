From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fetch,upload-pack: make --depth=0 or --depth=inf for infinite depth
Date: Tue,  8 Jan 2013 19:19:12 +0700
Message-ID: <1357647552-15815-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 13:19:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsY9R-00038C-RW
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 13:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab3AHMTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2013 07:19:09 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:45026 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500Ab3AHMTH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 07:19:07 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so169661dad.38
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 04:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=49f9Mccnx8OrBhHFQ7nSbBBCnejj1oSeeYZ1q19NHXw=;
        b=jclXdYzLOBMitG2MR0muY+T/peWUqAg0/shlm7cMZ6GzHv0PWhHFBLlN/fofMsLMKe
         zId9e6ZVib9gROAh0XVJpJuOinL/DKLP3AlHhhLh4XLhdsQ+umWdluKY4qWdz04PMhs+
         ESF8WvTHT2sqyxVWRbSvAlHGbjtzSi9vtc2rVzwRhYGdT9GlIOqCmazswm+Xr6CAul2Y
         LHI14q1LYU8DbymypXN+iALuQoLTj/9PY+wczYU2noyztS+IyT6sGegTMw0LdxhAoMpR
         UgpprUvm/kTfKgOCJJZC0CEjQ9hsKHEDIbbTeudc/IBYoZfOUPC1VK8glOWaBPlJRmpM
         SZ1Q==
X-Received: by 10.68.247.39 with SMTP id yb7mr200936185pbc.15.1357647544376;
        Tue, 08 Jan 2013 04:19:04 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id a9sm4954285pav.24.2013.01.08.04.19.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 04:19:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 08 Jan 2013 19:19:13 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212962>

The user can do fetch --depth=3D2147483647 for infinite depth now. But
it's hard to remember. Any other large numbers would also do if it's
longer than the longest commit chain in repository (some guessing may
be involved). Make --depth=3D0 or --depth=3Dinf an alias for
--depth=3D2147483647. JGit and older C Git store depth as "int" so both
are OK with this number. Dulwich does not support shallow clone.

fetch-pack is not changed because it's a plumbing and the plumber is
expected to write this number explicitly.

Make upload-pack recognize this special number as infinite depth. The
effect is essentially the same as before, except that upload-pack is
more efficient in this case as it does not have to traverse the commit
DAG to the bottom any more. The chance of a user actually wanting
exactly 2147483647 commits depth, not infinite, is probably too small
to consider.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This is a patch from the graveyard, the third patch of a series [1].
 The series, nd/clone-depth-zero, has been merged. Although I don't kno=
w
 only the first patch in the original series got in.

 http://thread.gmane.org/gmane.comp.version-control.git/154267/focus=3D=
154268

 Documentation/fetch-options.txt     |  2 ++
 Documentation/technical/shallow.txt |  3 +++
 commit.h                            |  3 +++
 t/t5500-fetch-pack.sh               |  8 ++++++++
 transport.c                         |  5 +++++
 upload-pack.c                       | 13 ++++++++++---
 6 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 6e98bdf..140d0cd 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -12,6 +12,8 @@
 	`git clone` with `--depth=3D<depth>` option (see linkgit:git-clone[1]=
)
 	to the specified number of commits from the tip of each remote
 	branch history. Tags for the deepened commits are not fetched.
+	Depth 0 or "inf" is infinite, which may turn repository to a
+	non-shallow one again.
=20
 ifndef::git-pull[]
 --dry-run::
diff --git a/Documentation/technical/shallow.txt b/Documentation/techni=
cal/shallow.txt
index 0502a54..ea2f69f 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -53,3 +53,6 @@ It also writes an appropriate $GIT_DIR/shallow.
 You can deepen a shallow repository with "git-fetch --depth 20
 repo branch", which will fetch branch from repo, but stop at depth
 20, updating $GIT_DIR/shallow.
+
+The special depth 2147483647 (or 0x7fffffff, the largest positive
+number a signed 32-bit integer can contain) means infinite depth.
diff --git a/commit.h b/commit.h
index 0f469e5..fbde106 100644
--- a/commit.h
+++ b/commit.h
@@ -162,6 +162,9 @@ extern struct commit_list *get_merge_bases(struct c=
ommit *rev1, struct commit *r
 extern struct commit_list *get_merge_bases_many(struct commit *one, in=
t n, struct commit **twos, int cleanup);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list =
*in);
=20
+/* largest postive number a signed 32-bit integer can contain */
+#define INFINITE_DEPTH 0x7fffffff
+
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 6322e8a..2d40073 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -264,6 +264,14 @@ test_expect_success 'clone shallow object count' '
 	grep "^count: 52" count.shallow
 '
=20
+test_expect_success 'infinite deepening (full repo)' '
+	(
+		cd shallow &&
+		git fetch --depth=3Dinf &&
+		! test -f .git/shallow
+	)
+'
+
 test_expect_success 'clone shallow without --no-single-branch' '
 	git clone --depth 1 "file://$(pwd)/." shallow2
 '
diff --git a/transport.c b/transport.c
index 2673d27..a938ba0 100644
--- a/transport.c
+++ b/transport.c
@@ -12,6 +12,7 @@
 #include "url.h"
 #include "submodule.h"
 #include "string-list.h"
+#include "commit.h"
=20
 /* rsync support */
=20
@@ -475,11 +476,15 @@ static int set_git_option(struct git_transport_op=
tions *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
 		if (!value)
 			opts->depth =3D 0;
+		else if (!strcmp(value, "inf"))
+			opts->depth =3D INFINITE_DEPTH;
 		else {
 			char *end;
 			opts->depth =3D strtol(value, &end, 0);
 			if (*end)
 				die("transport: invalid depth option '%s'", value);
+			if (opts->depth =3D=3D 0)
+				opts->depth =3D INFINITE_DEPTH;
 		}
 		return 0;
 	}
diff --git a/upload-pack.c b/upload-pack.c
index 6142421..88f0029 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -670,10 +670,17 @@ static void receive_needs(void)
 	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
 		return;
 	if (depth > 0) {
-		struct commit_list *result, *backup;
+		struct commit_list *result =3D NULL, *backup =3D NULL;
 		int i;
-		backup =3D result =3D get_shallow_commits(&want_obj, depth,
-			SHALLOW, NOT_SHALLOW);
+		if (depth =3D=3D INFINITE_DEPTH)
+			for (i =3D 0; i < shallows.nr; i++) {
+				struct object *object =3D shallows.objects[i].item;
+				object->flags |=3D NOT_SHALLOW;
+			}
+		else
+			backup =3D result =3D
+				get_shallow_commits(&want_obj, depth,
+						    SHALLOW, NOT_SHALLOW);
 		while (result) {
 			struct object *object =3D &result->item->object;
 			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
--=20
1.8.0.rc2.23.g1fb49df
