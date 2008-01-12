From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk dev branch: F5 problem again
Date: Sat, 12 Jan 2008 21:55:08 +1100
Message-ID: <18312.40076.179788.88596@cargo.ozlabs.ibm.com>
References: <47876C69.8070604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 11:55:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDe1h-000175-QE
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 11:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760486AbYALKzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 05:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760587AbYALKzR
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 05:55:17 -0500
Received: from ozlabs.org ([203.10.76.45]:46544 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760473AbYALKzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 05:55:16 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id D2999DDE35; Sat, 12 Jan 2008 21:55:14 +1100 (EST)
In-Reply-To: <47876C69.8070604@viscovery.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70306>

Johannes Sixt writes:

> I'm using gitk's dev branch (476ca63d Index [fnvr]highlights by id...) on
> Windows.
> 
> Start gitk like this:
> 
>    gitk somefile.c
> 
> while on a branch whose tip touches somefile.c.
> 
> Now:
> 
>    git commit --amend
> 
> Then press F5 in gitk. I get these error reports after which gitk is
> unresponsive:
> 
> can't read "children(1,)": no such element in array

Thanks.

I found the reason for the Tcl errors - an incorrect optimization in
make_disporder - and I have pushed out a fix.

However, that shows up another problem, due to the way parent
rewriting does (or doesn't) work when we are limiting both by
revisions and by path.  When you press F5 in the above scenario, you
will get the new version of the commit, with its real parent shown as
an open-circle commit, disconnected from the rest of the graph.

What's happening here is that to do the update, gitk first re-reads
all the references, notices that the head has changed, and does a git
log command like:

	git log newhead ^oldhead -- somefile.c

The git log traversal stops as soon as it finds a commit which is an
ancestor of oldhead, which in this case will be oldhead's (and
newhead's) real parent.  Because the traversal doesn't go far enough
to find another commit that touches somefile.c (which would be the
fake parent that gitk would want to use for the graph), the parent
rewriting doesn't happen and git log outputs the newhead commit with
its real parent rather than a fake parent.  Assuming the real parent
doesn't touch somefile.c, it is a commit that gitk doesn't have in its
graph, so it can't join newhead into the existing graph properly.  I'm
not sure how best to fix that.  I'll have to think about it.

Paul.
