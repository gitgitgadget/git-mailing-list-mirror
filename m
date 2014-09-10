From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 24/32] checkout: reject if the branch is already checked out elsewhere
Date: Thu, 11 Sep 2014 05:42:00 +0700
Message-ID: <1410388928-32265-25-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:44:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqcf-0002L6-Np
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbaIJWoR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:44:17 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35071 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaIJWoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:44:16 -0400
Received: by mail-pa0-f49.google.com with SMTP id lf10so6565820pab.8
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gSDaYso1ejcvXqH21X6aG5MVY7pMyJSXr3Fx/fqu5Wo=;
        b=CjN8fy7oGB6zSZpISBL4kasqcwrwyDI+00wvx8ES0Nnkc5lFnRWzwR5lavXXxj6Fxg
         8Fla9ewKRtrZatSddkGcRbfUc4VT5HRFgb1wL8uH/++BIlJXf8yUV7HtiiXe/fDHpq/n
         v9gVYBJhWHYmotjQX1m2em3iFg/CAwH/lQJV1wrTGkk82QEzVl72iTTIAA1kMp760H0U
         AeIZLY5q/S0YltTREnFTkMk2rzI6ogpO+c/2TzWGzdYNz9m4BeIPSxd43PF4PkfL1Rpy
         +Ip4jXezmq3mZxqZKDC1AsaLp389UKYp8Ue6L5kTndpLzM9rsdqH98kE9m2/+9nKPZy1
         /6/g==
X-Received: by 10.66.65.133 with SMTP id x5mr67852813pas.26.1410389055779;
        Wed, 10 Sep 2014 15:44:15 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id ry9sm16347588pab.37.2014.09.10.15.44.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:44:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:44:35 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256801>

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
index b5ddf88..6d623fa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -431,6 +431,11 @@ struct branch_info {
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
@@ -954,12 +959,78 @@ static const char *unique_tracking_name(const cha=
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
+		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id)=
;
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
+		strbuf_addf(&path, "%s/worktrees/%s/gitdir", get_git_common_dir(), i=
d);
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
+	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
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
@@ -1081,6 +1152,16 @@ static int parse_branchname_arg(int argc, const =
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
@@ -1287,7 +1368,8 @@ int cmd_checkout(int argc, const char **argv, con=
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
index 8c73b18..afa8a62 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -18,13 +18,14 @@ test_expect_success 'checkout --to an existing work=
tree' '
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
@@ -42,7 +43,7 @@ test_expect_success 'checkout --to a new worktree fro=
m a subdir' '
 test_expect_success 'checkout --to from a linked checkout' '
 	(
 		cd here &&
-		git checkout --to nested-here master
+		git checkout --detach --to nested-here master
 		cd nested-here &&
 		git fsck
 	)
@@ -60,4 +61,18 @@ test_expect_success 'checkout --to a new worktree cr=
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
