From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Wed, 18 Jul 2012 03:21:04 -0400
Message-ID: <20120718072104.GB12942@sigill.intra.peff.net>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
 <20120717034640.GB20945@sigill.intra.peff.net>
 <7vvchnx7tc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 09:21:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOZN-000607-P2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab2GRHVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:21:09 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36860
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046Ab2GRHVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:21:07 -0400
Received: (qmail 15775 invoked by uid 107); 18 Jul 2012 07:21:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 03:21:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 03:21:04 -0400
Content-Disposition: inline
In-Reply-To: <7vvchnx7tc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201656>

On Mon, Jul 16, 2012 at 10:42:07PM -0700, Junio C Hamano wrote:

> > Just like log, the notes are part of the commit information to the right
> > of the graph. But this second hunk is for when we are not using the
> > pretty-printer at all, and the output looks like this:
> >
> >   $ git rev-list --graph --notes -2 HEAD
> >   * f6bbb09529a4cc73446c7c115ac1468477bd0cc6
> >
> >   Notes:
> >       foobar
> >   * 31c79549b85c6393be4f40432f5b86ebc097fc7e
> >
> > which doesn't make sense
> 
> I actually have quite a different feeling about this.  As I said in
> the separate message, I think --graph, or anything that makes the
> output unparsable or harder to parse for machines for that matter,
> in rev-list are not something we have because we wanted to support
> them, but that which just happen to work because the large part of
> rev-list and log can share building blocks to do similar things.
> The key phrase is "can share" here; it does not necessarily mean
> they "should" [*1*].

Somebody went to the trouble to make "rev-list --graph" work[1] (that is
what the call to graph_show_remainder in the else clause of the
conditional is about). I agree it seems kind of useless, but it does
work now, and we should at least not make it worse (and I think we both
agree that the output above is just wrong).

So whatever we show for a note, it should look like:

  * f6bbb095...
  | the notes thing to show
  * 31c79549...

Because that is how graph output is formatted. Either that, or we should
disallow --graph entirely with rev-list (which I'd also be OK with).

> I do not mind having an option to show the notes text, but I doubt
> it is a sane thing to do to make "rev-list --notes" unconditionally
> show the payload of the notes blob.  "rev-list --objects" only shows
> the object names of trees and blobs, not the payload in these
> objects, and this is very much on purpuse.  It allows the downstream
> process that reads its output from the pipe to easily parse the
> output and choose to do whatever it wants to do using them.
> 
> I wonder if we should show the blob object names that store the
> notes payload if we were given --notes option in a format that is
> easy for readers to mechanically parse its output.

So leaving aside the --graph issues, we would need to decide what to
show in the non-graph case. And I think your suggestion is good; there
is no real need to dereference the blob (if you want that, you can turn
on the pretty-printer).

I'm just not sure what the output should be. I guess:

  <commit_sha1> <notes sha1s>

is probably the most sensible (it's sort of like --parents). And that
solves the --graph issue, too, since it continues to take only a single
line.

-Peff

[1] Looking at the code, I do think somebody wanted "rev-list --graph"
to work, and it is not an accident. But I think they did not do a very
thorough job, as things like "git rev-list --objects --graph" produce
nonsensical output.
