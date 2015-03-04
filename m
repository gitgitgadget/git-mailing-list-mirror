From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: correct help string for --exclude-standard
Date: Wed, 4 Mar 2015 06:26:03 -0500
Message-ID: <20150304112603.GA26545@peff.net>
References: <1425045718-30696-1-git-send-email-pclouds@gmail.com>
 <20150304101606.GB15788@peff.net>
 <CACsJy8AW4=tsFLDcJb=is5UUdVyyFPD+AHi1v-xX=qCXLL_N2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 12:26:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT7RL-0001Y4-Mb
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 12:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759267AbbCDL0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 06:26:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:56210 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755693AbbCDL0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 06:26:06 -0500
Received: (qmail 6025 invoked by uid 102); 4 Mar 2015 11:26:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 05:26:06 -0600
Received: (qmail 29761 invoked by uid 107); 4 Mar 2015 11:26:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 06:26:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 06:26:03 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AW4=tsFLDcJb=is5UUdVyyFPD+AHi1v-xX=qCXLL_N2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264755>

On Wed, Mar 04, 2015 at 06:13:32PM +0700, Duy Nguyen wrote:

> On Wed, Mar 4, 2015 at 5:16 PM, Jeff King <peff@peff.net> wrote:
> > Hmm. If the default is "--exclude-standard", then what expect people to
> > use is "--no-exclude-standard". Would it make more sense to list that in
> > the "-h" output?
> 
> I thought about it and actually edited git-grep man page to clarify
> the default, only to find out this.  When --untracked is used,
> --exclude-standard is the default. When --no-index is used,
> --no-exclude-standard is the default. Can't have it both ways. This is
> already mentioned with the subtle phrase "only useful with...".

Yuck. :)

I agree your patch is the right thing to do, then.

> > It might be nice if parseopt had a PARSE_OPT_NEGHELP option or something
> > to show the "--no-" form.
> 
> Regardless, yes it would be nice to have something like this. I think
> there are places that can make use of this.

Grepping around, it looks like the best form would be an OPT_NEGBOOL
that acts like a boolean but negates the truth value, and advertises the
negative form. We have a lot of:

  OPT_BOOL('n', "no-checkout", &option_no_checkout,
           N_("don't create a checkout"))

where countermanding an earlier "--no-checkout" has to be spelled as
"--no-no-checkout", rather than "--checkout". If we could write:

  OPT_NEGBOOL('n', "checkout", ...)

that would be nicer. But the short option is a bit weird. We'd want:

  -n: option_no_checkout=true
  --checkout: option_no_checkout=false
  --no-checkout: option_no_checkout=true

That is, we flip the sense of the long option, but the short option
still yields "true". I think that would be useful, but it sure is weird
to explain.

-Peff
