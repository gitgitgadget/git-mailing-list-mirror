From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix tree mode of the file list for files containing curly
	brackets
Date: Fri, 14 Mar 2008 22:58:41 +0100
Message-ID: <20080314215841.GB5914@steel.home>
References: <20080314214904.GA5914@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:59:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaHw0-00036s-Ew
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 22:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbYCNV6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 17:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbYCNV6r
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 17:58:47 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:38241 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYCNV6q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 17:58:46 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolN9Q==
Received: from tigra.home (Faa12.f.strato-dslnet.de [195.4.170.18])
	by post.webmailer.de (klopstock mo53) (RZmta 16.10)
	with ESMTP id 201205k2EGPpVP ; Fri, 14 Mar 2008 22:58:44 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5E01B277BD;
	Sat, 15 Mar 2008 06:58:16 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 4FACD56D28; Fri, 14 Mar 2008 22:58:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080314214904.GA5914@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77291>

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

 gitk-git/gitk |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index f1f21e9..b3a57be 100644
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
+	    set la [split "$line" " "]
+	    if {$diffids ne $nullid2 && [lindex $la 1] ne "blob"} continue
+	    set sha1 [lindex $la 2]
+	    set fname [lindex [split "$line" "\t"] 1]
 	    lappend treeidlist($id) $sha1
 	}
 	lappend treefilelist($id) $fname
-- 
1.5.4.4.578.g182d
