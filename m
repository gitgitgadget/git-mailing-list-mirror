Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7B9C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A383E221FE
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 18:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oDTRKznc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgJHS3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:29:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63819 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJHS3k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 14:29:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9882FA88E;
        Thu,  8 Oct 2020 14:29:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ACuTGxkYk9xTQMWpNgIjKT3nTBI=; b=oDTRKz
        ncS77h3bU3xL0VuzZ9En0zuTEHSpvaISuN/uup1T5w3+mIzAvBoz+TbWJmrIaql3
        KNbG05irAhq/NiHCZF0CIWXk65Wds1OqkN9+52UOt7gaF7zNNmp6EB7GrMCgQWlJ
        6yEJCKM0qPJuVo1vfjPmFEf0EuVVPBHCiAbGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G4i6blhlXl5CPCt9Qi3BHXDi1O9E0Kf0
        n5nu7a2wqs0sZH9YZB8zpc+28LTqm8CPwsFbL1edCC2JY16TOm6gJVvMERHmWa+G
        ZZWMPjwO58kOn2485YaC88WwQO3mI7tS+TuSOaQjh1438BN2oJHz7jlUuiPvT7c1
        jdaLGsMTSIM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A137EFA88D;
        Thu,  8 Oct 2020 14:29:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E3916FA88A;
        Thu,  8 Oct 2020 14:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] contrib/git-resurrect.sh: use hash-agnostic OID
 pattern
References: <cover.1602139448.git.liu.denton@gmail.com>
        <6fad1fc7fdad98c3dda1ec334a10a6a9e311fef8.1602139448.git.liu.denton@gmail.com>
        <20201008161345.GD2823778@coredump.intra.peff.net>
Date:   Thu, 08 Oct 2020 11:29:34 -0700
In-Reply-To: <20201008161345.GD2823778@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 8 Oct 2020 12:13:45 -0400")
Message-ID: <xmqqwo00woz5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37B6772E-0994-11EB-9D62-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 07, 2020 at 11:44:40PM -0700, Denton Liu wrote:
>
>> diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
>> index 57a77c03f9..d843df3afd 100755
>> --- a/contrib/git-resurrect.sh
>> +++ b/contrib/git-resurrect.sh
>> @@ -37,19 +37,18 @@ search_reflog_merges () {
>>  	)
>>  }
>>  
>> -_x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
>> -_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>> +oid_pattern=$(git hash-object --stdin </dev/null | sed -e 's/./[0-9a-f]/g')
> ...
> in both cases we are matching output we asked for, so we really matching
> [0-9a-f]\+ would be correct and sufficient. That's a little simpler. I
> don't feel too strongly either way, though.

Yes.  I think use of _x40 is overrated.

>   Side note: It's a shame that there is no way to convince rev-list not
>   to print the "commit ..." header, which is really what we're avoiding
>   here. We probably should have suppressed it with user-formats when
>   they were introduced, but it's too late to make that change. I wonder
>   if it would be worth adding a command-line option, though. I've often
>   had to hack around this when parsing rev-list output (and sometimes
>   even resort to using git-log if it's a one-off).

Or make "git log" without frills as fast as rev-list, perhaps?

What extra things do we do that makes "log" inherently slower than
"rev-list"?

I do not mind a new option (e.g. --no-header) to "rev-list", though.

Thanks.

