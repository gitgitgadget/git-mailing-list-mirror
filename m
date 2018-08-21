Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2B01F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeHUXSw (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 19:18:52 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37628 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUXSv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 19:18:51 -0400
Received: by mail-wm0-f42.google.com with SMTP id n11-v6so3949522wmc.2
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vH78IYIWLd5AVu0SLcsiraa55HimDgXut+nzS8k4vjQ=;
        b=OFFyNf5V0rcmzLPH0cBo2WzCDuHeSklbluwlJ0STJn5Mdc4dMxkVguFR9rYOF/3LgE
         NRmybMfA96dF1xfR9QqZxgvHBCaIfAPXhwsyZKEiagow+/ycusq3AvVcApuut4YTna34
         gL2uhXEDeqmNqFCqtnFUTqeXFWnRAsNlbOsw+36vlQPqEJRr5VYB1vg87mlYYcERjPV8
         goRtouy/ndmMFERQth4oy/APuUwoHevvYDIYe2wBP3h6Yrq05FblLZs5gliVevdHSiRD
         5aDQIBwB97UQrWLJ4OY9SvnuwezwttTZlNAt9Ob3SggHVBoufw8pBP+2FZYHcGBcLBGp
         5I6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vH78IYIWLd5AVu0SLcsiraa55HimDgXut+nzS8k4vjQ=;
        b=GF/H5KrDq0yV5oU+lK7YbUOPGLwXee1x9H3QLtBtSk8U5M6UL2eERmwkzSmvlSkXnP
         z51P9I0fRT2m2vQpuJpLzG3zxdhYzGwOBbQD07XCt1czzC5jK+asdDCxlozPdxqszvcM
         guQZyAfgUM0iMZQsdOMRGxRHXR9yrLsPwgxtD3MAGoVToA+TuyycwSq2K1FpyknXYls7
         gFtf09KVGDEoTe60/UT1wpOltWnGjtQ0CIBHYUtBRr5qSxhIWhK837n4CcJ61YtPj28w
         10RELNYbG1Lxch1oiYWCBE4DFLih+ZjwH4Ny/QOQk97fL37DvdRHtK2mc43xsf+ffdRF
         2bSw==
X-Gm-Message-State: APzg51AB2pZchBsg3QI9+T/L8G1Uxu8XCFBKW2dsY3wfsos4GLRSqEhH
        lRlXfiar+gFcYX2R0co3KFY=
X-Google-Smtp-Source: ANB0VdZb42hm03luPXZjp+/kBvA6FhJIUdGsrfmMbiYI/8j0GSLV+eFW4oVQOdp0nZWYIfYt62SoBg==
X-Received: by 2002:a1c:8016:: with SMTP id b22-v6mr525124wmd.9.1534881010174;
        Tue, 21 Aug 2018 12:50:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k34-v6sm4068126wre.18.2018.08.21.12.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 12:50:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have" objects
References: <20180821184140.GA24165@sigill.intra.peff.net>
        <20180821190705.GF30764@sigill.intra.peff.net>
        <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 21 Aug 2018 12:50:09 -0700
In-Reply-To: <xmqqin438pze.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 21 Aug 2018 12:43:49 -0700")
Message-ID: <xmqqbm9v8pou.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> When we serve a fetch, we pass the "wants" and "haves" from
>> ...
>> This lets us limit the change primarily to the oe_delta()
>> and oe_set_delta_ext() functions. And as a bonus, most of
>> the rest of the code does not consider these dummy entries
>> at all, saving both runtime CPU and code complexity.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>
> Sorry for commenting on something completely off-topic, but when
> applied with "git am -s", I get a resulting commit with 3 S-o-b (the
> above two, plus the one added by "-s"), with a blank line in between
> them.  I can understand the first blank line (the one between your
> two S-o-b), as the first S-o-b does not even appear to be part of
> the trailer block, but cannot explain why I get an extra one before
> the one added by "-s".  Puzzled...

I think your original "two s-o-b with a blank line in between" was
caused by the same problem, and "git commit --amend -s" perhaps
added an extra one at the end, and added a blank line before the
last "paragraph" while at it?

My suspicion is the long horizontal line at the beginning of the
table, triggers it.  I haven't followed the code closely yet,
though.
