Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132DD2018E
	for <e@80x24.org>; Sun, 10 Jul 2016 17:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbcGJRGe (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 13:06:34 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:32799 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbcGJRGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 13:06:33 -0400
Received: by mail-vk0-f46.google.com with SMTP id b192so111868682vke.0
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 10:06:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/LGNyvZq72022QVaWFMEx0FVKXclQgg69RHNu86UWZ0=;
        b=fGkTj28q4l5otGGAMAt+JCtUbqVCDulpN/HLCUYQrEuZfC4VOUuo0cZyUN3EQnQg4e
         vLtjI6N4KfN8fKdambn5wiWiRNzVFaHQPzAQkM/pLsrkAAGDv9yG3v1kMjSiPhci9eob
         WiLSCYhxtaWRNvn8OGnJLoE3euPXX2lkxgEHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/LGNyvZq72022QVaWFMEx0FVKXclQgg69RHNu86UWZ0=;
        b=bi4i/wH/MXiF0+/2zuXFlsTcUAuFkmRoGBz+CJ7lH8Xs/8HXecCjFzq9bqSJ7CDBlQ
         Z8Rj/uWJ2gsRdUv0Il7AmPjGqHoC6Uvol1q3nuepVPXhVWNRunFU3rnmruZl3mIyCK5B
         yUCcAhSu9NMdO+h+g3ECUYklW7oFFnNrCHnDK03EZOlbtvvuvAeeY6P7hN/fSPIWHIYl
         oZQLTF35O0PtGWRwaI9mb9B4DDRTgbtqtHS2kJthPi8b2XNzUlFsbao+J7V1xzrSTfOn
         EuhfQeLB4YpncmYI0q5z/BPLeytW9ZbmusmG5EHFwcro+BYuUqKR/1NckbkCaPfu9NeG
         r8Kw==
X-Gm-Message-State: ALyK8tK9ao12VPqVvnhuQeL4X/BMok+zDtc8Bej2v1qYwefI0VjqnmcRuZ2aFDPZhu90AZKgMicL+D2+8EgH+Q==
X-Received: by 10.31.7.68 with SMTP id 65mr7771185vkh.74.1468170392075; Sun,
 10 Jul 2016 10:06:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.41.197 with HTTP; Sun, 10 Jul 2016 10:06:12 -0700 (PDT)
In-Reply-To: <20160709003113.26930-3-sbeller@google.com>
References: <20160709003113.26930-1-sbeller@google.com> <20160709003113.26930-3-sbeller@google.com>
From:	Shawn Pearce <spearce@spearce.org>
Date:	Sun, 10 Jul 2016 10:06:12 -0700
Message-ID: <CAJo=hJtUyF=-iZeA1qBi42KBCP0pE6KsK4_MDP4JZEOf-K0waQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	e@80x24.org, Jeff King <peff@peff.net>, dwwang@google.com,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 8, 2016 at 5:31 PM, Stefan Beller <sbeller@google.com> wrote:
> +
> +       /* NEEDSWORK: expose the limitations to be configurable. */
> +       int max_options = 32;
> +
> +       /*
> +        * NEEDSWORK: expose the limitations to be configurable;
> +        * Once the limit can be lifted, include a way for payloads
> +        * larger than one pkt, e.g allow a payload of up to
> +        * LARGE_PACKET_MAX - 1 only, and reserve the last byte
> +        * to indicate whether the next pkt continues with this
> +        * push option.
> +        */
> +       int max_size = 1024;

Instead of this, what about a new config variable
receive.maxCommandBytes[1] that places a limit on the number of bytes
of pkt-line data the client can supply in both the command list ("old
new ref"), push signature framing, and option list?

Memory demands for the server are proportional to the data sent. A
simple byte limit lets the user make the decision about how this gets
used. Longer ref names or option values means fewer refs or options
can be sent. Shorter ref names or option values means more values or
options can be sent.

I studied a lot of repositories[2] and most use ref names under 200
bytes in length. A 3 MiB default for receive.maxCommandBytes gives
users something like 11,115 references in a single git push invocation
if they used all 200 bytes in every name. Most users don't have ref
names this long. Unlike a cap on each ref, it allows users to use the
full 65449 bytes in a reference name available in pkt-line, but you
can only send 48 such references. Likewise for options. :)


[1] I may propose this to JGit.
[2] More than 3M, but maybe Peff has access to more.
