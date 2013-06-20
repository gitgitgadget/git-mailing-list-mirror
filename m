From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] pull: pull into void by fast-forwarding from empty tree
Date: Thu, 20 Jun 2013 14:36:03 +0200
Message-ID: <45f6841746e5dcea03a97fc3ea24aef274728023.1371731513.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?q?Stefan=20Sch=C3=BC=C3=9Fler?= <mail@stefanschuessler.de>
X-From: git-owner@vger.kernel.org Thu Jun 20 14:36:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upe65-0001hi-8k
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 14:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532Ab3FTMgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jun 2013 08:36:11 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42876 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757442Ab3FTMgI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 08:36:08 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 20 Jun
 2013 14:35:57 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 20 Jun
 2013 14:36:04 +0200
X-Mailer: git-send-email 1.8.3.1.664.gae9f72a
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228487>

The logic for pulling into an unborn branch was originally designed to
be used on a newly-initialized repository (d09e79c, git-pull: allow
pulling into an empty repository, 2006-11-16).  It thus did not
initially deal with uncommitted changes in the unborn branch.  The
case of an _unstaged_ untracked file was fixed by by 4b3ffe5 (pull: do
not clobber untracked files on initial pull, 2011-03-25).  However, it
still clobbered existing staged files, both when the file exists in
the merged commit (it will be overwritten), and when it does not (it
will be lost!).

We fix this by doing a two-way merge, where the "current" side of the
merge is an empty tree, and the "target" side is HEAD (already updated
to FETCH_HEAD at this point).  This amounts to claiming that all work
in the index was done vs. an empty tree, and thus all content of the
index is precious.

Reported-by: Stefan Sch=C3=BC=C3=9Fler <mail@stefanschuessler.de>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

Stefan Sch=C3=BC=C3=9Fler <mail@stefanschuessler.de> writes:

> I think there's a bug in git pull. Doing a git pull in a fresh
> repository without any commits removes files in the index.
[...]

Thanks for the bug report!

 git-pull.sh     |  9 ++++++++-
 t/t5520-pull.sh | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index 638aabb..1f84383 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -266,10 +266,17 @@ case "$merge_head" in
 	;;
 esac
=20
+# Pulling into unborn branch: a shorthand for branching off
+# FETCH_HEAD, for lazy typers.
 if test -z "$orig_head"
 then
 	git update-ref -m "initial pull" HEAD $merge_head "$curr_head" &&
-	git read-tree -m -u HEAD || exit 1
+	# Two-way merge: we claim the index is based on an empty tree,
+	# and try to fast-forward to HEAD.  This ensures we will not
+	# lose index/worktree changes that the user already made on
+	# the unborn branch.
+	empty_tree=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	git read-tree -m -u $empty_tree HEAD || exit 1
 	exit
 fi
=20
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 6af6c63..927903c 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -57,6 +57,30 @@ test_expect_success 'pulling into void does not over=
write untracked files' '
 	)
 '
=20
+test_expect_success 'pulling into void does not overwrite staged files=
' '
+	git init cloned-staged-colliding &&
+	(
+		cd cloned-staged-colliding &&
+		echo "alternate content" >file &&
+		git add file &&
+		test_must_fail git pull .. master &&
+		echo "alternate content" >expect &&
+		test_cmp expect file
+	)
+'
+
+test_expect_success 'pulling into void does not remove new staged file=
s' '
+	git init cloned-staged-new &&
+	(
+		cd cloned-staged-new &&
+		echo "new tracked file" >newfile &&
+		git add newfile &&
+		git pull .. master &&
+		echo "new tracked file" >expect &&
+		test_cmp expect newfile
+	)
+'
+
 test_expect_success 'test . as a remote' '
=20
 	git branch copy master &&
--=20
1.8.3.1.664.gae9f72a
