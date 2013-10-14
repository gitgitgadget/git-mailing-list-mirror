From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] split_ident: parse timestamp from end of line
Date: Mon, 14 Oct 2013 18:31:37 -0400
Message-ID: <20131014223137.GA12744@sigill.intra.peff.net>
References: <20131014202734.GA7007@sigill.intra.peff.net>
 <xmqqwqlfebhi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 00:31:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqfw-0004JO-1O
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756880Ab3JNWbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:31:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:49327 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756397Ab3JNWbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:31:39 -0400
Received: (qmail 20709 invoked by uid 102); 14 Oct 2013 22:31:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Oct 2013 17:31:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Oct 2013 18:31:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwqlfebhi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236126>

On Mon, Oct 14, 2013 at 03:25:29PM -0700, Junio C Hamano wrote:

> > +	/*
> > +	 * Look from the end-of-line to find the trailing ">" of the mail
> > +	 * address, even though we should already know it as split->mail_end.
> > +	 * This can help in cases of broken idents with an extra ">" somewhere
> > +	 * in the email address.  Note that we are assuming the timestamp will
> > +	 * never have a ">" in it.
> > +	 *
> > +	 * Note also that this memchr can never return NULL, as we would
> > +	 * always find at least the split->mail_end closing bracket.
> > +	 */
> > +	cp = memrchr(split->mail_end, '>', len - (split->mail_end - line));
> > +	for (cp = cp + 1; cp < line + len && isspace(*cp); cp++)
> >  		;
> 
> "git grep" tells me this is the first use of memrchr(), which,
> unlike memchr(), is _GNU_SOURCE-only if I am not mistaken, so we may
> need a fallback definition in the compat/ and NEEDS_MEMRCHR in the
> Makefile, I think.

Yeah, you are right[1]. I'm happy to re-roll. I wonder if we even need
to worry about a compatibility wrapper. We are already doing pointer
manipulations, and it is probably just as readable to roll the loop by
hand.

-Peff

[1] I even looked at "man memrchr" on my glibc system and was surprised
    to see it mentioned above the "#define _GNU_SOURCE" fold. But that
    "fold" is used only sometimes (e.g., strchrnul), and not others (in
    memrchr, the portability bits are listed at the end of the
    synopsis). Grr.
