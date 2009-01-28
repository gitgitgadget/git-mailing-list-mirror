From: Jeff King <peff@peff.net>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 03:17:45 -0500
Message-ID: <20090128081745.GA2172@coredump.intra.peff.net>
References: <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com> <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org> <20090128033020.GF1321@spearce.org> <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org> <20090128044150.GI1321@spearce.org> <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org> <20090128075515.GA1133@coredump.intra.peff.net> <7vfxj3vos2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 09:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS5di-0000xs-Lk
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 09:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbZA1IRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 03:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbZA1IRt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 03:17:49 -0500
Received: from peff.net ([208.65.91.99]:39472 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbZA1IRs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 03:17:48 -0500
Received: (qmail 19992 invoked by uid 107); 28 Jan 2009 08:17:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 03:17:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 03:17:45 -0500
Content-Disposition: inline
In-Reply-To: <7vfxj3vos2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107505>

On Wed, Jan 28, 2009 at 12:05:33AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But in other cases, it silently gives you the wrong answer.  For
> > example, consider a history like:
> >
> >        C--D
> >       /
> >   A--B
> >       \
> >        E--F
> >
> > now let's suppose I have everything except 'E'. If I ask for
> >
> >   git rev-list F..D
> >
> > then it will not realize that A and B are uninteresting, and I will get
> > A-B-C-D. I think it is much better for git to complain loudly that it
> > could not compute the correct answer.
> 
> Fair enough.  I think we can resurrect the conditional and the traversal
> option revs->ignore_missing_negative only for this hunk in my [2/2] patch
> to support that use case.
> [ hunk handling parent lookup]

Don't the other changes have similar parallel use cases? [2/2] also deals
with tag lookup. Wouldn't you also expect, if you had a tag "T" pointing
to "E" in the above scenario that "git rev-list T..D" would barf? I
really think you don't want to ignore missing negations _ever_ unless
the caller knows that such a miss is really only about optimization and
not correctness.

Side note:

As you described, we expect to reach this situation from a partial
transfer. Which means that you don't actually have a _ref_ for "T" (or
"F"). So it is unlikely to come up in normal use (you would have to
manually specify the sha1 of a broken portion of the graph).

But what is more important is that your repository _is_ corrupted, I
think we are losing an important method by which the user finds out. Git
is usually very good at informing you of a problem in the repo early,
and I think unconditionally ignoring missing objects would lose that.

-Peff
