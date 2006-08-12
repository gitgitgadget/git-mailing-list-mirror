From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-sh-setup: Fail if the git directory was not found.
Date: Fri, 11 Aug 2006 18:47:50 -0700
Message-ID: <7vlkpuragp.fsf@assigned-by-dhcp.cox.net>
References: <44DC4C92.5060009@codeweavers.com>
	<7vfyg2sxrk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 12 03:47:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBibU-0003PU-Nv
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 03:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWHLBrw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 21:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWHLBrw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 21:47:52 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57259 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750708AbWHLBrw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 21:47:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060812014751.SMRR12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Aug 2006 21:47:51 -0400
To: Robert Shearman <rob@codeweavers.com>
In-Reply-To: <7vfyg2sxrk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 11 Aug 2006 15:39:11 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25249>

Junio C Hamano <junkio@cox.net> writes:

> Moving the assignment of GIT_OBJECT_DIRECTORY is fine, but
> changing it to an unconditional assignment is wrong.  The user
> can have a GIT_OBJECT_DIRECTORY set independently from GIT_DIR
> (or ../some/where/.git that is detected).

How about this as a replacement?

-- >8 --
[PATCH] git-sh-setup: do not use repo-config to test the git directory

Since repo-config does not fail in non-git directory, it is not
a good command to use to test the git-ness nor validate the
repository revision of $GIT_DIR.

Original patch by Robert Shearman but with minor fixes.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-sh-setup.sh |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d15747f..42f9b1c 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -35,17 +35,12 @@ case "$1" in
 	exit
 esac
 
+# Make sure we are in a valid repository of a vintage we understand.
 if [ -z "$SUBDIRECTORY_OK" ]
 then
 	: ${GIT_DIR=.git}
-	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
-
-	# Make sure we are in a valid repository of a vintage we understand.
-	GIT_DIR="$GIT_DIR" git repo-config --get core.nosuch >/dev/null
-	if test $? = 128
-	then
-	    exit
-	fi
+	GIT_DIR=$(GIT_DIR="$GIT_DIR" git-rev-parse --git-dir) || exit
 else
 	GIT_DIR=$(git-rev-parse --git-dir) || exit
 fi
+: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
-- 
1.4.2.rc4.g9d8df
