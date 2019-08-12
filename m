Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CBFC1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 22:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfHLWSa (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 18:18:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:41308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726734AbfHLWSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 18:18:30 -0400
Received: (qmail 29644 invoked by uid 109); 12 Aug 2019 22:18:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Aug 2019 22:18:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27486 invoked by uid 111); 12 Aug 2019 22:21:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2019 18:21:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Aug 2019 18:18:29 -0400
From:   Jeff King <peff@peff.net>
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: send-email and credential
Message-ID: <20190812221828.GA16666@sigill.intra.peff.net>
References: <CALnO6CDFQA_QmR_2tczPNJiymfUxt8LUiF0HOvKJKreB_HmNuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CDFQA_QmR_2tczPNJiymfUxt8LUiF0HOvKJKreB_HmNuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 06:00:14PM -0400, D. Ben Knoble wrote:

> I spent a frustrating hour today hoping to setup git-send-email with
> my gmail account. I've been able to confirm the following:
> 
> 1. git credential works
> 
>     # git config credential.helper
>     osxkeychain
>     # git credential fill <<EOF
>     protocol=smtp
>     host=smtp.gmail.com
>     EOF
> 
> outputs the correct username and password for my gmail account.
> 
> 2. I (believe) I setup gitconfig properly:
> 
>     # git config --get-regexp sendemail
>     sendemail.smtpserver smtp.gmail.com
>     sendemail.smtpuser ben.knoble@gmail.com
>     sendemail.smtpencryption tls
>     sendemail.smtpserverport 587
>     sendemail.multiedit true
>     sendemail.annotate true
> 
> The strange behavior I'm seeing is that git-send-email
> 
> - prompted me via macOS for keychain access (expected). This happened
> twice in a row, during one command invocation.
> - prompted me at the terminal for my gmail password (shudders)
> - stopped prompting me for messages send after that (all within the 15
> minutes of the first two)
> 
> Can anyone confirm/explain what's going on? I've never tried to use
> git-credential or git-send-email before, so I'm new to those (but
> experienced in git).

I don't think the saved password you're showing in step 1 is being
triggered, because Git will send "smtp.gmail.com:587" as the host field.
Try this:

  git \
    -c credential.helper='!exec >/tmp/credential.log 2>&1; cat; echo' \
    send-email ...

which will log the helper request. It probably has:

  host=smtp.gmail.com:587

I don't remember the specifics of how osxkeychain works, but it probably
pulls the port out of that and passes it to the OS keychain code, which
then treats it as a separate service.

So the rest of the behavior makes sense, then, I think:

  1. macOS had to unlock your keychain to check for the entry

  2. finding nothing, Git prompted you for the password

  3. Git then wrote the password to keychain after it was used
     successfully (maybe prompting another keychain password request? I
     don't know how it works), after which it should work without a
     password.

-Peff
