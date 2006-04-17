From: Paul Mackerras <paulus@samba.org>
Subject: Re: [BUG] gitk: breaks with both version and file limits
Date: Mon, 17 Apr 2006 10:38:02 +1000
Message-ID: <17474.58218.187884.491028@cargo.ozlabs.ibm.com>
References: <20060416115403.GS12638@nowhere.earth>
	<7vslodp4sk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 02:38:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVHkr-00007w-9r
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 02:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWDQAiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 20:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWDQAiI
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 20:38:08 -0400
Received: from ozlabs.org ([203.10.76.45]:60288 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750869AbWDQAiI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 20:38:08 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 162D967B23; Mon, 17 Apr 2006 10:38:07 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslodp4sk.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18810>

Junio C Hamano writes:

> The real issue is "git-rev-list --boundary ran..ge -- path" does
> not show boundary.  I am not sure if it even worked in the past;
> will take a look.

Ah... and in addextraid I wasn't appending a 0 to commitlisted, so
commitlisted got out of sync with the displayorder list.  I just
committed this patch, which keeps them in sync.  I think that's
preferable to working around the missing elements.

Paul.

diff --git a/gitk b/gitk
index f88c06e..87e7162 100755
--- a/gitk
+++ b/gitk
@@ -1116,11 +1116,12 @@ proc layoutrows {row endrow last} {
 
 proc addextraid {id row} {
     global displayorder commitrow commitinfo
-    global commitidx
+    global commitidx commitlisted
     global parentlist childlist children
 
     incr commitidx
     lappend displayorder $id
+    lappend commitlisted 0
     lappend parentlist {}
     set commitrow($id) $row
     readcommit $id
@@ -1500,7 +1501,7 @@ proc drawcmittext {id row col rmx} {
 proc drawcmitrow {row} {
     global displayorder rowidlist
     global idrowranges idrangedrawn iddrawn
-    global commitinfo commitlisted parentlist numcommits
+    global commitinfo parentlist numcommits
 
     if {$row >= $numcommits} return
     foreach id [lindex $rowidlist $row] {
