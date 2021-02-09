Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0132C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0AD64E5A
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhBIUva (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 15:51:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52545 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhBIUj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 15:39:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A97DB0934;
        Tue,  9 Feb 2021 15:38:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7b/SE9mAd7SsjGzob0kPrIqRotI=; b=QqW01h
        NN+TYbeTKAEw19cS6fMLytwHQN1GAEAEiB4o+0TS5y2AfTopQFHueC60GTcsTrNr
        /zcqWh9L2K62V+H9dgIMuXMhEoNZ2VnjgdRkPX5JsckPSCPZOFVgR0A3MBTVxG/r
        BGrI4oQEizS8QKkwZ3t6OzyPGecFQhJKSSsjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QaJ/oVyNlx9Cm0H3lLeatrEPR7iCj3iG
        /1h7tqb4/qo6Eo92hC98LCxXod6ENVDJqI75uMe/tqFNVwHoFJnxnYjRHOmwXB/l
        SdP9UOgIg3VdV0zfOf5iUCVwRwmoIHvfuPdgL6bisutq7WQBCgGEgrlv61zu+ypo
        ZftprPbCUvc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4106CB0933;
        Tue,  9 Feb 2021 15:38:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89C49B0931;
        Tue,  9 Feb 2021 15:38:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] grep: error out if --untracked is used with --cached
References: <YCGxos2vB6mgHOTA@nand.local>
        <20210208232159.100543-1-matheus.bernardino@usp.br>
        <CABPp-BFouwiACwwS5mDdgBRF=YK--=NfqZ9r=qkFouEvyJfnGQ@mail.gmail.com>
Date:   Tue, 09 Feb 2021 12:38:02 -0800
In-Reply-To: <CABPp-BFouwiACwwS5mDdgBRF=YK--=NfqZ9r=qkFouEvyJfnGQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 9 Feb 2021 02:06:46 -0800")
Message-ID: <xmqqtuql0yfp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B50B6DAE-6B16-11EB-8397-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ...  Even then, I'd be tempted to say that
> --untracked is only used in combination with a search of the working
> tree.

I tend to agree.  Something like

  $ git grep -ne POISON maint master next seen -- t/test-lib.sh

would be a useful thing, but I do not see how --untracked would
usefully interact with any of these "tracked" contents, be the
search from the index or tree.

