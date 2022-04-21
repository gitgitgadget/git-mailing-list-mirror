Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BF5C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382681AbiDUUbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241544AbiDUUbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:31:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12454DF5E
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:28:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CD4E1292B4;
        Thu, 21 Apr 2022 16:28:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/uocEixtN5j1eu38iuLTOESUrmAWFZ4aLwGtFC
        2y4O8=; b=qUQIxdOBpY6avU3UON9YsV53pm48fjXmbh2SUqCKhcdj6atHmhJmHX
        pEy2rsVx+FGtiG8+WxCH3x/Bl8W5qrl5jJBDRdv1ea/gwx2CI9wu79q9XI1nYePr
        7QKpfA/W0HzvjbqcfjHXK5aBc1/rymTTEpo/AhxcmNjt10jB0IyG8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43C0C1292B3;
        Thu, 21 Apr 2022 16:28:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A135B1292B2;
        Thu, 21 Apr 2022 16:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/2] multi-pack-index: use --object-dir real path
References: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
        <0435406e2db6c5977928a2b0b0b79e66c0a078ee.1650553069.git.gitgitgadget@gmail.com>
        <936e7f12-362d-3303-ddf4-5b40f17a0b9e@github.com>
Date:   Thu, 21 Apr 2022 13:28:56 -0700
In-Reply-To: <936e7f12-362d-3303-ddf4-5b40f17a0b9e@github.com> (Victoria Dye's
        message of "Thu, 21 Apr 2022 12:50:51 -0700")
Message-ID: <xmqqy1zyfaev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABC43FA8-C1B1-11EC-9432-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> +static void normalize_object_dir(void)
>> +{
>> +	if (!opts.object_dir)
>> +		opts.object_dir = get_object_directory();
>> +	else
>> +		opts.object_dir = real_pathdup(opts.object_dir, 1);
>> +}
>> +
>
> Rather than copy the 'normalize_object_dir()' calls to every subcommand, you
> could "centralize" this by making the 'object_dir' option an 'OPT_CALLBACK'
> option, something like:
>
> static struct option common_opts[] = {
> 	OPT_CALLBACK(0, "object-dir", &opts.object_dir, N_("file"),
> 		     N_("object directory containing set of packfile and pack-index pairs"),
> 		     normalize_object_dir),
> 	OPT_END(),
> };
>
> It would require changing the function signature of 'normalize_object_dir'
> to match what's shown in 'Documentation/technical/api-parse-options.txt',
> and it potentially needs prefix handling similar to what's done in
> parse-options.c:get_value() (which internally calls 'fix_filename()' for
> filename opts), but I think it's probably worth reducing duplication here
> and avoiding the need to add 'normalize_object_dir()' to any new subcommand
> in the future.

Good suggestion.  Thanks, both, for taking care of this.

Are there other places that we take end-user input and treat it as a
pathname without necessary normalization, I wonder.  The codepath
fixed by this series is relatively new, and I am not surprised such
a bug was still there and hopefully it was an isolated remaining bug.
