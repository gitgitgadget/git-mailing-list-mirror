Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B28E1F461
	for <e@80x24.org>; Mon, 13 May 2019 23:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEMXYn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 19:24:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53231 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEMXYn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 19:24:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEA91155792;
        Mon, 13 May 2019 19:24:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+hsWEvVYephQ5fxGQQdZAqQ+xos=; b=K9p6LO
        ojh92BaMLgQ4WNx0OyIk4ygXLbRSx6DVxecDsxcTHCy8V8gqyuPLwXBgslEOwAmY
        OMtYoxtoRfMyytLj8J5zbc36T7lOahmz3lBRy9Nz4gRmuHPvJdpT3wqN6i2JcChj
        Rblc4eqLHTT2pqRGiFXXJsaJje8rnPvECOK/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aJWz16hCCHL5lkBKEU5PR0TdpLgLJQrn
        uVlWArgxRjG/eS0C0aV+lmyOCh2P9zmyGOqAezqQijTmw6v+6R4lAAHNpb5U8NQE
        xi3PPEG+A0IJrfjSYo7dIdtLIB1tC4QpPhtvrbz1XWUS0xcn7R21NYTvdyk3hxop
        SuLXIpglOac=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6F28155791;
        Mon, 13 May 2019 19:24:40 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E3C4155790;
        Mon, 13 May 2019 19:24:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] pkt-line: fix declaration of `set_packet_header()`
References: <pull.192.git.gitgitgadget@gmail.com>
        <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com>
Date:   Tue, 14 May 2019 08:24:39 +0900
In-Reply-To: <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 13 May 2019
        15:43:16 -0700 (PDT)")
Message-ID: <xmqqo9469buw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4806B394-75D6-11E9-BE88-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When this function was changed in a97d00799a19 (remote-curl: use
> post_rpc() for protocol v2 also, 2019-02-21) from file-local to global,
> the declaration was incorrectly missing the `const` qualifier.

I do not quite get it.  Back when the function was file-scope
static, it did not even have a separate declaration, and the
definition the said commit added looks correct to me.

Having "const int size" parameter in the definition of a function
does help the compilers and the developers by making sure any
earlier reference to the parameter in the function would not modify
it and cause later reference to obtain a different value.

But the parameter treated as a constant without getting modified
during the invocation of the function is an implementation detail of
the function; there is no point exposing that implementation detail
to its callers.  It does not even help the compilers handling the
caller's compilation unit---the parameter is passed by value, so the
caller knows that the callee would not modify it without "const"
there.

Does the language even allow flagging "const int in the definition,
int in the declaration" as a warning-worthy discrepancy?

> -void set_packet_header(char *buf, int size);
> +void set_packet_header(char *buf, const int size);
