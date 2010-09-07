From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] Make rev-list --objects work together with pathspecs
Date: Wed,  8 Sep 2010 01:48:03 +1000
Message-ID: <1283874483-32017-6-git-send-email-pclouds@gmail.com>
References: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 03:38:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot9cn-0005A2-Bz
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 03:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020Ab0IHBiq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 21:38:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38640 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab0IHBip (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 21:38:45 -0400
Received: by pzk9 with SMTP id 9so1950122pzk.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 18:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CBeNikPIK+kK2ZyHzytGepohqno2ymp7uVcUnvcDCV8=;
        b=Gila5RH0DvjdOJzPKzGFP5Xo4ZD80/zhFM+h7YsmfS2cYr6rgs0ZrSTLI6FFoOD1Oq
         u8JabWDZ01Jhw9cAFUYxf50Rnamw0L3ei2igOq1PAVzzj/NKPBnxxSEN00kgyyRQSBnc
         Lr3YQevY+ra8Xe4TfuKPJXSAxyXxKYOWhe+Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XJOWHTTTDRgo9sfANQQeTOALPLchtV82qVGT4lQH3yNBvjMC6Lan2mNmrWRZ9DnTJ2
         YNCEIUs8YCn8H5c7oLZg332khawJL5puZbQzDtJvGVIvAInmfSyRATGdkjsmSRaZ2Wf1
         w7w29FOz4Pktz7MbiDIpVN3R3wo1rfRM9jOvk=
Received: by 10.142.225.5 with SMTP id x5mr402444wfg.285.1283909925225;
        Tue, 07 Sep 2010 18:38:45 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id n35sm6497160wfa.3.2010.09.07.18.38.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 18:38:44 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Sep 2010 11:38:39 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155757>

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
 list-objects.c           |   25 +++++++++++++++++++++++++
 revision.c               |    8 ++++++--
 revision.h               |    3 ++-
 t/t6000-rev-list-misc.sh |    6 +++---
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 8953548..44efca3 100644
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
+							    &revs->diffopt.el);
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
@@ -147,6 +170,7 @@ void traverse_commit_list(struct rev_info *revs,
 	int i;
 	struct commit *commit;
=20
+	diff_tree_setup_exclude_list(&revs->diffopt);
 	while ((commit =3D get_revision(revs)) !=3D NULL) {
 		add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
@@ -181,4 +205,5 @@ void traverse_commit_list(struct rev_info *revs,
 		revs->pending.alloc =3D 0;
 		revs->pending.objects =3D NULL;
 	}
+	free(revs->diffopt.el.excludes);
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
