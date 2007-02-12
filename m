From: Bill Lear <rael@zopyra.com>
Subject: Re: Question on git fetch to bare repo
Date: Mon, 12 Feb 2007 14:47:02 -0600
Message-ID: <17872.53830.887188.137662@lisa.zopyra.com>
References: <17867.41997.561756.679778@lisa.zopyra.com>
	<20070209023941.GE10574@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 21:46:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGi4G-0000WJ-OL
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 21:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbXBLUq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 15:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbXBLUq3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 15:46:29 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60944 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965336AbXBLUq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 15:46:28 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1CKl7r25965;
	Mon, 12 Feb 2007 14:47:07 -0600
In-Reply-To: <20070209023941.GE10574@coredump.intra.peff.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39436>

On Thursday, February 8, 2007 at 21:39:41 (-0500) Jeff King writes:
>...
>You're more on the right track here, but not quite. If you want to save
>things in branches, you either need to use a 'remotes' shorthand (which
>defines pull lines with refspecs) or you need to specify the refspec on
>the command line (like master:master). However, you _don't_ want to
>fetch directly into your master branch. fetch is for copying refs and
>objects, not for merging (and you've presumably made some commits on
>master that the upstream doesn't have).
>
>It seems like you're trying to merge in your "public" repository, which
>is a mistake. I think you would be much better served to think of your
>public repository as a place where you publish changes (_only_ from your
>private repository), and do all of your external fetching and merging in
>your private repository. Everyone has a public repo, so you always
>"pull" from other people's public repos, and "push" into your public
>repo. Thus you don't need --shared at all.

Ok, I've gotten some time to read through this.  Kinda sad that
something published 4 days ago seems like the distant past ...

The problem I have with doing all of my fetching and merging in my
private repo is this: I have an update hook in my public repo that I
use to communicate my changes to my peers.  The problem is when I pull
from a peer's repo into my private repo, make some of my changes, and
then publish (push) my changes to the public repo, HIS changes are
pushed as well, and the update script naturally picks up on these and
broadcasts them.  My peer group ends up getting the same update
message about his commits that they have already received.  Multiply
this among 6 peers and it becomes a real headache.

On the other hand, if I fetch his changes into my public (bare) repo
first, and then pull from there into my private, make changes in my
private and then commit and publish to my public, the update script
will send out my changes --- and only MY changes --- to my peers.

So, what I have (just now) tried to do (using the latest 1.5 code),
is clone my public repo to create my private repo:

% git clone /repos/git/project

and my .git/config file is now:

% cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = /repos/git/project
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

and no .git/remotes/origin exists.

I notice that this did not "clone" all the branches in my public repo:

% git branch
* master

whereas in my public repo:

% cd /repos/git/project
% git --bare branch
  topic
* master

So, regardless if I can correct that (very confused as to why the
clone did not grab the branch), it seems that I did not make my intent
clear...

I'm still not sure if I'm obeying the "don't develop on anything
on the RHS of ':' dictum".

I'm going to puzzle over the rest of your advice to see if I can
grok it and fold it into the new (1.5) way of life.


Bill
