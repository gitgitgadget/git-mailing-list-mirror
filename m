Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2513FC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 23:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A2161460
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 23:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhD2XnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 19:43:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64100 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD2XnO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 19:43:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4912D70D7;
        Thu, 29 Apr 2021 19:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FMo+722zytNyVWF+GgoGwGvV2GJj958JFGqENt
        tdBfc=; b=gUhV0NRRaqEFdUqcfYpT4goUB3SGhvwM+/5oh9Y93iqGMNRtzrQam9
        0VBBwh+eSfNsUUmkySU4rour0d8l983ipYM644/q7OddUK02nBhB94OSwdlqFaGs
        qeTQEtVI0o11dhr5y9tQ56mBvSOY9l70IRUiEp5sN4mvvMbPJCb1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90A45D70D6;
        Thu, 29 Apr 2021 19:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8D92D70D5;
        Thu, 29 Apr 2021 19:42:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 3/3] fast-export, fast-import: implement signed-commits
References: <20210422002749.2413359-1-lukeshu@lukeshu.com>
        <20210423164118.693197-1-lukeshu@lukeshu.com>
        <20210423164118.693197-4-lukeshu@lukeshu.com>
        <xmqqfszbcazc.fsf@gitster.g> <87o8dwq2hv.wl-lukeshu@lukeshu.com>
        <CABPp-BHhfT3b=UyWOXACrBb6nw86n74thNAx7DUDF0YNOcA-yA@mail.gmail.com>
Date:   Fri, 30 Apr 2021 08:42:24 +0900
In-Reply-To: <CABPp-BHhfT3b=UyWOXACrBb6nw86n74thNAx7DUDF0YNOcA-yA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 29 Apr 2021 15:38:57 -0700")
Message-ID: <xmqqim44fyjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D627524-A944-11EB-9F80-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I do get that we might have to use warn-strip as the default anyway
> just because some existing tools might rely on it, but do you have any
> examples outside of git-filter-repo?  Given the filter-repo bug
> reports I've gotten with users being surprised at commit signatures
> being stripped (despite the fact that this is documented -- users
> don't always read the documentation), I'd argue that changing to
> --signed-commits=abort as the default is probably a good bugfix for
> both fast-export and for filter-repo.

Thanks.  The "filter-repo already gets bug reports from the users"
is a valuable input when deciding if it is reasonable to sell the
behaviour change as a bugfix to our users.

Perhaps teaching fast-export to pay attention to two environment
variables that say "when no --signed-{tag,commit}=<disposition>"
command line option is given, use this behaviour" would be a good
enough escape hatch for existing tools and their users, while they
are waiting for their tools to get updated with the new option you
are planning to add?

Also, I am glad that you brought up another possible behaviour that
Luke's patch did not add.  Exporting existing signatures that may
become invalid and deciding what to do with them on the receiving
end would be a good option to have.  And that would most likely have
to be done at "fast-import" end, as a commit that "fast-export"
expected to retain its object name if its export stream were applied
as-is may not retain the object name when the export stream gets
preprocessed before being fed to "fast-import".


