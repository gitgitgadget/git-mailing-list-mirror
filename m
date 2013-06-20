From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] pull: merge into unborn by fast-forwarding from empty
 tree
Date: Thu, 20 Jun 2013 18:38:28 -0400
Message-ID: <20130620223828.GB18675@sigill.intra.peff.net>
References: <20130620223550.GA21667@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 00:38:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpnUy-00011J-ML
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 00:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433Ab3FTWid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jun 2013 18:38:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:60541 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030368Ab3FTWic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 18:38:32 -0400
Received: (qmail 18006 invoked by uid 102); 20 Jun 2013 22:39:32 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 17:39:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 18:38:28 -0400
Content-Disposition: inline
In-Reply-To: <20130620223550.GA21667@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228552>

=46rom: Thomas Rast <trast@inf.ethz.ch>

The logic for pulling into an unborn branch was originally
designed to be used on a newly-initialized repository
(d09e79c, git-pull: allow pulling into an empty repository,
2006-11-16).  It thus did not initially deal with
uncommitted changes in the unborn branch.  The case of an
_unstaged_ untracked file was fixed by 4b3ffe5 (pull: do not
clobber untracked files on initial pull, 2011-03-25).
However, it still clobbered existing staged files, both when
the file exists in the merged commit (it will be
overwritten), and when it does not (it will be deleted).

We fix this by doing a two-way merge, where the "current"
side of the merge is an empty tree, and the "target" side is
HEAD (already updated to FETCH_HEAD at this point).  This
amounts to claiming that all work in the index was done vs.
an empty tree, and thus all content of the index is
precious.

Note that this use of read-tree just gives us protection
against overwriting index and working tree changes. It will
not actually result in a 3-way merge conflict in the index.
This is fine, as this is a rare situation, and the conflict
would not be interesting anyway (it must, by definition, be
an add/add conflict with the whole content conflicting). And
it makes it simpler for the user to recover, as they have no
HEAD to "git reset" back to.

Reported-by: Stefan Sch=C3=BC=C3=9Fler <mail@stefanschuessler.de>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Jeff King <peff@peff.net>
---
 git-pull.sh     |  9 ++++++++-
 t/t5520-pull.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index 7904753..6828e2c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -266,9 +266,16 @@ then
 	;;
 esac
=20
+# Pulling into unborn branch: a shorthand for branching off
+# FETCH_HEAD, for lazy typers.
 if test -z "$orig_head"
 then
-	git read-tree -m -u $merge_head &&
+	# Two-way merge: we claim the index is based on an empty tree,
+	# and try to fast-forward to HEAD.  This ensures we will not
+	# lose index/worktree changes that the user already made on
+	# the unborn branch.
+	empty_tree=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	git read-tree -m -u $empty_tree $merge_head &&
 	git update-ref -m "initial pull" HEAD $merge_head "$curr_head"
 	exit
 fi
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 6af6c63..ed4d9c8 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -57,6 +57,35 @@ test_expect_success 'pulling into void does not over=
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
+		test_cmp expect file &&
+		git cat-file blob :file >file.index &&
+		test_cmp expect file.index
+	)
+'
+
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
+		test_cmp expect newfile &&
+		git cat-file blob :newfile >newfile.index &&
+		test_cmp expect newfile.index
+	)
+'
+
 test_expect_success 'test . as a remote' '
=20
 	git branch copy master &&
--=20
1.8.3.rc2.14.g7eee6b3
