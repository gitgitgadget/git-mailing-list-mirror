From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-line
 subject.
Date: Thu, 24 Feb 2011 02:34:16 -0500
Message-ID: <20110224073416.GD16550@sigill.intra.peff.net>
References: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com>
 <7vsjvfby0z.fsf@alter.siamese.dyndns.org>
 <20110223080854.GB2724@sigill.intra.peff.net>
 <7vd3miac47.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: xzer <xiaozhu@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 08:34:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsViO-00081n-Pv
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 08:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab1BXHeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 02:34:15 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45474 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab1BXHeP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 02:34:15 -0500
Received: (qmail 19768 invoked by uid 111); 24 Feb 2011 07:34:14 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 07:34:14 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 02:34:16 -0500
Content-Disposition: inline
In-Reply-To: <7vd3miac47.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167777>

On Wed, Feb 23, 2011 at 09:34:32AM -0800, Junio C Hamano wrote:

> A bit of history.  The original design of the pp_title_line() function
> since 4234a76 (Extend --pretty=oneline to cover the first paragraph,
> 2007-06-11) was to notice a multi-line paragraph and turn embedded
> newlines into line folds (this seems to be a breakage specific to
> non-ASCII titles).

Yes, the only actual breakage is the interaction of the folding with
non-ascii titles. The "fold everything" is a new feature. And one that
is probably not all that necessary in the real world, as rfc2822 allows
up to 998 characters. So it is more about complying with the SHOULD
there than the MUST.

> As RFC 5322 (or 822/2822 for that matter) does not allow newlines in field

Wow, I'm out of date. I had no idea 2822 had been superseded. ;)

> bodies (2.2: A field body MUST NOT include CR and LF except when used in
> "folding" and "unfolding"...), it was the only way to allow the recipient
> to tell where the original line breaks were to fold at the line breaks in
> the original commit message.  Then the recipient _can_ be git aware and
> turn the folding CRLF-SP into a LF, not just a SP, relying on the hope
> that the transport between the sender and the recipient would not clobber
> line folding, to recover the original.

Ah, that makes the current code make a lot more sense. Thanks for the
history.

> The rebase pipeline (i.e. "format-patch | am") would have satisfied such a
> flaky assumption and that was the only reason I wrote the line folding on
> the output side that way.  These days, however, "am" invoked in the rebase
> pipeline knows to slurp the message not from the patch text but from the
> original message, so we can safely depart form the original design rationale.

Agreed.

> I was re-reading RFC 2047 and its 5. (3) [Page 8] seems to imply that this
> might be allowed: "Only printable and white space character data should be
> encoded using this scheme."; I think LF is counted as a white space
> character in this context, but it is a bit unclear.

Yeah, the section is a little vague. I think the intent is that senders
should encode reasonable text things, not multimedia garbage, and that
receivers should be wary of getting arbitrary crap. So I think we are
following the spirit of the section in any case.

Reading over it, though, I do notice that we are specifically forbidden
to break multi-byte characters between encoded-words. And my
implementation doesn't take care about that. I think in practice, any
reasonable implementation would just concatenate the results and be
happy, but you never know.

> If this "encode newline via 2047" _were_ allowed, I would say that my
> preference is not to go with your 1. above.  Instead I would prefer to see
> us feed the entire first paragraph, whether it is a single-liner or
> multi-line paragraph, to the step 2 ...

Hmm. I disagree. I thought the decision was made long ago to convert
such multi-paragraph subjects into a single line in most cases.  Because
supporting such subjects at all was never about encouraging people to
flaunt the subject-line convention, but about letting the tools have a
reasonable default behavior for commits imported from systems that did
not follow that convention.

On top of that, I think there is some question of how encoded newlines
in a subject line will be handled by MUAs in the wild (given the
ambiguity of rfc2047 mentioned above). So perhaps it is better to be
conservative and not generate them by default.

And on top of that, it is not just a "how should it be if starting from
scratch" decision. We have been flattening multi-line ascii subjects for
years, so this would be a behavior change.

So I would think this should be triggered by an option ("-k" makes the
most sense to me) if anything. I am somewhat lukewarm on even that; as
you mentioned above, the rebase pipeline has a better preservation
mechanism these days, so it is really about people who want to email
patches to each other while disregarding the subject-line convention.

> >   3. rfc2047 should fold all lines at some sane length...
> 
> ... and the have step3 fold its result to limit the physical length of the
> output line(s).  Note that a multi-line first paragraph always will be
> encoded using 2047 because we cannot have a newline in the field body per
> RFC5322.  But going the above route would allow us to recover the original
> first paragraph intact.

Yes, exactly.

> We might need to tweak the receiving end a bit, though.  IIRC, mailinfo
> output assumed we will always be dealing with a single-liner subject.

I don't know if it's intentional or accidental, but mailinfo handles it
just as I would expect. See my other message.

-Peff
