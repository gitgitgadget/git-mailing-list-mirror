Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C731F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 03:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfJPDhX (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 23:37:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56749 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfJPDhX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 23:37:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 650797D2B3;
        Tue, 15 Oct 2019 23:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oHpRKzOzb9JRX+zrnr0aTWl2AF8=; b=k28ejw
        3I9qw40kLX8LPx2wcQ93G5NzbiLGXkHDSPMab00FzYLwu6Oq0/7P6Gp1jxZMQwP5
        BtcqLWP0anjNbWKn9Fs8f7s1H39fF/7E/qHI23/pIzNh+GotOszY1A1X+Ov9xGjj
        eocMWdfIwWNosbfP8cnY1AHQnv8aK3E/TJowY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k0Tgak6MKHorVQwuf55XJt87p7sRz7wX
        ydwt4dTwYZ6mZSy5qDZZJeVozecpQxBC//hq/HjpKztTPZl+53ZwtrmODCzvKlJ5
        u0+K8asaX6qLj7qv7NZKpVjv32wbKPZalF9S12ZVSW8r7evvUM066Ewf8e6FqXoU
        oACaGlJqWlQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DB247D2B2;
        Tue, 15 Oct 2019 23:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8F1E67D2B0;
        Tue, 15 Oct 2019 23:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH v3 02/13] graph: handle line padding in `graph_next_line()`
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
        <056c95d4edc8748c513db8c159c5e3d347ffc894.1571183279.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 12:37:16 +0900
In-Reply-To: <056c95d4edc8748c513db8c159c5e3d347ffc894.1571183279.git.gitgitgadget@gmail.com>
        (James Coglan via GitGitGadget's message of "Tue, 15 Oct 2019 23:47:48
        +0000")
Message-ID: <xmqq4l099x8z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4115C4C0-EFC6-11E9-995C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"James Coglan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: James Coglan <jcoglan@gmail.com>
>
> Now that the display width of graph lines is implicitly tracked via the
> `graph_line` interface, the calls to `graph_pad_horizontally()` no
> longer need to be located inside the individual output functions, where
> the character counting was previously being done.
>
> All the functions called by `graph_next_line()` generate a line of
> output, then call `graph_pad_horizontally()`, and finally change the
> graph state if necessary. As padding is the final change to the output
> done by all these functions, it can be removed from all of them and done
> in `graph_next_line()` instead.

Very well explained.
