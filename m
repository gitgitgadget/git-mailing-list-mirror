From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH/RFC] git-merge.sh: better handling of combined
	--squash,--no-ff,--no-commit options
Date: Sun, 2 Mar 2008 17:58:19 +0000
Message-ID: <20080302175820.31385.qmail@9e9c5b8314ca7b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:58:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVsSS-0004wp-Ha
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbYCBR6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbYCBR6D
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:58:03 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:38276 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755363AbYCBR6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:58:01 -0500
Received: (qmail 31395 invoked by uid 1000); 2 Mar 2008 17:58:20 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75821>

git-merge used to use either the --squash,--no-squash, --no-ff,--ff,
--no-commit,--commit option, whichever came last in the command line.
This lead to some un-intuitive behavior, having

 git merge --no-commit --no-ff <branch>

actually commit the merge.  Now git-merge respects --no-commit together
with --no-ff, as well as other combinations of the options.  However,
this broke a selftest in t/t7600-merge.sh which expected to have --no-ff
completely override the --squash option, so that

 git merge --squash --no-ff <branch>

fast-forwards, and makes a merge commit; now it prepares a squash
commit.  Combining --squash with --no-ff doesn't seem to make sense
though, so the test is adapted to test --no-ff without the preceding
--squash.

The unexpected behavior was reported by John Goerzen through
 http://bing.sdebian.org/468568

Signed-off-by: Gerrit Pape <pape@smarden.org>

---
 git-merge.sh     |   13 +++++++------
 t/t7600-merge.sh |    1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 1c123a3..2a5c456 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -37,6 +37,7 @@ use_strategies=
 
 allow_fast_forward=t
 allow_trivial_merge=t
+squash= no_commit=
 
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
@@ -152,17 +153,17 @@ parse_config () {
 		--summary)
 			show_diffstat=t ;;
 		--squash)
-			allow_fast_forward=t squash=t no_commit=t ;;
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
+			allow_fast_forward=f ;;
 		-s|--strategy)
 			shift
 			case " $all_strategies " in
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 50c51c8..085f55f 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -419,6 +419,7 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c0 with c1 (no-ff)' '
 	git reset --hard c0 &&
+	git config branch.master.mergeoptions "" &&
 	test_tick &&
 	git merge --no-ff c1 &&
 	verify_merge file result.1 &&
-- 
1.5.4.3

