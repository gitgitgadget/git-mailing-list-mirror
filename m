From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] filter-branch: always export GIT_DIR if it is set
Date: Tue, 5 Jun 2007 18:49:57 +0200
Message-ID: <20070605164957.GA12358@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx> <20070603144714.GD20061@moooo.ath.cx> <7vodjudei2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:50:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvcEh-00059u-4d
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 18:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561AbXFEQuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 12:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764380AbXFEQuD
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 12:50:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:39419 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756561AbXFEQuB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 12:50:01 -0400
Received: (qmail invoked by alias); 05 Jun 2007 16:49:59 -0000
Received: from pd9ebb5ec.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.236]
  by mail.gmx.net (mp055) with SMTP; 05 Jun 2007 18:49:59 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+J8D1fwlaJ5PZjDy6ePPZ6s2tm5y1SgZWH5ql3Cq
	P5baFcubARKpwe
Content-Disposition: inline
In-Reply-To: <7vodjudei2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49205>

Currently filter-branch exports GIT_DIR only if it is a
relative path but git-sh-setup might also set GIT_DIR to an
absolute path that is not exported yet.  Additionally we need
to export GIT_WORK_TREE with GIT_DIR to ensure that the
current working directory is used as working tree even for
bare repositories.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Junio C Hamano <gitster@pobox.com> wrote:
> Hmph.
> 
> When this series is applied on top of 'next' (or whatever
> contains t7003-filter-branch.sh), this seems to break it quite
> badly.

With the GIT_WORK_TREE patch series a relative path in GIT_DIR is
expanded to an absolute path.  Therefore
    GIT_DIR=$(GIT_DIR=.git git rev-parse --git-dir)
in git-sh-setup will give the full path to the repository.
git-filter-branch exports GIT_DIR only if the path is relative.  In
consequence GIT_DIR was not set at all and the following git commands
failed.  Additionally GIT_WORK_TREE has to be exported because to make
sure that the current directory is used as working tree even for bare
repositories.

I merged the worktree branch to next and applied the patch, all tests
passed.

This problem reveals a small change which might cause trouble with other
scripts.  I looked at the git repository and found no other script which
should have problems with this series.  With
    $ git grep -e export --and -e GIT_DIR
I found:
    Documentation/install-doc-quick.sh
    git-clone.sh
    git-instaweb.sh
        These do not need a working tree.
    git-cvsexportcommit.perl
        git apply is used with GIT_DIR='', this forces git-apply not to
        use the git repository.

I'm not sure if any other script out there tries to do this.  Perhaps we
should just keep the old behaviour and use the current directory as
working tree when the repository name ends in /.git even though
core.bare is true?
---
 git-filter-branch.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0c8a7df..f4cfbea 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -313,9 +313,12 @@ workdir="$(pwd)"
 
 case "$GIT_DIR" in
 /*)
+	export GIT_DIR
+	export GIT_WORK_TREE=.
 	;;
 *)
 	export GIT_DIR="$(pwd)/../../$GIT_DIR"
+	export GIT_WORK_TREE=.
 	;;
 esac
 
-- 
1.5.2.1.120.g3877-dirty
