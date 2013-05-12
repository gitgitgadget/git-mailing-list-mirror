From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Sun, 12 May 2013 09:59:34 +0100
Message-ID: <20130512085934.GG2299@serenity.lan>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
 <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
 <20130511214900.GF2299@serenity.lan>
 <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
 <7v1u9cx5pf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 12 10:59:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbS8J-0000gJ-Lb
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 10:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab3ELI7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 04:59:45 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:52440 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab3ELI7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 04:59:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D72EF606578;
	Sun, 12 May 2013 09:59:42 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dBoNW3QY2PW1; Sun, 12 May 2013 09:59:42 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 8D37A606570;
	Sun, 12 May 2013 09:59:36 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v1u9cx5pf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224028>

On Sat, May 11, 2013 at 08:00:44PM -0700, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Sat, May 11, 2013 at 2:49 PM, John Keeping <john@keeping.me.uk> wrote:
> >>
> >> Hmm... I hadn't realised that.  Looking a bit closer, it looks like
> >> init_patch_ids sets up its own diffopts so its not affected by the
> >> command line (except for pathspecs which would be easy to check for).
> >> Of course that still means it can be affected by settings in the user's
> >> configuration.
> >
> > .. and in the actual diff algorithm.
> 
> As to the "objection" side of the argument, I already said
> essentially the same thing several months ago:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/202654/focus=202898
> 
> and do not have much to add [*1*].
> 
> However.
> 
> The use of patch-id in cherry and rebase is to facilitate avoiding
> to replay commits that are obviously identical to the ones you have
> in your history.  The cached patch id for an existing old commit may
> differ from a patch id you freshly compute for a new commit you are
> trying to see if it truly new, even though they may represent the
> same change.  So we may incorrectly think such a new commit is not
> yet in your history and attempt to replay it.
> 
> But it is not a big problem.  Either 3-way merge notices that there
> is nothing new, or you get a conflict and have chance to inspect
> what is going on.

It's not a problem here, but false negatives would be annoying if you're
looking at "git log --cherry-mark".

> A conceptually much larger and more problematic issue is that we may
> discard a truly new change that you still need as an old one you
> already have due to a hash collision and discard it.  Because the
> hash space of SHA-1 is so large, however, it is not a problem in
> practice, and more importantly, that hash space is just as large as
> the hash space used by Git to reduce a patch to a patch id, the
> filtering done with patch-id in cherry and rebase _already_ have
> that exact problem with or without this additional cache layer. A
> stale cache may make the possibility of lost change due to such a
> hash collision merely twice as likely.
> 
> > ... it's a "the patch ID actually ignores a lot of data in order
> > to give the same ID even if lins have been added above it, and the
> > patch is at different line numbers etc".
> 
> Yes.
> 
> > So maybe it doesn't matter. But at the same time, I really think
> > caching patch ID's should be something people should be aware of is
> > fundamentally wrong, even if it might work.
> 
> I do not think it is "caching patch ID" that people should be aware
> of is fundamentally wrong.  What is fundamentally wrong, even if it
> might work, is "using patch ID" itself.
> 
> > And quite frankly, if you do rebases etc so much that you think patch
> > ID's are so important that they need to be cached, you may be doing
> > odd/wrong things.
> 
> And that, too ;-)

I've never noticed a problem with rebases, it's when I use "git log
--cherry master..." to see if patches I've sent to a mailing list have
been picked up.

To take Git as an example (albeit a bad one because "What's Cooking" is
a more useful way to track patch state here), if I compare this patch to
pu I have:

	$ git rev-list --left-right --count pu...
	234	1

and caching patch IDs takes that from ~0.6s to ~0.1s.  When doing that
over several branches consecutively that makes a big difference to the
overall runtime, especially because most of the commits of interest will
be cached during the first one.
