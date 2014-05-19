From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] replace: add --graft option
Date: Mon, 19 May 2014 13:35:05 -0400
Message-ID: <20140519173505.GA28673@sigill.intra.peff.net>
References: <20140518182939.5260.91202.chriscool@tuxfamily.org>
 <5379D1EF.8040203@alum.mit.edu>
 <20140519111940.GB17492@sigill.intra.peff.net>
 <xmqqvbt11y15.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 19:35:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmRT1-0000Mw-JI
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 19:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbaESRfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 13:35:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:55143 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753183AbaESRfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 13:35:07 -0400
Received: (qmail 31636 invoked by uid 102); 19 May 2014 17:35:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 May 2014 12:35:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2014 13:35:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbt11y15.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249607>

On Mon, May 19, 2014 at 10:25:10AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It might make sense to just teach parse_commit_header to be a little
> > more thorough; it has to read past those lines anyway to find the author
> > and committer lines, so it would not be much more expensive to note
> > them.  And then of course the code needs to be pulled out of the
> > pretty-printer and made generally accessible.
> 
> I notice that you said "might" above.

Yeah. I think having a reusable parser is definitely a good thing. I'm
not sure if it's worth the massive amount of refactoring that would be
required for this particular use case.

> > That's more or less what Christian's function is doing, though it
> > assumes things like that the parents come immediately after the tree,
> > and that they are all in a group. Those are all true for objects created
> > by git, but I think we can be a little flexible.
> 
> The headers up to committer are cast in stone in their ordering, and
> I do not immediately see how loosening it would be beneficial.
> 
> Unless you are trying to give users a new way to record exactly the
> same commit in twenty-four (or more) ways with their own object
> names, that is ;-)

Sorry, I didn't mean to imply that people can do what they want with
that ordering. Implementations that reorder the headers are stupid and
wrong, and should be fixed.

BUT. I really don't like making these assumptions or doing ad-hoc
parsing all through the code. We _do_ see quirky, wrong objects, and
want to handle them sanely and consistently. That's hard to do when
there are parsers sprinkled throughout the code which handle each case
slightly differently. I don't recall seeing this with header ordering,
but I know that broken ident lines have caused us headaches in the past,
and I'm happy that we've (mostly) settled on the code in
split_ident_line to handle this.

Things like:

  +       /* find existing parents */
  +       parent_start = buf.buf;
  +       parent_start += 46; /* "tree " + "hex sha1" + "\n" */
  +       parent_end = parent_start;

scare me. Is buf actually 46 bytes long? If not, we read past the end of
the buffer. What if it contains something besides "tree <sha1>\n" at the
beginning? We don't even notice!

The version I posted elsewhere in the thread at least operates on a
line-by-line basis, and tries to verify its assumptions (and barfs if
not). It's still doing its own parsing, but at least it's keeping its
assumptions on the object format to a minimum ("drop old parent lines",
"add new ones after tree, and barf if there's not exactly one tree
line").

-Peff
