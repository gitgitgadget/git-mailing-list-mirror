From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] branch: segfault fixes and validation
Date: Sat, 23 Feb 2013 19:22:27 +0700
Message-ID: <1361622147-20921-1-git-send-email-pclouds@gmail.com>
References: <7vvc9kccwa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Per Cederqvist <cederp@opera.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 13:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9E7R-0006G1-PH
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 13:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758781Ab3BWMVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 07:21:47 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:52801 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758756Ab3BWMVq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 07:21:46 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so772285daj.22
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 04:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=OtLP5WKMRmocb21zleVQADbdqDY1bC7bc5LChb5CNIU=;
        b=aEfIaiX9IpXZlHpAsCE08pD+yoFwsx5PMqfgF0poOdg3Tx1uFY3Ti5vtDY/p4qpQ3w
         SaIU00/BntVfTaE2g1fBETtOBVWTbmbrbszbJZykAAWCyJWyOH+0UiBaRnOJz0mU1fik
         nJveaOUqx99CiNZZsHMNxMGDzm31tu5dZtEEk5WYgF+oMeeqTJNzY0ccdGT9rLkH26zz
         6SnSXEimAuTeHKXWmDDDDtWJyKWRknlQ8lGu/Vyev5RcrQqTF64WBf3XpKnPCtMfbrfc
         1yyOSpNaIgRHPMkbV8/iP7DV9uyS/JE5I21WOjdG+Q9GltQjWhq/w3FzHdpW8nOtRnHR
         iE0A==
X-Received: by 10.68.189.169 with SMTP id gj9mr8345968pbc.67.1361622105273;
        Sat, 23 Feb 2013 04:21:45 -0800 (PST)
Received: from lanh ([115.74.55.130])
        by mx.google.com with ESMTPS id tp2sm5893380pbc.12.2013.02.23.04.21.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 04:21:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 23 Feb 2013 19:22:40 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <7vvc9kccwa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216894>

branch_get() can return NULL (so far on detached HEAD only) but some
code paths in builtin/branch.c cannot deal with that and cause
segfaults.

While at there, make sure to bail out when the user gives 2 or more
branches with --set-upstream-to or --unset-upstream, where only the
first branch is processed and the rest silently dropped.

Reported-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Sat, Feb 23, 2013 at 3:27 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 > Instead of asking "Is it detached?", perhaps we can say something
 > like "You told me to set the upstream of HEAD to branch X, but " in
 > front?  At least, that will be a better explanation for the reason
 > why the operation is failing.

 Fixed.

 > What you can do is to have a single helper function that can explain
 > why branch_get() returned NULL (or extend branch_get() to serve that
 > purpose as well); then you do not have to duplicate the logic twice
 > on the caller's side (and there may be other callers that want to do
 > the same).

 The explanation mentions about the failed operation, which makes a
 helper less useful. We could still do the helper, but it may lead to
 i18n legos. So no helper in this version.

 > The existing test might be wrong, by the way.  Your HEAD may point
 > at a branch Y but you may not have any commit on it yet, and you may
 > want to allow setting the upstream of that to-be-born branch to
 > another branch X with "branch --set-upstream-to=3DX [Y|HEAD]".

 It sounds complicated. I think we can revisit it when a user actually
 complains about it.

 builtin/branch.c  | 27 +++++++++++++++++++++++++++
 t/t3200-branch.sh | 21 +++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6371bf9..00d17d2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -889,6 +889,17 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 	} else if (new_upstream) {
 		struct branch *branch =3D branch_get(argv[0]);
=20
+		if (argc > 1)
+			die(_("too many branches to set new upstream"));
+
+		if (!branch) {
+			if (!argc || !strcmp(argv[0], "HEAD"))
+				die(_("could not set upstream of HEAD to %s when "
+				      "it does not point to any branch."),
+				    new_upstream);
+			die(_("no such branch '%s'"), argv[0]);
+		}
+
 		if (!ref_exists(branch->refname))
 			die(_("branch '%s' does not exist"), branch->name);
=20
@@ -901,6 +912,16 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 		struct branch *branch =3D branch_get(argv[0]);
 		struct strbuf buf =3D STRBUF_INIT;
=20
+		if (argc > 1)
+			die(_("too many branches to unset upstream"));
+
+		if (!branch) {
+			if (!argc || !strcmp(argv[0], "HEAD"))
+				die(_("could not unset upstream of HEAD when "
+				      "it does not point to any branch."));
+			die(_("no such branch '%s'"), argv[0]);
+		}
+
 		if (!branch_has_merge_config(branch)) {
 			die(_("Branch '%s' has no upstream information"), branch->name);
 		}
@@ -916,6 +937,12 @@ int cmd_branch(int argc, const char **argv, const =
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
