Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 332FF1FF30
	for <e@80x24.org>; Tue, 23 May 2017 08:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966707AbdEWIbH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 23 May 2017 04:31:07 -0400
Received: from wes1-so1-b.wedos.net ([46.28.106.43]:50839 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965219AbdEWIbD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 04:31:03 -0400
Received: from jvn (105.215.broadband18.iol.cz [109.81.215.105])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 3wX7yp3wHZz5r0;
        Tue, 23 May 2017 10:30:58 +0200 (CEST)
Date:   Tue, 23 May 2017 10:30:50 +0200
From:   Jan Viktorin <viktorin@rehivetech.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        xiaoqiang zhao <zxq_yx_007@163.com>,
        Git Mailing List <git@vger.kernel.org>, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com,
        Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5] send-email: --batch-size to work around some SMTP
 server limit
Message-ID: <20170523103050.1f7ab7e0@jvn>
In-Reply-To: <xmqq60gskobw.fsf@gitster.mtv.corp.google.com>
References: <20170521125950.5524-1-zxq_yx_007@163.com>
        <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>
        <xmqq60gskobw.fsf@gitster.mtv.corp.google.com>
Organization: RehiveTech
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 23 May 2017 16:46:27 +0900
Junio C Hamano <gitster@pobox.com> wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > Looking at this the Nth time now though I wonder about this approach
> > in general. In all your E-Mails I don't think you ever said /what/
> > sort of error you had from the SMTP server, you just said you had a
> > failure or an error, I assume you hit one of the die's in the
> > send_message() function. Can you paste the actual error you get
> > without this patch?

Hello,

I have issues with a company SMTP server that returns:

Net::SMTP::SSL=GLOB(0x20d6510)<<< 451 4.3.0 Please try again later,
rate limited.
4.3.0 Please try again later, rate limited.

Unfortunately, I didn't find out the exact properties of the limit yet.
It seems that sending more then 10 patches at once fails. Thus, I have
to send longer patch sets in 2 rounds:

1. normal git send-email
2. git send-email --no-thread --in-reply-to="<COVER LETTER ID>" \
     <REST-OF-PATCHES>...

It is not exactly the same as sending all the patches at once.

The xiaoqiang's solution sounds promising to me. However, probably a
more general solution would be to "just" enable sending a whole patch
set in 2 rounds manually. But I didn't find any way how to do it right.

Regards
Jan

> >
> > I wonder if something like this would Just Work for this case without
> > any configuration or command-line options, with the added benefit of
> > just working for anyone with transitory SMTP issues as well (patch
> > posted with -w, full version at
> > https://github.com/avar/git/commit/acb60c4bde50bdcb62b71ed46f49617e2caef84e.patch):  
> 
> Yeah, if the issues users of 163.com are having can be resolved with
> a more general approach like this, that would be very much preferred.
> 
> > Now that's very much a WIP and I don't have a server like that to test against.
> >
> > Having worked with SMTP a lot in a past life/job, I'd say it's *very*
> > likely that you're just getting a /^4/ error code from 163.com,
> > probably 421, which would make this logic even simpler. I.e. we could
> > just adjust this to back-off for /^4/ instead of trying to handle
> > arbitrary errors.
> >
> > Anyway, I'm not interested in pursuing that WIP patch, and I don't
> > think perfect should be the enemy of the good here. Your patch works
> > for you, doesn't really damage anything else, so if you're not
> > interested in hacking up something like the above I think we should
> > just take it.
> >
> >
> > But I do think it would be very good to get a reply to you / details
> > in the commit message about what error you get exactly in this
> > scenario, see if you get better details with --smtp-debug, and if so
> > paste that (sans any secret info like user/password you don't want to
> > share).  
> 
> Let's wait for a few days to see if xiaoqiang wants to take your
> outline of more general approach and polish it.  I do prefer the "no
> config" solution as xiaoqiang won't be the only 163.com user, but
> Individual Contributors cannot be forced, so ...
> 
> Thanks.
