From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/11] list-objects.c: add show_tree_entry callback to traverse_commit_list
Date: Sun,  8 Sep 2013 22:04:16 +0700
Message-ID: <1378652660-6731-8-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:02:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgV8-0003Zj-Ry
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab3IHPCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:02:05 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:41590 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab3IHPCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:02:04 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so5218030pab.7
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4RjzVDmeUDrzZAAs26H+VZ2W0M7mW3b5CULRSNqcInQ=;
        b=fPFvX0dOrWwUKV4eErSun+HzZmCwSy/K0p5+lQJTQqu5D8PwDqgUpiba1vziJEvfIU
         dkkoOOdGJWJJL0c8gtoMRk7JW0XW0h5uydklR+xNkXs2BK8+OkFc5Q7RjGFDyubgY4G6
         qsq6/MRmP964d2VLLxN8Pouoy3lyO4nAkK0puyrM3PLfbg3gzuKJxkO+W4+qpKSU2eME
         tpt6Dz6An5xtqzgDov2ZD0QZ87G5xnFn0DEQFI6ARu3cylFlek4aAl5SIYnXCtFmdBZR
         icFx7BY+MYUnKAs5FRvsZW/KSrysuczY0ZVLTYj0D0Q28Gi8vghJ4H2DZ3/LC59H3f+a
         /n7A==
X-Received: by 10.66.218.198 with SMTP id pi6mr15192068pac.107.1378652523895;
        Sun, 08 Sep 2013 08:02:03 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id 7sm11432130paf.22.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:02:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:05:12 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234246>

This helps construct tree dictionary in pack v4.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 2 +-
 builtin/rev-list.c     | 4 ++--
 list-objects.c         | 9 ++++++++-
 list-objects.h         | 3 ++-
 upload-pack.c          | 2 +-
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ef68fc5..b38d3dc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2380,7 +2380,7 @@ static void get_object_list(int ac, const char **=
av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+	traverse_commit_list(&revs, show_commit, NULL, show_object, NULL);
=20
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs(&revs);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index a5ec30d..b25f896 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -243,7 +243,7 @@ static int show_bisect_vars(struct rev_list_info *i=
nfo, int reaches, int all)
 		strcpy(hex, sha1_to_hex(revs->commits->item->object.sha1));
=20
 	if (flags & BISECT_SHOW_ALL) {
-		traverse_commit_list(revs, show_commit, show_object, info);
+		traverse_commit_list(revs, show_commit, NULL, show_object, info);
 		printf("------\n");
 	}
=20
@@ -348,7 +348,7 @@ int cmd_rev_list(int argc, const char **argv, const=
 char *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
=20
-	traverse_commit_list(&revs, show_commit, show_object, &info);
+	traverse_commit_list(&revs, show_commit, NULL, show_object, &info);
=20
 	if (revs.count) {
 		if (revs.left_right && revs.cherry_mark)
diff --git a/list-objects.c b/list-objects.c
index 3dd4a96..6def897 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -61,6 +61,7 @@ static void process_gitlink(struct rev_info *revs,
=20
 static void process_tree(struct rev_info *revs,
 			 struct tree *tree,
+			 show_tree_entry_fn show_tree_entry,
 			 show_object_fn show,
 			 struct name_path *path,
 			 struct strbuf *base,
@@ -107,9 +108,13 @@ static void process_tree(struct rev_info *revs,
 				continue;
 		}
=20
+		if (show_tree_entry)
+			show_tree_entry(&entry, cb_data);
+
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
+				     show_tree_entry,
 				     show, &me, base, entry.path,
 				     cb_data);
 		else if (S_ISGITLINK(entry.mode))
@@ -167,6 +172,7 @@ static void add_pending_tree(struct rev_info *revs,=
 struct tree *tree)
=20
 void traverse_commit_list(struct rev_info *revs,
 			  show_commit_fn show_commit,
+			  show_tree_entry_fn show_tree_entry,
 			  show_object_fn show_object,
 			  void *data)
 {
@@ -196,7 +202,8 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		}
 		if (obj->type =3D=3D OBJ_TREE) {
-			process_tree(revs, (struct tree *)obj, show_object,
+			process_tree(revs, (struct tree *)obj,
+				     show_tree_entry, show_object,
 				     NULL, &base, name, data);
 			continue;
 		}
diff --git a/list-objects.h b/list-objects.h
index 3db7bb6..297b2e0 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -2,8 +2,9 @@
 #define LIST_OBJECTS_H
=20
 typedef void (*show_commit_fn)(struct commit *, void *);
+typedef void (*show_tree_entry_fn)(const struct name_entry *, void *);
 typedef void (*show_object_fn)(struct object *, const struct name_path=
 *, const char *, void *);
-void traverse_commit_list(struct rev_info *, show_commit_fn, show_obje=
ct_fn, void *);
+void traverse_commit_list(struct rev_info *, show_commit_fn, show_tree=
_entry_fn, show_object_fn, void *);
=20
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct commit_list *, struct rev_info *,=
 show_edge_fn);
diff --git a/upload-pack.c b/upload-pack.c
index 127e59a..ccf76d9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -125,7 +125,7 @@ static int do_rev_list(int in, int out, void *user_=
data)
 		for (i =3D 0; i < extra_edge_obj.nr; i++)
 			fprintf(pack_pipe, "-%s\n", sha1_to_hex(
 					extra_edge_obj.objects[i].item->sha1));
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+	traverse_commit_list(&revs, show_commit, NULL, show_object, NULL);
 	fflush(pack_pipe);
 	fclose(pack_pipe);
 	return 0;
--=20
1.8.2.83.gc99314b
