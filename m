From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 23/25] checkout: detach if the branch is already checked out elsewhere
Date: Tue, 18 Feb 2014 20:40:12 +0700
Message-ID: <1392730814-19656-24-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:43:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkxb-0002Ii-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbaBRNnB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:43:01 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:52771 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbaBRNmc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:42:32 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so16701033pbc.40
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=atJF4cdCoLjdgaMCm4sfK64U0zyVyqlyC3odVQMcHMk=;
        b=c3gGfCyxyYIXADKGTj8o1WbMzfngyrdDY2QJBiQYiwW5gPLwjPypDXfrUiDywrclY+
         NcWyP69zZOUncUauawoPJOQ7sUSPFF7n5R/UGHVmx6DVJW7K2mj6Jvqj1pd+GzPYXIv6
         MJNN7baxwfklYygjE/HEJNwrSOSYLPquIDRHocF+fjB5E640E+X7PO3xXJhDBEuhU0f+
         qIBGuxxfmJ3760X5sKu3CKpint5xRSvFqOwTviF6NNC66g9GezzzdUgiTbJVMMqrc9GE
         650NsLULk02kUn+uXOOcDRfoukUIG0NSFR0hOpfGcPyD1+aALN5r5TVMwP1QS5JEub+2
         48GA==
X-Received: by 10.66.160.2 with SMTP id xg2mr32796458pab.23.1392730951676;
        Tue, 18 Feb 2014 05:42:31 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id qw8sm56104424pbb.27.2014.02.18.05.42.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:42:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:42:44 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242324>

The normal rule is anything outside refs/heads/ is detached. This
strictens the rule a bit more: if the branch is checked out (either in
$GIT_COMMON_DIR/HEAD or any $GIT_DIR/repos/.../HEAD) then it's
detached as well.

A hint is given so the user knows where to go and do something there
if they still want to checkout undetached here.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 78 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t2025-checkout-to.sh | 15 ++++++++--
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f961604..7b86f2b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -433,6 +433,11 @@ struct branch_info {
 	const char *name; /* The short name used */
 	const char *path; /* The full name of a real branch */
 	struct commit *commit; /* The named commit */
+	/*
+	 * if not null the branch is detached because it's alrady
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
+	if ((dir =3D opendir(path.buf)) =3D=3D NULL)
+		return;
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
@@ -1109,6 +1184,9 @@ static int parse_branchname_arg(int argc, const c=
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
index 76eae4a..f6a5c47 100755
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
+		! git symbolic-ref HEAD &&
+		git rev-parse HEAD >actual &&
+		test_cmp ../expect actual &&
 		git fsck
 	)
 '
@@ -36,4 +37,12 @@ test_expect_success 'checkout --to a new worktree cr=
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
1.8.5.2.240.g8478abd
