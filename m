From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/20] shallow.c: implement a generic shallow boundary finder based on rev-list
Date: Tue, 29 Dec 2015 19:10:28 +0700
Message-ID: <1451391043-28093-6-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt7i-0006J6-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbbL2ML1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:11:27 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36350 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbbL2ML0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:11:26 -0500
Received: by mail-pf0-f182.google.com with SMTP id 65so82241590pff.3
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Tbl/6CvPGlJ3aQhOpEBjFC2E8jVFX4g6r9GO2E7EBfs=;
        b=lFq69IJBuWSSJ8C/h2gIkVzDV1sEx4EZwaYLgfX+azoWoAd/IVAR4s5SmCqvMzm89U
         FoYuoy6Nyv0ViNSJhNQCugyt7XNd07KRTkDDxxV6YASRAunO7GVD1WojQs5LXOE9/yeP
         eQz0aD+NEFnCNm0qJbOV1HAhJa+z1pSjkCpsurlNEwPiV0Z5TGO94ZcS1V3iqZNfUNZT
         usBoMsSdzuuc6NQF6SoDKwf6EcG1jiDCOnGW3J2w/PtvPRQZmmG9KywOZtmInXPiX/GJ
         chfOt/P9m1C6EueBNfizwuQwxUj4N4cNwAUPov7/HgxZx3Qlv+dduGihV/u+/FctkzAj
         ldTw==
X-Received: by 10.98.14.5 with SMTP id w5mr68685734pfi.126.1451391085668;
        Tue, 29 Dec 2015 04:11:25 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id k65sm83042922pfj.57.2015.12.29.04.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:11:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:11:20 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283116>

Instead of a custom commit walker like get_shallow_commits(), this new
function uses rev-list to mark NOT_SHALLOW to all reachable commits,
except borders. The definition of reachable is to be defined by the
protocol later. This makes it more flexible to define shallow boundary.

Note: if a commit has one NOT_SHALLOW parent and one SHALLOW parent,
then it's considered the boundary. Which means in the client side, this
commit has _no_ parents. This could lead to surprising cuts if we're no=
t
careful.

Another option is to include more commits and only mark commits whose
all parents are SHALLOW as boundary.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h  |  2 ++
 shallow.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 94 insertions(+)

diff --git a/commit.h b/commit.h
index 5d58be0..b717be1 100644
--- a/commit.h
+++ b/commit.h
@@ -258,6 +258,8 @@ extern int for_each_commit_graft(each_commit_graft_=
fn, void *);
 extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *he=
ads,
 		int depth, int shallow_flag, int not_shallow_flag);
+extern struct commit_list *get_shallow_commits_by_rev_list(
+		int ac, const char **av, int shallow_flag, int not_shallow_flag);
 extern void set_alternate_shallow_file(const char *path, int override)=
;
 extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol,
 				 const struct sha1_array *extra);
diff --git a/shallow.c b/shallow.c
index 60f1505..45dffaa 100644
--- a/shallow.c
+++ b/shallow.c
@@ -10,6 +10,8 @@
 #include "diff.h"
 #include "revision.h"
 #include "commit-slab.h"
+#include "revision.h"
+#include "list-objects.h"
=20
 static int is_shallow =3D -1;
 static struct stat_validity shallow_stat;
@@ -137,6 +139,96 @@ struct commit_list *get_shallow_commits(struct obj=
ect_array *heads, int depth,
 	return result;
 }
=20
+static void show_commit(struct commit *commit, void *data)
+{
+	commit->object.flags |=3D *(int *)data;
+}
+
+/*
+ * Given rev-list arguments, run rev-list. All reachable commits
+ * except border ones are marked with not_shallow_flag. Border commits
+ * are marked with shallow_flag. The list of border/shallow commits
+ * are also returned.
+ */
+struct commit_list *get_shallow_commits_by_rev_list(int ac, const char=
 **av,
+						    int shallow_flag,
+						    int not_shallow_flag)
+{
+	struct commit_list *result =3D NULL, *cl;
+	struct rev_info revs;
+	unsigned int i, nr;
+
+	/*
+	 * SHALLOW and NOT_SHALLOW should not be set at this
+	 * point. But better be safe than sorry.
+	 */
+	nr =3D get_max_object_index();
+	for (i =3D 0; i < nr; i++) {
+		struct object *o =3D get_indexed_object(i);
+		if (!o)
+			continue;
+		o->flags &=3D ~(shallow_flag | not_shallow_flag);
+	}
+
+	is_repository_shallow(); /* make sure shallows are read */
+
+	init_revisions(&revs, NULL);
+	save_commit_buffer =3D 0;
+	setup_revisions(ac, av, &revs, NULL);
+
+	/* Mark all reachable commits as NOT_SHALLOW */
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	traverse_commit_list(&revs, show_commit, NULL, &not_shallow_flag);
+
+	/*
+	 * mark border commits SHALLOW + NOT_SHALLOW.
+	 * We cannot clear NOT_SHALLOW right now. Imagine border
+	 * commit A is processed first, then commit B, whose parent is
+	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
+	 * itself is considered border at step 2, which is incorrect.
+	 */
+	nr =3D get_max_object_index();
+	for (i =3D 0; i < nr; i++) {
+		struct object *o =3D get_indexed_object(i);
+		struct commit *c =3D (struct commit *)o;
+		struct commit_list *p;
+		int parent_is_shallow =3D 0;
+
+		if (!o || o->type !=3D OBJ_COMMIT || !(o->flags & not_shallow_flag))
+			continue;
+
+		if (parse_commit(c))
+			die("unable to parse commit %s",
+			    oid_to_hex(&c->object.oid));
+
+		for (p =3D c->parents; p; p =3D p->next) {
+			if (p->item->object.flags & not_shallow_flag)
+				continue;
+			parent_is_shallow =3D 1;
+			if (p->item->object.flags & shallow_flag)
+				continue;
+			p->item->object.flags |=3D shallow_flag;
+			commit_list_insert(p->item, &result);
+		}
+
+		if (parent_is_shallow) {
+			o->flags |=3D shallow_flag;
+			commit_list_insert(c, &result);
+		}
+	}
+	/* clean up NOT_SHALLOW on border commits */
+	cl =3D result;
+	while (cl) {
+		struct object *object =3D &result->item->object;
+		if ((object->flags & not_shallow_flag) &&
+		    (object->flags & shallow_flag))
+			object->flags &=3D ~not_shallow_flag;
+		cl =3D cl->next;
+	}
+	return result;
+}
+
 static void check_shallow_file_for_update(void)
 {
 	if (is_shallow =3D=3D -1)
--=20
2.3.0.rc1.137.g477eb31
