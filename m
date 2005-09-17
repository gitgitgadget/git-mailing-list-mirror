From: Anton Blanchard <anton@samba.org>
Subject: [PATCH] bisect succeeds but has non zero exit code
Date: Sat, 17 Sep 2005 14:32:39 +1000
Message-ID: <20050917043239.GG14962@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 17 06:35:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGUPr-0007UY-NJ
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 06:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVIQEfD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 00:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVIQEfD
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 00:35:03 -0400
Received: from ozlabs.org ([203.10.76.45]:19690 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750903AbVIQEfB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2005 00:35:01 -0400
Received: by ozlabs.org (Postfix, from userid 1010)
	id 204F4682F4; Sat, 17 Sep 2005 14:35:00 +1000 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8753>


Hi,

I was writing some scripts to automate a bisection search and noticed
I could get a non zero exit code when the command succeeded:

# git-bisect start
# echo $?
0

# git-bisect good ef4cbee0b0d0f791bb593f99b702410f3c0efce6
# echo $?
1

# git bisect bad 6d36ba629e0ef47a03d3703ee1d38143c25532a8
Bisecting: 13 revisions left to test after this
[1619cca2921f6927f4240e03f413d4165c7002fc] Partially revert "Fix time
going twice as fast problem on ATI Xpress chipsets"
# echo $?
0

It looks like bisect_next_check returns false and we return a non zero
exit code. The following patch forces a good exit code in that case.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

--- git-bisect.sh.orig	2005-09-15 17:37:08.000000000 +1000
+++ git-bisect.sh	2005-09-17 14:24:30.000000000 +1000
@@ -111,6 +111,7 @@
 
 bisect_auto_next() {
 	bisect_next_check && bisect_next
+	true
 }
 
 bisect_next() {
