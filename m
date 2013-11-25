From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 14/28] upload-pack: make sure deepening preserves shallow roots
Date: Mon, 25 Nov 2013 10:55:40 +0700
Message-ID: <1385351754-9954-15-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknEF-0001xA-0R
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab3KYDwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:52:51 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:37189 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3KYDwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:52:50 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so4778647pbb.22
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=M9ofSl4nAxMhpgiom8gRBIKfC/Jbj7JdXprDyvp+cQ4=;
        b=dYLliT9Q91bV855ZL4zCdi9W7quZhingZUyUj3/BhkzKu83b6yhIPLlEBNy6bqbHO4
         /Y65p3a8cUG8K6adhJnDA7eM6LVX5pnLYCfOsLlRIX1YH84g6QTqWWxZJ7Zrol6qYDBG
         Dte8pVYwLCQL0HR3aPfUnEbhMBRMuR8hEusMBb5b7B7Pbp2Fjc93uI0RNpc5eTCfEVeM
         yEE1L4GAIM2wPOmX2QkF4kbYitwJIl4+X88ncpnpaB1OPn1INpk7I8yL3jlPKTsYZ0QU
         ruuFJ2fcGlKPwvzXdPqfzemvKQ8+Gic9sXapjpTC2jonr+y23FScmTc9p/RgmPmiKels
         /ovw==
X-Received: by 10.68.254.164 with SMTP id aj4mr167185pbd.161.1385351570166;
        Sun, 24 Nov 2013 19:52:50 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id pl1sm69716848pbb.20.2013.11.24.19.52.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:52:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:57:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238286>

When "fetch --depth=3DN" where N exceeds the longest chain of history i=
n
the source repo, usually we just send an "unshallow" line to the
client so full history is obtained.

When the source repo is shallow we need to make sure to "unshallow"
the current shallow point _and_ "shallow" again when the commit
reaches its shallow bottom in the source repo.

This should fix both cases: large <N> and --unshallow.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt |  8 ++++++--
 shallow.c                       |  6 +++++-
 t/t5536-fetch-shallow.sh        | 16 ++++++++++++++++
 upload-pack.c                   |  2 +-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index ba1fe49..a83d2b4 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -14,8 +14,12 @@
 	branch history. Tags for the deepened commits are not fetched.
=20
 --unshallow::
-	Convert a shallow repository to a complete one, removing all
-	the limitations imposed by shallow repositories.
+	If the source repository is complete, convert a shallow
+	repository to a complete one, removing all the limitations
+	imposed by shallow repositories.
++
+If the source repository is shallow, fetch as much as possible so that
+the current repository has the same history as the source repository.
=20
 ifndef::git-pull[]
 --dry-run::
diff --git a/shallow.c b/shallow.c
index 2ec0c8c..1baf6b5 100644
--- a/shallow.c
+++ b/shallow.c
@@ -73,6 +73,7 @@ struct commit_list *get_shallow_commits(struct object=
_array *heads, int depth,
 	struct commit_list *result =3D NULL;
 	struct object_array stack =3D OBJECT_ARRAY_INIT;
 	struct commit *commit =3D NULL;
+	struct commit_graft *graft;
=20
 	while (commit || i < heads->nr || stack.nr) {
 		struct commit_list *p;
@@ -97,7 +98,10 @@ struct commit_list *get_shallow_commits(struct objec=
t_array *heads, int depth,
 		if (parse_commit(commit))
 			die("invalid commit");
 		cur_depth++;
-		if (cur_depth >=3D depth) {
+		if ((depth !=3D INFINITE_DEPTH && cur_depth >=3D depth) ||
+		    (is_repository_shallow() && !commit->parents &&
+		     (graft =3D lookup_commit_graft(commit->object.sha1)) !=3D NULL =
&&
+		     graft->nr_parent < 0)) {
 			commit_list_insert(commit, &result);
 			commit->object.flags |=3D shallow_flag;
 			commit =3D NULL;
diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
index 41de74d..e011ead 100755
--- a/t/t5536-fetch-shallow.sh
+++ b/t/t5536-fetch-shallow.sh
@@ -79,6 +79,22 @@ EOF
 	)
 '
=20
+test_expect_success 'fetch --unshallow from shallow clone' '
+	(
+	cd shallow2 &&
+	git fetch --unshallow &&
+	git fsck &&
+	git log --format=3D%s origin/master >actual &&
+	cat <<EOF >expect &&
+6
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
 test_expect_success 'fetch something upstream has but hidden by client=
s shallow boundaries' '
 	# the blob "1" is available in .git but hidden by the
 	# shallow2/.git/shallow and it should be resent
diff --git a/upload-pack.c b/upload-pack.c
index f082f06..28269c7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -619,7 +619,7 @@ static void receive_needs(void)
 	if (depth > 0) {
 		struct commit_list *result =3D NULL, *backup =3D NULL;
 		int i;
-		if (depth =3D=3D INFINITE_DEPTH)
+		if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
 			for (i =3D 0; i < shallows.nr; i++) {
 				struct object *object =3D shallows.objects[i].item;
 				object->flags |=3D NOT_SHALLOW;
--=20
1.8.2.83.gc99314b
