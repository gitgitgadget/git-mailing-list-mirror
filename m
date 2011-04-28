From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] merge-one-file: fix broken merges with GIT_WORK_TREE
Date: Thu, 28 Apr 2011 18:41:25 -0400
Message-ID: <20110428224125.GB16027@sigill.intra.peff.net>
References: <20110428223822.GA16004@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aman Gupta <themastermind1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 00:41:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFZtt-0000nX-US
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 00:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab1D1Wl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 18:41:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46618
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290Ab1D1Wl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 18:41:28 -0400
Received: (qmail 6755 invoked by uid 107); 28 Apr 2011 22:43:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Apr 2011 18:43:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2011 18:41:25 -0400
Content-Disposition: inline
In-Reply-To: <20110428223822.GA16004@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172414>

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

This patch properly prefixes the path in the shell
redirection. An alternative strategy would be to have
merge-one-file use git-sh-setup, and cd_to_toplevel
beforehand. I opted for the minimal fix here, as changing
directories would impact where merge-one-file is unpacking
and working with files.

While we're at it, we'll also error-check the call to cat.
Merging a file in a subdirectory could in fact fail, as the
redirection relies on the "checkout-index" call just prior
to create leading directories. But we never noticed, since
we ignored the error return from running cat.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-merge-one-file.sh  |    4 +++-
 t/t6060-merge-index.sh |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index b86402a..0b5e3f6 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -132,7 +132,9 @@ case "${1:-.}${2:-.}${3:-.}" in
 
 	# Create the working tree file, using "our tree" version from the
 	# index, and then store the result of the merge.
-	git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4"
+	git checkout-index -f --stage=2 -- "$4" &&
+		cat "$src1" >"${GIT_WORK_TREE:+$GIT_WORK_TREE/}$4" ||
+		exit 1
 	rm -f -- "$orig" "$src1" "$src2"
 
 	if [ "$6" != "$7" ]; then
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 8f8ec77..fd90e70 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -51,7 +51,7 @@ test_expect_success 'git merge-index git-merge-one-file resolves' '
 	test_cmp expect-merged file-index
 '
 
-test_expect_failure 'merge-one-file respects GIT_WORK_TREE' '
+test_expect_success 'merge-one-file respects GIT_WORK_TREE' '
 	git clone . bare.git &&
 	(cd bare.git &&
 	 mkdir work &&
-- 
1.7.5.rc3.17.g5e09b
