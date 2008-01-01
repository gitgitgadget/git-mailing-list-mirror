From: Jeff King <peff@peff.net>
Subject: Re: observing changes to a git repository
Date: Tue, 1 Jan 2008 01:54:03 -0500
Message-ID: <20080101065403.GA21912@coredump.intra.peff.net>
References: <20071231222820.GA11278@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Swetland <swetland@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 07:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9b5F-0006fp-Fk
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 07:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbYAAGyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 01:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbYAAGyJ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 01:54:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1526 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbYAAGyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 01:54:08 -0500
Received: (qmail 5265 invoked by uid 111); 1 Jan 2008 06:54:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 01 Jan 2008 01:54:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jan 2008 01:54:03 -0500
Content-Disposition: inline
In-Reply-To: <20071231222820.GA11278@bulgaria.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69430>

On Mon, Dec 31, 2007 at 02:28:20PM -0800, Brian Swetland wrote:

> - periodically:
>   - grab the current head (call this Current)
>   - if it's the same as Last stop
>   - do a git log Current ^Last to observe what has happened since
>     we last noticed a change.  report on these commits.
>   - Last = Current

Overall this makes sense. But in the case of history going backwards,
you might want to show a log of "Current...Last". IOW, imagine this
history:

  B-C
 /
A-D-E

Last is set to 'C' from some iteration of your script. In one period,
somebody does a git-reset back to A, then makes commits D and E. So you
want to see not just B and C, but some representation that D and E are
no longer of interest.  "gitk Last...Current" will show you a nice graph
with a fork. git-log's --left-right option can represent the same
information textually. What you want depends, I think, on the goal of
your script.

> If these branches can be updated such that history is rewritten (not
> a concern in my particular case), I assume that for correctness you'd
> have to make Last and Current actual branches (perhaps under
> refs/heads/observer/... or whatever) to ensure that they don't get gc'd
> out from under you.

Yes, although realistically the reflog will keep it intact (unless you
have a bare repo without reflog).

> If I'm tracking several branches which can be merged between, I might
> want to keep track of which commits I've sent reports about if I don't
> want to re-report commits when they're merged into another branch.

What you have should work in the face of merges. Here's a history with
some merges:

  B-C     H-I <-- branch1
 /   \   /   \
A-D-E-F-G-J-K-L <-- master

where 'F' and 'L' are our merges. Because ^H implies ^G, but not ^J, if
we have something like Current=L, Last=H, you will see I, J, K, L.

So you will see each commit only once, unless you are running this
script per-branch, in which case you will see it once per branch. :) In
that case, you can do something like "git log Current ^LastBranch1
^LastBranch2 ...". IOW, Last* indicates "I've seen this and don't care
about it anymore".

-Peff
