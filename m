From: Mark Hills <mark@pogo.org.uk>
Subject: git-clone file permissions and cpio
Date: Mon, 21 Apr 2008 09:45:18 +0100 (BST)
Message-ID: <alpine.BSO.1.10.0804210911170.21918@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 11:20:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnsCl-0002xu-0t
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 11:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbYDUJUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 05:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbYDUJUI
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 05:20:08 -0400
Received: from mailout.ijneb.com ([212.13.201.26]:8376 "EHLO metheny.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755041AbYDUJUH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 05:20:07 -0400
X-Greylist: delayed 2087 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Apr 2008 05:20:06 EDT
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1JnreI-0001Ce-Np; Mon, 21 Apr 2008 09:45:18 +0100
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80015>

I persuaded my employer to test Git -- with good results so far. But we 
have a problem with file permissions.

We use the setuid bit on much of our central file hierarchy to ensure that 
anyone in a certain unix group of trusted users can push.

I noticed that the .git/objects directory was losing this setuid bit.

This creates problems later, when subdirectories of .git/objects are 
created by one user, and another user does a checkin which requires write 
to that subdirectory:

drwxrwx--- 2 mhills trust 51 Apr 18 09:39 eb
drwxrwx--- 2 mhills user   6 Apr 18 09:40 f4
drwxrwx--- 2 mhills trust  6 Apr 18 09:39 info
drwxrwx--- 2 mhills trust  6 Apr 18 09:39 pack

The offending operation is a cpio-based file copy in git-clone.sh. I 
updated to the latest Git source and cpio, with the same issue.

I got some kind of working behaviour with the diff below, which stops cpio 
'fixing' the file permissions (only on the directories). But it seems the 
underlying cause is cpio trying to copy file permissions which it would be 
better off not doing in this case (and which there isn't a flag to 
disable).

Is this a known problem? How can we fix this properly?

Mark


diff --git a/git-clone.sh b/git-clone.sh
index 2636159..3b8280b 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -333,7 +333,7 @@ yes)
                         fi
                 fi &&
                 cd "$repo" &&
-               find objects -depth -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
+               find objects -depth ! -type d -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
                         exit 1
         fi
         git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
