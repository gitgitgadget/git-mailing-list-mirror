From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/8] Make rev-list --objects work together with pathspecs
Date: Thu,  9 Sep 2010 01:50:21 +1000
Message-ID: <1283961023-4491-7-git-send-email-pclouds@gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 05:23:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtXjS-0000RF-Mp
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 05:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab0IIDXO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 23:23:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42783 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0IIDXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 23:23:11 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so315428pvg.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 20:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GbbJ0W+VlNEB6gfveHaro56Tr+RAKxi+uF7CpUIP/bs=;
        b=cdplXlKc1Gukez5ND5WtIap0t7bN1iRiWye7ltjlI4NoZsW7TYkQZG25ARAptbD0rL
         rIsV5Lck9qXJiG6zZYBANMRQUQu074muKewA+o6ISIqWGMlZnntB8A+Q6HfyZ0Iiu/Ri
         zZmPfl41igN/AkBuJqpAaQnxlVK//gjH7/9/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=e++RqJyTfcec9sNsqiJrxVnnvXbN+k+Hz9rGnP/HadDWFKo02e7SOPatLn8LZEtQ63
         8gS7HfeR8DVLd5H5dK1hAAaX0d+mjaaXRLZkkSDkoUcgHSZuuPkVk1AfImb0aJK1ikCC
         b1DSojJo4KROzQodKLw6hSM4K1ra3mfGYGQCI=
Received: by 10.143.164.8 with SMTP id r8mr454057wfo.118.1284002591457;
        Wed, 08 Sep 2010 20:23:11 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id n34sm828596wfa.2.2010.09.08.20.23.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 20:23:10 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Sep 2010 01:51:15 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g13aff
In-Reply-To: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155835>

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
 list-objects.c           |   23 +++++++++++++++++++++++
 revision.c               |    8 ++++++--
 revision.h               |    3 ++-
 t/t6000-rev-list-misc.sh |    6 +++---
 4 files changed, 34 insertions(+), 6 deletions(-)

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
index b2a5867..4d7dc4b 100644
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
1.7.1.rc1.70.g13aff
