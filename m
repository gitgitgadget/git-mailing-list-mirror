From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RESEND] [PATCH] Fix tree mode of the file list for files
	containing curly brackets
Date: Sun, 27 Apr 2008 21:53:53 +1000
Message-ID: <18452.26961.14738.430774@cargo.ozlabs.ibm.com>
References: <20080314214904.GA5914@steel.home>
	<20080427105700.GA28896@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 13:55:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq5TG-00048e-Pa
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 13:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762526AbYD0LyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 07:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762657AbYD0LyQ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 07:54:16 -0400
Received: from ozlabs.org ([203.10.76.45]:35178 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762421AbYD0LyO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 07:54:14 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7DF87DDE24; Sun, 27 Apr 2008 21:54:07 +1000 (EST)
In-Reply-To: <20080427105700.GA28896@steel.home>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80445>

Alex Riesen writes:

> As far as I could understand the online documentation the [lindex ...]
> thing expects an array, which a string produced by git-ls-tree is not.
> So [split ...] it first, to get a real Tcl string-array.

Unfortunately that will do the wrong thing if the filename contains a
tab character.  I think the right thing is to split the line textually
at the tab, then treat the first part as a list (which will be OK
since it consists of words without special characters, separated by
spaces), and the second part as the filename.  That is what I was
trying to do anyway, but I forgot to strip off the part after the tab,
which is why lindex got unhappy with it.  Here's the patch I'm about
to commit.

Paul.

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9a4d9c4..da685aa 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4992,11 +4992,12 @@ proc gettreeline {gtf id} {
 	if {$diffids eq $nullid} {
 	    set fname $line
 	} else {
-	    if {$diffids ne $nullid2 && [lindex $line 1] ne "blob"} continue
 	    set i [string first "\t" $line]
 	    if {$i < 0} continue
-	    set sha1 [lindex $line 2]
 	    set fname [string range $line [expr {$i+1}] end]
+	    set line [string range $line 0 [expr {$i-1}]]
+	    if {$diffids ne $nullid2 && [lindex $line 1] ne "blob"} continue
+	    set sha1 [lindex $line 2]
 	    if {[string index $fname 0] eq "\""} {
 		set fname [lindex $fname 0]
 	    }
