From: David Watson <dwatson@mimvista.com>
Subject: [PATCH] Test for git-svn dcommit clobbering changes
Date: Fri, 31 Aug 2007 20:25:01 -0400
Message-ID: <20070901002501.GA11591@mimvista.com>
References: <Pine.LNX.4.64.0708312200480.28586@racer.site> <20070831221814.GB31033@untitled> <Pine.LNX.4.64.0709010017250.28586@racer.site> <20070831234854.GA6451@mimvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 02:24:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRGmn-0002ld-SE
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 02:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbXIAAYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 20:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbXIAAYA
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 20:24:00 -0400
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:44333
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750856AbXIAAX7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 20:23:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id 49443355DC9;
	Fri, 31 Aug 2007 20:22:09 -0400 (EDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: 1.06
X-Spam-Level: *
X-Spam-Status: No, score=1.06 tagged_above=-10 required=6.6 tests=[AWL=-0.333,
	BAYES_00=-2.599, RCVD_IN_NJABL_DUL=1.946, RCVD_IN_SORBS_DUL=2.046]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RNoP6IVKk0Ml; Fri, 31 Aug 2007 20:22:02 -0400 (EDT)
Received: from localhost (cpe-66-61-71-72.neo.res.rr.com [66.61.71.72])
	by zimbra.mimvista.com (Postfix) with ESMTP id 936C1355C9B;
	Fri, 31 Aug 2007 20:22:02 -0400 (EDT)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070831234854.GA6451@mimvista.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57235>

If you make multiple commits, and a commit other than the first applies
to the same file as a new change in the SVN repository, git-svn will blow
away the other commit's changes.

---


On Fri, Aug 31, 2007 at 07:48:55PM -0400, David Watson wrote:
> I just reproduced this one in a live repository. Here's what you do:
> 
> $ git checkout -b breakme trunk
> $ vi file1.txt
> $ git-commit -a -m 'first change'
> $ vi file2.txt
> $ git-commit -a -m 'second change'
> ..... Full moon, become a werewolf ......
> C:\svnrepo> edit file2.txt
> C:\svnrepo> svn commit -m 'this will be gone'
> ..... Become yourself again ....
> $ git svn fetch --all # (not sure if this is necessary)
> $ git svn dcommit
> $ git log -p

 t/t9106-git-svn-commit-diff-clobber.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 6f132f2..2706153 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -50,6 +50,9 @@ test_expect_failure 'dcommit fails to commit because of conflict' "
 	svn commit -m 'fourth line from svn' &&
 	cd .. &&
 	rm -rf t.svn &&
+	echo another file from git >> file2 &&
+	git add file2 &&
+	git commit -m 'another file here' &&
 	echo 'fourth line from git' >> file &&
 	git commit -a -m 'fourth line from git' &&
 	git-svn dcommit
-- 
1.5.3.rc4

Dave Watson
