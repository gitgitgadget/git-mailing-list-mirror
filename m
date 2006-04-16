From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] gitk: breaks with both version and file limits
Date: Sun, 16 Apr 2006 14:51:55 -0700
Message-ID: <7vslodp4sk.fsf@assigned-by-dhcp.cox.net>
References: <20060416115403.GS12638@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Apr 16 23:52:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVFA5-0002su-N7
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 23:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWDPVv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 17:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDPVv7
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 17:51:59 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62874 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750848AbWDPVv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Apr 2006 17:51:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060416215158.NQAQ24255.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Apr 2006 17:51:58 -0400
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060416115403.GS12638@nowhere.earth> (Yann Dirson's message of
	"Sun, 16 Apr 2006 13:54:03 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18806>

Yann Dirson <ydirson@altern.org> writes:

> As an example, on a current git tree, the following command triggers
> an 'Error: expected boolean value but got ""' dialog when scrolling to
> the bottom of the graph, and leaves the bottom of the graph not drawn.
> This happens with current master, but not with 1.2.4.

A workaround errorproofing would be to do something like this
(note that I do not really speak Tcl).

The real issue is "git-rev-list --boundary ran..ge -- path" does
not show boundary.  I am not sure if it even worked in the past;
will take a look.

-- >8 --
gitk: [lindex $list $no_such_idx] returns "" which is not a valid bool

When asking for commit that is not listed for some reason in
commitlisted, gitk barfed because return value from lindex was
"" which was not a bool acceptable in ($bool ? A : B) construct.

We are expecting "1" here for listed commits (this comes from
getcommitlines), so explicitly check for it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/gitk b/gitk
index f88c06e..5d2b0cc 100755
--- a/gitk
+++ b/gitk
@@ -1460,7 +1460,7 @@ proc drawcmittext {id row col rmx} {
     global linehtag linentag linedtag
     global mainfont namefont canvxmax
 
-    set ofill [expr {[lindex $commitlisted $row]? "blue": "white"}]
+    set ofill [expr {("1" == [lindex $commitlisted $row]) ? "blue" : "white"}]
     set x [xc $row $col]
     set y [yc $row]
     set orad [expr {$linespc / 3}]
