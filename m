Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D0A1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 12:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJHTso (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 15:48:44 -0400
Received: from mail.ao2.it ([92.243.12.208]:48895 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeJHTso (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 15:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=DCRJqcsdTn1f/QQ6SvzmM/c5Sp5chC5pMZ2KUwyXKwA=;
        b=b7qKFra/ahIZSC7QvjvWqFvYgSI99WsUQ2GoxahqaB9WNXRufGqetpqzQ3m/ps4HZjiErdGVaTi9PSNKGlVQvO6ANUvVtPwyB9CyA01xPuDqXImZ26O94Cate2/p1tyVHdamhyj2gQe3rTF5wHXyhCh+j8bVok8EdLi4DqtxTul74X6f/NlM8qg7/3Xy2GYjYP9Fd1ENVBksMgBJ5n7VAwEWw9ZhdaAe5lP52PVidzu/Th2zOrXxGBRUOGLKQgVzgI31bzqkDe6h2HyYQGIY4MjVr9j/Eksprp+t2vQHdyu3CtvdDF/KZFRpTkYRfx/d6mlqP4tBQ605mhgXXDp/nw==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g9Uk4-0004B3-TW; Mon, 08 Oct 2018 14:34:32 +0200
Date:   Mon, 8 Oct 2018 14:37:09 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 08/10] submodule: add a helper to check if it is safe
 to write to .gitmodules
Message-Id: <20181008143709.dfcc845ab393c9caea66035e@ao2.it>
In-Reply-To: <xmqq36tiwsh7.fsf@gitster-ct.c.googlers.com>
References: <20181005130601.15879-1-ao2@ao2.it>
        <20181005130601.15879-9-ao2@ao2.it>
        <CAGZ79kbaeRVBLhYiqzisADHs+Af+c2giXcsCySAEe4jue_rWwA@mail.gmail.com>
        <xmqq36tiwsh7.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 07 Oct 2018 08:44:20 +0900
Junio C Hamano <gitster@pobox.com> wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> >>  static int module_config(int argc, const char **argv, const char *prefix)
> >>  {
> >> +       enum {
> >> +               CHECK_WRITEABLE = 1
> >> +       } command = 0;
> >
> > Can we have the default named? Then we would only use states
> > from within the enum?
> 
> Why?  Do we use a half-intelligent "switch () { case ...: ... }"
> checker that would otherwise complain if we handled "case 0" in such
> a switch statement, or something like that?
> 
> Are we going to gain a lot more enum members, by the way?  At this
> point, this looks more like a
> 
> 	unsigned check_writable = 0; /* default is not to check */
> 
> to me.

Hi,

the CHECK_WRITEABLE operation is alternative to the get/set ones, not
an addition, so I can see the rationale behind Stefan's suggestion:
either have named enums members for all command "modes" or for none of
them; however other users of enum+OPT_CMDMODE seems to think like the
enum is for commands passed as *options* and the unnamed default is for
actions derived from *arguments*. I don't have a strong opinion on this
matter, tho, so just tell me what you prefer and I'll do it for v7.

Using an enum was to have a more explicit syntax in case other commands
were going to be added in the future (I imagine "--stage" or
"--list-all" as possible additions), and does not affect the generated
code, so I though it was worth it.

Anyways, these are really details, let's concentrate on patches 9 and
10 which deserve much more attention. :)

Thanks you,
   Antonio
-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
