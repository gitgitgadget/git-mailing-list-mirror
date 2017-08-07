Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86E72047F
	for <e@80x24.org>; Mon,  7 Aug 2017 20:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdHGU70 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 16:59:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50246 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751662AbdHGU7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 16:59:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADDD7A4D13;
        Mon,  7 Aug 2017 16:59:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IkuDwQzByrl42avxlXj1RrzH4sU=; b=q07nZV
        AawolgrI+acw+zlD7r7QHO/oGA0t7gwztwOwRxNlSDOxl3UL/CvWBn2jtoHf+5yj
        zH5rV/+Slt2M04o29MQ7jjfAA7wd0j44lsFXJuerxWAk81/yq3Rdzvnns13lGyZa
        LQU0OadHRCqU6lLaGD8O5VdJUZe4zFrIbEblc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OcAN3ZyCJEgvLp4P7MbVjHDHJizV13gO
        1pkuka9vGTl0D3QgP7nsOUP3kRElnKE2w2T0TE8Dwgr2zNOMkBqard2bsD3zpu2R
        Djz/Wfdn/ccXSGdMe12DGeML64xsVFgOznPGC8UpWaBLi7bPLX4ZLbdxXEILvnzo
        db0wiD7l19U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6C1AA4D12;
        Mon,  7 Aug 2017 16:59:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E742A4D11;
        Mon,  7 Aug 2017 16:59:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Can the '--set-upstream' option of branch be removed ?
References: <xmqq1sp2q1cc.fsf@gitster.mtv.corp.google.com>
        <20170807143938.5127-1-kaarticsivaraam91196@gmail.com>
Date:   Mon, 07 Aug 2017 13:59:22 -0700
In-Reply-To: <20170807143938.5127-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 7 Aug 2017 20:09:36 +0530")
Message-ID: <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4ABD8172-7BB3-11E7-A827-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> I refactored builtin/branch.c to remove the '--set-upstream'
> option,successfully. The corresponding patch follows. 
>
> There's just one issue with the version of git that doesn't
> have the '--set-upstream' option. It's described in the commit
> log message of the following patch.

which is...

> Note that, 'git branch' still *accepts* '--set-upstream' as a consequence
> of "unique prefix can be abbrievated in option names". '--set-upstream'
> is a unique prefix of '--set-upstream-to' after '--set-upstream' has
> been removed.

... this.

Thanks for spotting the issue.  

I think in the longer term we still want to remove --set-upstream as
many people seem to say that its behaviour has been uttering
confusing to them and that is why we keep giving the warning any
time it is used.

> I guess it would be difficult to detect the removal of the option in
> case it's used in scripts and might cause confusion to users?

If we want to follow through the transition, because of the issue
you spotted, we'd need one extra step to make sure users won't be
hurt before removal: we would need to still recognize --set-upstream
as an option distinct from --set-upstream-to, and actively fail the
request, telling them that the former option no longer is supported.

Then after waiting for a few years, we may be able to re-introduce
the "--set-upstream" option that takes the arguments in the same
order as "--set-upstream-to", which would be the ideal endgame
(assuming that the reason why we started deprecating "--set-upstream"
and encouraged users to use "--set-upstream-to" still holds).

