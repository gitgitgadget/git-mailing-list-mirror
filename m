From: Alex Riesen <raa.lkml@gmail.com>
Subject: [RESEND] [PATCH] Fix tree mode of the file list for files
	containing curly brackets
Date: Sun, 27 Apr 2008 12:57:00 +0200
Message-ID: <20080427105700.GA28896@steel.home>
References: <20080314214904.GA5914@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 12:57:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq4Zu-0005yc-Pz
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 12:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbYD0K5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 06:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbYD0K5G
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 06:57:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:50204 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbYD0K5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 06:57:04 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarZw4lh2bA==
Received: from tigra.home (Faeb6.f.strato-dslnet.de [195.4.174.182])
	by post.webmailer.de (mrclete mo12) (RZmta 16.27)
	with ESMTP id N00407k3R8BYPE ; Sun, 27 Apr 2008 12:57:00 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id AAC97277BD;
	Sun, 27 Apr 2008 12:57:00 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 80B7B56D28; Sun, 27 Apr 2008 12:57:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080314214904.GA5914@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80439>

As far as I could understand the online documentation the [lindex ...]
thing expects an array, which a string produced by git-ls-tree is not.
So [split ...] it first, to get a real Tcl string-array.

For instance:

    $ git init
    $ date >file
    $ git add . && git commit -m1
    $ git mv file '{a-b}.a.b'
    $ git commit -m2
    $ git mv file '{a-b}.a.b{'
    $ git commit -m3
    $ git mv file '{a-b}.a .b{'
    $ git commit -m4
    $ gitk

Now switch the file list from "Patch" to "Tree":

    list element in braces followed by ".a.b" instead of space
    list element in braces followed by ".a.b" instead of space
	while executing
    "lindex $line 1"
	(procedure "gettreeline" line 9)
	invoked from within
    "gettreeline file11 4b155a05282eeccd7c8fd381b22ed442efde2850"
	("eval" body line 1)
	invoked from within
    "eval $script"
	(procedure "dorunq" line 9)
	invoked from within
    "dorunq"
	("after" script)

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Alex Riesen, Fri, Mar 14, 2008 22:49:04 +0100:
> +	    set la [split "$line" " \t"]
> +	    if {$diffids ne $nullid2 && [lindex $la 1] ne "blob"} continue
> +	    set sha1 [lindex $la 2]
> +	    set fname [lindex $la 3]

And, as I actually do know nothing about Tcl, it does not work for
files with spaces. The last lindex is obviuosly wrong, it breaks names
with whitespaces.

I rebased the patch on current master.

 gitk-git/gitk |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9a4d9c4..5599878 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4992,14 +4992,10 @@ proc gettreeline {gtf id} {
 	if {$diffids eq $nullid} {
 	    set fname $line
 	} else {
-	    if {$diffids ne $nullid2 && [lindex $line 1] ne "blob"} continue
-	    set i [string first "\t" $line]
-	    if {$i < 0} continue
-	    set sha1 [lindex $line 2]
-	    set fname [string range $line [expr {$i+1}] end]
-	    if {[string index $fname 0] eq "\""} {
-		set fname [lindex $fname 0]
-	    }
+	    set la [split "$line" " \t"]
+	    if {$diffids ne $nullid2 && [lindex $la 1] ne "blob"} continue
+	    set sha1 [lindex $la 2]
+	    set fname [lindex [split "$line" "\t"] 1]
 	    lappend treeidlist($id) $sha1
 	}
 	lappend treefilelist($id) $fname
