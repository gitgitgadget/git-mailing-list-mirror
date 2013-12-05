From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 14/28] upload-pack: make sure deepening preserves shallow roots
Date: Thu,  5 Dec 2013 20:02:41 +0700
Message-ID: <1386248575-10206-15-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:59:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYWx-00027x-Q7
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756647Ab3LEM7o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:59:44 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34139 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab3LEM7n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:59:43 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so24463147pde.21
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cud2JZ086X97/V4rY14VikLCndGYhpOkwZPFFynx2kw=;
        b=NMjbnLeOD8ilnfyI4pGWLjJQF3OJ3SwzoIfWESdQ/YT9i76FxtdWm6dufZQYA2AFkL
         7JJp1funXJ4P8iOXDbk3Su6r3jMI4GRyhKHAFM2npw8WMPAvL5uWsYS9Acti72+lIwQi
         C0AtyD3eGtMig+XrVRb14VdIgZjqcEjQR4SffY0x/LVEWYHIfUJXi3M7xQah4x4pbery
         e8DFNLjMAiGlnidKGScEe1phkyc4Nky7BDuL/aicgjeMbT+jh6ioSaOfEYTFZi5vg8di
         dhtCwVmL+kw9rcIKlg1Xr8ndox4RJUFsfmngS0Vdq9sPO345l9UX+9SUmtOPaFcuPi0q
         lIfw==
X-Received: by 10.68.196.69 with SMTP id ik5mr52545616pbc.132.1386248382650;
        Thu, 05 Dec 2013 04:59:42 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id qf7sm167044143pac.14.2013.12.05.04.59.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:59:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:04:26 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238870>

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
index 975d699..ae46b10 100644
--- a/shallow.c
+++ b/shallow.c
@@ -75,6 +75,7 @@ struct commit_list *get_shallow_commits(struct object=
_array *heads, int depth,
 	struct commit_list *result =3D NULL;
 	struct object_array stack =3D OBJECT_ARRAY_INIT;
 	struct commit *commit =3D NULL;
+	struct commit_graft *graft;
=20
 	while (commit || i < heads->nr || stack.nr) {
 		struct commit_list *p;
@@ -99,7 +100,10 @@ struct commit_list *get_shallow_commits(struct obje=
ct_array *heads, int depth,
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
index d211052..022cb2c 100755
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
1.8.5.1.25.g8667982
