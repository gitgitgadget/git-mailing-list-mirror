From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Wed, 13 Jan 2016 18:22:56 -0500
Message-ID: <20160113232255.GA17937@sigill.intra.peff.net>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601120939270.2964@virtualbox>
 <xmqqtwmitz2a.fsf@gitster.mtv.corp.google.com>
 <20160112214909.GD2841@sigill.intra.peff.net>
 <xmqqtwmhkrj2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 00:23:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJUlQ-0003pp-UA
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 00:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbcAMXW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 18:22:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:53377 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751107AbcAMXW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 18:22:58 -0500
Received: (qmail 20070 invoked by uid 102); 13 Jan 2016 23:22:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 18:22:58 -0500
Received: (qmail 2288 invoked by uid 107); 13 Jan 2016 23:23:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 18:23:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2016 18:22:56 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtwmhkrj2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283995>

On Wed, Jan 13, 2016 at 03:07:13PM -0800, Junio C Hamano wrote:

> > And then after a quiet period we can drop the "_crlf()" and have
> > strbuf_getline() back.
> 
> Actually, I think a patch that
> 
>  - renames strbuf_getline() to strbuf_getdelim(); and
>  - renames strbuf_getline_crlf() to strbuf_getline() 
> 
> on top of the series we already have is sufficient to bring the
> endgame state to us.  The new strbuf_getline() has a different
> function signature from the traditional one, so any topic in flight
> that is unaware of this series can easily be caught, and we can do
> this without a quiet period.

Ah, right, I forgot about the changed function signature.

> A more interesting question is if strbuf_getdelim() should take an
> arbitrary byte as its third parameter.  As I said elsewhere, the
> only reason why it is not a "do we use LF or do we use NUL?"
> boolean is because I wrote these codepaths anticipating that there
> might be a value other than NUL and LF that could be useful when I
> introduced line_termination long time ago, but no useful caller that
> uses other useful value has emerged, so I think the interface was
> too broad and too general for its own good.
> 
> It becomes very tempting not to do strbuf_getdelim() at all, but
> instead rewrite the current calls to strbuf_getline() to call one of
> two functions, i.e. strbuf_getline_lf() and strbuf_getline_nul(),
> when we rename strbuf_getline_crlf() to strbuf_getline().

I think you'll end up with some of the callers being a bit uglier. I.e.,
where we say:

  strbuf_getline(&buf, in, delim);

and "delim" is set elsewhere. These will become:

  if (delim == '\n') /* or maybe even "if (nul_terminate)" */
	strbuf_getline_lf(&buf, in);
  else
	strbuf_getline_nul(&buf, in);

which is a bit less nice.  But I guess these cases already need to
become uglier if we want them to handle CRLF. Unless we want to wrap the
idiom as:

  int strbuf_get_record(struct strbuf *buf,
			FILE *in,
			enum { STRBUF_RECORD_LINE,
			       STRBUF_RECORD_NUL
			     } delim);

and then "-z" option parsers use STRBUF_RECORD_NUL instead of setting a
char to '\0'.

> By going that route, those who want to help CRLF situation further
> can then concentrate on output from "git grep strbuf_getline_lf()",
> identify the ones that can be safely turned into strbuf_getline(),
> and do the conversion.

I'm not sure that is any easier than just grepping for strbuf_delim()
that takes '\n').

-Peff
