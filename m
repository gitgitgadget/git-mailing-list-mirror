From: Alex Riesen <raa.lkml@gmail.com>
Subject: Fix tree mode of the file list for files containing curly brackets
Date: Fri, 14 Mar 2008 22:49:04 +0100
Message-ID: <20080314214904.GA5914@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaHmh-0008DL-Bu
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 22:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbYCNVtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 17:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbYCNVtL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 17:49:11 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:31650 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbYCNVtK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 17:49:10 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolN9Q==
Received: from tigra.home (Faa12.f.strato-dslnet.de [195.4.170.18])
	by post.webmailer.de (klopstock mo56) (RZmta 16.10)
	with ESMTP id 501206k2EKjhC7 ; Fri, 14 Mar 2008 22:49:08 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2A276277BD;
	Sat, 15 Mar 2008 06:48:40 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 0F07E56D28; Fri, 14 Mar 2008 22:49:04 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77290>

As far as I could understand the online documentation the [lindex ...]
thing expects an array, which a string produced by git-ls-tree is not.
So [split ...] it first, to get a real Tcl string-array.

For instance:

    $ git init
    $ date >file
    $ git add . && git commit -m1
    $ git mv file '{a-b}.a.b'
    $ git commit -m2
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

--

My workaround for the problem was the patch attached, but as I know
next to nothing of Tcl, I suspect it is at least incomplete (there
could be other places with the same problem).

diff --git a/gitk-git/gitk b/gitk-git/gitk
index f1f21e9..3368148 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4946,14 +4946,10 @@ proc gettreeline {gtf id} {
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
+	    set fname [lindex $la 3]
 	    lappend treeidlist($id) $sha1
 	}
 	lappend treefilelist($id) $fname
