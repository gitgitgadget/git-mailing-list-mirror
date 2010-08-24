From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/32] rev-list: support traversing in narrow repository mode
Date: Wed, 25 Aug 2010 08:20:00 +1000
Message-ID: <1282688422-7738-11-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1sy-0001Xh-Gi
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab0HXWWG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:22:06 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37012 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270Ab0HXWWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:22:01 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so2813054pxi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XwXrGCNOfuyxvXL/fHS9cdhc0tW9lxqePRBpq2aMJMo=;
        b=iC3JHU0qId/cT7zT3xFQeSJgncw5asfhSi2gBT1IErSFDE5xtPcHs+vgYCEKpzGSLU
         ZIkYaPAN1ifgk+XbPkNEa0Bi9p4O1nNuh1+wiCcBIsaVEmpbkoocu9r6cObadMiuRU4X
         /SbbC6J1ZVQNhmNPRTVXlXYHo5QtRbTDl5xAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cqRyVFF0f+IseXF84UdR4wKDSSCS90wxqFUJp//7d3XYCJ0Y4OVt0XAhbV4QE0LGp0
         OCIaQp/MjSCZUxmiNj5Ay2koaQ/q2nlqcxa8vbrjeIUFa6eZhE3j/DYH9E8Pc/vswR5s
         HjvY5FvhelblDwh3lHEhvJu3GWHhrti6HBrIM=
Received: by 10.143.1.16 with SMTP id d16mr6155616wfi.295.1282688521735;
        Tue, 24 Aug 2010 15:22:01 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id y16sm643516wff.2.2010.08.24.15.21.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:22:00 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:21:56 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154354>

In this mode, only trees within revs->narrow_prefix is traversed. This
narrows down the whole repository to the given subtree. This mode will
be used by upload-pack/pack-objects to create a narrow pack, and by
all git operations in narrow repository (i.e. $GIT_DIR/narrow exists).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 list-objects.c |   36 +++++++++++++++++++++++++++++++++---
 revision.h     |    4 +++-
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 8953548..7014926 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -61,12 +61,15 @@ static void process_tree(struct rev_info *revs,
 			 struct tree *tree,
 			 show_object_fn show,
 			 struct name_path *path,
-			 const char *name)
+			 const char *name,
+			 const char *subtree)
 {
 	struct object *obj =3D &tree->object;
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
+	const char *slash =3D NULL;
+	int subtree_len;
=20
 	if (!revs->tree_objects)
 		return;
@@ -82,13 +85,34 @@ static void process_tree(struct rev_info *revs,
 	me.elem =3D name;
 	me.elem_len =3D strlen(name);
=20
+	if (subtree) {
+		slash =3D strchr(subtree, '/');
+		subtree_len =3D slash ? slash - subtree : strlen(subtree);
+	}
+
 	init_tree_desc(&desc, tree->buffer, tree->size);
=20
 	while (tree_entry(&desc, &entry)) {
+		/*
+		 * FIXME, does not follow tree rename
+		 * some sort of rename hints would be nice
+		 * (because diff machinery should not be used
+		 * here for detecting renames)
+		 */
+		if (!subtree)
+			; 	/* no subtree restriction, go on */
+		else if (S_ISDIR(entry.mode) &&
+			 !strncmp(entry.path, subtree, subtree_len) &&
+			 entry.path[subtree_len] =3D=3D '\0')
+			;	/* inside subtree, go on */
+		else
+			continue; /* stop */
+
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
-				     show, &me, entry.path);
+				     show, &me, entry.path,
+				     slash ? slash+1 : NULL);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
 					show, &me, entry.path);
@@ -147,6 +171,11 @@ void traverse_commit_list(struct rev_info *revs,
 	int i;
 	struct commit *commit;
=20
+	if (get_narrow_prefix() && !revs->narrow_tree) {
+		revs->narrow_tree =3D 1;
+		revs->narrow_prefix =3D get_narrow_prefix();
+	}
+
 	while ((commit =3D get_revision(revs)) !=3D NULL) {
 		add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
@@ -164,7 +193,8 @@ void traverse_commit_list(struct rev_info *revs,
 		}
 		if (obj->type =3D=3D OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     NULL, name);
+				     NULL, name,
+				     revs->narrow_tree ? revs->narrow_prefix : NULL);
 			continue;
 		}
 		if (obj->type =3D=3D OBJ_BLOB) {
diff --git a/revision.h b/revision.h
index 36fdf22..ccdf28a 100644
--- a/revision.h
+++ b/revision.h
@@ -33,6 +33,7 @@ struct rev_info {
=20
 	/* Basic information */
 	const char *prefix;
+	const char *narrow_prefix;
 	const char *def;
 	void *prune_data;
 	unsigned int early_output;
@@ -68,7 +69,8 @@ struct rev_info {
 			cherry_pick:1,
 			bisect:1,
 			ancestry_path:1,
-			first_parent_only:1;
+			first_parent_only:1,
+			narrow_tree:1;
=20
 	/* Diff flags */
 	unsigned int	diff:1,
--=20
1.7.1.rc1.69.g24c2f7
