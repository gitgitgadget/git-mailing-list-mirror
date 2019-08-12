Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D4C1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 00:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfHLAcb (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 20:32:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59636 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfHLAca (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 20:32:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81D33171701;
        Sun, 11 Aug 2019 20:32:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qtClZvVMBTQKO3l2XS3ExHjJwDE=; b=UdpXdD
        VgphM177xX+M+E70FvO9rLPi7R+Z4/b1NR4JlIQNYajlDT0Lh+AVN1XM0kJm0piY
        IgtXEVobDmjHrsc8hSpVrFW5EkVDun4YNVSOLMKzTuCRRSuIaTKpArcchxmPBAs0
        dgAZXbue3hFl+X6gAHeIXdRzHUoWq9GhGDQVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AlI+GvMsB0Ugt5e4dfnVTHM/cw980I8i
        lyzsqcEY/Mo7qKn8OXF0MdnC93zbQUFvb2Jt5bdOX3uFsBlxVgLN0uGNpXwtDdPX
        DNi/N22KhHu7+wgKoOg39LrQNBLtdF3YZIMacRTaJ9ZftHjWN0I2NHG2byBMCqCG
        j31c7l1a/xE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A0E6171700;
        Sun, 11 Aug 2019 20:32:28 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E19021716FF;
        Sun, 11 Aug 2019 20:32:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] path: add a function to check for path suffix
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
        <20190811174748.33552-1-sandals@crustytoothpaste.net>
        <20190811174748.33552-2-sandals@crustytoothpaste.net>
Date:   Sun, 11 Aug 2019 17:32:26 -0700
In-Reply-To: <20190811174748.33552-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 11 Aug 2019 17:47:47 +0000")
Message-ID: <xmqq1rxrcjfp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9AF5124-BC98-11E9-82F2-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We have a function to strip the path suffix from a commit, but we don't
> have one to check for a path suffix. For a plain filename, we can use
> basename, but that requires an allocation, since POSIX allows it to
> modify its argument. Refactor strip_path_suffix into a helper function
> and a new function, has_path_suffix to meet this need.

I wish we did not use a crazy phrase "path suffix", that would
inevitably confuse ourselves with things like ".exe".

>  /*
> + * If path ends with suffix (complete path components), returns the offset of
> + * the last character in the path before the suffix (sans trailing directory
> + * separators), and -1 otherwise.

i.e. this is offset to the last path component.

> +static ssize_t stripped_path_suffix_offset(const char *path, const char *suffix)

Perhaps

    static ssize_t last_path_component_offset(const char *path, const char *name)

I am tempted to also call the second parameter to this function
"basename", as we know from the proposed log message that you wish
"basename" were usable for this purpose, but basename itself has
another confusing factor (i.e. "are we stripping ".exe" extension?",
to which the answer is no in the context of these functions).

If we agree with the "last path component" phrasing, has_path_suffix()
would become something like:

    int last_path_component_equals(const char *path, const char *name);

perhaps.
