From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] builtin-commit: use reduce_heads() only when appropriate
Date: Fri, 3 Oct 2008 17:09:27 +0200
Message-ID: <20081003150927.GG6839@neumann>
References: <20081003023518.GA3291@spearce.org>
	<1223035487-2576-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jnareb@gmail.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 17:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlmIu-0000pU-UI
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 17:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbYJCPJn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Oct 2008 11:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbYJCPJm
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 11:09:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:49995 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYJCPJm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 11:09:42 -0400
Received: from [127.0.1.1] (p5B1337F6.dip0.t-ipconnect.de [91.19.55.246])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1KlmHX0VGv-0007c5; Fri, 03 Oct 2008 17:09:28 +0200
Content-Disposition: inline
In-Reply-To: <1223035487-2576-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/Ohp2mp1kKLVHx7TLFNPtmWJ/YZlVR9MW0jRa
 CjInC4wAgwd7szqg9gfkC5sSAZvxpONTxrt18S8TzSfMqP/+jC
 ioMTG111qgDtHqfRsMMNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97431>

Since commit 6bb6b034 (builtin-commit: use commit_tree(), 2008-09-10),
builtin-commit performs a reduce_heads() unconditionally.  However,
it's not always needed, and in some cases even harmful.

reduce_heads() is not needed for the initial commit or for an
"ordinary" commit, because they don't have any or have only one
parent, respectively.

reduce_heads() must be avoided when 'git commit' is run after a 'git
merge --no-ff --no-commit', otherwise it will turn the
non-fast-forward merge into fast-forward.  For the same reason,
reduce_heads() must be avoided when amending such a merge commit.

To resolve this issue, 'git merge' will write info about whether
fast-forward is allowed or not to $GIT_DIR/MERGE_MODE.  Based on this
info, 'git commit' will only perform reduce_heads() when it's
committing a merge and fast-forward is enabled.

Also add test cases to ensure that non-fast-forward merges are
committed and amended properly.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

  I think this should be squashed onto Mikl=F3s' patch.

  First, it fixes the segmentation fault caused by using the strbuf
  before initializing it.  Second, amending a no-ff merge commit has
  the same issues with reduce_heads();  see the new test case.  And the
  commit message is also more detailed ;)

  I'm not sure about putting these two new test into t7600-merge.sh.
  Although the infrastructure to keep these tests very short (repo with
  branches already set up, verify_parents) is there available, the firs=
t
  test tests not only merge, but the cooperation of merge and commit,
  and this second one tests only commit.

  Regards,
  G=E1bor


 builtin-commit.c |   21 +++++++++++----------
 t/t7600-merge.sh |    7 +++++++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e69b4af..93f360f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -953,6 +953,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 		return 1;
 	}
=20
+	strbuf_init(&sb, 0);
 	/* Determine parents */
 	if (initial_commit) {
 		reflog_msg =3D "commit (initial)";
@@ -986,22 +987,22 @@ int cmd_commit(int argc, const char **argv, const=
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
-	strbuf_reset(&sb);
-	if (!stat(git_path("MERGE_MODE"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
-			die("could not read MERGE_MODE: %s", strerror(errno));
-		if (!strcmp(sb.buf, "no-ff"))
-			allow_fast_forward =3D 0;
-	}
-	if (allow_fast_forward)
-		parents =3D reduce_heads(parents);
=20
 	/* Finally, get the commit message */
-	strbuf_init(&sb, 0);
+	strbuf_reset(&sb);
 	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		rollback_index_files();
 		die("could not read commit message");
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 98cfc53..209d7cd 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -520,4 +520,11 @@ test_expect_success 'merge --no-ff --no-commit && =
commit' '
=20
 test_debug 'gitk --all'
=20
+test_expect_success 'amending no-ff merge commit' '
+	EDITOR=3D: git commit --amend &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
 test_done
--=20
1.6.0.2.430.gfc53
