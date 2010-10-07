From: pclouds@gmail.com
Subject: [PATCH 2/2] worktree: provide better prefix to go back to original cwd
Date: Thu,  7 Oct 2010 11:46:53 +0700
Message-ID: <4cad50da.0e958e0a.40e3.5efd@mx.google.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens.Lehmann@web.de, Junio C Hamano <gitster@pobox.com>,
	jrnieder@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, judge.packham@gmail.co
X-From: git-owner@vger.kernel.org Thu Oct 07 06:47:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3iOE-0001rW-GE
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 06:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab0JGErY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 00:47:24 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34222 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab0JGErY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 00:47:24 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so60408pzk.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 21:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xRatOJKj+Tn2vgNBeE2+fPmMlcWsNYjWcO2yCxfM94w=;
        b=pPlLBXGlej+C6QKE5rEkvAgdyfkj/Ozbadj0L7P1/fdJoc5Sfu8NfkGYFJoBVTU/Ck
         IBktnylkuKNvwRmIDvjJlyMLaOb3r9ihmGzK4GpaZ9FKqsmHLk5+j/Z5wj+l7KDrON0/
         /L6D7HVfmGiHzTao15ueuhl8DydJTNsMdezdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uYtjDxfMKK15EYX9SnUgK/FPDAe5VnstZ7I0hQZlYpaWhN4jYit43cViNNK1B2YZei
         AquSo4xgF1FIOVdLxQ6DPJVESKozbFJbj68I7gf4cu48KiwvPCaoldA3vAjoIUZjcRzA
         MDT5xObo/cRq+91AJWNNnH7rpWW4AF5Qz2pNo=
Received: by 10.142.199.18 with SMTP id w18mr171523wff.336.1286426843770;
        Wed, 06 Oct 2010 21:47:23 -0700 (PDT)
Received: from pclouds@gmail.com ([118.69.34.31])
        by mx.google.com with ESMTPS id w14sm1772518wfd.18.2010.10.06.21.47.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 21:47:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Oct 2010 11:47:08 +0700
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158369>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

When both GIT_DIR and GIT_WORK_TREE are set, if cwd is outside
worktree, prefix (the one passed to every builtin commands) will be
set to NULL, which means "user stays at worktree topdir", but cwd is
not moved to worktree topdir.

As a consequence, command line arguments will be interpreted
differently. Assume there is a file named "bar" in foo/.git. A command
can expect command line arguments to be "path in repository":

$ GIT_DIR=3Dfoo/.git GIT_WORK_TREE=3Dfoo git blah bar

or "path in file system":

$ GIT_DIR=3Dfoo/.git GIT_WORK_TREE=3Dfoo git blah foo/bar

Some commands may want "path in repository" and "path in file system"
to be identical. Moreover, output from commands in such situations are
relative to worktree topdir (because prefix is NULL), not what users
expect. It's just confusing.

This patch does not address that. Instead it prepares some variables
to ease access to original cwd in this case. Commands that work well
outside worktree should:

 - detect this case, via is_inside_work_tree()

 - enter_work_tree() (not strictly needed, but I believe it would
   less work this way)

 - prepend startup_info->cwd_to_worktree to output so it becomes
   relative to original cwd

 - prepend startup_info->worktree_to_cwd to command line arguments
   if they are meant to access file system

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I don't care Windows UNC path. And I did not test the case
 where cwd is on C:\ while worktree is on another drive.

 As stated elsewhere, I neglect other cases where cwd may be
 outside worktree. The goal of these patches is to help
 Chris' grep series. If it works out, I'll fix the rest.

 Sorry Chris, I think I have dragged you into worktree setup
 mess.

 builtin/rev-parse.c        |   10 ++++
 cache.h                    |    2 +
 setup.c                    |  119 ++++++++++++++++++++++++++++++++++++=
++++++--
 t/t1510-worktree-prefix.sh |   52 +++++++++++++++++++
 4 files changed, 179 insertions(+), 4 deletions(-)
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
index e71db23..be35b8f 100644
--- a/cache.h
+++ b/cache.h
@@ -1111,6 +1111,8 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 /* git.c */
 struct startup_info {
 	int have_repository;
+	char *cwd_to_worktree; /* path from original cwd to worktree */
+	char *worktree_to_cwd; /* path from worktree to original cwd */
 };
 extern struct startup_info *startup_info;
=20
diff --git a/setup.c b/setup.c
index 3fbe928..1f5117a 100644
--- a/setup.c
+++ b/setup.c
@@ -320,10 +320,120 @@ const char *read_gitfile_gently(const char *path=
)
 	return path;
 }
=20
+/*
+ * Given "foo/bar" and "hey/hello/world", return "../../hey/hello/worl=
d/"
+ * Either path1 or path2 can be NULL. All must be canonical.
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
+			if (is_dir_sep(*path1))
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
+		if (p[-1] !=3D '/') /* path2 may be c:/, don't put another slash  */
+			*p++ =3D '/';
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
+		while (len && !is_dir_sep(worktree[len]))
+			len--;
+		len++;
+
+		/* Worktree and cwd are on different drives? */
+		if (len =3D=3D 3 && has_dos_drive_prefix(cwd)) {
+			if (startup_info) {
+				/* make_path_to_path will add the trailing slash */
+				startup_info->cwd_to_worktree =3D make_path_to_path(NULL, worktree=
);
+				startup_info->worktree_to_cwd =3D make_path_to_path(NULL, cwd);
+			}
+			return NULL;
+		}
+	}
+	else {
+		if (worktree[len]) {
+			if (!is_dir_sep(worktree[len])) {
+				while (len && !is_dir_sep(worktree[len]))
+					len--;
+			}
+		}
+		else {
+			if (!is_dir_sep(cwd[len])) {
+				while (len && !is_dir_sep(cwd[len]))
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
@@ -344,9 +454,10 @@ static const char *setup_explicit_git_dir(const ch=
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
1.7.1.rc1.70.g788ca
