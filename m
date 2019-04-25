Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B451F453
	for <e@80x24.org>; Thu, 25 Apr 2019 05:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfDYF33 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 01:29:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52814 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYF32 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 01:29:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 969731494B6;
        Thu, 25 Apr 2019 01:29:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xYUJJ5kzJUJfis3hEkma+w+hC3M=; b=FlIU91
        VJCJOGN/ue3X47Lymsfq10VtJu1gjF8tb1REnLSbNVSKICu+E2rMeUZD3Rd3xE86
        KX7DoR7Weq4r+XhHFmL3jD5YF/MSUdKkMDtC5hvS84hzWMoNG/EfR+CgyCAW/Y1z
        0SXrlzEI8lTXhb3AyWNPuyS3ObBXeuiq04L9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K9NdcL6gpy+i1uhnlzo3s+iHQD75Jnsn
        bKTtQlNrc9QSMfsabW8X26mY0/EcLOuB2RHIHBJErnCN7gQI8c1O8/Vp9ulInbMD
        OVMPkKXKijnXbsoKcBwOiUvO6RlnxSlSo+2KVbkKSaBvnZgVACBDQQP4Jvx1YP6w
        kOpDZEGFCTg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DC651494B5;
        Thu, 25 Apr 2019 01:29:26 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD8DB1494B4;
        Thu, 25 Apr 2019 01:29:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 3/5] commit-graph: create new version flags
References: <pull.112.git.gitgitgadget@gmail.com>
        <pull.112.v2.git.gitgitgadget@gmail.com>
        <4ddb82916321f093d88282ef4bcab99993339fb5.1556135881.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Apr 2019 14:29:24 +0900
In-Reply-To: <4ddb82916321f093d88282ef4bcab99993339fb5.1556135881.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 24 Apr 2019
        12:58:05 -0700 (PDT)")
Message-ID: <xmqqftq6y7nv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1701ACF0-671B-11E9-9597-DF19F34BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	int version = 0;
> ...
> +	if (flags & COMMIT_GRAPH_VERSION_1)
> +		version = 1;
> +	if (!version)
> +		version = 1;
> +	if (version != 1) {
> +		error(_("unsupported commit-graph version %d"),
> +		      version);
> +		return 1;
> +	}

The above sequence had a certain "Huh?" factor before 5/5 introduced
the support for a later version that is in use by default.

Is it sensible to define VERSION_$N as if they are independent bits
in a single flags variable?  What does it mean for the flags variable
to have both GRAPH_VERSION_1 and GRAPH_VERSION_2 bits set?

What I am getting at is if this is better done as a n-bit bitfield
that represents a small unsigned integer (e.g. "unsigned char" that
lets you play with up to 255 versions, or "unsigned version : 3"
that limits you to up to 7 versions).

You use an 8-bit byte in the file format anyway, so it might not be
so bad to have a separate version parameter that is not mixed with
the flag bits, perhaps?
