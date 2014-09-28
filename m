From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 24/32] checkout: reject if the branch is already checked out elsewhere
Date: Sun, 28 Sep 2014 08:22:38 +0700
Message-ID: <1411867366-3821-25-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:25:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3Ec-0002it-NZ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbaI1BZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:25:04 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:52933 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BZC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:25:02 -0400
Received: by mail-pd0-f171.google.com with SMTP id y13so14855186pdi.16
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/uE3PwfXOkoumwWws+fePrE3Zn3bk5H2kybZzqx97p0=;
        b=tnGAWcZ1d1uEgfZMxDahAWpJ0HwilUHf+yf388zxi1qv+YE/4IgC2EB/4CRacKGWg/
         jX03EX8v6wIgfw7HsOsNwM/7pZzYc76v/BpqWj9CrIbaNssAGt4tiNWtvT0ajQaPMzWQ
         LA9tsVfgxh6HZxilldBJeBRGLk3NnKpDPPm0uuaYJgIEjZj3fCwUmgEsz6290nM+t44U
         0Y4z1SzczfJK5mA4Kd155O/HXD1ZwJWU2rX+X7/DIoEwPlA4SN0E7uO/Q0BfwrquwS45
         y4OqZWnh+is9lkEyIYMe5yrcGUBNwzz2wo0h84tP/cDigroBWeV7YJG+RJcKyB5Z827s
         VXUw==
X-Received: by 10.67.14.198 with SMTP id fi6mr11100091pad.34.1411867501877;
        Sat, 27 Sep 2014 18:25:01 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id yt3sm8533984pbc.34.2014.09.27.18.24.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:25:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:25:04 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257583>

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
index ab46af9..6d68913 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -430,6 +430,11 @@ struct branch_info {
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
@@ -958,12 +963,78 @@ static const char *unique_tracking_name(const cha=
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
@@ -1085,6 +1156,16 @@ static int parse_branchname_arg(int argc, const =
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
@@ -1291,7 +1372,8 @@ int cmd_checkout(int argc, const char **argv, con=
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
index 4963415..edd3404 100755
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
-		git checkout --to nested-here master &&
+		git checkout --detach --to nested-here master &&
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
