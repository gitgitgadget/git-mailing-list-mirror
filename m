Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D5A1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 23:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfHPXQB (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 19:16:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57409 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfHPXQB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 19:16:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BC0A169DCF;
        Fri, 16 Aug 2019 19:15:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vEsNRnFeE5uWJoU9StvLo2UdDlY=; b=pnG5y3
        7EHnKarXm12TihJpE+0dWVSyLoEXpjdkJYxCYv8HsTSnGha1Ir2WqJqK6c0eK4jF
        A37ucnh50xSn7M0mGDt+ZbK9qPh52odn7vrEvJQ/ouYFviHnMKkIPveTlplpZtEL
        A4K12VNGDOxhstcF5JExwYW99WmNaeHL0lGos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E4YMFX7f5z3tcMtHLWxuRx1Tx0or3eZq
        TZ31x/84ol+WGo/rlZ1k7OhVYF7vV+m3KfSXthlmh17siS4g1OHkzOn5Z+k6hc+O
        x1U1K7hqFtkN6Uxk+yMC+WpaDUAAvCgL1D5XNtOz0v4Q+4Qw5/hylkTxCMK9zA+J
        mL+JTTbbyOU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 447C3169DCE;
        Fri, 16 Aug 2019 19:15:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF5C8169DCD;
        Fri, 16 Aug 2019 19:15:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 23/24] merge-recursive: add sanity checks for relevant merge_options
References: <20190726155258.28561-1-newren@gmail.com>
        <20190815214053.16594-1-newren@gmail.com>
        <20190815214053.16594-24-newren@gmail.com>
        <xmqqd0h428ig.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFE+EX9HtAqN7CeBNHDTObGVw6nT8=+xxAASPJPXAq2=g@mail.gmail.com>
Date:   Fri, 16 Aug 2019 16:15:57 -0700
In-Reply-To: <CABPp-BFE+EX9HtAqN7CeBNHDTObGVw6nT8=+xxAASPJPXAq2=g@mail.gmail.com>
        (Elijah Newren's message of "Fri, 16 Aug 2019 15:08:40 -0700")
Message-ID: <xmqq7e7czope.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE5ED918-C07B-11E9-AD72-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> If the only possible values are 0 and 1, I can either add assertions
> to check that at run time, or make the compiler check it for us by
> confining its value to a single bit.  A compile-time check seems more
> robust...

Sure, as long as they can catch assignments (e.g. ".field = 2",
or more interestingly ".field = .field + 1" in a loop, etc.) and
increments or decrements and flag them.

> But the fact that you flagged the struct change -- would you prefer
> some commit message explanation of how it's related, or was it more
> the case that you felt it was a different kind of change and wanted it
> split out into a separate patch?  I'm suspecting the former but am not
> quite sure.

I do not see it as related at all, so either split it out into a
separate patch, or just drop it (and have a runtime check as
everybody else in this step), would be the sensible alternatives.  I
think the latter is easier to reason about but it may be just me.
