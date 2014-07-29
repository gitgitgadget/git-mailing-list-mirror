From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/8] checkout: no auto-detach if the ref is already checked out
Date: Tue, 29 Jul 2014 20:50:27 +0700
Message-ID: <1406641831-2390-5-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:53:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7qM-0005wq-7p
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbaG2NxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:53:24 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46931 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbaG2Nwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:52:53 -0400
Received: by mail-pd0-f179.google.com with SMTP id ft15so11753822pdb.10
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9qtU9jszz+prJTEcGb7idfu7U7EajU4vfIt1jawmjAg=;
        b=FAtx4Ksrqy5FzKtSTGQl0YtyTWbttzZkSt6rltKd8TSiXUCcTEpjbYAjzyeY/KdhEw
         QG1zR4aVMvFFiX7jXmLKi6xI3j9Tg/6gn1z8hxKmgfB4ROIKe3YlwjQNIAaR/ntqB7j7
         cMTefoRXaI6kDQd4vW32HU0gFGvKZXRPKpzFaNcaWsZiHcZCrZ8ppaet7AC4AF9r6vGp
         Lq2Xnp2/bKb78sXKApUsm0XmtjfTEF573sWThXCEU1AeFYsHjpdvwOZulTAhkjb/gd+S
         PZ7MLqUckt3QpX0iaTNwy1WOphYRJ51r7O74tlARgzr+8jgfY3cf6X4dkfvreDARhBZQ
         oLjw==
X-Received: by 10.66.121.168 with SMTP id ll8mr2319637pab.86.1406641972684;
        Tue, 29 Jul 2014 06:52:52 -0700 (PDT)
Received: from lanh ([115.73.243.195])
        by mx.google.com with ESMTPSA id eh4sm20826295pbc.79.2014.07.29.06.52.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2014 06:52:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jul 2014 20:52:55 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254442>

Give the user a choice in this case: detach, make a new branch,
release current branch in the other checkout or simply 'cd' there and
continue to work.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  4 +++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 builtin/checkout.c       | 76 ++++++++++++++++++++++++++--------------=
--------
 t/t2025-checkout-to.sh   | 16 +++++-----
 5 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 57999fa..b2c3388 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -201,6 +201,10 @@ advice.*::
 	rmHints::
 		In case of failure in the output of linkgit:git-rm[1],
 		show directions on how to proceed from the current state.
+	checkoutLocked::
+		In multiple checkout setup, attempting to checkout a
+		branch already checked out elsewhere will fail. Show
+		some useful options to proceed.
 --
=20
 core.fileMode::
diff --git a/advice.c b/advice.c
index 9b42033..cf3b0f7 100644
--- a/advice.c
+++ b/advice.c
@@ -15,6 +15,7 @@ int advice_detached_head =3D 1;
 int advice_set_upstream_failure =3D 1;
 int advice_object_name_warning =3D 1;
 int advice_rm_hints =3D 1;
+int advice_checkout_locked =3D 1;
=20
 static struct {
 	const char *name;
@@ -35,6 +36,7 @@ static struct {
 	{ "setupstreamfailure", &advice_set_upstream_failure },
 	{ "objectnamewarning", &advice_object_name_warning },
 	{ "rmhints", &advice_rm_hints },
+	{ "checkoutlocked", &advice_checkout_locked },
=20
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index 5ecc6c1..935631d 100644
--- a/advice.h
+++ b/advice.h
@@ -18,6 +18,7 @@ extern int advice_detached_head;
 extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
 extern int advice_rm_hints;
+extern int advice_checkout_locked;
=20
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6ac89eb..0714856 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -645,11 +645,6 @@ static void update_refs_for_switch(const struct ch=
eckout_opts *opts,
 			if (old->path && advice_detached_head)
 				detach_advice(new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
-			if (new->checkout && !*new->checkout)
-				fprintf(stderr, _("hint: the main checkout is holding this branch\=
n"));
-			else if (new->checkout)
-				fprintf(stderr, _("hint: the linked checkout %s is holding this br=
anch\n"),
-					new->checkout);
 		}
 	} else if (new->path) {	/* Switch branches. */
 		create_symref("HEAD", new->path, msg.buf);
@@ -1006,31 +1001,50 @@ static const char *unique_tracking_name(const c=
har *name, unsigned char *sha1)
 	return NULL;
 }
=20
-static int check_linked_checkout(struct branch_info *new,
-				  const char *name, const char *path)
+static void check_linked_checkout(struct branch_info *new, const char =
*id)
 {
 	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+	struct strbuf gitdir =3D STRBUF_INIT;
 	const char *start, *end;
-	if (strbuf_read_file(&sb, path, 0) < 0 ||
-	    !skip_prefix(sb.buf, "ref:", &start)) {
-		strbuf_release(&sb);
-		return 0;
-	}
=20
+	if (id)
+		strbuf_addf(&path, "%s/repos/%s/HEAD", get_git_common_dir(), id);
+	else
+		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+
+	if (strbuf_read_file(&sb, path.buf, 0) < 0 ||
+	    !skip_prefix(sb.buf, "ref:", &start))
+		goto done;
 	while (isspace(*start))
 		start++;
 	end =3D start;
 	while (*end && !isspace(*end))
 		end++;
-	if (!strncmp(start, new->path, end - start) &&
-	    new->path[end - start] =3D=3D '\0') {
-		strbuf_release(&sb);
-		new->path =3D NULL; /* detach */
-		new->checkout =3D xstrdup(name); /* reason */
-		return 1;
-	}
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
+	if (advice_checkout_locked)
+		die(_("'%s' is already checked out at %s\n"
+		      "Either go there and continue working, or detach HEAD using\n"
+		      "    git checkout --detach [more options] %s\n"
+		      "or create a new branch based off '%s' using\n"
+		      "    git checkout -b <branch name> [more options] %s\n"
+		      "or switch to another branch at the other checkout and retry."=
),
+		    new->name, gitdir.buf, new->name, new->name, new->name);
+	else
+		die(_("'%s' is already checked out at %s"), new->name, gitdir.buf);
+done:
+	strbuf_release(&path);
 	strbuf_release(&sb);
-	return 0;
+	strbuf_release(&gitdir);
 }
=20
 static void check_linked_checkouts(struct branch_info *new)
@@ -1045,27 +1059,17 @@ static void check_linked_checkouts(struct branc=
h_info *new)
 		return;
 	}
=20
-	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 	/*
 	 * $GIT_COMMON_DIR/HEAD is practically outside
 	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
 	 * uses git_path). Parse the ref ourselves.
 	 */
-	if (check_linked_checkout(new, "", path.buf)) {
-		strbuf_release(&path);
-		closedir(dir);
-		return;
-	}
+	check_linked_checkout(new, NULL);
=20
 	while ((d =3D readdir(dir)) !=3D NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s/repos/%s/HEAD",
-			    get_git_common_dir(), d->d_name);
-		if (check_linked_checkout(new, d->d_name, path.buf))
-			break;
+		check_linked_checkout(new, d->d_name);
 	}
 	strbuf_release(&path);
 	closedir(dir);
@@ -1076,7 +1080,8 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
 				struct branch_info *new,
 				struct tree **source_tree,
 				unsigned char rev[20],
-				const char **new_branch)
+				const char **new_branch,
+				int force_detach)
 {
 	int argcount =3D 0;
 	unsigned char branch_rev[20];
@@ -1198,7 +1203,7 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
 	else
 		new->path =3D NULL; /* not an existing branch */
=20
-	if (new->path) {
+	if (new->path && !force_detach && !*new_branch) {
 		unsigned char sha1[20];
 		int flag;
 		char *head_ref =3D resolve_refdup("HEAD", sha1, 0, &flag);
@@ -1417,7 +1422,8 @@ int cmd_checkout(int argc, const char **argv, con=
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
index b0d97a0..c6601a4 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -14,7 +14,7 @@ test_expect_success 'checkout --to not updating paths=
' '
=20
 test_expect_success 'checkout --to a new worktree' '
 	git rev-parse HEAD >expect &&
-	git checkout --to here master &&
+	git checkout --detach --to here master &&
 	(
 		cd here &&
 		test_cmp ../init.t init.t &&
@@ -28,7 +28,7 @@ test_expect_success 'checkout --to a new worktree' '
 test_expect_success 'checkout --to from a linked checkout' '
 	(
 		cd here &&
-		git checkout --to nested-here master
+		git checkout --detach --to nested-here master
 		cd nested-here &&
 		git fsck
 	)
@@ -46,19 +46,17 @@ test_expect_success 'checkout --to a new worktree c=
reating new branch' '
 	)
 '
=20
-test_expect_success 'detach if the same branch is already checked out'=
 '
+test_expect_success 'die the same branch is already checked out' '
 	(
 		cd here &&
-		git checkout newmaster &&
-		test_must_fail git symbolic-ref HEAD
+		test_must_fail git checkout newmaster
 	)
 '
=20
-test_expect_success 'not detach on re-checking out current branch' '
+test_expect_success 'not die on re-checking out current branch' '
 	(
 		cd there &&
-		git checkout newmaster &&
-		git symbolic-ref HEAD
+		git checkout newmaster
 	)
 '
=20
@@ -66,7 +64,7 @@ test_expect_success 'checkout --to from a bare repo' =
'
 	(
 		git clone --bare . bare &&
 		cd bare &&
-		git checkout --to ../there2 master
+		git checkout --to ../there2 -b bare-master master
 	)
 '
=20
--=20
2.1.0.rc0.78.gc0d8480
