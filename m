From: "Tommy M. McGuire" <mcguire@crsr.net>
Subject: [PATCH] git cvsimport sanity checking
Date: Fri, 10 Jun 2005 01:27:47 -0500
Message-ID: <20050610062747.GA4763@immutable.crsr.net>
References: <Pine.LNX.4.58.0506071556000.2286@ppc970.osdl.org> <20050610062206.GA3992@immutable.crsr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 08:23:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgcvd-0000NY-DT
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 08:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVFJG1z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 02:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVFJG1z
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 02:27:55 -0400
Received: from [65.98.21.155] ([65.98.21.155]:63757 "EHLO immutable.crsr.net")
	by vger.kernel.org with ESMTP id S262494AbVFJG1w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 02:27:52 -0400
Received: from mcguire by immutable.crsr.net with local (Exim 3.35 #1 (Debian))
	id 1Dgczb-0001HK-00; Fri, 10 Jun 2005 01:27:47 -0500
To: "Tommy M. McGuire" <mcguire@crsr.net>
Content-Disposition: inline
In-Reply-To: <20050610062206.GA3992@immutable.crsr.net>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds some sanity checking to git-cvsimport-script,
specifically forcing the use of cvsps -x (to get the latest information
from the repository, rather than whatever is in the cache) and aborting
early if cvsps does not produce any output.

I debated removing the $MODULE directory following an abort, but I
eventually decided leaving stuff behind would make debugging easier.  On
the other hand, this patch should help with the "cvsimport left me with
an empty repository" complaints.

Signed-off-by: Tommy McGuire <mcguire@crsr.net>

Call cvsps with the -x flag, to get the current state of the repository,
and abort the cvs import early if cvsps does not produce any output.

---
commit 2e670826cec5642a11e2e7d6adcb48e02225ba6d
tree 25e4f590772b9c0bc8ac37f8a57f4a08435ed5c6
parent 21b4b44a5deee7985f14d0f4776ad0d489092a96
author Tommy M. McGuire <mcguire@crsr.net> Fri, 10 Jun 2005 01:38:42 -0500
committer Tommy M. McGuire <mcguire@crsr.net> Fri, 10 Jun 2005 01:38:42 -0500

 git-cvsimport-script |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -20,6 +20,8 @@ cvsps -h 2>&1 | grep -q "cvsps version 2
 mkdir "$MODULE" || exit 1
 cd "$MODULE"
 
-TZ=UTC cvsps -A $MODULE | git-cvs2git $ARGS --cvsroot="$CVSROOT" --module="$MODULE" > .git-create-script || exit 1
+TZ=UTC cvsps -x -A $MODULE > .git-cvsps-result
+[ -s .git-cvsps-result ] || exit 1
+git-cvs2git $ARGS --cvsroot="$CVSROOT" --module="$MODULE" < .git-cvsps-result > .git-create-script || exit 1
 sh .git-create-script
 



!-------------------------------------------------------------flip-


-- 
Tommy McGuire
