From: Jeff King <peff@peff.net>
Subject: Re: Tag peeling peculiarities
Date: Fri, 22 Mar 2013 13:42:35 -0400
Message-ID: <20130322174235.GA29011@sigill.intra.peff.net>
References: <51409439.5090001@alum.mit.edu>
 <7vwqtb2ood.fsf@alter.siamese.dyndns.org>
 <20130313215800.GA23838@sigill.intra.peff.net>
 <51415516.2070702@alum.mit.edu>
 <20130314052448.GA2300@sigill.intra.peff.net>
 <5141B475.1000707@alum.mit.edu>
 <20130314134032.GA9222@sigill.intra.peff.net>
 <514431EA.2050402@alum.mit.edu>
 <20130316093441.GA26260@sigill.intra.peff.net>
 <514475C4.7020901@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 22 18:43:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ5zl-0001KY-IY
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 18:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422743Ab3CVRmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 13:42:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35923 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422717Ab3CVRmo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 13:42:44 -0400
Received: (qmail 3044 invoked by uid 107); 22 Mar 2013 17:44:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 13:44:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 13:42:35 -0400
Content-Disposition: inline
In-Reply-To: <514475C4.7020901@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218827>

[this email is from last week, and I think most of was responded to in
 other parts of the thread, but there were a few loose ends]

On Sat, Mar 16, 2013 at 02:38:12PM +0100, Michael Haggerty wrote:

> >> * Change pack-refs to use the peeled information from ref_entries if it
> >>   is available, rather than looking up the references again.
> > 
> > I don't know that it matters from a performance standpoint (we don't
> > really care how long pack-refs takes, as long as it is within reason,
> > because it is run as part of a gc).  But it would mean that any errors
> > in the file are propagated from one run of pack-refs to the next. I
> > don't know if we want to spend the extra time to be more robust.
> 
> I thought about this argument too.  Either way is OK with me.  BTW would
> it make sense to build a consistency check of peeled references into fsck?

Yeah, I do think an fsck check makes sense. It should not be expensive,
and if there is a realistic corruption/health check for a repo, it makes
sense to me for it to be part of fsck. I do not recall many incidents of
packed-refs corruption in the history of the list, but this fairly
recent one comes to mind:

  http://thread.gmane.org/gmane.comp.version-control.git/217065

On the other hand, if it is just as cheap to rewrite the file as it is
to do the health checks, I wonder if the advice should simply be "run
pack-refs again" (and doing so should always start from scratch, not
trusting the existing version).

> > Yuck. I really wonder if repack_without_ref should literally just be
> > writing out the exact same file, minus the lines for the deleted ref.
> > Is there a reason we need to do any processing at all? I guess the
> > answer is that you want to avoid re-parsing the current file, and just
> > write it out from memory. But don't we need to refresh the memory cache
> > from disk under the lock anyway? That was the pack-refs race that I
> > fixed recently.
> 
> It would certainly be thinkable to rewrite the file textually without
> parsing it again.  But I did it this way for two reasons:
> 
> 1. It would be better to have one packed-refs file parser and writer
> rather than two.  (I'm working towards unifying the two writers, and
> will continue once I understand their differences.)

I see your point, though I also feel that with the right refactoring,
they could share the parser. And the second writer would be mostly a
pass-through. But much more compelling is reason 2...

> 2. Given how peeled references were added, it seems dangerous to read,
> modify, and write data that might be in a future format that we don't
> entirely understand.  For example, suppose a new feature is added to
> mark Junio's favorite tags:
> 
>     # pack-refs with: peeled fully-peeled junios-favorites \n
>     ce432cac30f98b291be609a0fc974042a2156f55 refs/heads/master
>     83b3dd7151e7eb0e5ac62ee03aca7e6bccaa8d07 refs/tags/evil-dogs
>     ^e1d04f8aad59397cbd55e72bf8a1bd75606f5350
>     7ed863a85a6ce2c4ac4476848310b8f917ab41f9 refs/tags/lolcats
>     ^990f856a62a24bfd56bac1f5e4581381369e4ede
>     ^^^junios-favorite
>     b0517166ae2ad92f3b17638cbdee0f04b8170d99 refs/tags/nonsense
>     ^4baff50551545e2b6825973ec37bcaf03edb95fe

Hmm. Good point. It is tempting to make a rule like "extensions that
are specific to a ref must come after the ref but before the next ref".
And then the writer could simply drop any lines between the to-delete
ref and the one that follows it.

I think that would work OK in practice, but I am worried that it would
paint us into a corner later on (after all, we do not know what
extensions will be added in the future). The only thing I can think of
that would break is something where a ref or its extension depends on
previous entries.  E.g., we start prefix-compressing the ref names to
save space. Of course that would break backwards compatibility horribly
anyway, so it's a no-go. But maybe some extension would want to refer to
a prior ref. I dunno.

-Peff
