From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-commit: avoid always using reduce_heads()
Date: Sun,  5 Oct 2008 21:51:40 +0200
Message-ID: <1223236300-2170-1-git-send-email-vmiklos@frugalware.org>
References: <20081003145915.GB3291@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jnareb@gmail.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 05 21:52:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZeV-00086L-Du
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 21:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbYJETvR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2008 15:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754810AbYJETvR
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 15:51:17 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45776 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbYJETvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 15:51:16 -0400
Received: from vmobile.example.net (dsl5401C49A.pool.t-online.hu [84.1.196.154])
	by yugo.frugalware.org (Postfix) with ESMTPA id 611F8149C60;
	Sun,  5 Oct 2008 21:51:14 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id E00D019E7C3; Sun,  5 Oct 2008 21:51:40 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <20081003145915.GB3291@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97531>

In case git merge --no-ff is used with --no-commit or we have a
conflict, write info about if fast forwards are allowed or not to
$GIT_DIR/MERGE_MODE.

Based on this info, don't run reduce_heads() in case fast-forwards are
denied, to avoid turning a 'merge --no-ff' to a non-merge commit.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

On Fri, Oct 03, 2008 at 07:59:15AM -0700, "Shawn O. Pearce" <spearce@sp=
earce.org> wrote:
> ./test-lib.sh: line 237:   362 Segmentation fault      git commit -m
> initial
> * FAIL 1: setup
>
> I leave the debugging to you.  ;-)

That's weird, make test passed for me before I sent this patch. It was
based on 15dc66a.

Now I squashed in Gabor's patch and rebased it against 52e8370, I hope
it fixed the issue (make test still passes for me).

 branch.c         |    1 +
 builtin-commit.c |   16 ++++++++++++++--
 builtin-merge.c  |   10 ++++++++++
 t/t7600-merge.sh |   16 ++++++++++++++++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index b1e59f2..205b89d 100644
--- a/branch.c
+++ b/branch.c
@@ -168,5 +168,6 @@ void remove_branch_state(void)
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_RR"));
 	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
 }
diff --git a/builtin-commit.c b/builtin-commit.c
index b920257..93f360f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -937,6 +937,8 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents =3D NULL, **pptr =3D &parents;
+	struct stat statbuf;
+	int allow_fast_forward =3D 1;
=20
 	git_config(git_commit_config, NULL);
=20
@@ -951,6 +953,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 		return 1;
 	}
=20
+	strbuf_init(&sb, 0);
 	/* Determine parents */
 	if (initial_commit) {
 		reflog_msg =3D "commit (initial)";
@@ -984,14 +987,22 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		}
 		fclose(fp);
 		strbuf_release(&m);
+		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
+				die("could not read MERGE_MODE: %s",
+						strerror(errno));
+			if (!strcmp(sb.buf, "no-ff"))
+				allow_fast_forward =3D 0;
+		}
+		if (allow_fast_forward)
+			parents =3D reduce_heads(parents);
 	} else {
 		reflog_msg =3D "commit";
 		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 	}
-	parents =3D reduce_heads(parents);
=20
 	/* Finally, get the commit message */
-	strbuf_init(&sb, 0);
+	strbuf_reset(&sb);
 	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		rollback_index_files();
 		die("could not read commit message");
@@ -1040,6 +1051,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
=20
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
=20
 	if (commit_index_files())
diff --git a/builtin-merge.c b/builtin-merge.c
index 5c65a58..4c9ed5d 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -180,6 +180,7 @@ static void drop_save(void)
 {
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("MERGE_MODE"));
 }
=20
 static void save_state(void)
@@ -1210,6 +1211,15 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 			merge_msg.len)
 			die("Could not write to %s", git_path("MERGE_MSG"));
 		close(fd);
+		fd =3D open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT | O_TRUNC, 06=
66);
+		if (fd < 0)
+			die("Could open %s for writing", git_path("MERGE_MODE"));
+		strbuf_reset(&buf);
+		if (!allow_fast_forward)
+			strbuf_addf(&buf, "no-ff");
+		if (write_in_full(fd, buf.buf, buf.len) !=3D buf.len)
+			die("Could not write to %s", git_path("MERGE_MODE"));
+		close(fd);
 	}
=20
 	if (merge_was_ok) {
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9516f54..209d7cd 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -511,4 +511,20 @@ test_expect_success 'in-index merge' '
=20
 test_debug 'gitk --all'
=20
+test_expect_success 'merge --no-ff --no-commit && commit' '
+	git reset --hard c0 &&
+	git merge --no-ff --no-commit c1 &&
+	EDITOR=3D: git commit &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'amending no-ff merge commit' '
+	EDITOR=3D: git commit --amend &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
 test_done
--=20
1.6.0.2
