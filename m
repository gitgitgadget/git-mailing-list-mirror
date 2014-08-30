From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/32] checkout: reject if the branch is already checked out elsewhere
Date: Sat, 30 Aug 2014 15:33:54 +0700
Message-ID: <1409387642-24492-25-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:36:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe8x-00037H-KV
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbaH3IgH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:36:07 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33743 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbaH3IgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:36:03 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so8187300pab.29
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Go73E3TLaV5B5hkKGoO2ucO4vlPV3BtltqYWnF1WxX8=;
        b=PgKl0R5VNDlKL9Cccc7omI4BTPw6vi54FOnNyNV2+nH+xGIwpe7+9ejCWopfj1/znv
         MxfghWiKLcO4edbv5mfiW0hBAeSj6v8m6bTQ6CQysATpz5Kz+Odkt5cVLmC5pm/XoChi
         29BAxyKBSuO7iukTFLCzFFsOm91OS4nBrCvvL6o+DDWCXSvY0X0lu2ck78Fv6jomAEVa
         ilBjpJfnQ4FuO4Kuw3rSbl/Sf76k1uJi46zml4+ro/gIE9uv4xdhqD3fs7V+ES/Y8+Dq
         kK57YDCwj8MXR5p6wNDnrn+LC7b8KcesU01uKOd4nj/ObEy2qPtm1f8pHEGKWU2YuKif
         cUsA==
X-Received: by 10.68.225.133 with SMTP id rk5mr21841333pbc.101.1409387762935;
        Sat, 30 Aug 2014 01:36:02 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id ix1sm772025pbc.60.2014.08.30.01.36.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:36:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:36:12 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256234>

One branch obviously can't be checked out at two places (but detached
heads are ok). Give the user a choice in this case: --detach, -b
new-branch, switch branch in the other checkout first or simply 'cd'
and continue to work there.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 86 ++++++++++++++++++++++++++++++++++++++++++=
++++++--
 t/t2025-checkout-to.sh | 25 ++++++++++++---
 2 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4ae925a..614db34 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -432,6 +432,11 @@ struct branch_info {
 	const char *name; /* The short name used */
 	const char *path; /* The full name of a real branch */
 	struct commit *commit; /* The named commit */
+	/*
+	 * if not null the branch is detached because it's already
+	 * checked out in this checkout
+	 */
+	char *checkout;
 };
=20
 static void setup_branch_path(struct branch_info *branch)
@@ -989,12 +994,78 @@ static const char *unique_tracking_name(const cha=
r *name, unsigned char *sha1)
 	return NULL;
 }
=20
+static void check_linked_checkout(struct branch_info *new, const char =
*id)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+	struct strbuf gitdir =3D STRBUF_INIT;
+	const char *start, *end;
+
+	if (id)
+		strbuf_addf(&path, "%s/repos/%s/HEAD", get_git_common_dir(), id);
+	else
+		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+
+	if (strbuf_read_file(&sb, path.buf, 0) < 0 ||
+	    !skip_prefix(sb.buf, "ref:", &start))
+		goto done;
+	while (isspace(*start))
+		start++;
+	end =3D start;
+	while (*end && !isspace(*end))
+		end++;
+	if (strncmp(start, new->path, end - start) || new->path[end - start] =
!=3D '\0')
+		goto done;
+	if (id) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/repos/%s/gitdir", get_git_common_dir(), id);
+		if (strbuf_read_file(&gitdir, path.buf, 0) <=3D 0)
+			goto done;
+		strbuf_rtrim(&gitdir);
+	} else
+		strbuf_addstr(&gitdir, get_git_common_dir());
+	die(_("'%s' is already checked out at '%s'"), new->name, gitdir.buf);
+done:
+	strbuf_release(&path);
+	strbuf_release(&sb);
+	strbuf_release(&gitdir);
+}
+
+static void check_linked_checkouts(struct branch_info *new)
+{
+	struct strbuf path =3D STRBUF_INIT;
+	DIR *dir;
+	struct dirent *d;
+
+	strbuf_addf(&path, "%s/repos", get_git_common_dir());
+	if ((dir =3D opendir(path.buf)) =3D=3D NULL) {
+		strbuf_release(&path);
+		return;
+	}
+
+	/*
+	 * $GIT_COMMON_DIR/HEAD is practically outside
+	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
+	 * uses git_path). Parse the ref ourselves.
+	 */
+	check_linked_checkout(new, NULL);
+
+	while ((d =3D readdir(dir)) !=3D NULL) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		check_linked_checkout(new, d->d_name);
+	}
+	strbuf_release(&path);
+	closedir(dir);
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
 				struct tree **source_tree,
 				unsigned char rev[20],
-				const char **new_branch)
+				const char **new_branch,
+				int force_detach)
 {
 	int argcount =3D 0;
 	unsigned char branch_rev[20];
@@ -1116,6 +1187,16 @@ static int parse_branchname_arg(int argc, const =
char **argv,
 	else
 		new->path =3D NULL; /* not an existing branch */
=20
+	if (new->path && !force_detach && !*new_branch) {
+		unsigned char sha1[20];
+		int flag;
+		char *head_ref =3D resolve_refdup("HEAD", sha1, 0, &flag);
+		if (head_ref &&
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
+			check_linked_checkouts(new);
+		free(head_ref);
+	}
+
 	new->commit =3D lookup_commit_reference_gently(rev, 1);
 	if (!new->commit) {
 		/* not a commit */
@@ -1322,7 +1403,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 			!opts.new_branch;
 		int n =3D parse_branchname_arg(argc, argv, dwim_ok,
 					     &new, &opts.source_tree,
-					     rev, &opts.new_branch);
+					     rev, &opts.new_branch,
+					     opts.force_detach);
 		argv +=3D n;
 		argc -=3D n;
 	}
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 75ac420..796472b 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -24,13 +24,14 @@ test_expect_success 'checkout --to refuses to check=
out locked branch' '
 '
=20
 test_expect_success 'checkout --to a new worktree' '
-	git checkout --to here master &&
+	git rev-parse HEAD >expect &&
+	git checkout --detach --to here master &&
 	(
 		cd here &&
 		test_cmp ../init.t init.t &&
-		git symbolic-ref HEAD >actual &&
-		echo refs/heads/master >expect &&
-		test_cmp expect actual &&
+		test_must_fail git symbolic-ref HEAD &&
+		git rev-parse HEAD >actual &&
+		test_cmp ../expect actual &&
 		git fsck
 	)
 '
@@ -48,7 +49,7 @@ test_expect_success 'checkout --to a new worktree fro=
m a subdir' '
 test_expect_success 'checkout --to from a linked checkout' '
 	(
 		cd here &&
-		git checkout --to nested-here master
+		git checkout --detach --to nested-here master
 		cd nested-here &&
 		git fsck
 	)
@@ -66,4 +67,18 @@ test_expect_success 'checkout --to a new worktree cr=
eating new branch' '
 	)
 '
=20
+test_expect_success 'die the same branch is already checked out' '
+	(
+		cd here &&
+		test_must_fail git checkout newmaster
+	)
+'
+
+test_expect_success 'not die on re-checking out current branch' '
+	(
+		cd there &&
+		git checkout newmaster
+	)
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480
