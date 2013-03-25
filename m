From: Jeff King <peff@peff.net>
Subject: Re: propagating repo corruption across clone
Date: Mon, 25 Mar 2013 10:56:44 -0400
Message-ID: <20130325145644.GA16576@sigill.intra.peff.net>
References: <20130324183133.GA11200@sigill.intra.peff.net>
 <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net>
 <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 15:57:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK8pn-0005A0-H8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 15:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277Ab3CYO4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 10:56:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38998 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757179Ab3CYO4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 10:56:47 -0400
Received: (qmail 24874 invoked by uid 107); 25 Mar 2013 14:58:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 10:58:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 10:56:44 -0400
Content-Disposition: inline
In-Reply-To: <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219034>

On Mon, Mar 25, 2013 at 09:43:23AM -0400, Jeff Mitchell wrote:

> > But I haven't seen exactly what the corruption is, nor exactly what
> > commands they used to clone. I've invited the blog author to give more
> > details in this thread.
> 
> The syncing was performed via a clone with git clone --mirror (and a
> git:// URL) and updates with git remote update.

OK. That should be resilient to corruption, then[1].

> So I should mention that my experiments after the fact were using
> local paths, but with --no-hardlinks.

Yeah, we will do a direct copy in that case, and there is nothing to
prevent corruption propagating.

> If you're saying that the transport is where corruption is supposed to
> be caught, then it's possible that we shouldn't see corruption
> propagate on an initial mirror clone across git://, and that something
> else was responsible for the trouble we saw with the repositories that
> got cloned after-the-fact.

Right. Either it was something else, or there is a bug in git's
protections (but I haven't been able to reproduce anything likely).

> But then I'd argue that this is non-obvious. In particular, when using
> --no-hardlinks, I wouldn't expect that behavior to be different with a
> straight path and with file://.

There are basically three levels of transport that can be used on a
local machine:

  1. Hard-linking (very fast, no redundancy).

  2. Byte-for-byte copy (medium speed, makes a separate copy of the
     data, but does not check the integrity of the original).

  3. Regular git transport, creating a pack (slowest, but should include
     redundancy checks).

Using --no-hardlinks turns off (1), but leaves (2) as an option.  I
think the documentation in "git clone" could use some improvement in
that area.

> Something else: apparently one of my statements prompted joeyh to
> think about potential issues with backing up live git repos
> (http://joeyh.name/blog/entry/difficulties_in_backing_up_live_git_repositories/).
> Looking at that post made me realize that, when we were doing our
> initial thinking about the system three years ago, we made an
> assumption that, in fact, taking a .tar.gz of a repo as it's in the
> process of being written to or garbage collected or repacked could be
> problematic. This isn't a totally baseless assumption, as I once had a
> git repository that I was in the process of updating when I had a
> sudden power outage that suffered corruption. (It could totally have
> been the filesystem, of course, although it was a journaled file
> system.)

Yes, if you take a snapshot of a repository with rsync or tar, it may be
in an inconsistent state. Using the git protocol should always be
robust, but if you want to do it with other tools, you need to follow a
particular order:

  1. copy the refs (refs/ and packed-refs) first

  2. copy everything else (including object/)

That covers the case where somebody is pushing an update simultaneously
(you _may_ get extra objects in step 2 that they have not yet
referenced, but you will never end up with a case where you are
referencing objects that you did not yet transfer).

If it's possible that the repository might be repacked during your
transfer, I think the issue a bit trickier, as there's a moment where
the new packfile is renamed into place, and then the old ones are
deleted. Depending on the timing and how your readdir() implementation
behaves with respect to new and deleted entries, it might be possible to
miss both the new one appearing and the old ones disappearing. This is
quite a tight race to catch, I suspect, but if you were to rsync
objects/pack twice in a row, that would be sufficient.

For pruning, I think you could run into the opposite situation: you grab
the refs, somebody updates them with a history rewind (or branch
deletion), then somebody prunes and objects go away. Again, the timing
on this race is quite tight and it's unlikely in practice. I'm not sure
of a simple way to eliminate it completely.

Yet another option is to simply rsync the whole thing and then "git
fsck" the result. If it's not 100% good, just re-run the rsync. This is
simple and should be robust, but is more CPU intensive (you'll end up
re-checking all of the data on each update).

> So, we decided to use Git's built-in capabilities of consistency
> checking to our advantage (with, as it turns out, a flaw in our
> implementation). But the question remains: are we wrong about thinking
> that rsyncing or tar.gz live repositories in the middle of being
> pushed to/gc'd/repacked could result in a bogus backup?

No, I think you are right. If you do the refs-then-objects ordering,
that saves you from most of it, but I do think there are still some
races that exist during repacking or pruning.

-Peff

[1] I mentioned that clone-over-git:// is resilient to corruption. I
    think that is true for bit corruption, but my tests did show that we
    are not as careful about checking graph connectivity during clone as
    we are with fetch. The circumstances in which that would matter are
    quite unlikely, though.
