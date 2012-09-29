From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] revision: add --grep-reflog to filter commits by
 reflog messages
Date: Sat, 29 Sep 2012 02:16:41 -0400
Message-ID: <20120929061641.GA4425@sigill.intra.peff.net>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
 <1348893689-20240-1-git-send-email-pclouds@gmail.com>
 <1348893689-20240-3-git-send-email-pclouds@gmail.com>
 <20120929053013.GB3330@sigill.intra.peff.net>
 <7vpq55idbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqMD-0002Xr-39
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758867Ab2I2GQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34994 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758628Ab2I2GQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 02:16:44 -0400
Received: (qmail 26515 invoked by uid 107); 29 Sep 2012 06:17:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Sep 2012 02:17:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2012 02:16:41 -0400
Content-Disposition: inline
In-Reply-To: <7vpq55idbe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206641>

On Fri, Sep 28, 2012 at 10:54:29PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> +	if (opt->reflog_info) {
> >> +		strbuf_addstr(&buf, "reflog ");
> >> +		get_reflog_message(&buf, opt->reflog_info);
> >> +		strbuf_addch(&buf, '\n');
> >> +		strbuf_addstr(&buf, commit->buffer);
> >> +	}
> >> +	if (buf.len)
> >> +		retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
> >> +	else
> >> +		retval = grep_buffer(&opt->grep_filter,
> >> +				     commit->buffer, strlen(commit->buffer));
> >> +	strbuf_release(&buf);
> >> +	return retval;
> >
> > I like how callers not doing a reflog walk do not have to pay the price
> > to do the extra allocating. We could further limit it to only when
> > --grep-reflog is in effect, but I guess that would mean wading through
> > grep_filter's patterns, since it could be buried amidst ANDs and ORs?
> >
> > One alternative would be to set a bit in the grep_opt when we call
> > append_header_grep_pattern. It feels a bit like a layering violation,
> > though. I guess the bit could also go into rev_info. It may not even be
> > a measurable slowdown, though. Premature optimization and all that.
> 
> I do not think it is a layering violation.  compile_grep_exp()
> should be aware of the short-cut possibilities and your "our
> expression is interested in reflog so we need to read it" is very
> similar in spirit to the existing opt->extended bit.

Hmm. Yeah, I guess so. I was thinking that the grep code did not know
there was a commit or reflog involved at all (we just pass it a buffer,
and how we prepare it is our business), but it does already know about
the magic GREP_HEADER_* variables, and this is definitely part of that.

> We may also want to flag the use of the --grep-reflog option when
> the --walk-reflogs option is not in effect in setup_revisions() as
> an error, or something.

Good point. I think the docs in the patch just say it is ignored unless
walking, but it would be better to flag the error.

-Peff
