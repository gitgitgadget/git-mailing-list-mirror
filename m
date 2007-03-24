From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] When creating branch c/d check that branch c does not
 already exists.
Date: Sat, 24 Mar 2007 06:30:10 +0100
Message-ID: <20070324063010.a114722e.chriscool@tuxfamily.org>
References: <20060928065803.2774a63c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 06:22:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUyhf-0006vW-4D
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 06:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbXCXFV7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 01:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbXCXFV7
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 01:21:59 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60712 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbXCXFVy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 01:21:54 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 6F642B56E3;
	Sat, 24 Mar 2007 06:21:53 +0100 (CET)
In-Reply-To: <20060928065803.2774a63c.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42977>

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
