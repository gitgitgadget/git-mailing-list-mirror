From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Managing several threads of the same project in GIT
Date: Fri, 26 Dec 2008 12:35:32 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngl9jsj.mos.sitaramc@sitaramc.homelinux.net>
References: <loom.20081226T110416-269@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 13:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGBwD-0005iB-V3
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 13:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbYLZMfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 07:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbYLZMfo
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 07:35:44 -0500
Received: from main.gmane.org ([80.91.229.2]:53332 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbYLZMfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 07:35:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LGBuk-0006tn-JL
	for git@vger.kernel.org; Fri, 26 Dec 2008 12:35:38 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 12:35:38 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 12:35:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103938>

On 2008-12-26, pggrd <git@paggard.com> wrote:

> most of the code in the project is shared between the threads
> in certain files there are different code parts to meet client requirements 
> but even those files share the rest of the code

How different are the chunks of code per client?  A few
minor differences, or large chunks of code?

> What I need to be able to do is:
> - to get code for any thread I like at any time
> - to be able to develop each thread separately
> - to be able to merge certain changes from one thread to another, at the same
> time without loosing the changes specific to the thread,
> and keep track of merge history

> With GIT strategy to treat content as a single unity - if
> you will try to merge branches - everything will be merged
> thus overwriting the changes that need to stay. But in the
> example above, if I make a change in the shared code in
> one thread, I need to be able to populate this change to
> all the threads, but this change only.

Seems largely the same as maintaining an older release and
backporting changes from the main trunk to it (or sometimes
the other direction), while keeping them distinct.  Which
happens all the time...

However, a maint release eventually atrophies -- changes
stop coming in, and eventually your last customer using it
has upgraded and the branch becomes unused.

You can't do that with your "client branch", so eventually
this will start diverging further and further from the
trunk.

The way to mitigate that is to have your main trunk contain
only the stuff that is common to *all* your clients, and let
each client branch maintain differences from this.  So in
effect, those "topic branches" are never getting merged back
to the mainline.  When you make changes that should go to
every client, you make them on the master and merge them
into the "topic branch" (your client branch).  When you want
a commit from client A to be used for client B, you
cherry-pick (cherry-pick from within gitk is pretty neat for
occasional, manual, cherry picks).

The only caveat I see is that once in a while you'll want to
just rebase each client branch against the master just for
sanity.  This should be done on one repository, and be a
coordinated thing so that all the developers who're working
on that particular client branch can re-fetch.  You might
end up doing this once in a few months so it's not bad I
guess.

Sitaram

PS: I think all this will work, but others with more
experience need to weigh in... it's always a bad idea to ask
questions during the holidays, you never know who's manning
the support lines ;-)

PPS: As Santi said in the other reply, you should also
consider making these changes part of a single code base,
with some sort of configuration deciding what actually gets
done.  Would be cleaner in the long run I guess...
