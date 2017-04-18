Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D699C1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 02:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757134AbdDRC4w (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 22:56:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51755 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753810AbdDRC4v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 22:56:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CA3774144;
        Mon, 17 Apr 2017 22:56:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2KdtkgIzHb4xa9vxUcseJfp7yIQ=; b=PvUffv
        2NYQEn9PMawrFcYW608TD0dKxzkGO+OnURBJYimO5k4Pmzzkg4JTi+h1bW0wo+cL
        O9+BV8pxV2nkHcna+oflro+BZYH7hS5g5dv9JZIqA8RYSD+F93H6uGCPS4+2XvMC
        zqggfGyApjvPga3YFqRnBFTLzBMv6FCkOTrao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lkMi2cXpoQq0tKciy6tpYYoc+7K46ucv
        UUCFtPT8Pt1IT/O4fK+r1TUmFAap7BZcBQiLxFpD5X3KVqfyxckfU/isIXgKFuUj
        vn36KDt2e0wZ5uhdx0uE8A0Syjrj+ZuibZBSu6cIzdkCEYu5M57LRM4sqyO2wr9Q
        YbmDjGMi8lQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 139EA74143;
        Mon, 17 Apr 2017 22:56:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08C0C74142;
        Mon, 17 Apr 2017 22:56:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        bert.wesarg@googlemail.com
Subject: Re: [PATCH v2 2/3] config: handle conditional include when $GIT_DIR is not set up
References: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
        <20170417101002.18272-1-pclouds@gmail.com>
        <20170417101002.18272-2-pclouds@gmail.com>
        <xmqq7f2ih1l1.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 17 Apr 2017 19:56:47 -0700
In-Reply-To: <xmqq7f2ih1l1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 17 Apr 2017 19:49:30 -0700")
Message-ID: <xmqqzifefmog.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAA38AA6-23E2-11E7-9CF2-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	if (!have_git_dir() && opts.git_dir) {
>>  		struct git_config_source repo_config;
>>  
>>  		memset(&repo_config, 0, sizeof(repo_config));
>
> But this one I do not quite understand.  When have_git_dir() was
> false and asked discover_git_directory() to set opts.git_dir, we
> enter the body of this block and then end up doing
>
> 	git_config_with_options(cb, data &repo_config, &opts);
>
> with repo_config set to the discovered git directory plus "/config";
> we'd read the repository configuration twice, in other words.

Ahh, nevermind.  The fix to make the "usual sequence" pay attention
to the opts->git_dir comes in 3/3 and in that step this redundant
reading is also removed, so all is well at the end.

Thanks.
