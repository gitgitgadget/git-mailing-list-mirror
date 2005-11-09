From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Problems with binary patches (pull) and spaces in filenames (gitk)
Date: Wed, 9 Nov 2005 18:00:48 -0500
Message-ID: <20051109230048.GH31850@delft.aura.cs.cmu.edu>
References: <20051109213730.GA23052@ebar091.ebar.dtu.dk> <7vfyq5bhi2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:04:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZywH-0005hu-AB
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVKIXAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVKIXAy
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:00:54 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:23261 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1750913AbVKIXAx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 18:00:53 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1EZyvw-00073t-00; Wed, 09 Nov 2005 18:00:48 -0500
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vfyq5bhi2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11430>

On Wed, Nov 09, 2005 at 02:09:41PM -0800, Junio C Hamano wrote:
> Another minor gitk gripe I have is that it does not look at
> subdirectories of refs/{heads,tags}/ so I do not get labels to
> my topic branch heads.

I've been using the following gitk 'customization'. ISTR that it can be
cleaned up a bit further and do everything in a single scan of the refs/
subtree. I'll take another look at that tonight.

Jan

diff --git a/gitk b/gitk
index a9d37d9..cd0b84f 100755
--- a/gitk
+++ b/gitk
@@ -237,16 +237,27 @@ proc parsecommit {id contents listed old
 			     $comname $comdate $comment]
 }
 
+# recursively list all files in a directory
+proc listTree {root} {
+    set files [glob -nocomplain -directory $root -types f *]
+    set nodes [glob -nocomplain -directory $root -types d *]
+    foreach node $nodes {
+	set children [listTree $node]
+	set files [concat $files $children]
+    }
+    return $files
+}
+
 proc readrefs {} {
     global tagids idtags headids idheads tagcontents
 
-    set tags [glob -nocomplain -types f [gitdir]/refs/tags/*]
+    set tags [listTree [gitdir]/refs/tags]
     foreach f $tags {
 	catch {
 	    set fd [open $f r]
 	    set line [read $fd]
 	    if {[regexp {^[0-9a-f]{40}} $line id]} {
-		set direct [file tail $f]
+		regexp {[gitdir]/refs/tags/(.*)} $f match direct
 		set tagids($direct) $id
 		lappend idtags($id) $direct
 		set tagblob [exec git-cat-file tag $id]
@@ -271,13 +282,13 @@ proc readrefs {} {
 	    close $fd
 	}
     }
-    set heads [glob -nocomplain -types f [gitdir]/refs/heads/*]
+    set heads [listTree [gitdir]/refs/heads]
     foreach f $heads {
 	catch {
 	    set fd [open $f r]
 	    set line [read $fd 40]
 	    if {[regexp {^[0-9a-f]{40}} $line id]} {
-		set head [file tail $f]
+		regexp {[gitdir]/refs/heads/(.*)} $f match head
 		set headids($head) $line
 		lappend idheads($line) $head
 	    }
