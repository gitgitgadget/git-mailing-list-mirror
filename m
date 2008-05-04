From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH] Be more careful with objects directory permissions on
 clone
Date: Sun, 4 May 2008 12:37:00 +0100 (BST)
Message-ID: <alpine.BSO.1.10.0805041234570.5819@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 13:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JscXN-0006ay-Rn
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 13:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbYEDLhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 07:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbYEDLhB
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 07:37:01 -0400
Received: from mailout.ijneb.com ([212.13.201.26]:3138 "EHLO metheny.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754907AbYEDLhA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 07:37:00 -0400
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1JscWa-0004xU-In
	for git@vger.kernel.org; Sun, 04 May 2008 12:37:00 +0100
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81172>

Honour the setgid and umask when re-creating the objects directory
at the destination.

cpio in copy-pass mode aims to copy file permissions which causes this
problem and cannot be disabled. Be explicit by copying the directory
structure first, honouring the permissions at the destination, then copy
the files with their existing read-only permissions.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
  git-clone.sh |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 8c7fc7f..53c7e06 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -334,7 +334,10 @@ yes)
  			fi
  		fi &&
  		cd "$repo" &&
-		find objects -depth -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
+		# Create dirs using umask and permissions and destination
+		find objects -type d -print | (cd "$GIT_DIR" && xargs mkdir -p) &&
+		# Copy 0444 permissions on files
+		find objects -type f -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
  			exit 1
  	fi
  	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
-- 
1.5.5.1.126.g48d0c
