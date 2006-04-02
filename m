From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] xdiff shows trivially redundant diff.
Date: Sun, 02 Apr 2006 01:15:42 -0800
Message-ID: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 02 11:16:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPyge-0006Xh-Ur
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 11:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWDBJPr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 05:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWDBJPr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 05:15:47 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52958 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932280AbWDBJPq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 05:15:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060402091543.KVRY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Apr 2006 05:15:43 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18261>

$ git diff-tree -p 52e8a6^2 52d8a6 -- git-fetch.sh

shows a change that trivially is redundant, like this:

    diff --git a/git-fetch.sh b/git-fetch.sh
    index b4325d9..de4f011 100755
    --- a/git-fetch.sh
    +++ b/git-fetch.sh
    @@ -320,7 +320,7 @@ fetch_main () {
         ( : subshell because we muck with IFS
           IFS="    $LF"
           (
    -         git-fetch-pack $exec $keep "$remo...
    +         git-fetch-pack $exec $keep --thin...
           ) |
           while read sha1 remote_name
           do
    @@ -367,21 +367,26 @@ fetch_main "$reflist"

     # automated tag following
     case "$no_tags$tags" in
    -'')
    -       taglist=$(IFS=" " &&
    -       git-ls-remote $upload_pack --tags "$remote" |
    ...
    -       done)
    +'')
    +       case "$reflist" in
    +       *:refs/*)
    ...

Notice the first '-' and '+' lines of second hunk are identical?

There is another interesting thing.  This is running diff
between 52e8a6^2 and 52d8a6 blobs, but if I change them slightly
so that the first hunk is not different, then this anomaly
disappears.
