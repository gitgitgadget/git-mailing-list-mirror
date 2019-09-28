Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7659F1F463
	for <e@80x24.org>; Sat, 28 Sep 2019 03:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfI1DYL (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 23:24:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54478 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfI1DYL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 23:24:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E951034EAD;
        Fri, 27 Sep 2019 23:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6MDVMCPKcIbjvvHvSotibpbt3GM=; b=qKGzHv
        +Eh45bN12a4uxGOcoJ7XJqgPJZxG5PXNvpyYZRWzQpOs5/HlpEYma+hyu2PzukmG
        EsnkMVi767YdDWjAwP5DNSwX4GYZXMgxGMFsM3p4ZHYI1vyrjYnosQWa4wHTP3KB
        n4pQPLxNceDXROm+ITUoiQ+yw4qBewOMf4Bpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xsh9i8LwLVTuFLHyCRbs4QpU/x+hrxN4
        GxffwMq5MzaQg0npHbZrEXmjP912suOQ8ETiK99pMHnPstKARO5Wb25D6PBrTDHb
        UspS/66NC3D5SygEEO3XglkPXkjD0D4UHm1xCfnljlS+MTJGQpoQgKWgcbXQlPoC
        aXKkelANOic=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF50834EAC;
        Fri, 27 Sep 2019 23:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EBA234EAA;
        Fri, 27 Sep 2019 23:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/3] grep: don't add subrepos to in-memory alternates
References: <cover.1568771073.git.matheus.bernardino@usp.br>
        <xmqq36gt5qhr.fsf@gitster-ct.c.googlers.com>
        <CAHd-oW4u+iPFMvSGNvSJxfPLE34dQQ3x5_aQ-Y4Pd99FXR1p7Q@mail.gmail.com>
        <xmqqh857vsqz.fsf@gitster-ct.c.googlers.com>
        <CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com>
Date:   Sat, 28 Sep 2019 12:24:07 +0900
In-Reply-To: <CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Sat, 21 Sep 2019 17:34:35
        -0300")
Message-ID: <xmqqtv8xksrs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E9D9A1A-E19F-11E9-9930-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Right, this would be the best way of doing it. However, I think this
> is not how it's currently implemented. I if correctly understood the
> code in this call chain:
>
> grep_source_load_driver() >  userdiff_find_by_path() >
> git_check_attr() > collect_some_attrs() > prepare_attr_stack() >
> bootstrap_attr_stack()
>
> it seems that the whole stack is being rebuild for every path (even
> for paths descending in the same superproject or submodule).

bootstrap is guarded with "if (*stack) return;" and prepare knows to
rewind to the common level and push down the new ones, no?

At least that is how I remember writing the first version of it.
Have we broken the design over time, I wonder?

