Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4D5C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34AA64DC4
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhCLBCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 20:02:08 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45478 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhCLBCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 20:02:06 -0500
Received: by mail-lf1-f45.google.com with SMTP id k9so42919034lfo.12
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 17:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYWirf6yRikvQeGrhv05q3Ps7f2dqKVunqJlikbH2BU=;
        b=i5GoiWSfVDLIGmrnhqxPvoSlQ4gtdImE8H4HKE/YlmGNchXMRM+8qDafAGorQQNcM6
         h4Sp3PUI4HjpuY3EFUi3oK4nZV+89WlZz0WCUKN9SaPk4MdTqA3COnJlTMVzBa6LZ3Ca
         8DpRF59FpuYzzReb8ANwI8F8Ee6kPXAQhSrfiDGSf19PHUDAq4fl7GFFKN8TMyHN5CGO
         mgfgGU1N/TDJXc1/Q44PB0wMeCqanqt4hu+2IovT6UPA1L4xSMdMUZFouKoQEMa0yamu
         W1dONsprhgDR0B1rqWDmw5/SGYIQXis6xJlqvPZnTFH5Ao6w5Y9xaaYPGeEaHFi1fJPZ
         850g==
X-Gm-Message-State: AOAM5332CfZOwzIQfGDH5cfUVWOw1eD3r1mjNy5TDgF1vyawCL0UvE/5
        Qf1OPMxvEstRIDdzN4Jxx5IemVVpqf+NWttd815cpr1W
X-Google-Smtp-Source: ABdhPJw96aTC4ZKfNHG2+IfkDWde7SRrdtg7Z3q8idQ66REpaN+9ES6WMt+2X0FHt4hHEL1VP+RK2jVSm4C/Thj4sto=
X-Received: by 2002:ac2:4d42:: with SMTP id 2mr3945333lfp.51.1615510924763;
 Thu, 11 Mar 2021 17:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20210306225253.87130-1-john@szakmeister.net> <YEkljZWg4+lTQRyS@coredump.intra.peff.net>
In-Reply-To: <YEkljZWg4+lTQRyS@coredump.intra.peff.net>
From:   John Szakmeister <john@szakmeister.net>
Date:   Thu, 11 Mar 2021 20:01:53 -0500
Message-ID: <CAEBDL5U=BxHzYWmG2Cpw+XcMJTF8_Qp0KXoKz6N+fHp1ZWdbRQ@mail.gmail.com>
Subject: Re: [PATCH] http: store credential when PKI auth is used
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 3:01 PM Jeff King <peff@peff.net> wrote:
[snip]
> I think it was just something that nobody ever cared about before. The
> cert password request got converted to credential_fill() as part of
> 148bb6a7b4 (http: use credential API to get passwords, 2011-12-10). That
> commit added approve/reject for http, because that's what I really cared
> about, but the intent was always to treat most password queries
> consistently.

I figured it'd be something like that, but wanted to ask, just in case. :-)

> > diff --git a/http.c b/http.c
> > index f8ea28bb2e..440890695f 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -1637,6 +1637,8 @@ static int handle_curl_result(struct slot_results *results)
> >               credential_approve(&http_auth);
> >               if (proxy_auth.password)
> >                       credential_approve(&proxy_auth);
> > +             if (cert_auth.password)
> > +                     credential_approve(&cert_auth);
>
> So I think this is the right direction, but:
>
>   - you'd need a credential_reject() somewhere, too. Otherwise a bad
>     password will get stored and then reused over and over, with no
>     opportunity to tell the helper to forget about it.

Right, I totally forgot about that aspect of this.

>   - is this the best spot to check that our password was right? We only
>     care about unlocking the local cert, which in theory is independent
>     of what the server tells us. I suspect we can't really tell the
>     difference, though (we hand the cert path and password off to curl,
>     and then hopefully a request is successful). So this may be the best
>     we can do for approval. But for rejection, I doubt that a 401 would
>     be the right response. How does curl respond when the password is
>     bad? Likewise, what happens if the password is bad but the server is
>     willing to make the request anyway (does curl bail immediately, or
>     might we get an HTTP 200 even with a bad cert password)?

It turns out that it was the right spot.  Curl will report
CURLE_SSL_CERTPROBLEM when provided a bad password, so
I ended up checking for that and using it to reject the credential.  It's a
bit loose in that other problems with the client certificate could cause
the same error, but there's not a good way to know whether the issue
was password-related or not.  So the new patch set will just reject it,
even if the issue was ultimately some other problem with the cert.  It
seemed like the best response given the information we have.

>   - I think proxy_cert_auth would probably want the same treatment.

Oh, I think I misread this before making my fixes.  I think what you're
saying here is that proxy_cert_auth should be approved and rejected
in the same spots as the client cert auth?  I missed that but am happy
to add it, if that's what you meant.  The only trouble is that I don't have
a great way of checking that particular feature.

>   - The "if (cert_auth.password)" is redundant. credential_approve()
>     will return silently if there is no password to approve. I know
>     you're copying the pattern from directly above, but I think that one
>     should be cleaned up, too.

Done.

>     (I also was mildly surprised that this worked at all, since
>     credential_approve() will bail if there is no username field. But
>     the cert code fills in an empty username).
>
> Most of those are "nice to have" improvements over what you have here,
> but I think without a matching reject() this would be a regression.

No worries.  If we can figure out the details, I'm happy to add it.

-John
