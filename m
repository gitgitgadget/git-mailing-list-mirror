From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCHv2 1/5] worktree: provide better prefix to go back to original cwd
Date: Fri, 15 Oct 2010 16:26:40 -0700
Message-ID: <1287185204-843-2-git-send-email-judge.packham@gmail.com>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens.Lehmann@web.de, pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 16 01:27:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6tg3-0000z5-Cn
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 01:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233Ab0JOX1D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 19:27:03 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63588 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab0JOX1B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 19:27:01 -0400
Received: by mail-pw0-f46.google.com with SMTP id 4so245540pwj.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 16:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2RWOxn2DEli5OAzp3TqUeMuQmxeHUZmV5AoQwp1Ublk=;
        b=K5yd+ZAp6+xrWH0In+qfgi5KWk3ifTKgg24OSYR4xnqp9wkn8JnMW5CPk1W0qIv/YK
         2oGF1x/BKs2s5NQvAongSHqJnWfXqrGWpFjs4KZWed+6K3p/UUXaP1tvp6HfIrPDw8fY
         YCFOwiFacZG509DMXl2bRvehvA5hGCnnrplaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vicbPllc9kgccefSSGlpuGFzrlU9uMuFaKzd/HYPD1f+fJSgsF4NXufWp2QsYS37sj
         7zLLUjN1lU//TN5WN+05XyDkTAFpYAd7sLlqrexoxF/MViTAP6oOiZl10r9Ezq4lwJla
         EYnfMlNuCoeWIxRTWsVEb/N7YXRzEn5WwSnFU=
Received: by 10.142.212.3 with SMTP id k3mr1145659wfg.413.1287185220896;
        Fri, 15 Oct 2010 16:27:00 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id y42sm10506678wfd.10.2010.10.15.16.26.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 16:26:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159144>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

When both GIT_DIR and GIT_WORK_TREE are set, if cwd is outside worktree=
,
prefix (the one passed to every builtin commands) will be set to NULL,
which means "user stays at worktree topdir".

As a consequence, command line arguments are supposed to be relative
to worktree topdir, not current working directory. Not very intuitive.
Moreover, output from such situation is (again) relative to worktree
topdir. Users are expected to understand that.

This patch allows builtin commands access to original cwd even if it's
outside worktree, via cwd_to_worktree and worktree_to_cwd fields. As
the name implies, if you stay at original cwd, "cd $(cwd_to_worktree)"
would take you to worktree topdir and vice versa.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rev-parse.c        |   10 ++++
 cache.h                    |    2 +
 setup.c                    |  108 ++++++++++++++++++++++++++++++++++++=
++++++--
 t/t1510-worktree-prefix.sh |   52 +++++++++++++++++++++
 4 files changed, 168 insertions(+), 4 deletions(-)
 create mode 100755 t/t1510-worktree-prefix.sh

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..525610e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -623,6 +623,16 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 					puts(prefix);
 				continue;
 			}
+			if (!strcmp(arg, "--cwd-to-worktree")) {
+				if (startup_info->cwd_to_worktree)
+					puts(startup_info->cwd_to_worktree);
+				continue;
+			}
+			if (!strcmp(arg, "--worktree-to-cwd")) {
+				if (startup_info->worktree_to_cwd)
+					puts(startup_info->worktree_to_cwd);
+				continue;
+			}
 			if (!strcmp(arg, "--show-cdup")) {
 				const char *pfx =3D prefix;
 				if (!is_inside_work_tree()) {
diff --git a/cache.h b/cache.h
index 33decd9..c001272 100644
--- a/cache.h
+++ b/cache.h
@@ -1117,6 +1117,8 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 /* git.c */
 struct startup_info {
 	int have_repository;
+	char *cwd_to_worktree; /* chdir("this"); from cwd would return to wor=
ktree */
+	char *worktree_to_cwd; /* chdir("this"); from worktree would return t=
o cwd */
 };
 extern struct startup_info *startup_info;
=20
diff --git a/setup.c b/setup.c
index a3b76de..413703b 100644
--- a/setup.c
+++ b/setup.c
@@ -313,10 +313,109 @@ const char *read_gitfile_gently(const char *path=
)
 	return path;
 }
=20
+/*
+ * Given "foo/bar" and "hey/hello/world", return "../../hey/hello/worl=
d/"
+ * Either path1 or path2 can be NULL
+ */
+static char *make_path_to_path(const char *path1, const char *path2)
+{
+	int nr_back =3D 0;
+	int i, pathlen =3D path2 ? strlen(path2) : 0;
+	char *buf, *p;
+
+	if (path1 && *path1) {
+		nr_back =3D 1;
+		while (*path1) {
+			if (*path1 =3D=3D '/')
+				nr_back++;
+			path1++;
+		}
+	}
+
+	if (!nr_back && !pathlen)
+		return NULL;
+
+	p =3D buf =3D xmalloc(3*nr_back + pathlen + 2); /* "../"^nr_back + pa=
th2 + '/' + NULL */
+	for (i =3D 0; i < nr_back; i++) {
+		memcpy(p, "../", 3);
+		p +=3D 3;
+	}
+	if (pathlen) {
+		memcpy(p, path2, pathlen);
+		p +=3D pathlen;
+		*p++ =3D '/';
+	}
+	*p =3D '\0';
+	return buf;
+}
+
+/*
+ * Return a prefix if cwd inside worktree, or NULL otherwise.
+ * Also fill startup_info struct.
+ */
+static const char *setup_prefix(const char *cwd)
+{
+	const char *worktree =3D get_git_work_tree();
+	int len =3D 0, cwd_len =3D strlen(cwd), worktree_len =3D strlen(workt=
ree);
+
+	while (worktree[len] && worktree[len] =3D=3D cwd[len])
+		len++;
+
+	if (!worktree[len] && !cwd[len]) {
+		if (startup_info) {
+			startup_info->cwd_to_worktree =3D NULL;
+			startup_info->worktree_to_cwd =3D NULL;
+		}
+		return NULL;
+	}
+	/* get /foo/, not /foo/baa if /foo/baa1 and /foo/baa2 are given */
+	else if (worktree[len] && cwd[len]) {
+		while (len && worktree[len] !=3D '/')
+			len--;
+		len++;
+	}
+	else {
+		if (worktree[len]) {
+			if (worktree[len] !=3D '/') {
+				while (len && worktree[len] !=3D '/')
+					len--;
+			}
+		}
+		else {
+			if (cwd[len] !=3D '/') {
+				while (len && cwd[len] !=3D '/')
+					len--;
+			}
+		}
+		len++;		/* must be a slash here, skip it */
+	}
+
+	if (len < cwd_len && len < worktree_len) {
+		if (startup_info) {
+			startup_info->cwd_to_worktree =3D make_path_to_path(cwd+len, worktr=
ee+len);
+			startup_info->worktree_to_cwd =3D make_path_to_path(worktree+len, c=
wd+len);
+		}
+		return NULL;
+	}
+
+	if (startup_info) {
+		if (len < cwd_len) { /* cwd inside worktree */
+			startup_info->cwd_to_worktree =3D make_path_to_path(cwd+len, NULL);
+			startup_info->worktree_to_cwd =3D make_path_to_path(NULL, cwd+len);
+		}
+		else {
+			startup_info->cwd_to_worktree =3D make_path_to_path(NULL, worktree+=
len);
+			startup_info->worktree_to_cwd =3D make_path_to_path(worktree+len, N=
ULL);
+		}
+	}
+
+	return len < cwd_len ? cwd+len : NULL;
+}
+
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 				const char *work_tree_env, int *nongit_ok)
 {
-	static char buffer[1024 + 1];
+	static char buffer[PATH_MAX];
 	const char *retval;
=20
 	if (PATH_MAX - 40 < strlen(gitdirenv))
@@ -337,9 +436,10 @@ static const char *setup_explicit_git_dir(const ch=
ar *gitdirenv,
 	}
 	if (check_repository_format_gently(nongit_ok))
 		return NULL;
-	retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
-			get_git_work_tree());
-	if (!retval || !*retval)
+	if (!getcwd(buffer, sizeof(buffer)))
+		die_errno("can't find the current directory");
+	retval =3D setup_prefix(buffer);
+	if (!retval)
 		return NULL;
 	set_git_dir(make_absolute_path(gitdirenv));
 	if (chdir(work_tree_env) < 0)
diff --git a/t/t1510-worktree-prefix.sh b/t/t1510-worktree-prefix.sh
new file mode 100755
index 0000000..3839493
--- /dev/null
+++ b/t/t1510-worktree-prefix.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description=3D'test rev-parse --cwd-to-worktree and --worktree-to=
-cwd'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir foo bar &&
+	mv .git foo &&
+	mkdir foo/bar &&
+	GIT_DIR=3D`pwd`/foo/.git &&
+	GIT_WORK_TREE=3D`pwd`/foo &&
+	export GIT_DIR GIT_WORK_TREE
+'
+
+test_expect_success 'at root' '
+	(
+	cd foo &&
+	git rev-parse --cwd-to-worktree --worktree-to-cwd >result &&
+	: >expected &&
+	test_cmp expected result
+	)
+'
+
+test_expect_success 'cwd inside worktree' '
+	(
+	cd foo/bar &&
+	git rev-parse --cwd-to-worktree --worktree-to-cwd >result &&
+	echo ../ >expected &&
+	echo bar/ >>expected &&
+	test_cmp expected result
+	)
+'
+
+test_expect_success 'cwd outside worktree' '
+	git rev-parse --cwd-to-worktree --worktree-to-cwd >result &&
+	echo foo/ >expected &&
+	echo ../ >>expected &&
+	test_cmp expected result
+'
+
+test_expect_success 'cwd outside worktree (2)' '
+	(
+	cd bar &&
+	git rev-parse --cwd-to-worktree --worktree-to-cwd >result &&
+	echo ../foo/ >expected &&
+	echo ../bar/ >>expected &&
+	test_cmp expected result
+	)
+'
+
+test_done
--=20
1.7.3.1
