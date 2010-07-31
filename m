From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/16] list-objects: limit traversing within the given subtree if core.subtree is set
Date: Sat, 31 Jul 2010 23:18:11 +0700
Message-ID: <1280593105-22015-3-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:37:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOR3-0002kR-Av
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab0HAChz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:37:55 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33077 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab0HAChy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:37:54 -0400
Received: by pvc7 with SMTP id 7so978167pvc.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=L0TfsqSRjE1SgMT0XP8LQV5WZgWQpaiKeFNE89wDny8=;
        b=PEzxdEj3/HnaSJ4qHh+UUdj/xp6KlObsArA1YCbahWFZuB01x+DSCYvED/BO9NWVkt
         OBU+Zs1jGVIuJXtIgzCasM/RsaUOryWUZsoAFU2d+omMhFtihEtPrasCMEaLMox0jBs2
         3NaadT5jrtr1GG7IL2zBkTXgbWTzzZHmcWNZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Yb7k5BLbWtpxC2xdB8INIHHwl8bpElnHuxUNkFu14pwN7s7YLYCh2KC2Jt3ja+eXCn
         vmWqKlCSwo7pOCZVMGgp1EkqOhvExMMf3uE4pdOtcYlAuKlHVAFm5bKeOyfWv5PK96K6
         bNDOZRFf6BVBzvItWT1EHdxKZCz1M6aYTShKg=
Received: by 10.114.67.11 with SMTP id p11mr4840514waa.170.1280630273470;
        Sat, 31 Jul 2010 19:37:53 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id g4sm7701135wae.14.2010.07.31.19.37.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:37:52 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:18:46 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152349>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 list-objects.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 8953548..1b25b54 100644
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
+	const char *slash;
+	int subtree_len;
=20
 	if (!revs->tree_objects)
 		return;
@@ -82,13 +85,21 @@ static void process_tree(struct rev_info *revs,
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
-		if (S_ISDIR(entry.mode))
-			process_tree(revs,
-				     lookup_tree(entry.sha1),
-				     show, &me, entry.path);
+		if (S_ISDIR(entry.mode)) {
+			if (!subtree || !strncmp(entry.path, subtree, subtree_len))
+				process_tree(revs,
+					     lookup_tree(entry.sha1),
+					     show, &me, entry.path,
+					     slash && slash[1] ? slash+1 : NULL);
+		}
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
 					show, &me, entry.path);
@@ -164,7 +175,7 @@ void traverse_commit_list(struct rev_info *revs,
 		}
 		if (obj->type =3D=3D OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     NULL, name);
+				     NULL, name, core_subtree);
 			continue;
 		}
 		if (obj->type =3D=3D OBJ_BLOB) {
--=20
1.7.1.rc1.69.g24c2f7
