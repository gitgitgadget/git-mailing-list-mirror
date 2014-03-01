From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 23/27] checkout: detach if the branch is already checked out elsewhere
Date: Sat,  1 Mar 2014 19:12:59 +0700
Message-ID: <1393675983-3232-24-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJiww-0002kU-W9
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbaCAMXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:23:18 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:57673 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbaCAMXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:23:13 -0500
Received: by mail-pd0-f180.google.com with SMTP id y10so1865670pdj.25
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ojf7ykDQ+KuKB4MyIV+nzJdO/7l5a/hwMHm4sZYS9RE=;
        b=pichagQ+LV9qnToZ6+lumpbdsADmHpkDi7TQNB5SovQuJMfRTs0tRDv9hWW6RMcpZJ
         Y3m8LUFNVMUtDnpIlmEbgneM+GshSsGjwJ7SoWvtWuhWxDMl9kFUMY2jttFgVpXdtaQv
         qdc5Vn0REJkp9MyzhcOu3Ae8KoxbEoAsBBVjOOLt+iuh00f8RWV8HYSBGkzbk18SnFrj
         qna14IOUt/fEhrTUGxfT3Howohl9FeXbPaQvO1qgfteBFRqrQ+LjnHoEJAMqMlrirFZo
         PVvcFFi8a4R0WfTry7oM9g3sOXsWsGshfH0VMm80KmtKrGSzi9s5Fq489GbGgD3q0Qf1
         oECQ==
X-Received: by 10.68.244.229 with SMTP id xj5mr9281619pbc.108.1393676592442;
        Sat, 01 Mar 2014 04:23:12 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id yd4sm15929380pbc.13.2014.03.01.04.23.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:23:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:23:36 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243087>

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
index 28f9ac1..1675808 100644
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
@@ -982,6 +992,73 @@ static const char *unique_tracking_name(const char=
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
@@ -1109,6 +1186,9 @@ static int parse_branchname_arg(int argc, const c=
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
