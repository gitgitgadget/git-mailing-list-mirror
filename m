From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/16] list-objects.c: add show_tree_entry callback to traverse_commit_list
Date: Mon,  9 Sep 2013 20:57:59 +0700
Message-ID: <1378735087-4813-9-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:56:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1wj-00038X-UX
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864Ab3IIN4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:56:00 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58420 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab3IINz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:55:59 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so6139542pbc.22
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4RjzVDmeUDrzZAAs26H+VZ2W0M7mW3b5CULRSNqcInQ=;
        b=n3Fg1+wML3QWvxTMbBw7intraAuGQm6mxF2AAgyFnx0VrkESwHuWKDAENodFi98M8B
         xV8iFkCy8IW+7qzZxzW4aOpIbpXjfEoPeWouV0hOiv1BaK+DBUDtaUxQN/8bWVj/vx8E
         gMZbfTOsVOaCXpC9lmThP597t3pFFq9SJSOPKYgL6q3hhbB/X0jRtomhQLEv2IOJxRW5
         fPM3sveQknb6E7k9wV5RVeSFxP5C2u57STc9T+L1S7XDNlRpdKP7XKSDgA+XwtEy3DLR
         I5d+8bFZwmtCbdATwOxKcoP0qixJG4ynAExLbG84dtJq285PKWq/yFOPOdUC1W5wpqps
         DzSQ==
X-Received: by 10.68.204.136 with SMTP id ky8mr1938074pbc.192.1378734959085;
        Mon, 09 Sep 2013 06:55:59 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id qf7sm17783427pac.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:55:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:59:08 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234336>

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
