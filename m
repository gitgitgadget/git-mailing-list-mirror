From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Mon, 21 Jul 2008 15:39:06 +0200
Message-ID: <4884917A.1060005@free.fr>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org> <4882454D.2080500@free.fr> <7vd4l9zgmp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 15:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKvcZ-00031u-Db
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 15:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbYGUNjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2008 09:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbYGUNjL
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 09:39:11 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:43907 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbYGUNjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 09:39:10 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 1096812B71A;
	Mon, 21 Jul 2008 15:39:08 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D955112B6E3;
	Mon, 21 Jul 2008 15:39:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7vd4l9zgmp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89357>

Junio C Hamano a =E9crit :
>=20
> Anything that changes "am" to require a clean working tree will NEVER=
 be
> accepted.  I personally rely on the ability for it to run in a dirty =
tree,
> so does Linus.
>=20
> 	Side note.  Anything that changes "merge" to require a clean
> 	working tree is also unacceptable.  Cf.
>=20
> 	http://thread.gmane.org/gmane.comp.version-control.git/9073/focus=3D=
9089
>=20
> 	Linus talks about "patch" in the paragraph second to the last one
> 	in the message; back then he was talking about "git-applymbox" but
> 	the same argument there applies to its newer incarnation "git-am".
>=20
> 	Side note #2.  It would have been nice if "rebase" were also
> 	written in such a way that it can work in a dirty tree as long as
> 	local changes did not interfere with the operation, but it is a
> 	lot more involved.

Thanks for the explanation and the really interesting pointer.

The last thing that still annoy me is the --skip that refuse to skip in=
 3-way
merge. Perhaps we can use the "git read-tree --reset -u" thing for skip=
 too.

So, what about the following patch?

-- >8 --
=46rom: Olivier Marin <dkr@freesurf.fr>

git am --skip: clean the index while preserving local changes

In 3-way merge, "am" will let the index with unmerged path waiting
for us to resolve conflicts and continue. But if we want to --skip
instead, "am" refuses to continue because of the dirty index.

With this patch, "am" will clean the index without touching files
locally modified, before continue.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 git-am.sh           |   12 +++++++++---
 t/t4151-am-abort.sh |   11 +++++++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 60aaa4a..864c77e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -202,8 +202,15 @@ then
 	die "previous rebase directory $dotest still exists but mbox given."
 	resume=3Dyes
=20
-	case "$abort" in
-	t)
+	case "$skip,$abort" in
+	t,)
+		git rerere clear
+		git read-tree --reset -u HEAD HEAD
+		orig_head=3D$(cat "$GIT_DIR/ORIG_HEAD")
+		git reset HEAD
+		git update-ref ORIG_HEAD $orig_head
+		;;
+	,t)
 		git rerere clear
 		git read-tree --reset -u HEAD ORIG_HEAD
 		git reset ORIG_HEAD
@@ -297,7 +304,6 @@ last=3D`cat "$dotest/last"`
 this=3D`cat "$dotest/next"`
 if test "$skip" =3D t
 then
-	git rerere clear
 	this=3D`expr "$this" + 1`
 	resume=3D
 fi
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index dda7e2c..249093b 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -14,7 +14,7 @@ test_expect_success setup '
 	git add file-1 file-2 &&
 	git commit -m initial &&
 	git tag initial &&
-	for i in 2 3 4 5
+	for i in 2 3 4 5 6
 	do
 		echo $i >>file-1 &&
 		test_tick &&
@@ -32,7 +32,7 @@ do
 		git reset --hard initial &&
 		cp file-2-expect file-2 &&
=20
-		test_must_fail git am$with3 000[124]-*.patch &&
+		test_must_fail git am$with3 000[1245]-*.patch &&
 		git log --pretty=3Dtformat:%s >actual &&
 		for i in 3 2 initial
 		do
@@ -41,6 +41,13 @@ do
 		test_cmp expect actual
 	'
=20
+	test_expect_success "am$with3 --skip continue after failed am$with3" =
'
+		test_must_fail git-am$with3 --skip >output &&
+		test "$(grep "^Applying" output)" =3D "Applying 6" &&
+		test_cmp file-2-expect file-2 &&
+		test ! -f .git/rr-cache/MERGE_RR
+	'
+
 	test_expect_success "am --abort goes back after failed am$with3" '
 		git-am --abort &&
 		git rev-parse HEAD >actual &&
--=20
1.5.6.4.570.g052e.dirty
