Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0B8215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 23:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932963AbcJLXNf (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 19:13:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:56717 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753915AbcJLXNe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 19:13:34 -0400
Received: (qmail 2884 invoked by uid 109); 12 Oct 2016 23:13:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 23:13:24 +0000
Received: (qmail 24706 invoked by uid 111); 12 Oct 2016 23:13:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 19:13:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2016 19:13:22 -0400
Date:   Wed, 12 Oct 2016 19:13:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
Message-ID: <20161012231321.ar2csdmvhdya2q7r@sigill.intra.peff.net>
References: <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
 <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
 <vpqfuo3l4fl.fsf@anie.imag.fr>
 <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
 <vpq4m4iamfs.fsf@anie.imag.fr>
 <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
 <vpq60oy589b.fsf@anie.imag.fr>
 <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net>
 <vpq8tttr2ps.fsf@anie.imag.fr>
 <xmqqtwch2srj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwch2srj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 01:53:52PM -0700, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> >>> If it's not in the body of the message, then where is it?
> >>
> >> This point is clarified in the thread
> >> http://marc.info/?l=linux-wireless&m=147625930203434&w=2, which is
> >> with my upstream maintainer.
> >
> > Which explicitly states that the syntax is not [$number], but # $number,
> > right?
> 
> But I do not think that works, either.  Let's step back.
> 
> People write things like these
> 
>     Cc: Stable <stable@vger.kernel.org> # 4.8
>     Cc: Stable <stable@vger.kernel.org> [4.8+]
> 
> in the trailer part in the body of the message.  Are these lines
> meant to be usable if they appear as Cc: headers of an outgoing
> piece of e-mail as-is?

I think the answer is pretty clearly no. It's just that historically we
have auto-munged it into something useful. I think the viable options
are basically:

  1. Tell people not to do that, and to do something RFC compliant like
     "Stable [4.8+]" <stable@vger.kernel.org>. This is a little funny
     for git because we otherwise do not require things like
     rfc-compliant quoting for our name/email pairs. But it Just Works
     without anybody having to write extra code, or worry about corner
     cases in parsing.

  2. Drop everything after the trailing ">". This gives a valid rfc2822
     cc, and people can pick the "# 4.8" from the cc line in the body.

  3. Rewrite

       A <B@C> D

     into

       A D <B@C>

     regardless of what is in "D". This retains the information in the
     rfc2822 cc.

Starting from scratch, I'd say that (2) seems like a good combination of
simplicity and friendliness.  But (3) matches what we have done
historically (and still do at least for some values of "D", and
depending on the presence of Mail::Address).

Once we decide on a behavior, it seems like we should be able to apply
it consistently with or without Mail::Address by grabbing the bits after
the final ">".

Larry seems to be against (2), but I'm not sure I understand why pulling
the value from the in-body cc (which gets copied into the commit message
by git-am, too) would be a problem.

-Peff
