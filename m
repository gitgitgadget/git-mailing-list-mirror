From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH/RFC] filter-branch: Fix to allow replacing submodules with another content
Date: Wed, 13 Jan 2010 15:56:39 +0100
Message-ID: <201001131556.40167.sojkam1@fel.cvut.cz>
References: <1263227634-11259-1-git-send-email-sojkam1@fel.cvut.cz> <alpine.DEB.1.00.1001111901380.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 15:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV4eQ-0007cA-PY
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 15:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534Ab0AMO4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 09:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755469Ab0AMO4r
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 09:56:47 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:55959 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab0AMO4q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 09:56:46 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 04FA919F3392;
	Wed, 13 Jan 2010 15:56:45 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id j3zvTezX59xt; Wed, 13 Jan 2010 15:56:40 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id BCD0F19F3337;
	Wed, 13 Jan 2010 15:56:40 +0100 (CET)
Received: from steelpick.localnet (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 93B41FA003;
	Wed, 13 Jan 2010 15:56:40 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31.9-amd64; KDE/4.3.4; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.1001111901380.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136827>

On Monday 11 of January 2010 19:02:06 Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 11 Jan 2010, Michal Sojka wrote:
> > When git filter-branch is used to replace a submodule with another
> > content, it always fails on the first commit. Consider a repository with
> > directory submodule containing a submodule. If I want to remove the
> > submodule and replace it with a file, the following command fails.
> >
> > git filter-branch --tree-filter 'rm -rf submodule &&
> > 				 git rm -q submodule &&
> > 				 mkdir submodule &&
> > 				 touch submodule/file'
> >
> > The error message is:
> > error: submodule: is a directory - add files inside instead
> >
> > The reason is that git diff-index, which generates a part of the list of
> > files to update-index, emits also the removed submodule even if it was
> > replaced by a real directory.
> >
> > Adding --ignored-submodules solves the problem for me and
> > tests in t7003-filter-branch.sh passes correctly.
> 
> Have you tested replacing one revision of a submodule with another?

Hi,

no, I didn't try it. I wanted to test it now but it seems to me that
it cannot work even without my patch. I may be trying wrong
--tree-filter. If anybody has a better idea, let me know.

I suppose that in order to change the revision of the submodule within
the tree filter, I need to checkout the original revision first. Then
I could use e.g. git reset HEAD^ to change it. Unfortunately even
checkout of the submodule fails:

$ git filter-branch --tree-filter "git submodule update --init" HEAD
Clone of '/tmp/submod' into submodule path 'submod' failed
tree filter failed: git submodule update --init

This is because filter-branch sets GIT_WORKING_TREE to "." which
causes clone to fail.

Replacing a revision of a submodule can be done only by manipulating
index, but for this case you would use index-filter rather than
tree-filter. Right?

I have created a few tests for testing filter-branch with submodules.
See the patch bellow.

Michal

>From 9aa38185d795061a2f00204d181244f906280b5a Mon Sep 17 00:00:00 2001
From: Michal Sojka <sojkam1@fel.cvut.cz>
Date: Wed, 13 Jan 2010 15:15:28 +0100
Subject: [PATCH] filter-branch: Add tests for submodules


Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 t/t7003-filter-branch.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 9503875..daebd17 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -306,4 +306,30 @@ test_expect_success '--remap-to-ancestor with filename filters' '
 	test $orig_invariant = $(git rev-parse invariant)
 '
 
+test_expect_success 'setup submodule' '
+	rm -rf * .*
+	git init &&
+	test_commit file &&
+	mkdir submod &&
+	submodurl="$PWD/submod"
+	( cd submod &&
+	  git init &&
+	  test_commit file-in-submod ) &&
+	git submodule add "$submodurl"
+	git commit -m "added submodule" &&
+	test_commit add-file &&
+	( cd submod && test_commit add-in-submodule ) &&
+	git add submod &&
+	git commit -m "changed submodule"
+'
+
+test_expect_failure 'rewrite submodule with another content' '
+	git filter-branch --tree-filter "test -d submod && {
+					 rm -rf submod &&
+					 git rm -rf --quiet submod &&
+					 mkdir submod &&
+					 : > submod/file
+					 } || :"
+'
+
 test_done
-- 
1.6.6
