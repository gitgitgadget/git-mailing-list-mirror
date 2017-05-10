Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B28C2018D
	for <e@80x24.org>; Wed, 10 May 2017 04:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdEJEWd (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 00:22:33 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:36662 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdEJEWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 00:22:33 -0400
Received: by mail-ua0-f171.google.com with SMTP id j17so22356812uag.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 21:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VAtdb037BBfUIREpQOupOB58SrrxP848TucZ1fD+lCI=;
        b=ZT1KwXIGq4L05YdPhXNmjibDE+fRLhDknBmvp8hFXQBjKJ5R6/DCkCMCUYKbR/Xz3c
         QzvMxJMXEWKCSO1ZM93WUy20RNiRAdIuevCiUYR99eJX8egywMtpm/QndyOFwlcD8P7F
         vVepCl12YHqcLdhVG94657nzOPuyveIDKcvXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VAtdb037BBfUIREpQOupOB58SrrxP848TucZ1fD+lCI=;
        b=PJdES/8j5ARZl3cTNXtf05d1xsi8RQ6wxokGd802xwMWkpgD+JbptT1w7XwxDRAUZT
         UX9BK+YimZ3gvFb/oreL8ZmnUbF1WDqVqve4B4U2ep2/2QfHMoGTSGc3SKvTsWFlOC6D
         wdemC0NwOAEJWi9LmnOD8pBKYpGlYNGfyoB9d2Vk9qkQkM8+K1Ngi/MJEDPRB7/Ebsfb
         09JB/5tSIMnREp9eUrlkD91ekWwjJW6gEtfLm3ejm/Uzk7d5dxyA+8W+/zS5mLrfdkIG
         txwar/TKUXQCQ2Ki0X5egv89hdYoFEyYVde3n4bmtaKFWOy3KP7SnMo8Gi7yFGWje57O
         b94w==
X-Gm-Message-State: AODbwcC+nileP+T08m9DHxoSMZlZ5VV7DYDEggY1rrccSZbn9tYZGUh7
        bFYrEQ9pikRztIg0N7F0uRcupeyH3w==
X-Received: by 10.31.93.4 with SMTP id r4mr1612854vkb.28.1494390151962; Tue,
 09 May 2017 21:22:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.71.89 with HTTP; Tue, 9 May 2017 21:22:11 -0700 (PDT)
In-Reply-To: <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com> <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 9 May 2017 21:22:11 -0700
Message-ID: <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 3:16 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 09, 2017 at 11:20:42AM -0700, Jonathan Tan wrote:
>
>> fetch-pack, when fetching a literal SHA-1 from a server that is not
>> configured with uploadpack.allowtipsha1inwant (or similar), always
>> returns an error message of the form "Server does not allow request for
>> unadvertised object %s". However, it is sometimes the case that such
>> object is advertised.
>>
>> Teach fetch-pack to also check the SHA-1s of the refs in the received
>> ref advertisement if a literal SHA-1 was given by the user.
>
> Hmm. That makes sense generally, as the request should succeed. But it
> seems like we're creating a client that will sometimes succeed and
> sometimes fail, and the reasoning will be somewhat opaque to the user.
> I have a feeling I'm missing some context on when you'd expect this to
> kick in.

Specifically, someone I know was looking at building an application
that is passed only a SHA-1 for the tip of a ref on a popular hosting
site[1]. They wanted to run `git fetch URL SHA1`, but this failed
because the site doesn't have upload.allowtipsha1inwant enabled.
However the SHA1 was clearly in the output of git ls-remote.

So a workaround is to do this in shell, which is just weird:

  r=$(git ls-remote $url | grep ^$sha1);
  if [ -n "$r" ]; then
    exec git fetch $url $r:refs/tmp/foo
  else
    echo >&2 "cannot find $sha1"
    exit 1
  fi

For various reasons they expected this to work, because it works
against other sites that do have upload.allowtipsha1inwant enabled.
And I personally just expected it to work because the fetch client
accepts SHA-1s, and the wire protocol uses "want SHA1" not "want ref",
and the SHA-1 passed on the command line was currently in the
advertisement when the connection opened, so its certainly something
the server is currently willing to serve.

The application in question is using a SHA-1 rather than a ref name,
because thats what it was given by something else. And the other thing
basically wants this to fail-fast if it can't get that exact SHA-1. So
to pass a ref name to git fetch the supplier would have to actually
pass a tuple of ref+sha1, and then the fetcher has to check that the
ref it just obtained provides the sha1 it expected.

So this all turned into a bug report by me to Jonathan Tan, because
git fetch violated my assumption of what it would do if I handed it a
SHA-1 and the SHA-1 was currently the tip of a remote ref.


[1] github.com
