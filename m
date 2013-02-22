From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] branch: segfault fixes and validation
Date: Fri, 22 Feb 2013 18:47:43 +0700
Message-ID: <1361533663-3172-1-git-send-email-pclouds@gmail.com>
References: <7vvc9lv9rt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Per Cederqvist <cederp@opera.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 12:47:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8r5x-0007os-Uk
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 12:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776Ab3BVLqw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 06:46:52 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35420 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab3BVLqv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 06:46:51 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so430515pad.30
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=1mpMqKL0d0dlRGtvRpSAuGs2Ag5hNsA0HMIlHLWHxow=;
        b=PwKYLZI8bGhxqCdtWGbrmI95A9FzKhnOcgY7I6+ibPbCjFt6S72raf7oFafAOOk1Pq
         SzGo6PQ+NA9LZeKencAiigtA8CckIRlFnGNob8dUQjTKO6hYkdDMMkhgx+wKsgcKJXLm
         f9dDVu9AV4BT1QDrg1tfrFsJPak2BJJWecxjNchQKVeXrngpv10jGB/B9rqOmXF0uwTJ
         YobK1nxg40EqSZtf4X0h2XJhFDDS700e0jDVLF0AJRCX82TqyuNOpwN8vefIbQ62juMD
         IPDboqAjyQXV1k2pEJiE0dX/A9FAhlofYoN6Va5wSLtzF+niMFS67ykmNwa6hhTz9FkV
         X24g==
X-Received: by 10.66.147.98 with SMTP id tj2mr3471297pab.148.1361533611084;
        Fri, 22 Feb 2013 03:46:51 -0800 (PST)
Received: from lanh ([115.74.55.130])
        by mx.google.com with ESMTPS id 1sm2283328pba.32.2013.02.22.03.46.46
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Feb 2013 03:46:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Feb 2013 18:47:45 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <7vvc9lv9rt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216830>

branch_get() can return NULL (so far on detached HEAD only) but some
code paths in builtin/branch.c cannot deal with that and cause
segfaults. While at there, make sure we bail out when the user gives 2
or more arguments, but we only process the first one and silently
ignore the rest.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Feb 22, 2013 at 12:47 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
 > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
 >
 >> branch_get() can return NULL (so far on detached HEAD only)...
 >
 > Do you anticipate any other cases where the API call should validly
 > return NULL?
=20
 No. But I do not see any guarantee that it may never do that in
 future either. Which is why I was deliberately vague with "could not
 figure out...". But you also correctly observed my laziness there. So
 how about this? It makes a special case for HEAD but not insist on
 detached HEAD as the only cause.

 builtin/branch.c  | 24 ++++++++++++++++++++++++
 t/t3200-branch.sh | 21 +++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6371bf9..82ed337 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -889,6 +889,15 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 	} else if (new_upstream) {
 		struct branch *branch =3D branch_get(argv[0]);
=20
+		if (argc > 1)
+			die(_("too many branches to set new upstream"));
+
+		if (!branch) {
+			if (!argc || !strcmp(argv[0], "HEAD"))
+				die(_("HEAD does not point to any branch. Is it detached?"));
+			die(_("no such branch '%s'"), argv[0]);
+		}
+
 		if (!ref_exists(branch->refname))
 			die(_("branch '%s' does not exist"), branch->name);
=20
@@ -901,6 +910,15 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 		struct branch *branch =3D branch_get(argv[0]);
 		struct strbuf buf =3D STRBUF_INIT;
=20
+		if (argc > 1)
+			die(_("too many branches to unset upstream"));
+
+		if (!branch) {
+			if (!argc || !strcmp(argv[0], "HEAD"))
+				die(_("HEAD does not point to any branch. Is it detached?"));
+			die(_("no such branch '%s'"), argv[0]);
+		}
+
 		if (!branch_has_merge_config(branch)) {
 			die(_("Branch '%s' has no upstream information"), branch->name);
 		}
@@ -916,6 +934,12 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 		int branch_existed =3D 0, remote_tracking =3D 0;
 		struct strbuf buf =3D STRBUF_INIT;
=20
+		if (!strcmp(argv[0], "HEAD"))
+			die(_("it does not make sense to create 'HEAD' manually"));
+
+		if (!branch)
+			die(_("no such branch '%s'"), argv[0]);
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
