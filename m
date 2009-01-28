From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 08:16:53 -0800
Message-ID: <20090128161652.GK1321@spearce.org>
References: <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com> <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org> <20090128033020.GF1321@spearce.org> <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org> <20090128044150.GI1321@spearce.org> <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org> <20090128075515.GA1133@coredump.intra.peff.net> <7vfxj3vos2.fsf@gitster.siamese.dyndns.org> <20090128081745.GA2172@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 17:18:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSD7L-0007XG-GE
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 17:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbZA1QQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 11:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbZA1QQy
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 11:16:54 -0500
Received: from george.spearce.org ([209.20.77.23]:34975 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbZA1QQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 11:16:53 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0E2E338210; Wed, 28 Jan 2009 16:16:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090128081745.GA2172@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107545>

Jeff King <peff@peff.net> wrote:
> On Wed, Jan 28, 2009 at 12:05:33AM -0800, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > >
> > >        C--D
> > >       /
> > >   A--B
> > >       \
> > >        E--F
> 
> Don't the other changes have similar parallel use cases? [2/2] also deals
> with tag lookup. Wouldn't you also expect, if you had a tag "T" pointing
> to "E" in the above scenario that "git rev-list T..D" would barf? I
> really think you don't want to ignore missing negations _ever_ unless
> the caller knows that such a miss is really only about optimization and
> not correctness.

Exactly what I just said in my other message.
 
> Side note:
> 
> As you described, we expect to reach this situation from a partial
> transfer. Which means that you don't actually have a _ref_ for "T" (or
> "F"). So it is unlikely to come up in normal use (you would have to
> manually specify the sha1 of a broken portion of the graph).

True, but in the send-pack case we are discussing the remote side
has specified the SHA-1 of broken portions of the graph to us,
and we've taken that into consideration.  So we have to fix that
assumption we've made.

> But what is more important is that your repository _is_ corrupted,

Depends.  If the SHA-1 came from the remote side during send-pack,
it doesn't matter that we have a broken chain along that path,
it may have been a dumb transport fetch that was interrupted.
Our local repository isn't corrupt, it just has some extra crap
laying around that hasn't gc'd yet.

If the SHA-1 came from the user, then it depends on the context
of why the user is giving it to us.  In pretty much every case,
yes, its a corruption and we should be aborting.  :-)

Actually, the only time where it *isn't* a corruption is when its
input to "git bundle create A.bdl ... -not $SOMEBADID" as that is
the exact same thing as coming from the other side via send-pack.

> I
> think we are losing an important method by which the user finds out. Git
> is usually very good at informing you of a problem in the repo early,
> and I think unconditionally ignoring missing objects would lose that.

Yup, I agree.  But as you and Junio have already pointed out, C Git
can miss some types of corruption because the revision machinary has
some gaps.  *sigh*

I'd really like to see those gaps closed.  But I don't have a good
enough handle on the code structure of the C Git revision machinary
to do that myself in a short period of time.  I know JGit's well...
but that's only because I wrote it.  ;-)

Its now on my wish list of things I wish I had time for in C Git.
But perhaps someone who is more familiar with the revision machinary
will get to it first.

-- 
Shawn.
