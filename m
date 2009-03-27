From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <tor.arne.vestbo@nokia.com>
Subject: [PATCH v3 2/2] git-clone: Add new option --branch to override initial branch
Date: Fri, 27 Mar 2009 18:45:13 +0100
Message-ID: <1238175913-19175-3-git-send-email-tor.arne.vestbo@nokia.com>
References: <1238175913-19175-1-git-send-email-tor.arne.vestbo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 18:46:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnG8R-00070A-JQ
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 18:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371AbZC0Ro4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 13:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbZC0Ro4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 13:44:56 -0400
Received: from smtp.nokia.com ([192.100.122.233]:25356 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZC0Roz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 13:44:55 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2RHiL1r000387;
	Fri, 27 Mar 2009 19:44:40 +0200
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by esebh106.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Mar 2009 19:44:34 +0200
Received: from mgw-int01.ntc.nokia.com ([172.21.143.96]) by esebh102.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Mar 2009 19:44:34 +0200
Received: from localhost.localdomain (olwst90124.europe.nokia.com [172.24.90.124])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n2RHiSXx032239;
	Fri, 27 Mar 2009 19:44:33 +0200
X-Mailer: git-send-email 1.6.2.GIT
In-Reply-To: <1238175913-19175-1-git-send-email-tor.arne.vestbo@nokia.com>
X-OriginalArrivalTime: 27 Mar 2009 17:44:34.0545 (UTC) FILETIME=[B0F61610:01C9AF03]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114917>

The option '--branch' (short -b) allows the user to override the initia=
l
branch created and checked out by git-clone (normally this is the activ=
e
branch of the remote repository).

If the selected branch is not found the operation aborts.

The rationale for this option is to allow new users to Git, who might
not be familiar with the concepts of tracking branches versus normal
branches (or even branches at all), to easily clone a repository and
start working on a branch other than the remote's active branch.

Signed-off-by: Tor Arne Vestb=C3=B8 <tor.arne.vestbo@nokia.com>
---

The above situation can be found in projects which keep a master branch
for active development, as well as one or more maintenance branches for
released versions of the project. If a user would like to fix a bug for
a released version, he could use the proposed new option and simply do:

  $ git clone git://git.foo.com/project.git --branch 1.6

The manual steps to achieve the same thing would be something like:

  $ git clone -n git://git.foo.com/project.git        # (1)
  $ cd project                                        # (2)
  $ git checkout -t origin/1.6                        # (3)
  $ git branch -D master                              # (4)

A new user to Git might find this list of commands a bit daunting. It
is also somewhat fragile, as running 'git status' after step (2) will
create an index and hence prevent a checkout due to merge conflicts.

(The reason for deleting the master branch in step (4) is to prevent
errors when the user tries to push his changes to the (rebased) 1.6
branch without also rebasing his master branch against origin/master)


 Documentation/git-clone.txt |    5 +++
 builtin-clone.c             |   71 +++++++++++++++++++++++++----------=
-------
 t/t5702-clone-options.sh    |   70 +++++++++++++++++++++++++++++++++++=
+++++--
 3 files changed, 114 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 95f08b9..e7feb4d 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -119,6 +119,11 @@ then the cloned repository will become corrupt.
 	Instead of using the remote name 'origin' to keep track
 	of the upstream repository, use <name> instead.
=20
+--branch <name>::
+-b <name>::
+	Instead of using the remote repository's active branch as the
+	initial branch, use <name> instead.
+
 --upload-pack <upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is accessed
diff --git a/builtin-clone.c b/builtin-clone.c
index 0031b5f..0d03c87 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -41,6 +41,7 @@ static int option_quiet, option_no_checkout, option_b=
are, option_mirror;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin =3D NULL;
+static char *option_branch;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbose;
=20
@@ -69,6 +70,8 @@ static struct option builtin_clone_options[] =3D {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_STRING('b', "branch", &option_branch, "branch",
+		    "initial remote branch to check out"),
=20
 	OPT_END()
 };
@@ -323,7 +326,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
 	int dest_exists;
-	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
+	const struct ref *refs, *mapped_refs;
+	const struct ref *remote_head =3D NULL, *remote_head_points_at =3D NU=
LL;
+	const struct ref *initial_branch =3D NULL;
 	struct strbuf key =3D STRBUF_INIT, value =3D STRBUF_INIT;
 	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INIT;
 	struct transport *transport =3D NULL;
@@ -495,46 +500,35 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		mapped_refs =3D write_remote_refs(refs, refspec, reflog_msg.buf);
=20
 		remote_head =3D find_ref_by_name(refs, "HEAD");
-		head_points_at =3D guess_remote_head(remote_head, mapped_refs, 0);
-	}
-	else {
+		remote_head_points_at =3D guess_remote_head(remote_head, mapped_refs=
, 0);
+
+		if (option_branch) {
+			initial_branch =3D find_ref_by_name_abbrev(refs, option_branch);
+			if (!initial_branch)
+				die("remote has no branch named '%s'.", option_branch);
+		} else {
+			initial_branch =3D remote_head_points_at;
+		}
+	} else {
 		warning("You appear to have cloned an empty repository.");
-		head_points_at =3D NULL;
-		remote_head =3D NULL;
 		option_no_checkout =3D 1;
 		if (!option_bare)
 			install_branch_config(0, "master", option_origin,
 					      "refs/heads/master");
 	}
=20
-	if (head_points_at) {
-		/* Local default branch link */
-		create_symref("HEAD", head_points_at->name, NULL);
-
+	/* Set up remote HEAD */
+	if (remote_head_points_at) {
 		if (!option_bare) {
 			struct strbuf head_ref =3D STRBUF_INIT;
-			const char *head =3D head_points_at->name;
-
-			if (!prefixcmp(head, "refs/heads/"))
-				head +=3D 11;
-
-			/* Set up the initial local branch */
-
-			/* Local branch initial value */
-			update_ref(reflog_msg.buf, "HEAD",
-				   head_points_at->old_sha1,
-				   NULL, 0, DIE_ON_ERR);
=20
 			strbuf_addstr(&head_ref, branch_top.buf);
 			strbuf_addstr(&head_ref, "HEAD");
=20
 			/* Remote branch link */
 			create_symref(head_ref.buf,
-				      head_points_at->peer_ref->name,
+				      remote_head_points_at->peer_ref->name,
 				      reflog_msg.buf);
-
-			install_branch_config(0, head, option_origin,
-					      head_points_at->name);
 		}
 	} else if (remote_head) {
 		/* Source had detached HEAD pointing somewhere. */
@@ -542,7 +536,26 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			update_ref(reflog_msg.buf, "HEAD",
 				   remote_head->old_sha1,
 				   NULL, REF_NODEREF, DIE_ON_ERR);
-	} else {
+	}
+
+	/* Set up intitial branch and HEAD */
+	if (initial_branch) {
+		create_symref("HEAD", initial_branch->name, NULL);
+
+		if (!option_bare) {
+			const char *head =3D initial_branch->name;
+
+			if (!prefixcmp(head, "refs/heads/"))
+				head +=3D 11;
+
+			update_ref(reflog_msg.buf, "HEAD",
+				   initial_branch->old_sha1,
+				   NULL, 0, DIE_ON_ERR);
+
+			install_branch_config(0, head, option_origin,
+					      initial_branch->name);
+		}
+	} else if (!remote_head) {
 		/* Nothing to checkout out */
 		if (!option_no_checkout)
 			warning("remote HEAD refers to nonexistent ref, "
@@ -554,6 +567,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		transport_unlock_pack(transport);
=20
 	if (!option_no_checkout) {
+		const struct ref *checkout_ref =3D initial_branch ? initial_branch :=
 remote_head;
 		struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file))=
;
 		struct unpack_trees_options opts;
 		struct tree *tree;
@@ -572,8 +586,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		opts.verbose_update =3D !option_quiet;
 		opts.src_index =3D &the_index;
 		opts.dst_index =3D &the_index;
-
-		tree =3D parse_tree_indirect(remote_head->old_sha1);
+		tree =3D parse_tree_indirect(checkout_ref->old_sha1);
 		parse_tree(tree);
 		init_tree_desc(&t, tree->buffer, tree->size);
 		unpack_trees(1, &t, &opts);
@@ -583,7 +596,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			die("unable to write new index file");
=20
 		err |=3D run_hook(NULL, "post-checkout", sha1_to_hex(null_sha1),
-				sha1_to_hex(remote_head->old_sha1), "1", NULL);
+				sha1_to_hex(checkout_ref->old_sha1), "1", NULL);
 	}
=20
 	strbuf_release(&reflog_msg);
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 27825f5..08cd8bd 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -6,9 +6,14 @@ test_description=3D'basic clone options'
 test_expect_success 'setup' '
=20
 	mkdir parent &&
-	(cd parent && git init &&
-	 echo one >file && git add file &&
-	 git commit -m one)
+	(
+		cd parent && git init &&
+		echo one >file && git add file && git commit -m one &&
+		echo two >file && git add file && git commit -m two &&
+		git checkout -b topic &&
+		echo thee >topic-file && git add topic-file && git commit -m three &=
&
+		git checkout master
+	)
=20
 '
=20
@@ -32,4 +37,63 @@ test_expect_success 'redirected clone -v' '
=20
 '
=20
+test_expect_success 'clone --branch sets up the correct remote HEAD' '
+
+	git clone --branch=3Drefs/heads/topic parent clone-topic-remote-head =
&&
+	(cd clone-topic-remote-head && grep master .git/refs/remotes/origin/H=
EAD)
+
+'
+
+test_expect_success 'clone --branch sets up the correct local branch' =
'
+
+	git clone --branch=3Drefs/heads/topic parent clone-topic-name &&
+	(cd clone-topic-name && git rev-parse --verify refs/heads/topic)
+
+'
+
+test_expect_success 'clone --branch sets up the correct local HEAD' '
+
+	git clone --branch=3Drefs/heads/topic parent clone-topic-head &&
+	(cd clone-topic-head && grep topic .git/HEAD)
+
+'
+
+test_expect_success 'clone --branch checks out the correct branch' '
+
+	git clone --branch=3Drefs/heads/topic parent clone-topic-checkout &&
+	test -f clone-topic-checkout/topic-file
+
+'
+
+test_expect_success 'clone --branch works with -n' '
+
+	git clone -n --branch=3Drefs/heads/topic parent clone-topic-checkout-=
n &&
+	! test -f clone-topic-checkout-n/topic-file
+
+'
+
+test_expect_success 'clone --branch works with detatched remote HEAD' =
'
+
+	(cd parent && git checkout master~1) &&
+	git clone --branch=3Drefs/heads/topic parent clone-topic-checkout-det=
atched &&
+	test -f clone-topic-checkout-detatched/topic-file &&
+	(cd parent && git checkout master)
+
+'
+
+test_expect_success 'clone --branch works with invalid remote HEAD' '
+
+	(cd parent && echo "ref: refs/heads/nonexistent" > .git/HEAD) &&
+	git clone --branch=3Drefs/heads/topic parent clone-topic-checkout-non=
existent &&
+	test -f clone-topic-checkout-nonexistent/topic-file  &&
+	(cd parent && git checkout master)
+'
+
+test_expect_success 'clone --branch works with abbreviated ref name' '
+
+	git clone --branch=3Dtopic parent clone-topic-abbreviated-name &&
+	(cd clone-topic-abbreviated-name && git rev-parse --verify refs/heads=
/topic)
+
+'
+
 test_done
--=20
1.6.2.GIT
