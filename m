From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/43] worktree setup: restore original state when things go wrong
Date: Mon,  5 Apr 2010 20:41:13 +0200
Message-ID: <1270492888-26589-29-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH8-0000ps-ID
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab0DESnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:18 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:25858 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094Ab0DESnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:15 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1460167qwh.37
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OVhOKk8/N0azLg6WshJrVnT9qwZZ+FGB4q1IsW9G1B4=;
        b=Ug6vxGj3dtnZBebOA1EL6NTnhW/d+Ck96BTfE391jvO4Z8ZSUTU27XpK52MryjcTIx
         KhIA8hy3UKiieC4pAOpsKSiwOjA4anDXRvQ8EAvqBfJcwStbMdJGZ9GvUREaz6g2HuoK
         xuo6AkT2k27bA3SV9PEL29Afth9A4shjePR/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SwKsx3FCv8FRuB4eVkjwOxAzVfgcpjK0+9I6pWwwZKWgfRpmSwa7AeDiELMqNdPYxi
         Du+l6+E/u9XfPZJfLK5tcZcxWU8OVWEfaxks72z0VZpNleQewSxu88764M415aJIDHnu
         z81ds63XNtqQGJ8dAI8U4HbvUZqaOIMxKICbE=
Received: by 10.224.23.70 with SMTP id q6mr2164004qab.339.1270492994358;
        Mon, 05 Apr 2010 11:43:14 -0700 (PDT)
Received: from dektop ([72.14.241.40])
        by mx.google.com with ESMTPS id 22sm7257876qyk.2.2010.04.05.11.43.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:13 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:08 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144020>

In current state of setup_git_directory_gently(), when a repository is
not found, many things will not be the same as when setup procedure is
started (while they should be). For one thing, current working
directory will not be the same in certain cases.

This patch reorders actions in clear steps and rolls back if one step
is wrong. (Actually the last step, setting git_dir, can't be rolled
back by this patch).

The steps and their state change are:

 1. Looking in working directory for repository candidates (or $GIT_DIR
    if it is set)

    This step may move $(cwd) to somewhere.

 2. Set internal variables to record repository features, based only
    on repository location and environment variables.

    This step sets variables:
    - inside_git_dir
    - inside_work_tree

 3. Inspect $GIT_DIR/config to see if it's a valid repository.

    This step may change variables:
    - repository_format_version
    - shared_repository
    - is_bare_repository_cfg
    - git_work_tree_cfg

 4. Save the repository location for later use.

    This step calls setup_git_dir() to set many variables in environmen=
t.c

 5. Calculate prefix (relative path to the original current working
    directory)

Setup procedure is completed at step 5. Stopping at any other steps
is considered a setup failure.

In case of setup failure, if it's not fatal and nongit_ok is not NULL,
prefix must be calculated before returning to caller. In other words:

  if (!fatal && gently)
    goto step_5;

Things that go wrong before step 4 will be cleaned up by
unset_git_directory(). Step 4 is irreversible, for now.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    1 +
 setup.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index f4935b8..f53fb32 100644
--- a/cache.h
+++ b/cache.h
@@ -421,6 +421,7 @@ extern const char **get_pathspec(const char *prefix=
, const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
+extern void unset_git_directory(const char *prefix);
 extern const char *prefix_path(const char *prefix, int len, const char=
 *path);
 extern const char *prefix_filename(const char *prefix, int len, const =
char *path);
 extern int check_filename(const char *prefix, const char *name);
diff --git a/setup.c b/setup.c
index 2c1b64f..858cf6b 100644
--- a/setup.c
+++ b/setup.c
@@ -323,6 +323,42 @@ const char *read_gitfile_gently(const char *path)
 	return path;
 }
=20
+void unset_git_directory(const char *prefix)
+{
+	/*
+	 * FIXME:
+	 * chdir(prefix) may be enough for most of cases,
+	 * if original cwd is outside worktree, prefix
+	 * will always be set NULL, thus impossible to move
+	 * back to orignal cwd
+	 */
+	if (prefix && chdir(prefix))
+		die("Cannot change to '%s'", prefix);
+
+	if (startup_info) {
+		startup_info->prefix =3D NULL;
+		startup_info->have_repository =3D 0;
+	}
+
+	/* Initialized in setup_git_directory_gently_1() */
+	inside_work_tree =3D -1;
+	inside_git_dir =3D -1;
+
+	/* Initialized in check_repository_format_version() */
+	/*
+	 * repository_format_version is zero for two reasons:
+	 * - For really old repos, there won't be core.repositoryformatversio=
n
+	 *   we treat it as supported version zero.
+	 * - For repo creating commands like "git init" or "git clone"
+	 *   $GIT_DIR/config may not be there, just let it pass, the
+	 *   repository will be properly initialized later.
+	 * For history of this setting see commits 4f62953 and 96f1e58
+	 */
+	repository_format_version =3D 0;
+	shared_repository =3D PERM_UMASK;
+	is_bare_repository_cfg =3D -1;
+	git_work_tree_cfg =3D NULL;
+}
 /*
  * We cannot decide in this function whether we are in the work tree o=
r
  * not, since the config can only be read _after_ this function was ca=
lled.
@@ -403,6 +439,13 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 	 * - ../ (bare)
 	 * - ../../.git/
 	 *   etc.
+	 *
+	 * When a repository is found:
+	 * - inside_git_dir/inside_work_tree are set
+	 * - check_repository_format_gently() is called
+	 *   if repo version is not supported, restore cwd
+	 * - set_git_dir
+	 * - calculate and return prefix
 	 */
 	offset =3D len =3D strlen(cwd);
 	for (;;) {
@@ -410,13 +453,15 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
 		if (!gitfile_dir && is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 			gitfile_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 		if (gitfile_dir) {
-			if (set_git_dir(gitfile_dir))
-				die("Repository setup failed");
 			inside_git_dir =3D 0;
 			if (!work_tree_env)
 				inside_work_tree =3D 1;
-			if (check_repository_format_gently(gitfile_dir, nongit_ok))
+			if (check_repository_format_gently(gitfile_dir, nongit_ok)) {
+				unset_git_directory(offset !=3D len ? cwd + offset + 1: NULL);
 				return NULL;
+			}
+			if (set_git_dir(gitfile_dir))
+				die("Repository setup failed");
 			root_len =3D offset_1st_component(cwd);
 			git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : ro=
ot_len);
 			break;
@@ -425,8 +470,10 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
-			if (check_repository_format_gently(".", nongit_ok))
+			if (check_repository_format_gently(".", nongit_ok)) {
+				unset_git_directory(offset !=3D len ? cwd + offset + 1: NULL);
 				return NULL;
+			}
 			if (offset !=3D len) {
 				root_len =3D offset_1st_component(cwd);
 				cwd[offset > root_len ? offset : root_len] =3D '\0';
--=20
1.7.0.rc1.541.g2da82.dirty
