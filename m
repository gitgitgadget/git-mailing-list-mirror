From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 18:58:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609261849430.3952@g5.osdl.org>
References: <20060927002745.15344.qmail@web51005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 03:59:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSOhQ-0004lp-Ul
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 03:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWI0B66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 21:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWI0B66
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 21:58:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932253AbWI0B65 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 21:58:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8R1wonW032697
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Sep 2006 18:58:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8R1wmlM010719;
	Tue, 26 Sep 2006 18:58:49 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060927002745.15344.qmail@web51005.mail.yahoo.com>
X-Spam-Status: No, hits=-0.474 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27849>



On Tue, 26 Sep 2006, Matthew L Foster wrote:
> 
> It's true I don't know much about git, what is the difference between a 
> changeset and a snapshot?

Some of it is just semantic, but a lot of it has real user-visible meaning 
simply because of the "mental model" difference, so the semantics actually 
have some meaning.

A lot of systems think of commits as "what changed", and thus the 
"changeset" mentality. A "commit" is just the combination of all changes 
that that commit introduced.

Git very fundamentally does not think like that at all.

Git thinks of a commit as a _state_, and the history that led up to that 
state. So instead of the commit actually containing pointers to what 
changed, it very much contains a pointer directly to the actual state that 
was committed (a "tree" in git parlance), and then a set of pointers to 
the "parent" commits - the commits that explain where we came from.

Now, in some sense, you can ignore the difference between the two models, 
since you'd think that they are totally equivalent: from the git model, 
you can always get the "changeset" by just diffing the current state with 
the previous state, and conversely from the "changeset" model you can 
always get the "current state" by just applying the changeset to the 
previous state.

So in that sense, it's just two different ways of looking at exactly the 
same thing.

HOWEVER. The fact that git internally thinks in terms of "snapshots" means 
that it makes no sense to (for example) record a "file rename". Git 
figures it out on its own, by just looking at the state before and after. 
The great thing about that is that the exact same logic actually works 
even for _unconnected_ states/snapshots, in a way that a "changeset" based 
situation would find very hard.

So this is when the otherwise semantic difference actually shows itself. 
You can diff between two arbitrary points in time, and git will figure out 
renames on its own, without actually ever looking at the changesets in 
between (in fact, there may not even _be_ a straight, unbroken chain of 
changesets between the two states).

> Are you saying timestamps should be tracked separately or tracked by an 
> scm system built on top of git? Does/should git care about the when of a 
> snapshot?

Git does record the timestamp, but it records it in the same way it 
records the "username" - in that it doesn't really _matter_ to git. It 
never actually affects any meaning (well, since you can query for it, it 
has a meaning of sorts, but it's strictly limited to any explicit queries, 
so if you do "git log --since=2.weeks.ago" it will use the timestamp to 
give you what you want, but it doesn't actually affect anything 
important).

So think of the timestamps as just comments with a very specific format.

		Linus
