From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2010, #02; Sun, 04)
Date: Tue, 6 Apr 2010 00:42:41 -0400
Message-ID: <20100406044241.GB3901@coredump.intra.peff.net>
References: <7vtyrr6nes.fsf@alter.siamese.dyndns.org>
 <4BBA8A8C.2080905@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 06 06:43:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz0dH-00027S-WF
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 06:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128Ab0DFEnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 00:43:01 -0400
Received: from peff.net ([208.65.91.99]:35114 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999Ab0DFEm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 00:42:59 -0400
Received: (qmail 2695 invoked by uid 107); 6 Apr 2010 04:43:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Apr 2010 00:43:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Apr 2010 00:42:41 -0400
Content-Disposition: inline
In-Reply-To: <4BBA8A8C.2080905@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144096>

On Tue, Apr 06, 2010 at 09:12:44AM +0800, Michael J Gruber wrote:

> > * mg/notes-reflog (2010-03-29) 2 commits
> >  - refs.c: Write reflogs for notes just like for branch heads
> >  - t3301-notes: Test the creation of reflog entries
> > 
> > Implementation is trivially correct; I am unsure if "notes" tree wants
> > reflog in the first place, though.  Please convince me and I'll move it
> > to 'next' soon, aiming for -rc0 or -rc1 at the latest.
> 
> I think that Jeff's impressive textconv caching is only the first of
> many uses of notes where the notes ref is not a branch head with
> continuously added history, but where the ref is being rewritten over
> and over again. Also, people may rewrite their refs/notes/commits when
> experimenting with remote notes trees.
> 
> In both cases, I deem the reflog "backup" a useful safety measure (just
> as for other refs), and the automatic purging of the reflog provides
> just the appropriate housekeeping.

I agree. I don't expect people to want to look at their notes reflogs
very often, but we have become accustomed to having the reflog safety
net. It is often not until after the "oh crap" moment that the user
comes to the list and we tell them what the reflog is and how to
recover their lost data.

In the case of textconv caches, reflogs are not quite as important
because there is no lost data, only lost time. And as of now, we write a
large number of commits and trees that end up unreachable very quickly
(but only, of course, when encountering new items to cache).  But I
think that is a flaw in the notes-cache code. It should probably flush
the internal cache to a notes ref only on exit, not for every written
entry.

We had discussed dropping the expiration time for notes reflogs. Caches
could be 0 or very low (say 1 day), as recovery would primarily be about
experimentation with textconvs and recovering a cached state that is
slow to generate (e.g., you invalidate your cache by switching your
textconv, then switch it back; instead of regenerating your cache from
scratch, you find the latest cache commit that matches the textconv you
want. We could even do that automatically instead of clearing the cache,
but it is rare enough that I wouldn't bother).

General notes refs are probably useless after a week or two, since you
probably won't have the "oh no, I was working on this topic weeks ago
and I want to recover my partial work" moment that you do with regular
work. On the other hand, since they don't tend to have unreachable
entries, keeping them doesn't bloat the object database.

So that was a bit rambling perhaps, but the point is that I would rather
err on the side of having the reflog safety net and then later realize
we don't really want it, than vice versa.

-Peff
