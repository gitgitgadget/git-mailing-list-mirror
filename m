From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/32] rev-list: traverse some more trees to make upload-narrow-base happy
Date: Wed, 25 Aug 2010 08:20:17 +1000
Message-ID: <1282688422-7738-28-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:24:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uS-00030j-Il
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772Ab0HXWX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:23:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56379 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156Ab0HXWXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:23:54 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so50883pwi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PDJITE7AeXNyx7QLf/jyYsFmA6DsMXe4WPdC+6hNHWo=;
        b=cup72Zbtt+CmU2Fvz/qCXqTK2SH6Kwz0/DeQTuHAaqfk0o3Xb+wwk/qmjXQMb0Lz8k
         ClB6Z6RoKdZUrRJnMRxy7eDJ4bDAK6ef0q5XB3lYXV0weGXiW0+5QutNbaoTk0Z/b6vk
         fHDEMw1/BQbt5/qdZLSMsR7KDJ/6pm6mGYAAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gTxlfD/PxbNHPYfNg/YkiP2ZPUN/MojYT+OO6IBTEfbIbL2YnYN2Z7S0nP4xuqdymH
         x3FQUMqsinGDuwAjZ2/ifqPMalW7HYS3hiwMJy11wf55UFlQkxYjOFofp2csC9qGzJUo
         ZVHEOs4an3bl4WQvhO42HXG+zGr78BsYY6R40=
Received: by 10.114.38.1 with SMTP id l1mr8494536wal.41.1282688634071;
        Tue, 24 Aug 2010 15:23:54 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id q6sm941801waj.22.2010.08.24.15.23.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:23:52 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:23:47 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154366>

When in narrow repo and a merge is met, just traverse every valid
trees that could be found, regardless whether they are in narrow tree.

This is a weak point because fsck won't be able to find out missing
trees. Hopefully the remote end won't accept incomplete push.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 list-objects.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++--
 1 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 7014926..ccdd64b 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -62,7 +62,8 @@ static void process_tree(struct rev_info *revs,
 			 show_object_fn show,
 			 struct name_path *path,
 			 const char *name,
-			 const char *subtree)
+			 const char *subtree,
+			 int recursive)
 {
 	struct object *obj =3D &tree->object;
 	struct tree_desc desc;
@@ -81,6 +82,10 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |=3D SEEN;
 	show(obj, path, name);
+
+	if (!recursive)
+		return;
+
 	me.up =3D path;
 	me.elem =3D name;
 	me.elem_len =3D strlen(name);
@@ -112,7 +117,8 @@ static void process_tree(struct rev_info *revs,
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
 				     show, &me, entry.path,
-				     slash ? slash+1 : NULL);
+				     slash ? slash+1 : NULL,
+				     1);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
 					show, &me, entry.path);
@@ -163,6 +169,48 @@ static void add_pending_tree(struct rev_info *revs=
, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
=20
+static void add_pending_reachable_tree(struct rev_info *revs,
+				       const unsigned char *sha1,
+				       const char *base)
+{
+	struct name_entry entry;
+	struct object *subtree;
+	struct tree_desc desc;
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+	char *path =3D xmalloc(PATH_MAX);
+	int len;
+
+	buffer =3D read_sha1_file(sha1, &type, &size);
+	if (!buffer) {
+		free(path);
+		return;
+	}
+	if (type !=3D OBJ_TREE)
+		die("%s is not a tree", sha1_to_hex(sha1));
+
+	len =3D strlen(base);
+	memcpy(path, base, len);
+	path[len++] =3D '/';
+
+	init_tree_desc(&desc, buffer, size);
+	while (tree_entry(&desc, &entry)) {
+		if (!S_ISDIR(entry.mode))
+			continue;
+
+		subtree =3D lookup_object(entry.sha1);
+		strcpy(path+len, entry.path);
+		if (subtree) {
+			subtree->flags |=3D TMP_MARK; /* non recursive */
+			add_pending_object(revs, subtree, xstrdup(path));
+		}
+		add_pending_reachable_tree(revs, entry.sha1, path);
+	}
+	free(path);
+	free(buffer);
+}
+
 void traverse_commit_list(struct rev_info *revs,
 			  show_commit_fn show_commit,
 			  show_object_fn show_object,
@@ -177,6 +225,8 @@ void traverse_commit_list(struct rev_info *revs,
 	}
=20
 	while ((commit =3D get_revision(revs)) !=3D NULL) {
+		if (get_narrow_prefix())
+			add_pending_reachable_tree(revs, commit->tree->object.sha1, "");
 		add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
 	}
@@ -194,7 +244,12 @@ void traverse_commit_list(struct rev_info *revs,
 		if (obj->type =3D=3D OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
 				     NULL, name,
-				     revs->narrow_tree ? revs->narrow_prefix : NULL);
+				     revs->narrow_tree ? revs->narrow_prefix : NULL,
+				     (obj->flags & TMP_MARK) =3D=3D 0);
+			if (obj->flags & TMP_MARK) {
+				obj->flags &=3D ~TMP_MARK;
+				//free((char*)name);
+			}
 			continue;
 		}
 		if (obj->type =3D=3D OBJ_BLOB) {
--=20
1.7.1.rc1.69.g24c2f7
