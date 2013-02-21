From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] branch: segfault fixes and validation
Date: Thu, 21 Feb 2013 21:18:05 +0700
Message-ID: <1361456285-29611-1-git-send-email-pclouds@gmail.com>
References: <512612AD.4000609@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Per Cederqvist <cederp@opera.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 15:17:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Wy1-0003k3-Cd
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 15:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab3BUORU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 09:17:20 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:54331 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab3BUORU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 09:17:20 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so3480389pbc.35
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 06:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=6Ynt6eXFeNAf2QMNK07oUfm10d/pBfhILQ5bek4IM2A=;
        b=gTtGoHiRuI+7HzPleqY3uhYM3XTyrjoFYu8ycrCQmqua6gGUZSHnHo7y98gbrBO1ZX
         pcVuF2iDIdfBx8GDiI3gpGhSr5SKs28An5dwKADKIrPkgLds+T9SRlS8LISeHlOHLURz
         fb6oD6KHCM8aC+KLbgMxnypNZacxohIKlA4UqKb2q84fvkBtZHGSZKMAfLRoZ3JNZmZi
         MHSMcB60PzDyNZ06qC6KdxAt5LHBrq0xMLJStAvyJyzm3IaFMs0QIe0h75n8kPT+xRRr
         FzYqUFFt227uT95DCGMazOnRbQXT7ZmXxn0aIau98kFgxwXm8rZHkJnZ/UP2q/3ysOyE
         H7gA==
X-Received: by 10.66.160.98 with SMTP id xj2mr8334908pab.125.1361456239518;
        Thu, 21 Feb 2013 06:17:19 -0800 (PST)
Received: from lanh ([115.74.55.130])
        by mx.google.com with ESMTPS id x2sm115165211paw.8.2013.02.21.06.17.13
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 Feb 2013 06:17:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 21 Feb 2013 21:18:07 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <512612AD.4000609@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216774>

branch_get() can return NULL (so far on detached HEAD only) but some
code paths in builtin/branch.c cannot deal with that and cause
segfaults. Fix it.

While at there, make sure to bail out when the user gives 2 or more
arguments, but only the first one is processed.

Reported-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c  | 20 ++++++++++++++++++++
 t/t3200-branch.sh | 21 +++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6371bf9..c1d688e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -889,6 +889,13 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 	} else if (new_upstream) {
 		struct branch *branch =3D branch_get(argv[0]);
=20
+		if (argc > 1)
+			die(_("too many branches to set new upstream"));
+
+		if (!branch)
+			die(_("could not figure out the branch name from '%s'"),
+			    argc =3D=3D 1 ? argv[0] : "HEAD");
+
 		if (!ref_exists(branch->refname))
 			die(_("branch '%s' does not exist"), branch->name);
=20
@@ -901,6 +908,13 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 		struct branch *branch =3D branch_get(argv[0]);
 		struct strbuf buf =3D STRBUF_INIT;
=20
+		if (argc > 1)
+			die(_("too many branches to unset upstream"));
+
+		if (!branch)
+			die(_("could not figure out the branch name from '%s'"),
+			    argc =3D=3D 1 ? argv[0] : "HEAD");
+
 		if (!branch_has_merge_config(branch)) {
 			die(_("Branch '%s' has no upstream information"), branch->name);
 		}
@@ -916,6 +930,12 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 		int branch_existed =3D 0, remote_tracking =3D 0;
 		struct strbuf buf =3D STRBUF_INIT;
=20
+		if (!strcmp(argv[0], "HEAD"))
+			die(_("it does not make sense to create 'HEAD' manually"));
+
+		if (!branch)
+			die(_("could not figure out the branch name from '%s'"), argv[0]);
+
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
=20
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f3e0e4a..12f1e4a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -42,6 +42,10 @@ test_expect_success \
     'git branch a/b/c should create a branch' \
     'git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c'
=20
+test_expect_success \
+    'git branch HEAD should fail' \
+    'test_must_fail git branch HEAD'
+
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from master
 EOF
@@ -388,6 +392,14 @@ test_expect_success \
     'git tag foobar &&
      test_must_fail git branch --track my11 foobar'
=20
+test_expect_success '--set-upstream-to fails on multiple branches' \
+    'test_must_fail git branch --set-upstream-to master a b c'
+
+test_expect_success '--set-upstream-to fails on detached HEAD' \
+    'git checkout HEAD^{} &&
+     test_must_fail git branch --set-upstream-to master &&
+     git checkout -'
+
 test_expect_success 'use --set-upstream-to modify HEAD' \
     'test_config branch.master.remote foo &&
      test_config branch.master.merge foo &&
@@ -417,6 +429,15 @@ test_expect_success 'test --unset-upstream on HEAD=
' \
      test_must_fail git branch --unset-upstream
 '
=20
+test_expect_success '--unset-upstream should fail on multiple branches=
' \
+    'test_must_fail git branch --unset-upstream a b c'
+
+test_expect_success '--unset-upstream should fail on detached HEAD' \
+    'git checkout HEAD^{} &&
+     test_must_fail git branch --unset-upstream &&
+     git checkout -
+'
+
 test_expect_success 'test --unset-upstream on a particular branch' \
     'git branch my15
      git branch --set-upstream-to master my14 &&
--=20
1.8.1.2.536.gf441e6d
