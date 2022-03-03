Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911AEC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiCCAbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiCCAbm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:31:42 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B078D6A6
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:30:54 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D677717C828;
        Wed,  2 Mar 2022 19:30:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KinBu+s5ai+Wv8kHVE3OTX6r/XqaTgWbKmO308
        dJjwo=; b=rG32L87xAYRC40E65JtV+zhlXVwZZCtn2YYbDeycP/xMu1GIh+K+uy
        JfnScu88XUqbGxSwpf9Cqy61nhKgbF0M7h16DDDVBrh+Jcx0W4J1aHYNLfUMrg/i
        a8MglJnmta8zL8QUwAlA4JfXiBMPQT5RjydXirdPI+Wzv3hfOdhcw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF68117C827;
        Wed,  2 Mar 2022 19:30:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5629B17C826;
        Wed,  2 Mar 2022 19:30:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/7] fetch: increase test coverage of fetches
References: <cover.1645102965.git.ps@pks.im> <cover.1645430423.git.ps@pks.im>
        <081174b7a00cf094a7dacd8aba89fb137ea40f66.1645430423.git.ps@pks.im>
Date:   Wed, 02 Mar 2022 16:30:50 -0800
In-Reply-To: <081174b7a00cf094a7dacd8aba89fb137ea40f66.1645430423.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 21 Feb 2022 09:02:10 +0100")
Message-ID: <xmqqsfrzev2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DF239B2-9A89-11EC-8A37-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +test_expect_success 'backfill failure causes command to fail' '
> +	git init clone5 &&
> +
> +	write_script clone5/.git/hooks/reference-transaction <<-EOF &&
> +		while read oldrev newrev reference
> +		do
> +			if test "\$reference" = refs/tags/tag1
> +			then
> +				# Create a nested tag below the actual tag we
> +				# wanted to write, which causes a D/F conflict
> +				# later when we want to commit refs/tags/tag1.
> +				# We cannot just `exit 1` here given that this
> +				# would cause us to die immediately.
> +				git update-ref refs/tags/tag1/nested $B
> +				exit \$!
> +			fi
> +		done
> +	EOF

I think I've reviewed the previous round of these patches in
detail.  I by mistake sent a comment for this step in v2, but I
think the same puzzlement exists in this round, too.

