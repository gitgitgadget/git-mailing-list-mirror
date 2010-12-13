From: hvoigt <hvoigt@hvoigt.net>
Subject: [PATCH v3] gitk: add menuitem for file checkout from this or
 parent commit
Date: Mon, 13 Dec 2010 22:46:14 +0100
Message-ID: <20101213214613.GA2497@sandbox>
References: <20100928200344.GA12843@book.hvoigt.net>
 <20101211232324.GB3788@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 13 22:53:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSGKM-0001D6-I8
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 22:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611Ab0LMVw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 16:52:58 -0500
Received: from darksea.de ([83.133.111.250]:34744 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755831Ab0LMVw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 16:52:57 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2010 16:52:57 EST
Received: (qmail 17952 invoked from network); 13 Dec 2010 22:46:14 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Dec 2010 22:46:14 +0100
Content-Disposition: inline
In-Reply-To: <20101211232324.GB3788@brick.ozlabs.ibm.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163598>

This is useful if a user wants to checkout a file from a certain
commit. This is equivalent to

  git checkout $commit $file

and

  git checkout $commit^ $file

Checkout of the first parent is useful in situations where you want to
checkout a file before some modification. In the patch view only the
modified filenames are shown. It is much quicker to select the commit
which modified the file and then choose the file from the patch view
compared to select the parent commit and then browse through the whole
tree to choose the file.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Sun, Dec 12, 2010 at 10:23:24AM +1100, Paul Mackerras wrote:
> Thanks for the patch.  However, the commit message doesn't mention
> that the patch also adds the 'checkout from parent' menu item or why
> that's a useful thing to have.  I like the 'checkout from this commit'
> thing but I don't immediately see why checking out from the first
> parent is so useful that we have to have it as a menu item, but
> checking out from other parents of a merge isn't.

Here is a new version of the patch with some added explanation why this
is useful in day to day use. I choose the first parent because in my
usecase I checkout single files by typically using non-merge commits.
Do you think there are usecases for second or other parent commits on
merge commits?

Cheers Heiko

 gitk |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index e82c6bf..e0dd94d 100755
--- a/gitk
+++ b/gitk
@@ -2522,6 +2522,8 @@ proc makewindow {} {
 	{mc "Highlight this only" command {flist_hl 1}}
 	{mc "External diff" command {external_diff}}
 	{mc "Blame parent commit" command {external_blame 1}}
+	{mc "Checkout from this commit" command {external_checkout}}
+	{mc "Checkout from parent commit" command {external_checkout 1}}
     }
     $flist_menu configure -tearoff 0
 
@@ -3558,6 +3560,20 @@ proc make_relative {f} {
 }
 
 proc external_blame {parent_idx {line {}}} {
+
+    set cmdline [list git gui blame]
+    if {$line ne {} && $line > 1} {
+	lappend cmdline "--line=$line"
+    }
+    run_command_on_selected_file $cmdline $parent_idx
+}
+
+proc external_checkout {{parent_idx 0}} {
+    set cmdline [list git checkout]
+    run_command_on_selected_file $cmdline $parent_idx
+}
+
+proc run_command_on_selected_file {cmdline parent_idx} {
     global flist_menu_file gitdir
     global nullid nullid2
     global parentlist selectedline currentid
@@ -3573,17 +3589,13 @@ proc external_blame {parent_idx {line {}}} {
 	return
     }
 
-    set cmdline [list git gui blame]
-    if {$line ne {} && $line > 1} {
-	lappend cmdline "--line=$line"
-    }
     set f [file join [file dirname $gitdir] $flist_menu_file]
-    # Unfortunately it seems git gui blame doesn't like
+    # Unfortunately some commands do not like
     # being given an absolute path...
     set f [make_relative $f]
     lappend cmdline $base_commit $f
     if {[catch {eval exec $cmdline &} err]} {
-	error_popup "[mc "git gui blame: command failed:"] $err"
+	error_popup "[mc "$cmdline: command failed:"] $err"
     }
 }
 
-- 
1.7.2.3.msysgit.0.1.g5a65e
