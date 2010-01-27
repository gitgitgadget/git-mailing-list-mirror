From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH] filter-branch fix and tests
Date: Wed, 27 Jan 2010 16:49:18 +0100
Message-ID: <201001271649.19287.sojkam1@fel.cvut.cz>
References: <1264424786-26231-1-git-send-email-sojkam1@fel.cvut.cz> <alpine.DEB.1.00.1001261939420.4641@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 16:49:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaA98-00009N-9h
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 16:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab0A0Pt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 10:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498Ab0A0Pt1
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 10:49:27 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:47359 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755496Ab0A0Pt0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 10:49:26 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 2381319F3324;
	Wed, 27 Jan 2010 16:49:25 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id d-H0cvRd6My0; Wed, 27 Jan 2010 16:49:20 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id CE87D19F3379;
	Wed, 27 Jan 2010 16:49:20 +0100 (CET)
Received: from steelpick.localnet (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 9BB3AFA003;
	Wed, 27 Jan 2010 16:49:20 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31.11-amd64; KDE/4.3.4; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.1001261939420.4641@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138161>

Hi Johannes,

On Tuesday 26 of January 2010 19:40:47 Johannes Schindelin wrote:
> On Mon, 25 Jan 2010, Michal Sojka wrote:
> > this is resend of the patch I sent two weeks ago. I've extended the
> > commit message to address Johannes' question and in the second patch
> > I've added tests for the fix.
> 
> From a quick look, it does not seem that I will be happy with your "fix";
> you changed the commit message, but did not address the issue.
> 
> Unfortunately, I do not have time to review anything that takes longer
> than 30 minutes in total, and today not even that, so that will have to
> wait.

Thanks for your reply. I do not want to steal your time, but I may not
understand what is the issue. I extended my previous patch with tests
(see bellow) so that all the use cases which might be IMHO affected by
my "fix" are covered. If you can think of another use case let me
know.

The fastest way to test this patch is:
GIT_SKIP_TESTS='t7003.[12]? t7003.[2-9]' ./t7003-filter-branch.sh -d

>From 849b105541ba4b5e3592de6769922b1264be0c77 Mon Sep 17 00:00:00 2001
From: Michal Sojka <sojkam1@fel.cvut.cz>
Date: Wed, 27 Jan 2010 15:57:17 +0100
Subject: [PATCH] filter-branch: Add tests for submodules

There are three important tests:
1) 'rewrite submodule with another content' passes only with the
   previous patch applied.

2) 'checkout submodule during rewrite' demonstrates that it is not
   possible to replace a submodule revision in tree-filter by checking
   the submodule out and reseting the submodule's HEAD. Fails both
   with and without the previous patch. This is because filter-branch
   sets GIT_WORKING_TREE to "." which causes clone (called from
   git-submodule) to fail.

3) 'replace submodule revision' shows that replacing submodule
   revision is possible by direct index manipulation. Succeeds both
   with and without the previous patch.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 t/t7003-filter-branch.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 9503875..a218d7a 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -306,4 +306,52 @@ test_expect_success '--remap-to-ancestor with filename filters' '
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
+	git branch original HEAD
+'
+
+orig_head=`git show-ref --hash HEAD`
+export orig_head
+
+test_expect_success 'rewrite submodule with another content' '
+	git filter-branch --tree-filter "test -d submod && {
+					 rm -rf submod &&
+					 git rm -rf --quiet submod &&
+					 mkdir submod &&
+					 : > submod/file
+					 } || : &&
+					 test $orig_head != `git show-ref --hash HEAD`"
+'
+
+test_expect_failure 'checkout submodule during rewrite' '
+	git reset --hard original &&
+	git filter-branch -f --tree-filter \
+	    "git submodule update --init &&
+	     cd submod &&
+	     git reset --hard origin/master" HEAD
+'
+
+test_expect_success 'replace submodule revision' '
+	git reset --hard original &&
+	git filter-branch -f --tree-filter \
+	    "git ls-files --error-unmatch -- submod > /dev/null 2>&1 &&
+	     git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 submod ||
+	     : &&
+	     test $orig_head != `git show-ref --hash HEAD`"
+'
+
 test_done
-- 
1.6.6
