Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BDE1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 22:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbeGSWpC (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 18:45:02 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36172 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeGSWpC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:45:02 -0400
Received: by mail-yw0-f194.google.com with SMTP id v197-v6so3659062ywg.3
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 14:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gA7LF/Wmf+bIwd+8UBCfd5UjlZdMxz+kLGv9JribryA=;
        b=R2pOXsxwJfIU62I3G9O1igPQMe5wfsqsAASnA914HHblcAwRMqcq5D6rNDM46vmx/N
         8e4DheM2Ob4VaTkOLtFO5HDXY8EJrDzFiNakL6sZR8nPEl/j+pvvn5y2Ronss7SyBfci
         uxIDRI0uacT5Bq+e6d1N16u7EwQB87m5WyzaZn92RDYFfeiWZXPee2iVyibR2QhkQgiJ
         EKkMIjPC2iSWZsaM1Sg+E3njp3e8Fp5jFS0CDzV0EACIl70Y/vWpqSvGJPRv8uAzS+WH
         Pbvgm+yVyRdy1GwUysNVg8i+RYB+gwg9gZ06ks18BHbsw4Wo+Ti2nvQrGtZfStHZz2Fw
         hu9w==
X-Gm-Message-State: AOUpUlFGZ+vvof+asYngKxrydz6cp+/6ROgOsmyo5g8ZYvZRytHz6nT4
        YJfkWlALx+EG2FS4aWZKGoAsOgHPy1jaGpqK69g=
X-Google-Smtp-Source: AAOMgpeyDksaKejKdQBN5ZfBdpt9/fbOwF5KSbs6Sdq7ePIz98PetxjEYL0UDQE2+4IzqyfltjB8K1reqq7XImogPnE=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr6400457ywk.418.1532037599046;
 Thu, 19 Jul 2018 14:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180719203259.GA7869@sigill.intra.peff.net> <20180719203901.GA8079@sigill.intra.peff.net>
 <CAPig+cSErDoZ5XFjfJsqfEKZ6PSKfOos=9HW-7FDXU1XEtuktA@mail.gmail.com> <20180719212700.GA13151@sigill.intra.peff.net>
In-Reply-To: <20180719212700.GA13151@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Jul 2018 17:59:47 -0400
Message-ID: <CAPig+cTbvKZ6Ui_ib2g2Xqbv8zFwJp9idocbWaZLxj0Lpe+YBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 5:27 PM Jeff King <peff@peff.net> wrote:
> On Thu, Jul 19, 2018 at 05:11:15PM -0400, Eric Sunshine wrote:
> > On Thu, Jul 19, 2018 at 4:39 PM Jeff King <peff@peff.net> wrote:
> > > + * This header lists functions that have been banned from our code base,
> > > + * because they're too easy to misuse (and even if used correctly,
> > > + * complicate audits). Including this header turns them into compile-time
> > > + * errors.
> >
> > When the above talks about "including this header", the implication is
> > that it must be included _after_ the system header(s) which declare
> > the banned functions. I wonder if that requirement should be stated
> > here explicitly.
>
> Hmm, does it need to be? I had originally intended it to be included
> before, actually, though in the end I put it later.
> I guess it would yield declarations like strcpy_is_banned(), which would
> cause _different_ errors (probably link-time ones).

Yes, that's what I meant. You'd only get link-time errors if banned.h
was included before the system headers (assuming I'm thinking about
this correctly).

> > (Probably not worth a re-roll.)
>
> Yeah, I doubt it matters much either way, since the inclusion is done
> automatically in git-compat-util.h.

Exactly.

> I had also originally imagined this to be triggered via DEVELOPER=1,
> with something like "-include banned.h" in CFLAGS. But I think it
> probably is appropriate for everybody to run it, since it shouldn't
> cause any false positives or other compilation issues.

Agreed.

> The one I brainstormed (but forgot to mention) is that it might be
> possible for a platform to have strcpy as a macro already? In which case
> we'd need to #undef it or risk a compilation error (even if the macro
> isn't actually used).

I have some recollection (perhaps long outdated or just wrong) of
Microsoft headers spewing deprecation warnings about "unsafe"
functions. I don't know whether they did that by covering functions
with macros or by decorating the function with a deprecation attribute
or by some other mechanism, but such concern seems well-founded.
#undef'ing them might indeed be a very good preventative tactic.
