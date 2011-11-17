From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/8] Convert resolve_ref_unsafe+xstrdup to resolve_ref
Date: Thu, 17 Nov 2011 16:32:13 +0700
Message-ID: <1321522335-24193-7-git-send-email-pclouds@gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 10:29:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQyHu-0002uD-Gc
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 10:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab1KQJ3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 04:29:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44094 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210Ab1KQJ33 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 04:29:29 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so1839093iag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 01:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4UMbw1gzliYPONoQ/kufDasFjrhc/znmFxSgO2BhRbs=;
        b=NZ8dWPG4Zxq8QwoTjMFEDq2HWmMp5jsoiBIPqq+yFRIB20l41im7xvQHr0B7omlqh9
         sZEmXBJQ5AGtD92YcwKofODo8HNXEkVV79LoaMs7Ov+e5pzeqjUtwb8p2sijeDckVl0u
         YhQ3ni8YQGkSDrHthYRdkoYy+JgN5A/wjlEcY=
Received: by 10.42.146.72 with SMTP id i8mr13504607icv.38.1321522169050;
        Thu, 17 Nov 2011 01:29:29 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id g16sm55698941ibs.8.2011.11.17.01.29.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:29:28 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 17 Nov 2011 16:33:05 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185586>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c       |    3 +--
 builtin/checkout.c     |   13 +++++++------
 builtin/for-each-ref.c |    7 ++-----
 builtin/show-branch.c  |    4 +---
 reflog-walk.c          |    7 +++----
 wt-status.c            |    4 +---
 6 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 633b56e..a254898 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -689,10 +689,9 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
=20
 	track =3D git_branch_track;
=20
-	head =3D resolve_ref_unsafe("HEAD", head_sha1, 0, NULL);
+	head =3D resolve_ref("HEAD", head_sha1, 0, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
-	head =3D xstrdup(head);
 	if (!strcmp(head, "HEAD")) {
 		detached =3D 1;
 	} else {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2b8e73b..6efb1cf 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -696,15 +696,14 @@ static int switch_branches(struct checkout_opts *=
opts, struct branch_info *new)
 {
 	int ret =3D 0;
 	struct branch_info old;
+	char *path;
 	unsigned char rev[20];
 	int flag;
 	memset(&old, 0, sizeof(old));
-	old.path =3D xstrdup(resolve_ref_unsafe("HEAD", rev, 0, &flag));
+	old.path =3D path =3D resolve_ref("HEAD", rev, 0, &flag);
 	old.commit =3D lookup_commit_reference_gently(rev, 1);
-	if (!(flag & REF_ISSYMREF)) {
-		free((char *)old.path);
+	if (!(flag & REF_ISSYMREF))
 		old.path =3D NULL;
-	}
=20
 	if (old.path && !prefixcmp(old.path, "refs/heads/"))
 		old.name =3D old.path + strlen("refs/heads/");
@@ -718,8 +717,10 @@ static int switch_branches(struct checkout_opts *o=
pts, struct branch_info *new)
 	}
=20
 	ret =3D merge_working_tree(opts, &old, new);
-	if (ret)
+	if (ret) {
+		free(path);
 		return ret;
+	}
=20
 	if (!opts->quiet && !old.path && old.commit && new->commit !=3D old.c=
ommit)
 		orphaned_commit_warning(old.commit);
@@ -727,7 +728,7 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 	update_refs_for_switch(opts, &old, new);
=20
 	ret =3D post_checkout_hook(old.commit, new->commit, 1);
-	free((char *)old.path);
+	free(path);
 	return ret || opts->writeout_error;
 }
=20
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b954ca8..dc19f3c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -628,11 +628,8 @@ static void populate_value(struct refinfo *ref)
=20
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		unsigned char unused1[20];
-		const char *symref;
-		symref =3D resolve_ref_unsafe(ref->refname, unused1, 1, NULL);
-		if (symref)
-			ref->symref =3D xstrdup(symref);
-		else
+		ref->symref =3D resolve_ref(ref->refname, unused1, 1, NULL);
+		if (!ref->symref)
 			ref->symref =3D "";
 	}
=20
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 1e7bd31..9e849c7 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -726,10 +726,8 @@ int cmd_show_branch(int ac, const char **av, const=
 char *prefix)
=20
 		if (ac =3D=3D 0) {
 			static const char *fake_av[2];
-			const char *refname;
=20
-			refname =3D resolve_ref_unsafe("HEAD", sha1, 1, NULL);
-			fake_av[0] =3D xstrdup(refname);
+			fake_av[0] =3D resolve_ref("HEAD", sha1, 1, NULL);
 			fake_av[1] =3D NULL;
 			av =3D fake_av;
 			ac =3D 1;
diff --git a/reflog-walk.c b/reflog-walk.c
index 2d5aee0..fd17e71 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -170,11 +170,10 @@ int add_reflog_for_walk(struct reflog_walk_info *=
info,
 	else {
 		if (*branch =3D=3D '\0') {
 			unsigned char sha1[20];
-			const char *head =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);
-			if (!head)
-				die ("No current branch");
 			free(branch);
-			branch =3D xstrdup(head);
+			branch =3D resolve_ref("HEAD", sha1, 0, NULL);
+			if (!branch)
+				die ("No current branch");
 		}
 		reflogs =3D read_complete_reflog(branch);
 		if (!reflogs || reflogs->nr =3D=3D 0) {
diff --git a/wt-status.c b/wt-status.c
index cc6dad5..77adf64 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -111,7 +111,6 @@ void status_printf_more(struct wt_status *s, const =
char *color,
 void wt_status_prepare(struct wt_status *s)
 {
 	unsigned char sha1[20];
-	const char *head;
=20
 	memset(s, 0, sizeof(*s));
 	memcpy(s->color_palette, default_wt_status_colors,
@@ -119,8 +118,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->show_untracked_files =3D SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color =3D -1;
 	s->relative_paths =3D 1;
-	head =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);
-	s->branch =3D head ? xstrdup(head) : NULL;
+	s->branch =3D resolve_ref("HEAD", sha1, 0, NULL);
 	s->reference =3D "HEAD";
 	s->fp =3D stdout;
 	s->index_file =3D get_index_file();
--=20
1.7.4.74.g639db
