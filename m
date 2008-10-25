From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/7] textconv: don't convert for every operation
Date: Sat, 25 Oct 2008 03:19:12 -0400
Message-ID: <20081025071912.GA24287@coredump.intra.peff.net>
References: <20081025004815.GA23851@coredump.intra.peff.net> <20081025005256.GD23903@coredump.intra.peff.net> <7vhc71b5ai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 09:20:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtdRo-0004MR-PO
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 09:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbYJYHTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 03:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbYJYHTQ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 03:19:16 -0400
Received: from peff.net ([208.65.91.99]:1407 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbYJYHTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 03:19:15 -0400
Received: (qmail 26904 invoked by uid 111); 25 Oct 2008 07:19:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 25 Oct 2008 03:19:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Oct 2008 03:19:12 -0400
Content-Disposition: inline
In-Reply-To: <7vhc71b5ai.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99097>

On Fri, Oct 24, 2008 at 10:41:09PM -0700, Junio C Hamano wrote:

> Isn't this function "fill_mmfile()" and its callers leaky as a sieve?

Yes, it is (for the textconv case; the other is unaffected). That was
another reason I had attached the data to the diff_filespec, but
obviously I forgot about that when re-rolling the patch.

> I am also somewhat worried about the performance impact of running
> get_textconv() to the same filespec many times when no textconv is
> defined, which is the normal case we should optimize for.  It appears that
> diff_filespec_load_driver() is optimized for a wrong case (i.e. "we
> already know this needs a custom driver and we know which one").

No, it is the same as before. We always end up with a driver at the end
of the function, so further calls will be no-ops. So we do exactly one
attribute lookup per filespec, caching the result.

> I am inclined to suggest reverting the whole series (including the ones
> that are already in 'master') and start over from scratch, limiting the
> run_textconv() to only inside diff.c::builtin_diff() (in the else {} block
> where "Crazy xcl interfaces.." comment appears).

I am not terribly opposed to that (I was quite surprised to see the
original make it to 'next', let alone 'master'). OTOH, the real reason
to do so would be to keep a clean history, and it is already too late
for that.

I think it makes sense to figure out _what_ needs fixed first, because
it might be somewhat minor. So far I see:

  - leak from fill_mmfile; this definitely needs fixed. The quick fix is
    minor (free if we did a textconv). A more involved fix is to pull it
    out of fill_mmfile entirely and put the code directly into
    builtin_diff, which would be part of a re-roll of this latest
    series.  But see below.

  - Keep fill_mmfile allocation semantics clear.  I was trying to keep
    it simple for other fill_mmfile callers to opt-in to textconv, even
    if they chose to do it by some user-controlled mechanism instead of
    by default (e.g., diff.TextconvDiffstat or something). But maybe
    that is not of value to us. Again, that is a re-roll of this series.

  - performance considerations with driver loading. I believe this is a
    non-issue. So either you are reading the code wrong, or I am not
    understanding your concern correctly (or _I_ am reading the code
    wrong, of course).

Others?

-Peff
