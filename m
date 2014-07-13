From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 24/31] checkout: detach if the branch is already checked out elsewhere
Date: Sun, 13 Jul 2014 11:51:01 +0700
Message-ID: <1405227068-25506-25-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:55:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Bor-0001MC-7T
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbaGMEzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:55:20 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:45888 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbaGMEzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:55:19 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so3497642pde.31
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BBNuiGkkE7xM6IPCkkhkmmgUmZMW6ZFeLHaFp0gP9K8=;
        b=lI20Ok4WGIW8fn1qRIl/CYFdlsZCnGaYrT6L9SjzPytY0WWXEGj+mqEnZZTNW7s9OD
         sp3oqK9icVOC2ppi4mtfG9+xP7TWIDbe2c9lP8m9pxVlzfQWcltoBZ95zXI+Ja1s3Q0b
         AwmaaPR8jOz4U5qjOh/Xwd66jj9w0XtuEAXb9s4dQK3AaiCkbyamDq8dTiZVQ+i+nzon
         xoxCdSGJ7RedZb4kp4OQl00IdTEiHIl4kEyTsn8t0wLzVaqZ7ih4KCoqMUn+SBKUEtz8
         wW8x8ouxjyej6WbaLEaDslQGnqokYnWwjo5pws0inkwTiok7B3vNVWvzE229019TTnbq
         P6dw==
X-Received: by 10.66.188.5 with SMTP id fw5mr8664808pac.63.1405227319286;
        Sat, 12 Jul 2014 21:55:19 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id fi2sm6446711pbc.77.2014.07.12.21.55.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:55:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:55:19 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253427>

The normal rule is anything outside refs/heads/ is detached. This
increases strictness of the rule a bit more: if the branch is checked
out (either in $GIT_COMMON_DIR/HEAD or any $GIT_DIR/repos/.../HEAD)
then it's detached as well.

A hint is given so the user knows where to go and do something there
if they still want to checkout undetached here.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 84 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t2025-checkout-to.sh | 23 ++++++++++++--
 2 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3167fd2..fe24766 100644
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
@@ -640,6 +645,11 @@ static void update_refs_for_switch(const struct ch=
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
@@ -982,6 +992,71 @@ static const char *unique_tracking_name(const char=
 *name, unsigned char *sha1)
 	return NULL;
 }
=20
+static int check_linked_checkout(struct branch_info *new,
+				  const char *name, const char *path)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *start, *end;
+	if (strbuf_read_file(&sb, path, 0) < 0 ||
+	    !skip_prefix(sb.buf, "ref:", &start)) {
+		strbuf_release(&sb);
+		return 0;
+	}
+
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
@@ -1109,6 +1184,15 @@ static int parse_branchname_arg(int argc, const =
char **argv,
 	else
 		new->path =3D NULL; /* not an existing branch */
=20
+	if (new->path) {
+		unsigned char sha1[20];
+		int flag;
+		char *head_ref =3D resolve_refdup("HEAD", sha1, 0, &flag);
+		if (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path))
+			check_linked_checkouts(new);
+		free(head_ref);
+	}
+
 	new->commit =3D lookup_commit_reference_gently(rev, 1);
 	if (!new->commit) {
 		/* not a commit */
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 5ec49e2..20e3dc7 100755
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
@@ -45,4 +46,20 @@ test_expect_success 'checkout --to a new worktree cr=
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
+test_expect_success 'not detach on re-checking out current branch' '
+	(
+		cd there &&
+		git checkout newmaster &&
+		git symbolic-ref HEAD
+	)
+'
+
 test_done
--=20
1.9.1.346.ga2b5940
