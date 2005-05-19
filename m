From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk-1.0 released
Date: Fri, 20 May 2005 08:32:21 +1000
Message-ID: <17037.5109.556362.904185@cargo.ozlabs.ibm.com>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
	<20050519132411.GA29111@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 00:33:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYtYv-00072D-FJ
	for gcvg-git@gmane.org; Fri, 20 May 2005 00:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVESWcr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 18:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVESWcr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 18:32:47 -0400
Received: from ozlabs.org ([203.10.76.45]:53917 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261283AbVESWcU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 18:32:20 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 389A4679FE; Fri, 20 May 2005 08:32:16 +1000 (EST)
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050519132411.GA29111@elte.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar writes:

> very nice! Works well and it's pretty fast on a 2GHz P4.

I'm glad you like it. :)

> The "Octopus merge ..." text is incorrectly overlayed with a graph line.

The patch below fixes that.

> - i guess this one is on your todo list: the history graph of a single
>   object (file).

Yes.  I was hoping that git-rev-tree would grow an option to do the
necessary selection of commits and produce a simplified graph.  I
could do it in Tcl but it's probably better done in C.

> - first window appearance on an uncached repository can be pretty slow 
>   due to disk seeks - so it might make sense to display something (an 
>   hourglass?) sooner - when i first started it i thought it hung. On 
>   already cached repositories the window comes up immediately, and the 
>   list of commits is updated dynamically.

The problem is that git-rev-tree HEAD doesn't output anything until it
has read all the relevant commits, which can involve a lot of disk
seeks.  I put the "Reading commits..." message in to indicate that
something was happening, but your hourglass cursor suggestion is a
good one.  It looks like git-rev-list might be better suited to what I
want, actually.

> (and the biggest missing feature of GIT right now is author + 
> last-commit annotated file viewing which could be integrated into gitk 
> a'ka BK's revtool: selecting a given line of the file would bring one to 
> that commit, etc.)

Yes, indeed.  I'll have to think about how to do it in a responsive
fashion, since getting the necessary information involves reading all
the commits and all the tree objects back to the beginning of time,
AFAICS.  Gitk currently only reads the tree objects when you select a
commit, and it does that asynchronously; when you select a commit, it
immediately displays the commit message and starts a git-diff-tree
process.  When the output from git-diff-tree arrives, it updates the
listbox and then (if you haven't selected another commit in the
meantime) starts a git-diff-tree -p to get the diff.  As the output
from git-diff-tree arrives, it is colorized and placed in the details
window.  That's why you can let the up or down key autorepeat and gitk
doesn't get hopelessly behind.

Another thing I want to do is find a way to display the deleted lines
in the annotated file listing.  One thing I found quite frustrating
with bk revtool was trying to find which changeset deleted some
particular lines of code.  I was basically reduced to binary searching
through the changesets - and with a large source file, just finding
the place to check in the annotated listing for each changeset was
time-consuming and error-prone in itself.

Paul.

diff -urN gitk-1.0/gitk gitk
--- gitk-1.0/gitk	2005-05-20 08:17:18.000000000 +1000
+++ gitk	2005-05-20 08:09:38.000000000 +1000
@@ -563,6 +563,9 @@
 		   -fill $ofill -outline black -width 1]
 	$canv raise $t
 	set xt [expr $canvx0 + $nlines * $linespc]
+	if {$nparents($id) > 2} {
+	    set xt [expr {$xt + ($nparents($id) - 2) * $linespc}]
+	}
 	set headline [lindex $commitinfo($id) 0]
 	set name [lindex $commitinfo($id) 1]
 	set date [lindex $commitinfo($id) 2]
