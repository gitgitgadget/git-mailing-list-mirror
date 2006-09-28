From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] When creating branch c/d check that branch c does not
 already exists.
Date: Thu, 28 Sep 2006 07:00:38 +0200
Message-ID: <20060928070038.fd28ff39.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 06:54:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSnuu-0007Az-83
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 06:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWI1Eyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 00:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWI1Eyd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 00:54:33 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:4548 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750797AbWI1Eyc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 00:54:32 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id D5C6B75BA8;
	Thu, 28 Sep 2006 06:54:30 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27988>

With packed refs, there may not be a ".git/refs/heads/c" file
when branch c exists. And currently in this case, there is no check
to prevent creation of branch c/d.

This should probably be rewritten in C and done after the ref lock
has been taken to make sure no race exists though.

This is mainly to make all test cases in "t3210-pack-refs.sh" work.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-branch.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index 4826c75..4a1e7d9 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -122,6 +122,16 @@ then
 	done
 fi
 
+branchdir=$(dirname $branchname)
+while test "$branchdir" != "."
+do
+	if git-show-ref --verify --quiet -- "refs/heads/$branchdir"
+	then
+		die "$branchdir already exists."
+	fi
+	branchdir=$(dirname $branchdir)
+done
+
 if git-show-ref --verify --quiet -- "refs/heads/$branchname"
 then
 	if test '' = "$force"
-- 
1.4.2.1.g3bab
