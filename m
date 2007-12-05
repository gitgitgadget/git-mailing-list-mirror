From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Do check_repository_format() early
Date: Wed, 5 Dec 2007 20:33:32 +0700
Message-ID: <20071205132514.GA5580@laptop>
References: <20071128165837.GA5903@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 14:34:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzuOU-0002Av-Ag
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 14:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbXLENdt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 08:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbXLENdt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 08:33:49 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:13824 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbXLENds (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 08:33:48 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3621063rvb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 05:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=xkOVJOFeFp5lrD92+BBiPKYjpdrh9Mrj4UOZurVloIM=;
        b=yEIeLbjA8FdmcwMZJ65nvMN2U+OIdOPwMwsDFjg22GbSMDNpKVvB6mKLZVp9WsQ2z9L40IwP0eyeR8Q4ZavIEj5LKVc+YggXQMxWPLDdHty6WAKEtXQoKIhna0tNHdFM6VUwqm09Xby9XSOT1ES5PVVHhS37rVPuB/GvJZMArtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=GGcS8Df7rWPSvduHdGKjiGFSSe8HHe+i7SiGkQSjdkJJ7sU3wep5SzX8q0/KG16T1OmykqWqIYZ9nOP1k1Eh2cjrjgqvE2wDeU/1lGn5Twu43wGABnpU/1CtNd2NwlRxhRQnHnB/nWPDRMeo70J3tFFDyyHS5mxoZ5wkCe5UEJw=
Received: by 10.140.83.41 with SMTP id g41mr1157169rvb.1196861627087;
        Wed, 05 Dec 2007 05:33:47 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.36])
        by mx.google.com with ESMTPS id a22sm1089942pye.2007.12.05.05.33.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 05:33:46 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  5 Dec 2007 20:33:32 +0700
Content-Disposition: inline
In-Reply-To: <20071128165837.GA5903@laptop>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67151>

This pushes check_repository_format() (actually _gently() version)
to setup_git_directory_gently() in order to prevent from
using unsupported repositories.

New setup_git_directory_gently()'s behaviour is stop searching
for a valid gitdir and return as if there is no gitdir if a
unsupported repository is found. Warning will be thrown in these
cases.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Another round. Test added. Behaviour changed to make it tolerate
 unsupported repos as much as possible.

 setup.c                 |   37 ++++++++++++++++++++++++++++++-------
 t/t1302-repo-version.sh |   46 +++++++++++++++++++++++++++++++++++++++=
+++++++
 2 files changed, 76 insertions(+), 7 deletions(-)
 create mode 100755 t/t1302-repo-version.sh

diff --git a/setup.c b/setup.c
index faf4137..434a7a6 100644
--- a/setup.c
+++ b/setup.c
@@ -222,6 +222,22 @@ void setup_work_tree(void)
 	initialized =3D 1;
 }
=20
+static int check_repository_format_gently(int *nongit_ok)
+{
+	git_config(check_repository_format_version);
+	if (GIT_REPO_VERSION < repository_format_version) {
+		if (!nongit_ok)
+			die ("Expected git repo version <=3D %d, found %d",
+			     GIT_REPO_VERSION, repository_format_version);
+		warning("Expected git repo version <=3D %d, found %d",
+			GIT_REPO_VERSION, repository_format_version);
+		warning("Please upgrade Git");
+		*nongit_ok =3D -1;
+		return -1;
+	}
+	return 0;
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree o=
r
  * not, since the config can only be read _after_ this function was ca=
lled.
@@ -246,8 +262,15 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 			static char buffer[1024 + 1];
 			const char *retval;
=20
-			if (!work_tree_env)
-				return set_work_tree(gitdirenv);
+			if (!work_tree_env) {
+				retval =3D set_work_tree(gitdirenv);
+				/* config may override worktree */
+				if (check_repository_format_gently(nongit_ok))
+					return NULL;
+				return retval;
+			}
+			if (check_repository_format_gently(nongit_ok))
+				return NULL;
 			retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
 					get_git_work_tree());
 			if (!retval || !*retval)
@@ -287,6 +310,8 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
 			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+			if (check_repository_format_gently(nongit_ok))
+				return NULL;
 			return NULL;
 		}
 		chdir("..");
@@ -307,6 +332,8 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	if (!work_tree_env)
 		inside_work_tree =3D 1;
 	git_work_tree_cfg =3D xstrndup(cwd, offset);
+	if (check_repository_format_gently(nongit_ok))
+		return NULL;
 	if (offset =3D=3D len)
 		return NULL;
=20
@@ -357,11 +384,7 @@ int check_repository_format_version(const char *va=
r, const char *value)
=20
 int check_repository_format(void)
 {
-	git_config(check_repository_format_version);
-	if (GIT_REPO_VERSION < repository_format_version)
-		die ("Expected git repo version <=3D %d, found %d",
-		     GIT_REPO_VERSION, repository_format_version);
-	return 0;
+	return check_repository_format_gently(NULL);
 }
=20
 const char *setup_git_directory(void)
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
new file mode 100755
index 0000000..37fc1c8
--- /dev/null
+++ b/t/t1302-repo-version.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
+#
+
+test_description=3D'Test repository version check'
+
+. ./test-lib.sh
+
+cat >test.patch <<EOF
+diff --git a/test.txt b/test.txt
+new file mode 100644
+--- /dev/null
++++ b/test.txt
+@@ -0,0 +1 @@
++123
+EOF
+
+test_create_repo "test"
+test_create_repo "test2"
+
+GIT_CONFIG=3Dtest2/.git/config git config core.repositoryformatversion=
 99 || exit 1
+
+test_expect_success 'gitdir selection on normal repos' '
+	(test "$(git config core.repositoryformatversion)" =3D 0 &&
+	cd test &&
+	test "$(git config core.repositoryformatversion)" =3D 0)'
+
+# Make sure it would stop at test2, not trash
+test_expect_success 'gitdir selection on unsupported repo' '
+	(cd test2 &&
+	test "$(git config core.repositoryformatversion)" =3D 99)'
+
+test_expect_success 'gitdir not required mode' '
+	(git apply --stat test.patch &&
+	cd test && git apply --stat ../test.patch &&
+	cd ../test2 && git apply --stat ../test.patch)'
+
+test_expect_success 'gitdir required mode on normal repos' '
+	(git apply --check --index test.patch &&
+	cd test && git apply --check --index ../test.patch)'
+
+test_expect_failure 'gitdir required mode on unsupported repo' '
+	(cd test2 && git apply --check --index ../test.patch)'
+
+test_done
--=20
1.5.3.6.2040.gcdff-dirty
