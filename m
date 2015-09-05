From: Jeff King <peff@peff.net>
Subject: Re: More builtin git-am issues..
Date: Sat, 5 Sep 2015 04:03:26 -0400
Message-ID: <20150905080325.GA25039@sigill.intra.peff.net>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
 <CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
 <xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
 <55EA9A13.2050108@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:03:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY8Rt-0007PK-4M
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 10:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbbIEIDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 04:03:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:55356 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750749AbbIEID3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 04:03:29 -0400
Received: (qmail 12132 invoked by uid 102); 5 Sep 2015 08:03:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Sep 2015 03:03:29 -0500
Received: (qmail 1033 invoked by uid 107); 5 Sep 2015 08:03:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Sep 2015 04:03:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2015 04:03:26 -0400
Content-Disposition: inline
In-Reply-To: <55EA9A13.2050108@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277362>

On Sat, Sep 05, 2015 at 09:30:27AM +0200, Johannes Sixt wrote:

> >How about a bit looser rule like this?
> >
> >     A block of text at the end of the message, each and every
> >     line in which must match "^[^: 	]+:[      ]" (that is,
> >     a "keyword" that does not contain a whitespace nor a colon,
> >     followed by a colon and whitespace, and arbitrary value thru
> >     the end of line) is a signature block.
> 
> Why do we need a new rule? The old git-am had a logic that pleased everyone,
> and it must have been implemented somewhere. Shouldn't it be sufficient to
> just re-implement or re-use that logic?

That was my thought, too; if there is a regression, let's start by
fixing that for the upcoming 2.6.0, and then we can worry about doing
something fancier[1] later.

And I think the original behavior really is what Linus is asking for: we
consider the final block, even with a "[]" comment, as a S-o-b block if
it has a Signed-off-by in it. So if we have the final block:

    [some comment]
    Signed-off-by: Somebody Else <them@example.com>

Running "am -s" with the current master yields:

    [some comment]
    Signed-off-by: Somebody Else <them@example.com>

    Signed-off-by: Jeff King <peff@peff.net>

which is wrong. Running the same with v2.5.0 gets:

    [some comment]
    Signed-off-by: Somebody Else <them@example.com>
    Signed-off-by: Jeff King <peff@peff.net>

So far so good. Now let's change our input to:

    [some comment]
    Reviewed-by: Somebody Else <them@example.com>

and run "am -s".  Current "master" continues to stick the extra line in
there. No surprise. But now so does v2.5.0!

So I don't think the old behavior covered all cases well, either, and
there's room for improvement. But likewise, I don't recall seeing a lot
of complaints about it in practice. It seems like a sane thing to
restore it for the upcoming release, and then build from there.

-Peff

[1] I think part of the reason people are interested in "fancy" here is
    that this topic extends beyond "git am". There's "commit -s", of
    course, but there's also the generic "interpret-trailers" command,
    which is supposed to be a generalization of the "--signoff" option.
    It would be nice if the rules remained consistent for when we add a
    trailer to an existing block, rather than special-casing signoffs.

    But again, I think that's something to shoot for in the long run.
    It's more important in the short term not to regress "am".
