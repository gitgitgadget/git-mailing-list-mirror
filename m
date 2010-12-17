From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Make rev-list --objects work together with pathspecs
Date: Fri, 17 Dec 2010 20:26:47 +0700
Message-ID: <1292592407-26645-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 14:27:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTaLm-0000Rb-6x
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 14:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab0LQN1x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 08:27:53 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:39681 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab0LQN1w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 08:27:52 -0500
Received: by pzk36 with SMTP id 36so137783pzk.11
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 05:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=8fi4LxPJvn5Q7CdglEitH2fJzxw5dI/MHw1NoZoqUIQ=;
        b=ptgv99bSP1qhhYGlRs/z62S56yvYPolu4zwD2K7k3skGX0tOBDwFn9TLRtB7eN9M9N
         ZZ4pWOpwO42VsTun23yFOqpD0ga21Tbt6OLhltUeyYtLlABF4Mxb8Y3dXH0rqIOw8Sob
         GZ+aKxxiMZqCEWSQjVm+xfUERpQnDq1myYw4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=pBCSMaPKXMT1sZlNewmccMBaLwsK3JYbJLy8rjLJ/Ihd/POEof/y8h3ZRj3r3A0u3d
         SGdNkV6ovdoSjzc019f11JSPYZRQRmiBCFbBfe1PVpN/49Ddc0sF0CE0A1SsZLwSBvs7
         mQFOaFuRht1HrtE2eG92h1FcI9SaPCXYADumU=
Received: by 10.143.43.11 with SMTP id v11mr35783wfj.135.1292592470852;
        Fri, 17 Dec 2010 05:27:50 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id f5sm384036wfg.14.2010.12.17.05.27.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 05:27:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Dec 2010 20:26:48 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163879>

=46rom: Elijah Newren <newren@gmail.com>

When traversing commits, the selection of commits would heed the list o=
f
pathspecs passed, but subsequent walking of the trees of those commits
would not.  This resulted in 'rev-list --objects HEAD -- <paths>'
displaying objects at unwanted paths.

Have process_tree() call tree_entry_interesting() to determine which pa=
ths
are interesting and should be walked.

Naturally, this change can provide a large speedup when paths are speci=
fied
together with --objects, since many tree entries are now correctly igno=
red.
Interestingly, though, this change also gives me a small (~1%) but
repeatable speedup even when no paths are specified with --objects.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Replacement for 1/2 of en/object-list-with-pathspec, on top of
 nd/struct-pathspec v2 and followup patches.

 Note that I dropped path_name() changes.

 list-objects.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 8953548..61f6cc9 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -61,12 +61,15 @@ static void process_tree(struct rev_info *revs,
 			 struct tree *tree,
 			 show_object_fn show,
 			 struct name_path *path,
+			 struct strbuf *base,
 			 const char *name)
 {
 	struct object *obj =3D &tree->object;
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
+	int all_interesting =3D (revs->diffopt.pathspec.nr =3D=3D 0);
+	int baselen =3D base->len;
=20
 	if (!revs->tree_objects)
 		return;
@@ -82,13 +85,32 @@ static void process_tree(struct rev_info *revs,
 	me.elem =3D name;
 	me.elem_len =3D strlen(name);
=20
+	if (!all_interesting) {
+		strbuf_addstr(base, name);
+		if (base->len)
+			strbuf_addch(base, '/');
+	}
+
 	init_tree_desc(&desc, tree->buffer, tree->size);
=20
 	while (tree_entry(&desc, &entry)) {
+		if (!all_interesting) {
+			int showit =3D tree_entry_interesting(&entry,
+							    base, 0,
+							    &revs->diffopt.pathspec);
+
+			if (showit < 0)
+				break;
+			else if (!showit)
+				continue;
+			else if (showit =3D=3D 2)
+				all_interesting =3D 1;
+		}
+
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
-				     show, &me, entry.path);
+				     show, &me, base, entry.path);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
 					show, &me, entry.path);
@@ -97,6 +119,7 @@ static void process_tree(struct rev_info *revs,
 				     lookup_blob(entry.sha1),
 				     show, &me, entry.path);
 	}
+	strbuf_setlen(base, baselen);
 	free(tree->buffer);
 	tree->buffer =3D NULL;
 }
@@ -146,7 +169,9 @@ void traverse_commit_list(struct rev_info *revs,
 {
 	int i;
 	struct commit *commit;
+	struct strbuf base;
=20
+	strbuf_init(&base, PATH_MAX);
 	while ((commit =3D get_revision(revs)) !=3D NULL) {
 		add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
@@ -164,7 +189,7 @@ void traverse_commit_list(struct rev_info *revs,
 		}
 		if (obj->type =3D=3D OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     NULL, name);
+				     NULL, &base, name);
 			continue;
 		}
 		if (obj->type =3D=3D OBJ_BLOB) {
@@ -181,4 +206,5 @@ void traverse_commit_list(struct rev_info *revs,
 		revs->pending.alloc =3D 0;
 		revs->pending.objects =3D NULL;
 	}
+	strbuf_release(&base);
 }
--=20
1.7.3.3.476.g10a82
