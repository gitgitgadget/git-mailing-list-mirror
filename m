From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 10:29:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <453A7D7E.8060105@utoronto.ca>
 <20061022074513.GF29927@artax.karlin.mff.cuni.cz> <200610221105.26421.jnareb@gmail.com>
 <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
 <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>,
	=?ISO-8859-1?Q?Erik_B=E5gfors?= <zindar@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 23 19:30:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc3cp-0004lS-OH
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 19:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWJWRaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 13:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWJWRaH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 13:30:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8686 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932201AbWJWRaF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 13:30:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NHTtaX025386
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 10:29:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NHTrrm031308;
	Mon, 23 Oct 2006 10:29:54 -0700
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061022185350.GW75501@over-yonder.net>
X-Spam-Status: No, hits=-0.477 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29849>



On Sun, 22 Oct 2006, Matthew D. Fuller wrote:
> 
> > This special treatment influences or directly causes many of the
> > things in bzr that we've been discussing:
>   [...]
> > I've been arguing that all of these impacts are dubious. But I can
> > understand that a bzr user hearing arguments against them might fear
> > that they would lose the ability to be able to see a view of commits
> > that "belong" to a particular branch.
> 
> Dead center.

The thing that the bzr people don't seem to realize is that their choice 
of revision naming has serious side effects, some of them really 
technical, and limiting.

I already briought this up once, and I suspect that the bzr people simply 
DID NOT UNDERSTAND the question:

 - how do you do the git equivalent of "gitk --all"

which is just another reason why "branch-local" revision naming is simply 
stupid and has real _technical_ problems.

I really suspect that a lot of people can't see further than their own 
feet, and don't understand the subtle indirect problems that branch-local 
naming causes. 

For example, how long does it take to do an arbitrary "undo" (ie forcing a 
branch to an earlier state) in a project with tens of thousands of 
commits? That's actually a really important operation, and yes, 
performance does matter. It's something that you do a lot when you do 
things like "bisect" (which I used to approximate with BK by hand, and 
yes, re-weaving the branch history was apparently a big part of why it 
took _minutes_ to do sometimes).

Again, this is something that people don't expect to have _anything_ to do 
with revision numbering, but the fact is, it's a big part of the picture. 
If you have branch-local revision numbering, you need to renumber all 
revisions on events like this, and even if it is "just" re-creatigng the 
revno->"real ID" cache, it's actually an expensive operation exactly 
because it's going to be at least linear in history.

One of the git design requirements was that no operation should _ever_ 
need to be linear in history size, because it becomes a serious limiter of 
scalability at some point. We were seeing some of those issues with BK, 
which is why I cared.

So in git, doing things like jumping back and forth in history is O(1). 
Always (with a really low constant cost too). Of course, checking out the 
end result is then roughly O(n), but even there "n" is the size of the 
_changes_, not number of revisions or number of files.

(And there are obviously operations that _are_ O(revision history), the 
most trivial one being anything that visualizes all of history - but they 
depend on the size of history not because the operation itself gets more 
expensive, but because the dataset increases).

The whole confusing between "bzr pull" and "bzr merge" is another 
_technical_ sign of why branch-local revision numbers are a mistake. 

			Linus
