Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417D8C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 02:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D60D64F8E
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 02:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhCLC1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:27:39 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:43611 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhCLC1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 21:27:23 -0500
Received: by mail-lf1-f44.google.com with SMTP id d3so43160755lfg.10
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 18:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Z9iI1vzlCDRyEwvfq/i33JRTaAyxN33BTRSH/lyOME=;
        b=q7wshMzqwIVZSlpqHd+u1PzOVGo1phqsw5D5PB1IumxbgTRc/ACUFUSh44xP9Kmm5I
         /rMu6dbZrU5OwlJSpEJSpD5s/q7NRV0laeyjoGQpLM9fLlsDBM6VEUg+h3LFov+Q4QRH
         UXFxFJY3VN7NixMAxp98fbu+hBJv9KP0oJpvAsLZR8f0RQ26lz8nNfgaQX/tXXBrkKrc
         PJnfkKyY5u0YQvTjV8IZv8uaYIJcuAvDlY2xyyA1y3OwWWI19fdVtlTtpsiXo0iGtJ3k
         zcfIRddUAN/yMBzMyDJPaVvVdH9REzvddFV3qHMopADb3QcByoE9c3nGhch/u4pZcwvO
         clyw==
X-Gm-Message-State: AOAM533x+IfSjiGb1YueE4+Sn91aw7/cMzvFvjTPlxZYvTJXrgYu4YzP
        2gt992mlQQwuUrkg6+Thh/BPVFd77naIiBXm4kN9geFC
X-Google-Smtp-Source: ABdhPJxFV8Ba6OWA22YmNSi3rpYI40+RpkhaZfx6vd50hy/Nk37ziYKHFVi4e9WY3sUWD6WbHVtBRBDYVcWNnEZCWGM=
X-Received: by 2002:ac2:4d42:: with SMTP id 2mr4129396lfp.51.1615516042264;
 Thu, 11 Mar 2021 18:27:22 -0800 (PST)
MIME-Version: 1.0
References: <20210312004842.30697-1-john@szakmeister.net> <20210312004842.30697-2-john@szakmeister.net>
 <YErGymyECXjPXWcP@camp.crustytoothpaste.net> <YErHsQwIC2grgjwI@coredump.intra.peff.net>
In-Reply-To: <YErHsQwIC2grgjwI@coredump.intra.peff.net>
From:   John Szakmeister <john@szakmeister.net>
Date:   Thu, 11 Mar 2021 21:27:11 -0500
Message-ID: <CAEBDL5VeCe4UT7HFB0my0a1Cqmi-aXdYm86z9D6KSrMdi7fa+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] http: store credential when PKI auth is used
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 8:45 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Mar 12, 2021 at 01:41:30AM +0000, brian m. carlson wrote:
>
> > > diff --git a/http.c b/http.c
> > > index f8ea28bb2e..12a8aaba48 100644
> > > --- a/http.c
> > > +++ b/http.c
> > > @@ -1637,7 +1637,17 @@ static int handle_curl_result(struct slot_results *results)
> > >             credential_approve(&http_auth);
> > >             if (proxy_auth.password)
> > >                     credential_approve(&proxy_auth);
> > > +           credential_approve(&cert_auth);
> > >             return HTTP_OK;
> > > +   } else if (results->curl_result == CURLE_SSL_CERTPROBLEM) {
> > > +           /*
> > > +            * We can't tell from here whether it's a bad path, bad
> > > +            * certificate, bad password, or something else wrong
> > > +            * with the certificate.  So we reject the credential to
> > > +            * avoid caching or saving a bad password.
> > > +            */
> > > +           credential_reject(&http_auth);
> >
> > Is this supposed to be &cert_auth here?  I'm not sure how a bad HTTP
> > password would even have been tested in this case.
>
> Good catch! When reviewing, I was so busy thinking about _where_ this
> line should go that I didn't even notice what it said. :)

Good catch!  I don't even know how I did that. :-/  The system I
created the patch on is inaccessible via the Internet and I can't
really get data off of it.  This is entirely an error in translation
on my part.  The diff I printed has the correct line.  My bad.  I'll
send an update soon.

John
