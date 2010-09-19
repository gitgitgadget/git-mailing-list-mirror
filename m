From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] Make rev-list --objects work together with pathspecs
Date: Mon, 20 Sep 2010 09:24:28 +1000
Message-ID: <1284938669-16753-2-git-send-email-pclouds@gmail.com>
References: <1284938669-16753-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:25:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTFl-0008RK-Nb
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab0ISXYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:24:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64381 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab0ISXYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:24:45 -0400
Received: by pzk34 with SMTP id 34so1009081pzk.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LYd3n7P0a1AGWF/TvsU0HOXgmXuh6C4mrXmEorWbanE=;
        b=N6csbSLtUZRgeTX+MKwe1Pt3fL+mQmi75AX2xNOLeFp/P8w5nf+TfSdefcuNn4zcul
         787PRtgSMIDg46iXLGLYY6PbmbFtFzScvgpiw1PLMyttoR0QIj0hnP0FZeXzcSBukL5U
         WICJIuaMvOmlQ2dZEEAjpolplEFAD6oHbiTUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aVtRD3wXMhIWYMJYQziiL6m6cHzoBPKgxT4GU1Gr+c64sj4RCZfepiHxun60qQAuRz
         aqLubLU8kMeTtZIl2UEIUXIurJxSqh9HdKVdPzjwRedY2kSwd9Slx/V7MfaV/TLcZ5PL
         4ZmEUtALbl6FM4utg7roV22oAJVMY4qVS+Tro=
Received: by 10.142.151.34 with SMTP id y34mr381598wfd.171.1284938684118;
        Sun, 19 Sep 2010 16:24:44 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id o9sm6221784wfd.4.2010.09.19.16.24.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:24:43 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:24:37 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284938669-16753-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156529>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 list-objects.c |   23 +++++++++++++++++++++++
 revision.c     |    8 ++++++--
 revision.h     |    3 ++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 8953548..be4cf9f 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -67,6 +67,9 @@ static void process_tree(struct rev_info *revs,
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
+	int all_interesting =3D (revs->diffopt.pathspec.nr =3D=3D 0);
+	char *full_prefix =3D NULL;
+	int full_prefix_len =3D 0;
=20
 	if (!revs->tree_objects)
 		return;
@@ -82,9 +85,28 @@ static void process_tree(struct rev_info *revs,
 	me.elem =3D name;
 	me.elem_len =3D strlen(name);
=20
+	if (!all_interesting) {
+		full_prefix =3D path_name_impl(path, name, 1);
+		full_prefix_len =3D strlen(full_prefix);
+	}
+
 	init_tree_desc(&desc, tree->buffer, tree->size);
=20
 	while (tree_entry(&desc, &entry)) {
+		if (!all_interesting) {
+			int showit =3D tree_entry_interesting(&entry,
+							    full_prefix,
+							    full_prefix_len,
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
@@ -97,6 +119,7 @@ static void process_tree(struct rev_info *revs,
 				     lookup_blob(entry.sha1),
 				     show, &me, entry.path);
 	}
+	free(full_prefix);
 	free(tree->buffer);
 	tree->buffer =3D NULL;
 }
diff --git a/revision.c b/revision.c
index e77184a..352837f 100644
--- a/revision.c
+++ b/revision.c
@@ -16,7 +16,7 @@
=20
 volatile show_early_output_fn_t show_early_output;
=20
-char *path_name(const struct name_path *path, const char *name)
+char *path_name_impl(const struct name_path *path, const char *name, i=
nt isdir)
 {
 	const struct name_path *p;
 	char *n, *m;
@@ -27,7 +27,7 @@ char *path_name(const struct name_path *path, const c=
har *name)
 		if (p->elem_len)
 			len +=3D p->elem_len + 1;
 	}
-	n =3D xmalloc(len);
+	n =3D xmalloc(len + !!isdir);
 	m =3D n + len - (nlen + 1);
 	strcpy(m, name);
 	for (p =3D path; p; p =3D p->up) {
@@ -37,6 +37,10 @@ char *path_name(const struct name_path *path, const =
char *name)
 			m[p->elem_len] =3D '/';
 		}
 	}
+	if (isdir && len > 1) {
+		n[len-1] =3D '/';
+		n[len] =3D '\0';
+	}
 	return n;
 }
=20
diff --git a/revision.h b/revision.h
index 05659c6..92f4feb 100644
--- a/revision.h
+++ b/revision.h
@@ -173,7 +173,8 @@ struct name_path {
 	const char *elem;
 };
=20
-char *path_name(const struct name_path *path, const char *name);
+char *path_name_impl(const struct name_path *path, const char *name, i=
nt isdir);
+#define path_name(path, name) path_name_impl(path, name, 0)
=20
 extern void add_object(struct object *obj,
 		       struct object_array *p,
--=20
1.7.1.rc1.70.g788ca
