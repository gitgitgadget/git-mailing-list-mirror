Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEEEC433FE
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiDFVkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbiDFVjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:39:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC60CB7C
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 14:16:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 125B5132365;
        Wed,  6 Apr 2022 17:16:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=wCyxA2TZaN9d0cXhuQtS23vF6NReMt0BvD0vItezhAE=; b=fb1O
        iInRqG1pDx31OBpMVpiBRK0LBjuJY8yn8Ajs0/IAmhvp9NkZNBIcfHRFJQxwccJs
        gr7gZmSzdu9sH5V5ZdnLhWnPHzXwM9lYpOi5Q1UqvXHULfz58k7pBjRSqTGahBva
        eza/9kMPMF40bqwHxf+R537cq+GRHOx4rOFA9gY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03AA7132364;
        Wed,  6 Apr 2022 17:16:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57253132363;
        Wed,  6 Apr 2022 17:16:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Raphael Bauer <raphael@pdev.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty format: fix colors on %+ placeholder newline
References: <e8417ad5-f9f2-c1de-75f6-45be49f0011b@pdev.de>
        <20220405154529.966434-1-raphael@pdev.de>
Date:   Wed, 06 Apr 2022 14:16:40 -0700
Message-ID: <xmqq8rshx687.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA772F46-B5EE-11EC-A31E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raphael Bauer <raphael@pdev.de> writes:

> Previously, the color escape codes were not printed again when a %+
> placeholder was expanded, which could lead to missing colors.

It is very good to start the proposed log message by describing the
current behaviour, highlighting what problem it has.  Because the
message is merely _proposing_ to make this change, which may or may
not be accepted into the codebase, however, please describe the
status quo in the present tense.  "We behave this way", not "we used
to behave this way".  There is no need to say "Currently" (and it is
simply misleading to say "Previously").

> In particular, the following command on any commit history exercised the
> problem:
>
> git log --pretty=format:'%h%Cred%+d test' --graph
>
> The string 'test' should always be in red, but is not when commits have
> ref names associated and the %+d placeholder is expanded.
> This is also not a problem of any pager since the --graph option adds a
> colored pipe symbol at the beginning of the line, which makes re-setting
> the color again afterwards necessary.

Isn't it the problem with the "--graph" codepath, then?

It is unclear from the proposed log message why it is a good idea to
add the new behaviour to the code that handles "%+" unconditionally.
It also is unclear why the new behaviour to save only one "color
escape" is sufficient.  For example, if we used

    git log --pretty='format:%h%C(green)%C(reverse)%+d test' --graph

wouldn't the effects of these two add up?  Would it be sufficient to
remember the last one we saw and re-enable it?

Combining the above two together, it makes me wonder if the right
approach is instead to (1) stop resetting at the end of --graph, and
(2) instead "save" the attribute before starting to draw --graph,
draw the --graph in color, and then "restore" the attribute.

Whatever approach we decide to take to solve this issue, let's have
a test case or two added to the test suite to better document the
issue.

Thanks.
