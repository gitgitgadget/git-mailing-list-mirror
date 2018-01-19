Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACF751F404
	for <e@80x24.org>; Fri, 19 Jan 2018 22:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756659AbeASWxR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 19 Jan 2018 17:53:17 -0500
Received: from elephants.elehost.com ([216.66.27.132]:26305 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756577AbeASWxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 17:53:16 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0JMrANG099628
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Jan 2018 17:53:10 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>
References: <20180119173406.13324-1-randall.s.becker@rogers.com> <20180119173406.13324-3-randall.s.becker@rogers.com> <86c7345f-814d-8d81-bb55-e91fe630e118@ramsayjones.plus.com> <20180119212044.GA10303@sigill.intra.peff.net> <f2fd4d75-259b-a5b0-a7f9-74fec79cc970@ramsayjones.plus.com>
In-Reply-To: <f2fd4d75-259b-a5b0-a7f9-74fec79cc970@ramsayjones.plus.com>
Subject: RE: [PATCH v2 1/6] Bypass GCC attributes on NonStop platform where used.
Date:   Fri, 19 Jan 2018 17:53:04 -0500
Message-ID: <001201d39178$472d71e0$d58855a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5ceUaUBDLnBuBgyHh9+OiHAZcgwGNkmXnAL+IC2oA3QkNCgHUNrHhowgZhgA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 19, 2018 5:43 PM, Ramsay Jones wrote:
> On 19/01/18 21:20, Jeff King wrote:
> > On Fri, Jan 19, 2018 at 08:28:48PM +0000, Ramsay Jones wrote:
> >
> >>> diff --git a/remote.c b/remote.c
> >>> index 4e93753e1..c18f9de7f 100644
> >>> --- a/remote.c
> >>> +++ b/remote.c
> >>> @@ -11,6 +11,10 @@
> >>>  #include "mergesort.h"
> >>>  #include "argv-array.h"
> >>>
> >>> +#if defined (__TANDEM)
> >>> +#define __attribute(a)
> >>> +#endif
> >>> +
> >>
> >> Hmm, the only use of __attribute() I can find is in compat/regex/.
> >> In particular, there is no use of __attribute() in regex.c.
> >> [__attribute__() is used in regex.c]
> >>
> >> Is this an old patch which is no longer required?
> >>
> >> puzzled.
> 
> heh, I only just noticed that I (twice) wrote regex.c when I meant remote.c
> instead. Hopefully, that didn't cause too much confusion!
> 
> > I'm puzzled, too. The actual gcc thing is __attribute__(), and we
> > already turn that into a noop via macro expansion if __GNUC__ is not
> > defined (in git-compat-util.h, but see below).
> >
> > __attribute(), without the trailing underscores, is used internally by
> > the regex compat code (but it also converts that into a noop on
> > non-GNUC platforms)>
> 
> Indeed.
> 
> > However the logic in git-compat-util is weird:
> >
> >   #if defined(__HP_cc) && (__HP_cc >= 61000)
> >   #define NORETURN __attribute__((noreturn))
> >   #define NORETURN_PTR
> >   #elif defined(__GNUC__) && !defined(NO_NORETURN)
> >   #define NORETURN __attribute__((__noreturn__))
> >   #define NORETURN_PTR __attribute__((__noreturn__))
> >   #elif defined(_MSC_VER)
> >   #define NORETURN __declspec(noreturn)
> >   #define NORETURN_PTR
> >   #else
> >   #define NORETURN
> >   #define NORETURN_PTR
> >   #ifndef __GNUC__
> >   #ifndef __attribute__
> >   #define __attribute__(x)
> >   #endif
> >   #endif
> >   #endif
> >
> > Most of the conditional is dealing with NORETURN, but then we stick
> > the __attribute()__ handling in the "else" block. Is it possible that
> > this platform triggers __HP_cc, but doesn't actually understand
> > __attribute__?
> 
> That seems unlikely. However, that conditional looks a mess ... ;-)

Very messy and confusing and it is working properly now, so... consider this patch gone ;-)

Cheers,
Randall

