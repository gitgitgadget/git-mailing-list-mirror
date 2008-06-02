From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 2 Jun 2008 17:14:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806021659480.13507@racer.site.net>
References: <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806021545340.13507@racer.site.net> <20080602154320.GK12896@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 18:17:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Ci2-00009Y-9m
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 18:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbYFBQPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 12:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbYFBQPg
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 12:15:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:39474 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752552AbYFBQPf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 12:15:35 -0400
Received: (qmail invoked by alias); 02 Jun 2008 16:15:33 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 02 Jun 2008 18:15:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GxI0liJTGQNDE5NWsp6WcDQpCVvw6Qmm4ChZACA
	bVCut7lOFo+H9U
X-X-Sender: gene099@racer.site.net
In-Reply-To: <20080602154320.GK12896@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83540>

Hi,

On Mon, 2 Jun 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > _However_, I still try to come up with some attic for deleted refs.  
> > It is not just a matter of moving the logs to a different namespace 
> > because of D/F conflicts.
> 
> Record the delete at the end of the reflog so we have a date/time record 
> and the last SHA-1 value, just in case it doesn't match up with the most 
> recent reflog entry (e.g. user ran some legacy tool that just redirect 
> git-commit-tree output to the branch itself).

That's obvious.

> Take the SHA-1 hash of the reflog now that the final entry is written.  
> Rename the file to .git/attic/$sha1 and call it a day. I thought about 
> compressing the file too, but its not worth saving the disk space here 
> and it would make tools that inspect the attic expensive to run.
> 
> The attic can be easily cleaned out by looking at the timestamp of the 
> last record of each file.  Attic log files older than X days can be 
> removed.  This is better than reading the modification time of the file 
> as we don't have to worry about some copy tool not saving the 
> modification time if the user moves/copies the repository.

I actually would prefer to have the logs in the .git/logs/ directory, so 
that I can easily reuse all existing reflog handling.

After sending the mail, I actually got an idea:

	.git/logs/attic/<timestamp>/<refname>

I think this should work without problems.  In that case, git-gc also 
handles the garbage collection.

> The hard stuff is:
> 
> - Should the commits listed in attic reflogs be considered reachable 
>   when we pack, prune or fsck?  Commits in a reflog are, even if they 
>   aren't reachable from a transport perspective.

Yes, they should.  That is the whole purpose of keeping the reflogs: I 
want to be able to resurrect the branch, if I deleted it by accident.

> - What command gets the extra options to see what branches are in the 
>   attic and when they got there?

I'd like to have them listed with the other reflogs.

> - What command gets the extra option to recover a branch from the attic?

None.  It is the user's responsibility to use the information wisely.

git branch resurrected attic/<bla>/refs/heads/accidentally-deleted@{1}

> - When we recover a branch from the attic is it sufficient to recover it 
>   to the name it had at time of deletion?  Should we allow you to 
>   recover it to a different name?

See above.  I think resurrecting under the same name would not necessarily 
be the most frequent operation on deleted refs.

> - Is it sufficient to make you recover the branch from the attic before 
>   you can access the rest of its reflog with porcelain?
> 
> - What do we do if we recover a branch with stale reflog entries
>   and the attic is deemed to not be reachable (see above).

I'll just go with my idea, implement it, and post it here for discussion.

Ciao,
Dscho
