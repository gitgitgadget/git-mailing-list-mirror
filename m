Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78621C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 22:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiCBWnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCBWnT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 17:43:19 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950D1CD4
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 14:42:35 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0109F181F5F;
        Wed,  2 Mar 2022 17:42:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MrslZUkBQbY+RCAjRS/3Y860Q/OQG/JZnLHVvL
        r7Y20=; b=i6S7T3Pc29L3AmqRBQTAch2IOnJQOMwPlDCd0W9d46lG6os8ye4A68
        AvOmfyqhJvJStqnCt/CjsHkI1Sl9gbpaVh1xxH3VlnxG24HBaVIi8+mSq9/S2mgI
        9BWECqMPNv4AyPSvBE3WxoBC5uvG+V0fXi75gJN0j7bjhOOGKxkJg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDDF6181F5D;
        Wed,  2 Mar 2022 17:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54EE2181F5B;
        Wed,  2 Mar 2022 17:42:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
References: <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
        <YhzkdMxrIGlNutr6@ncase>
        <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
        <Yhz/hsDDGNVjt64R@xps>
        <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
        <Yh3rZX6cJpkHmRZc@ncase> <Yh325v3RBDMxjFnD@ncase>
        <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com>
        <Yh4zehdSnHLW1HuK@ncase>
        <1b9912f7-87be-2520-bb53-9e23529ad233@github.com>
        <Yh93vOkt2DkrGPh2@ncase>
        <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com>
        <xmqqh78gmdap.fsf@gitster.g>
        <1651a34e-38c1-fb8a-df59-1dcd8a8389b5@github.com>
Date:   Wed, 02 Mar 2022 14:42:30 -0800
In-Reply-To: <1651a34e-38c1-fb8a-df59-1dcd8a8389b5@github.com> (Derrick
        Stolee's message of "Wed, 2 Mar 2022 13:46:43 -0500")
Message-ID: <xmqqo82ogend.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BA40C50-9A7A-11EC-B3BD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> I am wondering if there is some notion of "if you do not understand
>> what this chunk is, you are incapable of handling this file
>> correctly, so do not use it" kind of bit per chunks (similar to the
>> index extensions where ones that begin with [A-Z] are optional) that
>> may negatively affect this plan.
>
> The chunk IDs do not have this special casing rule. This is a
> bit unfortunate for certain cases like adding something that _must_
> be understood. Here, it works to our benefit that GDAT and GDOV are
> optional and can be safely ignored. Thus, clients with this patch
> will ignore GDAT and GDOV and continue using topological levels
> form the CDAT chunk. Older clients without this patch will ignore
> the new GDA2 and GDO2 chunks and continue using topological levels.
>
> For Git versions without this topic branch, this "continue using
> topological levels" means no change of behavior at all.

Excellent.  Thanks.
