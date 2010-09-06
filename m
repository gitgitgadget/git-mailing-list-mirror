From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] Make rev-list --objects work together with pathspecs
Date: Mon,  6 Sep 2010 14:47:09 +1000
Message-ID: <1283748429-31076-5-git-send-email-pclouds@gmail.com>
References: <1283645647-1891-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 06:47:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsTcV-0001Yl-OV
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 06:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112Ab0IFErp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 00:47:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58873 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab0IFEro (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 00:47:44 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so1304132pzk.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 21:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5oze2Tz+LDnGuDi0EV34zzWY45caDOry+k5l+xhcsFE=;
        b=qJ9fILQYfGVNNp9u+cPLq1HdlK8qoXotlhJ7nowYFhfPGqemXukfFO5yJBtN5Yv/r/
         kOa0PeDXAvIhTn1cHkoi6FLXoTkkliZrmHVp3SipPYDgWXUEjaWGkA5sDj1g1m7bUOSJ
         uwuZt/PeBe2v6/3qOy2+nSl1HxOEKcw1JJp98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KR83AJPKz+iulOXMpek8y+RpC0pFNuo6i+VP7oEzZq0vxD7ciXiDHwLkjryLt7/cOZ
         lD9WYWlW2OCxu7TOxeXN9SdXcWDjePovSHpAI2td9bF8q3lVEPSY/hKMxgMzF4HKR52U
         EoN1sCgldWurfuUkojq/7pxl/sWVFqbmbCSeo=
Received: by 10.114.15.18 with SMTP id 18mr2818226wao.182.1283748464197;
        Sun, 05 Sep 2010 21:47:44 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id q6sm10435003waj.10.2010.09.05.21.47.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 21:47:43 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  6 Sep 2010 14:47:37 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283645647-1891-8-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155525>

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
 The "while (tree_entry(..))" loop makes a come back.
 tree_entry_interesting() call is updated.
 Nothing else is changed

 list-objects.c           |   25 +++++++++++++++++++++++++
 revision.c               |    8 ++++++--
 revision.h               |    3 ++-
 t/t6000-rev-list-misc.sh |    6 +++---
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 8953548..8ea1822 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -67,6 +67,9 @@ static void process_tree(struct rev_info *revs,
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
+	int all_interesting =3D (revs->diffopt.nr_paths =3D=3D 0);
+	char *full_prefix =3D NULL;
+	int full_prefix_len =3D 0;
=20
 	if (!revs->tree_objects)
 		return;
@@ -82,9 +85,30 @@ static void process_tree(struct rev_info *revs,
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
+							    revs->diffopt.paths,
+							    revs->diffopt.pathlens,
+							    revs->diffopt.nr_paths);
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
@@ -97,6 +121,7 @@ static void process_tree(struct rev_info *revs,
 				     lookup_blob(entry.sha1),
 				     show, &me, entry.path);
 	}
+	free(full_prefix);
 	free(tree->buffer);
 	tree->buffer =3D NULL;
 }
diff --git a/revision.c b/revision.c
index b1c1890..55c4586 100644
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
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index b3c1dd8..b10685a 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -11,13 +11,13 @@ test_expect_success setup '
 	git commit -m one
 '
=20
-test_expect_failure 'rev-list --objects heeds pathspecs' '
+test_expect_success 'rev-list --objects heeds pathspecs' '
 	git rev-list --objects HEAD -- wanted_file >output &&
 	grep wanted_file output &&
 	! grep unwanted_file output
 '
=20
-test_expect_failure 'rev-list --objects with pathspecs and deeper path=
s' '
+test_expect_success 'rev-list --objects with pathspecs and deeper path=
s' '
 	mkdir foo &&
 	>foo/file &&
 	git add foo/file &&
@@ -31,7 +31,7 @@ test_expect_failure 'rev-list --objects with pathspec=
s and deeper paths' '
 	! grep unwanted_file output
 '
=20
-test_expect_failure 'rev-list --objects with pathspecs and copied file=
s' '
+test_expect_success 'rev-list --objects with pathspecs and copied file=
s' '
 	git checkout --orphan junio-testcase &&
 	git rm -rf . &&
=20
--=20
1.7.1.rc1.69.g24c2f7
