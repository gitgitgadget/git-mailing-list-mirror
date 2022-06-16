Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F2C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 21:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378627AbiFPVb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiFPVb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 17:31:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE58661298
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:31:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A4B418863A;
        Thu, 16 Jun 2022 17:31:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dov0gn15MeqdCm4vHZGPNFVyupz6lpQoYqNy4U
        0fHFY=; b=naV4dtKyz4xoiuIYWPpohsQln8j0t4rt3JIaug+5q+Y7iXHdNOxGJZ
        ig3NWLwOzQmBtEnal+6qo1IPqt05aPRb7uX36CwZ+Ysn5GxxsFzTIdc0dMQJ0+Il
        XjWAdk1Lirf8sygl17N0R0zyxVz+lJJYVCUfBy4M83gOjgR0Go+rU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3196E188639;
        Thu, 16 Jun 2022 17:31:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B457F188638;
        Thu, 16 Jun 2022 17:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 0/5] support negative refspecs in git remote show
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
Date:   Thu, 16 Jun 2022 14:31:50 -0700
In-Reply-To: <20220616205456.19081-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 16 Jun 2022 13:54:51 -0700")
Message-ID: <xmqqv8t0qoqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC6CDA82-EDBB-11EC-823E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> This series adds support for negative refspecs to git remote show, fixing an
> issue reported by Pavel Rappo.
>
> In addition, it includes some cleanup of the t5505-remote.sh test script,
> focusing on removing subshells and using test_config more.
>
> To support this, test_config and test_unconfig are extended to take and
> handle more options. The test_config_global is removed in favor of just
> using test_config --global.
>
> In addition, test_config now passes the value and --fixed-value into
> test_unconfig so that only the specific value is removed (rather than all
> keys of the name).
>
> The original v1 can be found here:
> https://lore.kernel.org/git/20220614003251.16765-1-jacob.e.keller@intel.com/
>
> If the config changes are too controversial, I'm happy to split them out
> into a separate series for further discussion, or drop them if they aren't
> desirable.

I did not see anything in 5/5 that substantially depends on all the
code churn done in 1/5-4/5.  Am I mistaken?

It would have been much nicer to organize the patch series so that
the first one is the [v2 5/5].  It may not be able to use the
improved test_config, but writing test_when_finished instead would
not be the end of the world.  The three-line test body will still be
three lines.  Then test_when_finished will have to be updated in
follow-up patches that corresponds to [v2 1/5]-[v2 4/5], but that is
the cost of "clean up".  The main "fix" patch shouldn't be the one
that is paying the price for it.

The clean-up offered by [v2 1/5] is a worthwhile thing to do.  It's
just that I do not think it is wise to make the fix in [v2 5/5] wait
for the 1.4k lines patch to be adequately reviewed.

Retiring "test_config_global" in [v2 2/5] is probably a good change,
especially when we are to add more featurs to test_config.  Again,
[v2 5/5] shouldn't have to be made waiting on an extra 800-line patch
to be reviewed.
