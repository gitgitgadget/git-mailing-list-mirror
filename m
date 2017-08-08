Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D766B20899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbdHHW12 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:27:28 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34222 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbdHHW11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:27:27 -0400
Received: by mail-vk0-f41.google.com with SMTP id n125so19476064vke.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W3RbKY7eiSJTjG16j1P7vDw8J2cmEKzM0BdOWVLQs3c=;
        b=WS7MqQTcv1ZN1yQf56NxjVQ1nM7mAI1icAtcB4Y9MIQKnDK7wqzODBF115xXTB76EZ
         10oa2wPBAeoqX4Ux/ewd28EqGS+9TayrDImS0qQSwHKVQRQeQyNxPmGbhGyM4Nw+6zEk
         Jv8H6/cgv4BSlhqrDZzlpA606sTDb5czvOMks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W3RbKY7eiSJTjG16j1P7vDw8J2cmEKzM0BdOWVLQs3c=;
        b=jQ2nTEMfrpXc177fV/ZGpP57Htem0mPBnoPIzjRz9iusVdY+iBHUMKP6tM/NUD1bE0
         Y0R+wg9IS06rfDCUKPhh6hC8Czn1hJpKBEPwuEMaQqATpMn5rp7RpN7WAQFC0XwuFQlR
         brLgweLdWlnp05o4ZGWAMtkpF9ybJ1Ma4xawZPWNoId3Yr4pgj1IdCet0a0O3p33mP1z
         WEBiiAIpMa3GL1Nu07opUmMR3b/cJiFbECeLuFIkRBSfx5T26f8JhiXLLjb9VX2cSUR8
         UpSZCxgHkPh8MF3rxikCy2G75dfUflPpW+39TC3JgbEv4xPfwWYxWTt5GBB2jBHRkxmD
         o7lw==
X-Gm-Message-State: AHYfb5jZCAKcLiOZgrEMBMmqngNrFgzcdNvq3Ua+XfZrUqy3zDkyWRXH
        o0VKpIeKC6KhJXBr2HHBAs9T40nMyPHn
X-Received: by 10.31.211.70 with SMTP id k67mr3972608vkg.129.1502231246490;
 Tue, 08 Aug 2017 15:27:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 8 Aug 2017 15:27:05 -0700 (PDT)
In-Reply-To: <xmqqtw1hc28z.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
 <xmqqtw1hc28z.fsf@gitster.mtv.corp.google.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 8 Aug 2017 15:27:05 -0700
Message-ID: <CAJo=hJsyoFeCQbeJ=2XCRcE1U0zYaRr8VvzXHwkPwisdfUm71Q@mail.gmail.com>
Subject: Re: reftable [v6]: new ref storage format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 12:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I notice that you raised the location of restart table within a
> block in this iteration (or maybe it happened in v5).
>
> This forces you to hold all contents in core before the first byte
> is written out.  You start from the first entry (which will become
> the first restart entry), emit a handful as prefix compressed
> entries, emit a full entry (which will become the next restart
> entry), ... until you have enough to fill both the data and the
> restart table, then start writing from the header (which needs the
> length of the block), restart table and then data.
>
> I think it is OK to do so for the blocks whose size is limited to
> 16M, but I wonder if it is sensible to do the same for the index
> block whose limit is 2G.  If you keep the restart table after the
> data, then you could stream out the entries as you emit, write the
> restart table, and then seek back to fix the length in the header,
> without holding the 2G in core, no?

Yes. I'm torn on the ordering: restart table first or restart table last.

The advantage of it first is the reader can immediately work with it,
without necessarily touching the rest of the block. The disadvantage
is a writer can only stream at block sizes, as the writer is forced to
buffer the entire block. As it happens my implementation in JGit
buffers the entire block anyway, so this didn't really factor as an
issue for me.

Given that the index can now also be multi-level, I don't expect to
see a 2G index. A 2G index forces the reader to load the entire 2G to
take advantage of the restart table. It may be more efficient for such
a reader to have had the writer make a mutli-level index, instead of a
single monster index block. And so perhaps the writer shouldn't make a
2G index block that she is forced to buffer. :)

Perhaps I'll move it back to the tail of the block. I can see the
streaming writer code is maybe more straightforward that way.
