Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C893F1F424
	for <e@80x24.org>; Sun, 24 Dec 2017 15:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbdLXPqV convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 24 Dec 2017 10:46:21 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17089 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdLXPqU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 10:46:20 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBOFju9t084901
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Dec 2017 10:45:57 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, "'Johannes Sixt'" <j6t@kdbg.org>
Cc:     "'Simon Ruderich'" <simon@ruderich.org>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Git List'" <git@vger.kernel.org>,
        "'Ralf Thielow'" <ralf.thielow@gmail.com>
References: <alpine.DEB.2.21.1.1711012240500.6482@virtualbox> <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net> <20171103103248.4p45r4klojk5cf2g@ruderich.org> <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com> <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net> <20171104183643.akaazwswysphzuoq@ruderich.org> <20171105020700.2p4nguemzdrwiila@sigill.intra.peff.net> <20171106161315.dmftp6ktk6bu7cah@ruderich.org> <20171117223345.s3ihubgda3qdb2j6@sigill.intra.peff.net> <c50ac174-15bd-60bc-490c-d231e3eb501d@kdbg.org> <20171224145427.GG23648@sigill.intra.peff.net>
In-Reply-To: <20171224145427.GG23648@sigill.intra.peff.net>
Subject: RE: Improved error handling (Was: [PATCH 1/2] sequencer: factor out rewrite_file())
Date:   Sun, 24 Dec 2017 10:45:50 -0500
Message-ID: <000c01d37cce$49bd0d30$dd372790$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQETHqd4M/Yxdik5gTXmtSY045bMKQGfmX4lAbGNbzEBcmz+twKiDQJsAV6CvMYBOrfZGwJ6ckLjAQD7QWkCL84szwIBIf+ipEX/75A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 24, 2017 9:54 AM, Jeff King wrote:
> Subject: Re: Improved error handling (Was: [PATCH 1/2] sequencer: factor
> out rewrite_file())
> 
> On Sat, Nov 18, 2017 at 10:01:45AM +0100, Johannes Sixt wrote:
> 
> > > Yeah, I have mixed feelings on that. I think it does make the
> > > control flow less clear. At the same time, what I found was that
> > > handlers like die/ignore/warn were the thing that gave the most
> > > reduction in complexity in the callers.
> >
> > Would you not consider switching over to C++? With exceptions, you get
> > the error context without cluttering the API. (Did I mention that
> > librarification would become a breeze? Do not die in library routines:
> > not a problem anymore, just catch the exception. die_on_error
> > parameters? Not needed anymore. Not to mention that resource leaks
> > would be much, MUCH simpler to treat.)
> 
> I threw this email on my todo pile since I was traveling when it came, but I
> think it deserves a response (albeit quite late).
> 
> It's been a long while since I've done any serious C++, but I did really like the
> RAII pattern coupled with exceptions. That said, I think it's dangerous to do it
> half-way, and especially to retrofit an existing code base. It introduces a
> whole new control-flow pattern that is invisible to the existing code, so
> you're going to get leaks and variables in unexpected states whenever you
> see an exception.
> 
> I also suspect there'd be a fair bit of in converting the existing code to
> something that actually compiles as C++.
> 
> So if we were starting the project from scratch and thinking about using
> C++ with RAII and exceptions, sure, that's something I'd entertain[1]
> (and maybe even Linus has softened on his opinion of C++ these days ;) ).
> But at this point, it doesn't seem like the tradeoff for switching is there.

While I'm a huge fan of OO, you really need a solid justification for going there, and a good study of your target audience for Open Source C++. My comments are based on porting experience outside of Linux/Windows:

1. Conversion to C++ just to pick up exceptions is a lot like "One does not simply walk to Mordor", as Peff hinted at above.
2. Moving to C++ generally involves a **complete** redesign. While Command Patterns (and and...)  may be very helpful in one level, the current git code base is very procedural in nature.
3. From a porting perspective, applications written in with C++ generally (there are exceptions) are significantly harder than C. The POSIX APIs are older and more broadly supported/emulated than what is available in C++. Once you start getting into "my favourite C++ library is...", or "version2 or version3", or smart pointers vs. scope allocation, things get pretty argumentative. It is (arguably) much easier to disable a section of code that won't function on a platform in C without having to rework an OO model, making subsequent merges pretty much impossible and the port unsustainable. That is unless the overall design really factors in platform differences right into the OO model from the beginning of incubation.
4. I really hate making these points because I am an OO "fanspert", just not when doing portable code. Even in java, which is more port-stable than C++ (arguably, but in my experience), you tend to hit platform library differences than can invalidate ports.

My take is "oh my please don't go there" for the git project, for a component that has become/is becoming required core infrastructure for so many platforms.

With Respect,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



