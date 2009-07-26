From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Sun, 26 Jul 2009 11:39:50 -0400
Message-ID: <20090726153950.GA16780@sigill.intra.peff.net>
References: <20090723074104.GI4750@laphroaig.corp>
 <7veis7yxwx.fsf@alter.siamese.dyndns.org>
 <20090724193207.6117@nanako3.lavabit.com>
 <7v8wienk07.fsf@alter.siamese.dyndns.org>
 <20090725145237.GB18545@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 17:40:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV5pW-0005CS-Pg
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 17:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbZGZPjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 11:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbZGZPjx
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 11:39:53 -0400
Received: from peff.net ([208.65.91.99]:39620 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbZGZPjw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 11:39:52 -0400
Received: (qmail 6024 invoked by uid 107); 26 Jul 2009 15:41:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 26 Jul 2009 11:41:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Jul 2009 11:39:50 -0400
Content-Disposition: inline
In-Reply-To: <20090725145237.GB18545@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124123>

On Sat, Jul 25, 2009 at 04:52:37PM +0200, Pierre Habouzit wrote:

> FWIW it's what I was doing so far, and it's not very efficient for many
> patterns, you talked about the bit where you want to keep some of the
> debug, for this one I used to do that:
> 
> while I have meaning full commits to do:
>     git add -p; commit;
> git add -p the things I want to trash and commit
> git stash
> git reset --hard HEAD~1
> git stash apply
> 
> That sucks.
> [...]
> For all those reasons I believe it's a good thing to be able to have
> something to remove hunks from the working-directory. Jeff's suggestions
> to move them to some stash is the best suggestion so far, and is safe.

Here's kind of a weird idea I've been considering. Feel free to write it
off as insane ranting.

My two complaints about using stash for separating changes are:

  - it lacks the tool support for splitting changes that we have for
    making commits (like "add -p"), and it lacks the ability to build up
    a set of changes over multiple commands (like we can do for commits)

  - it works as a single destination. You stash and delete a change from
    the working tree, or you leave it. It's hard to say "there are 3
    different types of change here" and sort them all at once.

My idea is to instead have a general set of "registers" that contain
states, each of which is basically an index. You can copy state from
register to register, from working tree to register, or from register to
register. You can also do any of those moves by looking at differences
between two states and saying "move this change" (i.e., like what "add
-p" does for the regular index).

So one way of splitting changes would be to say:

  1. Set registers 'a' and 'b' to the same state as HEAD

  2. Pick changes from the working tree to go to 'a'

  3. Pick changes from the working tree to go to 'b'

  4. Commit 'a' on top of HEAD

  5. Commit 'b' on top of new HEAD (and this would probably actually
     mean the changes from 'b' to the old HEAD, not setting the new HEAD
     state to what's in 'b').

So it's sort of a generalized form of the index, where you have N "index
registers" and you sort your changes into them. And during steps 2 and
3, you could also make more changes, pick them out, etc.

The workflow you want maps into that pretty simply: you would sort your
changes into "stuff you want to commit" and "stuff that is debugging
cruft". And then you would just throw away the latter register (or use a
special "trash" register).

And the workflow I described is "pick the changes for 'a', then for
'a'". But there's no reason you couldn't go through the changes, sorting
each into "put this one into 'a', and this one into 'b'". Which is what
you asked for.

Is this really that different from what you proposed? No, I don't really
think so in terms of implementation, but it is really about a different
mental model:

  1. You never delete things. You only copy or move them into registers.

  2. The interface should be the same whether you are moving between
     registers, or to/from the working tree.

  3. It extends naturally to multiple registers.

Anyway, just some stray thoughts. No code, so feel free to ignore. ;)

-Peff
