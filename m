From: David Kastrup <dak@gnu.org>
Subject: [fixed PATCH] git-filter-branch.sh: Fix broken setting of GIT_DIR
Date: Fri, 10 Aug 2007 18:21:34 +0200
Message-ID: <864pj74ay9.fsf@lola.quinscape.zz>
References: <868x8j7aj2.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 18:22:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJXFa-0002Sl-JI
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 18:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764611AbXHJQWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 12:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765167AbXHJQWF
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 12:22:05 -0400
Received: from main.gmane.org ([80.91.229.2]:33458 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762545AbXHJQWD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 12:22:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJXFI-0008CL-Tl
	for git@vger.kernel.org; Fri, 10 Aug 2007 18:21:53 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 18:21:52 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 18:21:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <868x8j7aj2.fsf@lola.quinscape.zz>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:bvAatrvXLVlW0y1opb36mp63Bco=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55551>

If filter-branch is entered with an unset GIT_DIR, things are rather
fragile.  The GIT_DIR variable setting then points to something like
$(pwd)/../.. which is neither guaranteed to be a git directory
(depends on where filter-branch is started), nor will it continue to
work once the temporary directory (for which the pwd is output) ceases
to exist.

So we just call git-rev-parse in order to get the correct setting here
for exporting.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 git-filter-branch.sh |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index b5fa449..9e9e8bf 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -170,14 +170,11 @@ do
 	esac
 done < "$tempdir"/backup-refs
 
-case "$GIT_DIR" in
-/*)
-	;;
-*)
-	GIT_DIR="$(pwd)/../../$GIT_DIR"
-	;;
-esac
-export GIT_DIR GIT_WORK_TREE=.
+GIT_DIR=$(cd ../..;cd "./$(git-rev-parse --git-dir)";pwd)
+
+GIT_WORK_TREE=.
+
+export GIT_DIR GIT_WORK_TREE
 
 # These refs should be updated if their heads were rewritten
 
-- 
1.5.3.rc4.74.g3739cb17
