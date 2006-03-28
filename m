From: Paul Mackerras <paulus@samba.org>
Subject: Re: Gitk strangeness..
Date: Wed, 29 Mar 2006 09:51:34 +1100
Message-ID: <17449.48630.370867.10251@cargo.ozlabs.ibm.com>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
	<17448.40941.256361.866229@cargo.ozlabs.ibm.com>
	<7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
	<17448.48143.764989.649462@cargo.ozlabs.ibm.com>
	<7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net>
	<17448.54558.865097.519248@cargo.ozlabs.ibm.com>
	<7vzmjbj9a1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 29 00:52:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FON2p-0008BI-9j
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 00:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWC1Wvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 17:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWC1Wvs
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 17:51:48 -0500
Received: from ozlabs.org ([203.10.76.45]:45804 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964777AbWC1Wvl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 17:51:41 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id CA8C967A3B; Wed, 29 Mar 2006 09:51:40 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmjbj9a1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18136>

Junio C Hamano writes:

> How about this alternative patch, then?  It turned out to be
> quite convoluted as I feared.

That's brilliant.  Thank you!  With the patch to gitk below, the
graph display on Linus' example looks much saner.

Could you check in your patch to the git.git repository, please?

Thanks,
Paul.

diff --git a/gitk b/gitk
index 03cd475..1989aa5 100755
--- a/gitk
+++ b/gitk
@@ -46,7 +46,7 @@ proc start_rev_list {rlargs} {
     }
     if {[catch {
 	set commfd [open [concat | git-rev-list --header $order \
-			      --parents $rlargs] r]
+			      --parents --boundary $rlargs] r]
     } err]} {
 	puts stderr "Error executing git-rev-list: $err"
 	exit 1
@@ -114,8 +114,13 @@ proc getcommitlines {commfd}  {
 	set start [expr {$i + 1}]
 	set j [string first "\n" $cmit]
 	set ok 0
+	set listed 1
 	if {$j >= 0} {
 	    set ids [string range $cmit 0 [expr {$j - 1}]]
+	    if {[string range $ids 0 0] == "-"} {
+		set listed 0
+		set ids [string range $ids 1 end]
+	    }
 	    set ok 1
 	    foreach id $ids {
 		if {[string length $id] != 40} {
@@ -133,8 +138,12 @@ proc getcommitlines {commfd}  {
 	    exit 1
 	}
 	set id [lindex $ids 0]
-	set olds [lrange $ids 1 end]
-	set commitlisted($id) 1
+	if {$listed} {
+	    set olds [lrange $ids 1 end]
+	    set commitlisted($id) 1
+	} else {
+	    set olds {}
+	}
 	updatechildren $id $olds
 	set commitdata($id) [string range $cmit [expr {$j + 1}] end]
 	set commitrow($id) $commitidx
