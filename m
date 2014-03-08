From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 24/28] checkout: detach if the branch is already checked out elsewhere
Date: Sat,  8 Mar 2014 09:48:16 +0700
Message-ID: <1394246900-31535-25-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:50:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7LI-0006BN-Ag
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbaCHCuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:50:21 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:41176 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbaCHCuT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:50:19 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so4786251pdj.40
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5AuGvNMmhTMLjU3KGVEUDDhCqiFbbBvbmcFUom/1tqw=;
        b=FKbFo1esT0cCh16lMT8EkD2zDM8AWMmHLT1guMRXnnybxS3nl0AvNoBPITrfAUF1aD
         bB1YncqfuPr0K1oBZ3EDLn2kzmfRzPmWL3cOdI6obd0lCSakzs2+eJwc5FxIN4m+g0CJ
         MJyn6hNn7Fu21Xkq/qfC+edcigU+IYLP+93Kh1sRAQpmkWCMAieaQ5Medbh4gky0SVt/
         DMyYjG3PjNofhHjpy1cHHYX/u1+ocbyqwleMGqtU83YZ7HLJZd/VJ4y1RMGKi4Q4AyT9
         ch6QGsbQf0YWRx5HYvt11rMvO41rnmk+v9xn/c6XVD5WE8ymOJdl6DSD2nLnnieBMTuw
         yVhg==
X-Received: by 10.68.239.70 with SMTP id vq6mr25712601pbc.152.1394247019172;
        Fri, 07 Mar 2014 18:50:19 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id db3sm41733832pbb.10.2014.03.07.18.50.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:50:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:50:52 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243665>

The normal rule is anything outside refs/heads/ is detached. This
increases strictness of the rule a bit more: if the branch is checked
out (either in $GIT_COMMON_DIR/HEAD or any $GIT_DIR/repos/.../HEAD)
then it's detached as well.

A hint is given so the user knows where to go and do something there
if they still want to checkout undetached here.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 80 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t2025-checkout-to.sh | 15 ++++++++--
 2 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 97fdfcc..598b43d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -433,6 +433,11 @@ struct branch_info {
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
@@ -641,6 +646,11 @@ static void update_refs_for_switch(const struct ch=
eckout_opts *opts,
 			if (old->path && advice_detached_head)
 				detach_advice(new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
+			if (new->checkout && !*new->checkout)
+				fprintf(stderr, _("hint: the main checkout is holding this branch\=
n"));
+			else if (new->checkout)
+				fprintf(stderr, _("hint: the linked checkout %s is holding this br=
anch\n"),
+					new->checkout);
 		}
 	} else if (new->path) {	/* Switch branches. */
 		create_symref("HEAD", new->path, msg.buf);
@@ -983,6 +993,73 @@ static const char *unique_tracking_name(const char=
 *name, unsigned char *sha1)
 	return NULL;
 }
=20
+static int check_linked_checkout(struct branch_info *new,
+				  const char *name, const char *path)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	char *start, *end;
+	if (strbuf_read_file(&sb, path, 0) < 0)
+		return 0;
+	if (!starts_with(sb.buf, "ref:")) {
+		strbuf_release(&sb);
+		return 0;
+	}
+
+	start =3D sb.buf + 4;
+	while (isspace(*start))
+		start++;
+	end =3D start;
+	while (*end && !isspace(*end))
+		end++;
+	if (!strncmp(start, new->path, end - start) &&
+	    new->path[end - start] =3D=3D '\0') {
+		strbuf_release(&sb);
+		new->path =3D NULL; /* detach */
+		new->checkout =3D xstrdup(name); /* reason */
+		return 1;
+	}
+	strbuf_release(&sb);
+	return 0;
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
+	strbuf_reset(&path);
+	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+	/*
+	 * $GIT_COMMON_DIR/HEAD is practically outside
+	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
+	 * uses git_path). Parse the ref ourselves.
+	 */
+	if (check_linked_checkout(new, "", path.buf)) {
+		strbuf_release(&path);
+		closedir(dir);
+		return;
+	}
+
+	while ((d =3D readdir(dir)) !=3D NULL) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/repos/%s/HEAD",
+			    get_git_common_dir(), d->d_name);
+		if (check_linked_checkout(new, d->d_name, path.buf))
+			break;
+	}
+	strbuf_release(&path);
+	closedir(dir);
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
@@ -1110,6 +1187,9 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
 	else
 		new->path =3D NULL; /* not an existing branch */
=20
+	if (new->path)
+		check_linked_checkouts(new);
+
 	new->commit =3D lookup_commit_reference_gently(rev, 1);
 	if (!new->commit) {
 		/* not a commit */
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 5ec49e2..2d35a9b 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -13,13 +13,14 @@ test_expect_success 'checkout --to not updating pat=
hs' '
 '
=20
 test_expect_success 'checkout --to a new worktree' '
+	git rev-parse HEAD >expect &&
 	git checkout --to here master &&
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
@@ -45,4 +46,12 @@ test_expect_success 'checkout --to a new worktree cr=
eating new branch' '
 	)
 '
=20
+test_expect_success 'detach if the same branch is already checked out'=
 '
+	(
+		cd here &&
+		git checkout newmaster &&
+		test_must_fail git symbolic-ref HEAD
+	)
+'
+
 test_done
--=20
1.9.0.40.gaa8c3ea
