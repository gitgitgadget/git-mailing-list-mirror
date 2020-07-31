Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B95C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51842074B
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h0+I12TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbgGaROn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:14:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53748 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732710AbgGaROm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 13:14:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EF4075C55;
        Fri, 31 Jul 2020 13:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ju+c0EloFJwMgn+ObzqfkQFzys0=; b=h0+I12
        TFDDCddBxSQdOErH62mB0xM2RG+ELg0qIDarPHGzVHzsgbZsgViqHMyPnYb4uvxN
        49FK3ddZHo/1Cja/pUCGeaiOcga1nZHIbhMCxJAGPjZ9WdnDj7Sr8kwfq6irhxuY
        Uyrczpy+OXXiqN/RGaFFYL/ABxhv92xIWuwCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WOpZ0Ti/YVAeyWNPOObV7r/P89UNO/Kq
        9n3sqL6P0uvocT8L6fK20DdotWaxA/RFv0VtlBpDm3prrGtLg4OwxIX4I/7u42LH
        1nllG/pq82T6f820NcCuo3Id1byFcEXYidhSXNQ8YgUZd8Zlv4LPPp1Hv5z9dFr3
        MtEXuPlMzZ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 851F375C54;
        Fri, 31 Jul 2020 13:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EA5775C53;
        Fri, 31 Jul 2020 13:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH] commit-graph: add verify changed paths option
References: <pull.687.git.1596181765336.gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 10:14:39 -0700
In-Reply-To: <pull.687.git.1596181765336.gitgitgadget@gmail.com> (Son Luong
        Ngoc via GitGitGadget's message of "Fri, 31 Jul 2020 07:49:25 +0000")
Message-ID: <xmqqh7tn4neo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5176CC14-D351-11EA-8222-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Son Luong Ngoc <sluongng@gmail.com>
>
> Add '--has-changed-paths' option to 'git commit-graph verify' subcommand
> to validate whether the commit-graph was written with '--changed-paths'
> option.

The implementation seems to be only about "does this section exist?"
and not "does this section have healthy/uncorrupted data?", which
feels a bit strange for "verify".  Instead of setting ourselves up
to having to add "--has-this-section" and "--has-that-section" every
time a new kind of data is added to the system, how about giving the
verify command an option to list all the sections found in the file,
or a separate "git commit-graph list-sections" subcommand?

