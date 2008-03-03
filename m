From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-merge.sh: better handling of combined
	--squash,--no-ff,--no-commit options
Date: Mon, 3 Mar 2008 09:22:03 +0000
Message-ID: <20080303092203.9752.qmail@34b3887920a333.315fe32.mid.smarden.org>
References: <20080302175820.31385.qmail@9e9c5b8314ca7b.315fe32.mid.smarden.org> <7vir04n0rt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 10:22:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW6sc-0004XL-On
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 10:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbYCCJVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 04:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbYCCJVo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 04:21:44 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:42586 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759725AbYCCJVn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 04:21:43 -0500
Received: (qmail 9753 invoked by uid 1000); 3 Mar 2008 09:22:03 -0000
Content-Disposition: inline
In-Reply-To: <7vir04n0rt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75910>

git-merge used to use either the --squash,--no-squash, --no-ff,--ff,
--no-commit,--commit option, whichever came last in the command line.
This lead to some un-intuitive behavior, having

 git merge --no-commit --no-ff <branch>

actually commit the merge.  Now git-merge respects --no-commit together
with --no-ff, as well as other combinations of the options.  However,
this broke a selftest in t/t7600-merge.sh which expected to have --no-ff
completely override the --squash option, so that

 git merge --squash --no-ff <branch>

fast-forwards, and makes a merge commit; combining --squash with --no-ff
doesn't really make sense though, and is now refused by git-merge.  The
test is adapted to test --no-ff without the preceding --squash, and
another test is added to make sure the --squash --no-ff combination is
refused.

The unexpected behavior was reported by John Goerzen through
 http://bing.sdebian.org/468568

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Sun, Mar 02, 2008 at 03:50:46PM -0800, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > ...  Combining --squash with --no-ff doesn't seem to make sense
> Yeah, I think forbidding this combination would make much more sense.  The
> former asks there be _no_ merge (the user does not want to have a merge
> ever), while the other one asks to create a merge even when there is no
> need to (the user does want a merge).

Okay.

> Are there other combinations that we should forbid?

I don't think so, it's just --squash --no-ff, and maybe --squash --ff,
but --ff is the default anyway.

The combination --squash --commit doesn't work with the current
implementation though, but it might make sense to have the squash
committed automatically?


 git-merge.sh     |   17 +++++++++++------
 t/t7600-merge.sh |    6 ++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 1c123a3..03cd398 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -37,6 +37,7 @@ use_strategies=
 
 allow_fast_forward=t
 allow_trivial_merge=t
+squash= no_commit=
 
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
@@ -152,17 +153,21 @@ parse_config () {
 		--summary)
 			show_diffstat=t ;;
 		--squash)
-			allow_fast_forward=t squash=t no_commit=t ;;
+			test "$allow_fast_forward" = t ||
+				die "You cannot combine --squash with --no-ff."
+			squash=t no_commit=t ;;
 		--no-squash)
-			allow_fast_forward=t squash= no_commit= ;;
+			squash= no_commit= ;;
 		--commit)
-			allow_fast_forward=t squash= no_commit= ;;
+			no_commit= ;;
 		--no-commit)
-			allow_fast_forward=t squash= no_commit=t ;;
+			no_commit=t ;;
 		--ff)
-			allow_fast_forward=t squash= no_commit= ;;
+			allow_fast_forward=t ;;
 		--no-ff)
-			allow_fast_forward=false squash= no_commit= ;;
+			test "$squash" != t ||
+				die "You cannot combine --squash with --no-ff."
+			allow_fast_forward=f ;;
 		-s|--strategy)
 			shift
 			case " $all_strategies " in
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 50c51c8..5d16628 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -419,6 +419,7 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c0 with c1 (no-ff)' '
 	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
 	test_tick &&
 	git merge --no-ff c1 &&
 	verify_merge file result.1 &&
@@ -427,6 +428,11 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'combining --squash and --no-ff is refused' '
+	test_must_fail git merge --squash --no-ff c1 &&
+	test_must_fail git merge --no-ff --squash c1
+'
+
 test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
 	git reset --hard c0 &&
 	git config branch.master.mergeoptions "--no-ff" &&
-- 
1.5.4.3

