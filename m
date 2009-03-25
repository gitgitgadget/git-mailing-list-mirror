From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/5] Draft of API for git-vcs-*, transport.c code to use
 it.
Date: Wed, 25 Mar 2009 15:28:23 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903251446180.19665@iabervon.org>
References: <alpine.LNX.1.00.0903242303410.19665@iabervon.org> <7vskl284bt.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0903251050430.19665@iabervon.org> <7vbprp5vko.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:30:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmYnc-0006Bm-AT
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 20:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbZCYT21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 15:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754122AbZCYT21
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 15:28:27 -0400
Received: from iabervon.org ([66.92.72.58]:34249 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbZCYT20 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 15:28:26 -0400
Received: (qmail 8506 invoked by uid 1000); 25 Mar 2009 19:28:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 19:28:23 -0000
In-Reply-To: <7vbprp5vko.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114651>

On Wed, 25 Mar 2009, Junio C Hamano wrote:

> Suppose a project used to use subversion, but it migrated to git (not an
> unheard-of scenario these days, I hope).  The git repository now is the
> authoritative one, all the development happens on this side.
> 
> But in order to help:
> 
>  - people who have established their workflow to follow the project
>    (e.g. not necessarily contributing anything back, but just doing
>    regular "svn update");
> 
>  - people who have leftover local changes from the subversion days; and
> 
>  - other project infrastracture (e.g. trac) that the project hasn't
>    managed to interface to the new git repository yet;
> 
> the project decides to keep feeding recent updates to the subversion
> repository that used to be authoritative, even though it is now declared
> read-only (i.e. the only update comes from the git end).

Actually, this is easy: just configure the git repo to not fetch anything 
from the no-longer-authoritative subversion repository. git-vcs-svn would 
waste a bunch of time reimporting what it exported, but it wouldn't 
actually do anything with it (since it doesn't even have tracking refs to 
update). It could, of course, be optimized to avoid reimporting if it 
doesn't need to.

> My understanding is that the above scenario would not work if git-vcs-svn
> rewrites commits when git exports to svn, and existing git-svn two-way
> interface using its "dcommit" may have exactly the same issue.
> 
> The reason I brought this up was to involve people who have already faced
> this issue with git-svn in the discussion to see if we can avoid it by
> doing somethink similar to clever tricks they are using in their git-svn
> workflow, if there are some.  Perhaps your paragraph below may be one of
> those clever tricks, but there may be others.

The harder problem is that you can only push history that the remote 
system will be able to represent. In the same way that git wants your push 
to be a fast-forward, svn wants your push to not contain any merges (and 
p4 and svn both want your push to not contain parallel development 
pushed to a single branch). Rewriting the history to conform to the 
destination's requirements is most of what dcommit does, I believe.

I think that, in this use case, the right thing is to have a config option 
for git-vcs-svn to tell it to collapse the problematic commits (or maybe 
collapse all commits in a push). That would make the svn history export 
like the reflog, which is all linear and simple anyway, and probably 
sufficient for the above users of the old repository.

	-Daniel
*This .sig left intentionally blank*
