From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/8] gitk: fix file highlight when run in subdirectory
Date: Sun, 10 Apr 2011 11:54:10 +1000
Message-ID: <20110410015410.GA25368@brick.ozlabs.ibm.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1301969659-19703-2-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 04:03:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8k0E-0000M9-MI
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 04:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab1DJCDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 22:03:46 -0400
Received: from ozlabs.org ([203.10.76.45]:36523 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab1DJCDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 22:03:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id C00D21007D5; Sun, 10 Apr 2011 12:03:25 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1301969659-19703-2-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171233>

On Mon, Apr 04, 2011 at 10:14:12PM -0400, Martin von Zweigbergk wrote:

> The "highlight this only" and "highlight this too" commands in gitk
> add the path relative to $GIT_WORK_TREE to the "Find" input box. When
> the search (using git-diff-tree) is run, the paths are used
> unmodified, except for some shell escaping. Since the search is run
> from gitk's working directory, no commits matching the paths will be
> found if gitk was started in a subdirectory.
> 
> Make the paths passed to git-diff-tree relative to gitk's working
> directory instead of being relative to $GIT_WORK_TREE. If, however,
> gitk is run outside of the working directory (e.g. with $GIT_WORK_TREE
> set), we still need to use the path relative to $GIT_WORK_TREE.
> 
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> ---
> 
> This could also have been fixed by cd-ing to the work tree
> directory. That would also make the "Local changes checked in to index
> but not committed" and "Local uncommitted changes, not checked in to
> index" show up properly when running with GIT_WORK_TREE defined.
> 
> I wasn't sure if other parts of gitk depend on the working directory,
> or if there are plans to make something depend on it, so I thought
> changing it only for the specific case of file highlighting would be
> safer. What do you think?

I have to admit I wasn't aware of GIT_WORK_TREE before I saw your
patches.  The patches look OK, but I wonder how many of the problems
would go away if gitk were simply to set GIT_WORK_TREE in the
environment for the programs it runs, if it is not already set.
Something like this (untested):

 # check that we can find a .git directory somewhere...
 if {[catch {set gitdir [gitdir]}]} {
     show_error {} . [mc "Cannot find a git repository here."]
     exit 1
 }
 if {![file isdirectory $gitdir]} {
     show_error {} . [mc "Cannot find the git directory \"%s\"." $gitdir]
     exit 1
 }
+if {![info exists env(GIT_WORK_TREE)]} {
+    set worktree [file dirname $gitdir]
+    if {$worktree ne "."} {
+	set env(GIT_WORK_TREE) $worktree
+    }
+}

Paul.
