From: Jeff King <peff@peff.net>
Subject: [PATCHv2 2/2] merge-one-file: fix broken merges with alternate work
 trees
Date: Fri, 29 Apr 2011 18:24:32 -0400
Message-ID: <20110429222432.GB3347@sigill.intra.peff.net>
References: <20110429185228.GA27268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Aman Gupta <themastermind1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:24:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFw76-0003ev-CD
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933983Ab1D2WYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:24:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48445
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485Ab1D2WYe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:24:34 -0400
Received: (qmail 16851 invoked by uid 107); 29 Apr 2011 22:26:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Apr 2011 18:26:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 18:24:32 -0400
Content-Disposition: inline
In-Reply-To: <20110429185228.GA27268@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172498>

The merge-one-file tool predates the invention of
GIT_WORK_TREE. By the time GIT_WORK_TREE was invented, most
people were using the merge-recursive strategy, which
handles resolving internally. Therefore these features have
had very little testing together.

For the most part, merge-one-file just works with
GIT_WORK_TREE; most of its heavy lifting is done by plumbing
commands which do respect GIT_WORK_TREE properly. The one
exception is a shell redirection which touches the worktree
directly, writing results to the wrong place in the presence
of a GIT_WORK_TREE variable.

This means that merges won't even fail; they will silently
produce incorrect results, throwing out the entire "theirs"
side of files which need content-level merging!

This patch makes merge-one-file chdir to the toplevel of the
working tree (and exit if we don't have one). This most
closely matches the assumption made by the original script
(before separate work trees were invented), and matches what
happens when the script is called as part of a merge
strategy.

While we're at it, we'll also error-check the call to cat.
Merging a file in a subdirectory could in fact fail, as the
redirection relies on the "checkout-index" call just prior
to create leading directories. But we never noticed, since
we ignored the error return from running cat.

Signed-off-by: Jeff King <peff@peff.net>
---
This one takes a totally different strategy than v1, but I think it
makes more sense (and it fixes the core.worktree bug).

 git-merge-one-file.sh  |    7 ++++++-
 t/t6060-merge-index.sh |    4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index b86402a..7aeb969 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -22,6 +22,11 @@ LONG_USAGE="Usage: git merge-one-file $USAGE
 
 Blob ids and modes should be empty for missing files."
 
+SUBDIRECTORY_OK=Yes
+. git-sh-setup
+cd_to_toplevel
+require_work_tree
+
 if ! test "$#" -eq 7
 then
 	echo "$LONG_USAGE"
@@ -132,7 +137,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 
 	# Create the working tree file, using "our tree" version from the
 	# index, and then store the result of the merge.
-	git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4"
+	git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4" || exit 1
 	rm -f -- "$orig" "$src1" "$src2"
 
 	if [ "$6" != "$7" ]; then
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 895f079..debadbd 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -68,7 +68,7 @@ test_expect_success 'merge-one-file fails without a work tree' '
 	)
 '
 
-test_expect_failure 'merge-one-file respects GIT_WORK_TREE' '
+test_expect_success 'merge-one-file respects GIT_WORK_TREE' '
 	(cd bare.git &&
 	 mkdir work &&
 	 GIT_WORK_TREE=$PWD/work &&
@@ -82,7 +82,7 @@ test_expect_failure 'merge-one-file respects GIT_WORK_TREE' '
 	test_cmp expect-merged bare.git/work/file-index
 '
 
-test_expect_failure 'merge-one-file respects core.worktree' '
+test_expect_success 'merge-one-file respects core.worktree' '
 	mkdir subdir &&
 	git clone . subdir/child &&
 	(cd subdir &&
-- 
1.7.4.3.28.g10631
