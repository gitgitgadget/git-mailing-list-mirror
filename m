From: Owen Taylor <otaylor@redhat.com>
Subject: Re: git push --confirm ?
Date: Sat, 12 Sep 2009 16:11:06 -0400
Message-ID: <1252786266.2974.61.camel@localhost.localdomain>
References: <1252777897.2974.24.camel@localhost.localdomain>
	 <20090912184342.GB20561@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 22:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmYwQ-0006Uk-MD
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 22:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbZILULS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 16:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbZILULR
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 16:11:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51115 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779AbZILULR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 16:11:17 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8CKBGMo012919;
	Sat, 12 Sep 2009 16:11:16 -0400
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8CKBF0e010866;
	Sat, 12 Sep 2009 16:11:15 -0400
In-Reply-To: <20090912184342.GB20561@coredump.intra.peff.net>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128293>

On Sat, 2009-09-12 at 14:43 -0400, Jeff King wrote:
> On Sat, Sep 12, 2009 at 01:51:37PM -0400, Owen Taylor wrote:
> 
> >  * An initial --dry-run pass is done but with more verbosity -
> >    for updates of existing references, it would show what commits
> >    were being added or removed in a one-line format.
> > 
> >  * The user is prompted if they want to proceed
> >  
> >  * If the user agrees, then the push is run without --dry-run
> >
> > [...]
> >
> > I think this wouldn't be too hard to add to 'git push', though
> > I haven't tried to code it. Yes, it's not atomic without protocol
> > changes - I think that's OK:
> 
> I have never wanted such a feature, so maybe I am a bad person to
> comment, but I don't see much advantage from a UI standpoint over what
> we have now. Which is "git push --dry-run", check to see if you like it,
> and then re-run without --dry-run. If you just want to see more output
> in the first --dry-run, then that is easy to do with an alternate
> format.

The main UI advantage is that you can adjust the default with 'git
config' it on and leave it on. The time you screw up is not when you are
worried that you are going to push the wrong thing. It's when you are
you know exactly what 'git push' is going to do and it does something
different.

Secondarily, I don't really find the output of 'git push --dry-run'
that great - it's pretty good for finding out what branches you are
going to push... that you correctly understood the syntax of git push
and the relationship to your branch configuration, but not so good at
seeing what's going to be pushed,

If it shows:

 72b3142..1fa3134 my-topic -> my-topic
 12a31aa..34f2621 master -> master

That doesn't necessarily warn you that along with the bug fix you think
you are pushing you have a big merge into master sitting there that you
haven't finished testing. For updates, showing a commit count and (a
probably limited number of) commit subjects would avoid having to
cut-and-paste the update summary into git log.

As you say, maybe that's something that just needs to be fixed
with a better format for --dry-run. But that doesn't negate the main UI
advantage.

> But what _would_ be useful is doing it atomically. You can certainly do
> all three of those steps from within one "git push" invocation, and I
> think that is enough without any protocol changes. The protocol already
> sends for each ref a line like:
> 
>   <old-sha1> <new-sha1> <ref>
> 
> and receive-pack will not proceed with the update unless the <old-sha1>
> matches what is about to be changed.

Hmm, yeah, I've certainly looked at git-receive-pack(1) before but
hadn't internalized that --force was client side. Certainly doing it
with a single atomic pass is the better way to do it.

(Wouldn't work for rsync and http pushes, right? A simple "Not
supported" perhaps.)

> >  - If the push isn't being forced intermediate ref updates will
> >    be caught as a non-fast-forward in the second pass.
> > 
> >  - If the push is being forced, you might overwrite someone else's
> >    push anyways even without --confirm.
> 
> Yeah, "--force" is not very fine-grained. I wonder if rather than a
> complete --confirm you would rather have something iterative like:
> 
>   $ git push --interactive
>   Pushing to server:/path/to/repo.git
>     * [new branch]      topic -> topic
>   Push this branch [Yn]?
>       5ad9dce..cfc497a  topic -> topic
>   Push this branch [Yn]?

Hmm, of two minds about this. Doing it as a pick-and-choose
--interactive does integrate it conceptually with other parts of Git.
And probably is occasionally useful.

But it makes it considerably less convenient to just config on.
Because any time you want to push more than 2-3 refs at once you'll have
to add --no-interactive.

It also increases the amount of reading - if I see all the branches at
once that are being pushed I can immediately notice that I'm pushing two
branches when I thought I was pushing one, without actually having to
read the branch names.

My conception of the feature is as a safety harness. That some people
will be willing to pay a keystroke or two for that double check that
their mental model matches reality.

      5ad9dce...cfc497a topic -> topic (non-fast forward) 
> Force this branch [yN]?

This one is a disaster waiting to happen. Even with the reversed
defaults you may well have the 'y<return>' habit going. Unless the
non-fast-forward looks completely different (Red and Blinky) you
probably are going to go right past it.

- Owen
