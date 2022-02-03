Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BB1C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 22:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355673AbiBCWHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 17:07:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53273 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiBCWHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 17:07:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64F88111311;
        Thu,  3 Feb 2022 17:07:08 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=02uvMDQ2Hdu+eOmCRG0bu6LB8/NP0y0kE+lWtyO
        tS3U=; b=GVXWiSB5c35J9hJ8kplFHvwx/fu+9fiyfA/9qzULijQg3WyqCLhn848
        /pjnqtt4BuvfgX4v0Ns5k4fR9a/luINl4KiCKBRyVlTe1+z+AkwVefXPuSGRRZez
        DHwSsLpLH7UujU0qJ8rO781vWVefT/yyfxFzRmzL4fZ0vSaE0wW4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58DB0111310;
        Thu,  3 Feb 2022 17:07:08 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A189811130F;
        Thu,  3 Feb 2022 17:07:07 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 3 Feb 2022 17:07:05 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
Message-ID: <YfxSCbmatoSZlTwB@pobox.com>
References: <20220203123724.47529-1-fs@gigacodes.de>
 <Yfw0kapgSSWO3Pyx@pobox.com>
 <xmqqsfszr5q6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsfszr5q6.fsf@gitster.g>
X-Pobox-Relay-ID: A0B54702-853D-11EC-A463-CB998F0A682E-09356542!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>>     -	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
>>     +	string_list_split_in_place(&lines, gpg_status.buf, '\n', -1);
>>     +	ret |= !unsorted_string_list_has_string(&lines, "[GNUPG:] SIG_CREATED ");
> 
> Is "SIG_CREATED " supposed to be at the end of that line?  I thought
> that has_string() asks for an exact match, and unfortunately(?)
> there is not the string_list_has_string_that_has_this_prefix()
> function.  So...

By default, yes.  The string_list struct uses strcmp() if no
cmp function is given.  That's why the previous chunk has:

    struct string_list lines = { .cmp = starts_with };

There aren't any similar uses in the code, which is just one
of the reasons I wasn't confident that it was a good idea or
even a good implementation.

-- 
Todd
