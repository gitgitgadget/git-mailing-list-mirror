From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 3/3] branch: suggest how to undo a --set-upstream when given one branch
Date: Mon, 20 Aug 2012 15:47:40 +0200
Message-ID: <1345470460-28734-4-git-send-email-cmn@elego.de>
References: <1345470460-28734-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 16:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3SYE-0003Og-6b
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 16:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467Ab2HTOAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 10:00:15 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:47721 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755203Ab2HTN4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 09:56:17 -0400
Received: from flaca.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by hessy.dwim.me (Postfix) with ESMTPA id CB9E4816D2
	for <git@vger.kernel.org>; Mon, 20 Aug 2012 15:47:41 +0200 (CEST)
Received: (nullmailer pid 28779 invoked by uid 1000);
	Mon, 20 Aug 2012 13:47:40 -0000
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1345470460-28734-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203846>

This interface is error prone, and a better one (--set-upstream-to)
exists. Suggest how to fix a --set-upstream invocation in case the
user only gives one argument, which makes it likely that he meant to
do the opposite, like with

    git branch --set-upstream origin/master

when they meant one of

    git branch --set-upstream origin/master master
    git branch --set-upstream-to origin/master

While we're at it, add a notice that the --set-upstream flag is
deprecated and will be removed at some point.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

---

This produces suboptimal output in case that A tracks B and we do

    git checkout B
    git branch --set-upstream A

as it will suggest

    git branch --set-upstream A B

as a way of undoing what we just did. Avoiding it becomes a bit messy
(yet another layer of ifs), so I've left it out. Anybody reckon it's
worth recognising this?
---
 builtin/branch.c  | 35 +++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 2 files changed, 87 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 08068f7..33641d9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -707,6 +707,21 @@ static int edit_branch_description(const char *bra=
nch_name)
 	return status;
 }
=20
+static void print_set_upstream_warning(const char *branch, int branch_=
existed, const char *old_upstream)
+{
+	fprintf(stderr, _("If you wanted to make '%s' track '%s', do this:\n\=
n"), head, branch);
+	if (branch_existed) {
+		if (old_upstream)
+			fprintf(stderr, _("    git branch --set-upstream %s %s\n"), old_ups=
tream, branch);
+		else
+			fprintf(stderr, _("    git branch --unset-upstream %s\n"), branch);
+	} else {
+		fprintf(stderr, _("    git branch -d %s\n"), branch);
+	}
+
+	fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branch);
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete =3D 0, rename =3D 0, force_create =3D 0, list =3D 0;
@@ -877,10 +892,30 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <=3D 2) {
+		struct branch *branch =3D branch_get(argv[0]);
+		const char *old_upstream =3D NULL;
+		int branch_existed =3D 0;
+
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
+
+		if (track =3D=3D BRANCH_TRACK_OVERRIDE)
+			fprintf(stderr, _("The --set-upstream flag is deprecated and will b=
e removed. Consider using --track or --set-upstream-to\n"));
+
+		/*
+		 * Save what argv[0] was pointing to so we can give
+		 * the --set-upstream-to hint
+		 */
+		if (branch_has_merge_config(branch))
+			old_upstream =3D shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+
+		branch_existed =3D ref_exists(branch->refname);
 		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
 			      force_create, reflog, 0, quiet, track);
+
+		if (argc =3D=3D 1 && track =3D=3D BRANCH_TRACK_OVERRIDE)
+			print_set_upstream_warning(argv[0], branch_existed, old_upstream);
+
 	} else
 		usage_with_options(builtin_branch_usage, options);
=20
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 93e5d6e..702bffa 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -399,6 +399,58 @@ test_expect_success 'test --unset-upstream on a pa=
rticular branch' \
      test_must_fail git config branch.my14.remote &&
      test_must_fail git config branch.my14.merge'
=20
+test_expect_success 'test --set-upstream help message with one arg' \
+    'git branch --set-upstream origin/master 2>actual &&
+     test_when_finished git branch -d origin/master &&
+     cat >expected <<EOF &&
+The --set-upstream flag is deprecated and will be removed. Consider us=
ing --track or --set-upstream-to
+If you wanted to make '"'master'"' track '"'origin/master'"', do this:
+
+    git branch -d origin/master
+    git branch --set-upstream-to origin/master
+EOF
+     test_cmp expected actual
+'
+
+test_expect_success '--set-upstream with a branch that already has an =
upstream' \
+    'git branch --set-upstream-to my12 master &&
+     git branch --set-upstream-to my13 my12 &&
+     test_when_finished git branch --unset-upstream my12 &&
+     test_when_finished git branch --unset-upstream my13 &&
+     git branch --set-upstream my12 2>actual &&
+     cat actual &&
+     cat >expected <<EOF &&
+The --set-upstream flag is deprecated and will be removed. Consider us=
ing --track or --set-upstream-to
+If you wanted to make '"'master'"' track '"'my12'"', do this:
+
+    git branch --set-upstream my13 my12
+    git branch --set-upstream-to my12
+EOF
+     test_cmp expected actual
+'
+
+test_expect_success '--set-upstream with a branch that has no upstream=
' \
+    'git branch --set-upstream my12 2>actual &&
+     test_when_finished git branch --unset-upstream my12
+     cat >expected <<EOF &&
+The --set-upstream flag is deprecated and will be removed. Consider us=
ing --track or --set-upstream-to
+If you wanted to make '"'master'"' track '"'my12'"', do this:
+
+    git branch --unset-upstream my12
+    git branch --set-upstream-to my12
+EOF
+     test_cmp expected actual
+'
+
+test_expect_success '--set-upstream with two args should only show the=
 deprecation message' \
+    'git branch --set-upstream master my13 2>actual &&
+     test_when_finished git branch --unset-upstream master &&
+     cat >expected <<EOF &&
+The --set-upstream flag is deprecated and will be removed. Consider us=
ing --track or --set-upstream-to
+EOF
+     test_cmp expected actual
+'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from master
--=20
1.7.11.1.104.ge7b44f1
