From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Sat, 18 Dec 2010 23:55:15 +0300
Message-ID: <20101218205514.GA21249@landau.phys.spbu.ru>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
 <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru>
 <20101218161337.GB18643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 18 21:55:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU3oP-0006pc-PA
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 21:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209Ab0LRUzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 15:55:17 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:37441 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195Ab0LRUzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 15:55:16 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 125117F1A; Sat, 18 Dec 2010 23:55:15 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <20101218161337.GB18643@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163933>

On Sat, Dec 18, 2010 at 11:13:37AM -0500, Jeff King wrote:
> On Sat, Dec 18, 2010 at 05:54:12PM +0300, Kirill Smelkov wrote:
> 
> > It turned out, under blame there are requests to fill_textconv() with
> > sha1=0000000000000000000000000000000000000000 and sha1_valid=0.
> > 
> > As the code did not analyzed sha1 validity, we ended up putting 000000
> > into textconv cache which was fooling later blames to discover lots of
> > lines in 'Not Yet Committed' state.
> > [...]
> > -	if (driver->textconv_cache) {
> > +	if (driver->textconv_cache && df->sha1_valid) {
> >  		*outbuf = notes_cache_get(driver->textconv_cache, df->sha1,
> >  					  &size);
> 
> In short:
> 
>   Acked-by: Jeff King <peff@peff.net>
> 
> But it took some thinking to convince myself, so the long answer is
> below if anyone cares.
> 
> I was dubious at first that this could be the right solution. We still
> end up putting the filespec through run_textconv, which didn't seem
> right if it is not valid.
> 
> But reading into it more, there are two levels of invalidity:
> 
>   1. !DIFF_FILE_VALID(df) - we are not a valid file at all. I.e., we are
>      /dev/null.
> 
>   2. !df->sha1_valid - we are pointing to a working tree file whose sha1
>      we don't know
> 
> I think level (2) never happens at all in the regular diff code, which
> is why this case was completely unhandled. But it is OK in that case
> (required, even) to put the contents through run_textconv.
> 
> In theory we could actually calculate the sha1 in case (2) and cache
> under that, but I don't know how much it would buy us in practice. It
> saves us running the textconv filter at the expense of computing the
> sha1. Which is probably a win for most filters, but on the other hand,
> it is the wrong place to compute such a sha1. If it is a working tree
> file, we should ideally update our stat info in the index so that the
> info can be reused.

Jeff,

Thanks for your ACK and for the explanation.

My last patches to git were blame related so semi-intuitively I knew
that invalid sha1 are coming from files in worktree. Your description
makes things much more clear and I'd put it into patch log as well.
What is the best practice for this? For me to re-roll, or for Junio to
merge texts?

Also experimenting shows that, as you say, regular diff does not have this
problem, and also that diff calculates sha1 for files in worktree and so
their textconv results are cached. So clearly, there are some behaviour
differences between diff and blame.


Thanks again,
Kirill
