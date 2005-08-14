From: Amos Waterland <apw@rossby.metr.ou.edu>
Subject: [PATCH] clean up git script
Date: Sun, 14 Aug 2005 00:16:54 -0500
Message-ID: <20050814051654.GA36848@rossby.metr.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 14 07:19:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4Atv-0003vN-CD
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 07:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVHNFTL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 01:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVHNFTL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 01:19:11 -0400
Received: from rossby.metr.ou.edu ([129.15.192.80]:19983 "EHLO
	rossby.metr.ou.edu") by vger.kernel.org with ESMTP id S932458AbVHNFTK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 01:19:10 -0400
Received: from rossby.metr.ou.edu (localhost.metr.ou.edu [127.0.0.1])
	by rossby.metr.ou.edu (8.12.9p2/8.12.9) with ESMTP id j7E5Gu5L037259;
	Sun, 14 Aug 2005 00:16:56 -0500 (CDT)
	(envelope-from apw@rossby.metr.ou.edu)
Received: (from apw@localhost)
	by rossby.metr.ou.edu (8.12.9p2/8.12.9/Submit) id j7E5GsxK037258;
	Sun, 14 Aug 2005 00:16:54 -0500 (CDT)
	(envelope-from apw)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-yoursite-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Makes git work with a pure POSIX shell (tested with bash --posix and ash).
Right now git causes ash to choke on the redundant shift on line two.

Reduces the number of system calls git makes just to do a usage
statement from 22610 to 1122, and the runtime for same from 349ms to
29ms on my x86 Linux box. 

Presents a standard usage statement, and pretty prints the available
commands in a form that does not scroll off small terminals.

Signed-off-by: Amos Waterland <apw@rossby.metr.ou.edu>

---

 git |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/git b/git
--- a/git
+++ b/git
@@ -1,19 +1,18 @@
 #!/bin/sh
+
 cmd="$1"
-shift
-if which git-$cmd-script >& /dev/null
-then
-	exec git-$cmd-script "$@"
-fi
+path=$(dirname $0)
 
-if which git-$cmd >& /dev/null
-then
-	exec git-$cmd "$@"
-fi
+test -x $path/git-$cmd-script && exec $path/git-$cmd-script "$@"
+test -x $path/git-$cmd && exec $path/git-$cmd "$@"
 
-alternatives=($(echo $PATH | tr ':' '\n' | while read i; do ls $i/git-*-script 2> /dev/null; done))
+echo "Usage: git COMMAND [OPTIONS] [TARGET]"
+if [ -n "$cmd" ]; then
+    echo " git command '$cmd' not found: commands are:"
+else
+    echo " git commands are:"
+fi
 
-echo Git command "'$cmd'" not found. Try one of
-for i in "${alternatives[@]}"; do
-	echo $i | sed 's:^.*/git-:   :' | sed 's:-script$::'
-done | sort | uniq
+alternatives=$(cd $path &&
+               ls git-*-script | sed -e 's/git-//' -e 's/-script//')
+echo $alternatives | fmt | sed 's/^/  /'
