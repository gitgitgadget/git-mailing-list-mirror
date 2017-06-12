Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9133A20C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbdFLVU2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:20:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:38476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752558AbdFLVU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:20:28 -0400
Received: (qmail 1705 invoked by uid 109); 12 Jun 2017 21:20:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 21:20:27 +0000
Received: (qmail 16305 invoked by uid 111); 12 Jun 2017 21:20:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 17:20:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 17:20:26 -0400
Date:   Mon, 12 Jun 2017 17:20:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
Message-ID: <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net>
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
 <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
 <1497084241.8531.2.camel@gmail.com>
 <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
 <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
 <1497255003.1718.1.camel@gmail.com>
 <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 11:28:56AM -0700, Junio C Hamano wrote:

> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> >> Adding a bit to "struct wt_status" is a good first step to allow all
> >> three (i.e. in addition to "Initial commit" and "Changes to be
> >> committed", "Changes not staged for commit" is the other one that
> >> shares this potential confusion factor) to be phrased in a way that
> >> is more appropriate in an answer to the question "what is the status
> >> of my working area?", I would think.
> >> 
> >> Thanks.
> >> 
> > It seems that the current change has to be discarded altogether and
> > further the change required doesn't look trivial. This seems to warrant
> > some bit of research of the code base. As a first step I would like to
> > know which part of the code base creates the commit template. I guess
> > much can't be done without knowing how it's created.
> 
> Perhaps something along this line (warning: not even compile
> tested)?

So I think the addition of the bit here is obviously correct, and I'm
not opposed to the idea of giving wt-status more information so that it
can make better messages. But I'm not sure it's actually helping for
some of these cases. E.g.:

> -	status_printf_ln(s, c, _("Changes not staged for commit:"));
> +	if (s->commit_template)
> +		status_printf_ln(s, c, _("Changes not staged for commit:"));
> +	else
> +		status_printf_ln(s, c, _("Changes not yet in the index:"));

I think "staged for commit" still makes perfect sense even when we are
just asking "what's the current status" and not "what would it look like
if I were to commit".

And avoiding the word "index" is worth-while here, I think. I am not in
general of the "let's hide the index" camp" but it is a technical term.
If we can say the same thing in a way that is understood both by people
who know what the index is and people who do not, that seems like a win.

> -	status_printf_ln(s, c, _("Changes to be committed:"));
> +	if (s->commit_template)
> +		status_printf_ln(s, c, _("Changes to be committed:"));
> +	else
> +		status_printf_ln(s, c, _("Changes already in the index:"));

This one is less obvious, because "to be committed" more strongly
implies making an actual commit. At the same time, I don't think it's
unclear what it means in the context of status. It could be "Changes
staged for commit" to match the other "not staged" message, though I
think I prefer the existing wording.

> @@ -1578,7 +1584,10 @@ static void wt_longstatus_print(struct wt_status *s)
>  
>  	if (s->is_initial) {
>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
> -		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
> +		status_printf_ln(s, color(WT_STATUS_HEADER, s),
> +				 s->commit_template
> +				 ? _("Initial commit")
> +				 : _("No commit yet on the branch"));

This one I think is an improvement. :)

-Peff
