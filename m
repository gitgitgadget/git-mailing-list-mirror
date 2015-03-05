From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] shallow.c: implement a generic shallow boundary finder based on rev-list
Date: Thu,  5 Mar 2015 17:28:14 +0700
Message-ID: <1425551295-28653-6-git-send-email-pclouds@gmail.com>
References: <70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
 <1425551295-28653-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Thu Mar 05 11:29:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTT1q-0003jo-BM
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 11:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbbCEK3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 05:29:11 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33498 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbbCEK3H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 05:29:07 -0500
Received: by padet14 with SMTP id et14so45005307pad.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 02:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vcfoXDdqB4GtvZh3Q3wd1yWTYpqs19wqc6eZa8YFcDk=;
        b=L3uFS1LvTsiRt5rScM3PE8Kq9DGPstsaCk7nJTpZEUadtpyrb7vSUtW9ZywQEe9NLj
         KS4B5WhFWOJlhNQVyycGteBaBcW1C6elA9YXNuseR/YsE4eiHPiHZ5f6bfj/cpYQQMX3
         J4gXAzSP6lONTHmBe5ghp8VOKRbv907O2ksXDjQ27VrUeIRB7vhgW3L4BaDrrQZlQ6mS
         fiX3x4a0vDVOUXq9ibTtIJpfSLjyFcKiC5B+0dAqATisxGOL9/7SpWK183QGA8ViDUPT
         N6A38DtOHlt3m3FaFWlvY8sRcn3sUc9ixRW+coPexj7uMT50+plqyGfXKFO1LXYDU38M
         l2Xw==
X-Received: by 10.66.119.238 with SMTP id kx14mr14934849pab.2.1425551346940;
        Thu, 05 Mar 2015 02:29:06 -0800 (PST)
Received: from lanh ([115.73.230.115])
        by mx.google.com with ESMTPSA id fd5sm1323679pdb.67.2015.03.05.02.29.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 02:29:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Mar 2015 17:29:38 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425551295-28653-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264825>

Instead of a custom commit walker like get_shallow_commits(), this new
function uses rev-list to mark SHALLOW to all reachable commits. The
definition of reachable is to be defined by the protocol later. This
makes it more flexible to define shallow boundary.

Note: if a commit has one not_shallow parent and one shallow parent,
then it's considered the boundary. Which means in the client side,
this commit has _no_ parents. This could lead to surprising cuts if
we're not careful.

Another option is to include more commits and only mark commits whose
all parents are not-shallow as boundary.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h  |  2 ++
 shallow.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 67 insertions(+)

diff --git a/commit.h b/commit.h
index 9f189cb..5c80eea 100644
--- a/commit.h
+++ b/commit.h
@@ -254,6 +254,8 @@ extern int for_each_commit_graft(each_commit_graft_=
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
index d8bf40a..1db2768 100644
--- a/shallow.c
+++ b/shallow.c
@@ -10,6 +10,8 @@
 #include "revision.h"
 #include "commit-slab.h"
 #include "sigchain.h"
+#include "revision.h"
+#include "list-objects.h"
=20
 static int is_shallow =3D -1;
 static struct stat_validity shallow_stat;
@@ -137,6 +139,69 @@ struct commit_list *get_shallow_commits(struct obj=
ect_array *heads, int depth,
 	return result;
 }
=20
+static void show_commit(struct commit *commit, void *data)
+{
+	commit->object.flags |=3D *(int *)data;
+}
+
+struct commit_list *get_shallow_commits_by_rev_list(int ac, const char=
 **av,
+						    int shallow_flag, int not_shallow_flag)
+{
+	struct commit_list *result =3D NULL;
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
+		o->flags &=3D ~(shallow_flag | not_shallow_flag);
+	}
+
+	is_repository_shallow(); /* make sure shallows are read */
+
+	init_revisions(&revs, NULL);
+	save_commit_buffer =3D 0;
+	setup_revisions(ac, av, &revs, NULL);
+
+	/* mark all reachable commits as SHALLOW */
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	traverse_commit_list(&revs, show_commit, NULL, &shallow_flag);
+
+	nr =3D get_max_object_index();
+	for (i =3D 0; i < nr; i++) {
+		struct object *o =3D get_indexed_object(i);
+		struct commit *c =3D (struct commit *)o;
+		struct commit_list *p;
+		int parent_is_not_shallow =3D 0;
+
+		if (o->type !=3D OBJ_COMMIT || !(o->flags & shallow_flag))
+			continue;
+
+		if (parse_commit(c))
+			die("unable to parse commit %s",
+			    sha1_to_hex(c->object.sha1));
+
+		for (p =3D c->parents; p; p =3D p->next) {
+			if (p->item->object.flags & shallow_flag)
+				continue;
+			parent_is_not_shallow =3D 1;
+			if (p->item->object.flags & not_shallow_flag)
+				continue;
+			p->item->object.flags |=3D not_shallow_flag;
+			commit_list_insert(p->item, &result);
+		}
+
+		if (parent_is_not_shallow)
+			commit_list_insert(c, &result);
+	}
+	return result;
+}
+
 static void check_shallow_file_for_update(void)
 {
 	if (is_shallow =3D=3D -1)
--=20
2.3.0.rc1.137.g477eb31
