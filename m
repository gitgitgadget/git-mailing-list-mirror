Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B3DC433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 17:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbiERRVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 13:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbiERRVo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 13:21:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C50A719CE
        for <git@vger.kernel.org>; Wed, 18 May 2022 10:21:43 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E833213E507;
        Wed, 18 May 2022 13:21:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hPBwB8iiQ81/8OcAkR6c9znZ63BDbRdI5JQ45a
        2dMTo=; b=ewez8cmXt3zhH9fp8+C7NmRIlFe2aQWDSw2LX86zzN5ACsyYsj6oNY
        S1ANua57bUnlHXc8KrH5zp0DDoGMTbC3Hzr0q+KPavLjUFf0BXo9f/bfV2T+E8OA
        1gjStIgXiIgDTM56K82JW5xOLWRkQpfaQUII4Jo5IJqDCaOmMK5uM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEEB813E506;
        Wed, 18 May 2022 13:21:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5542E13E505;
        Wed, 18 May 2022 13:21:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Perhaps we want {diff,log,format}.noprefix and friends?
References: <20220510220821.1481801-1-tbodt@google.com>
        <0fc70bd3-5883-47e4-1814-6ed6c756a400@gmail.com>
        <CAN0heSper1O2ZdFq6RE=7znC0o+sFEsd8CBR3ckFtSoZu7Bzfw@mail.gmail.com>
        <CAN3rvwBWBPLB+Pm14S5Nb9LOV6ajhT8qMbwi5bBm1pK_8AgN5g@mail.gmail.com>
Date:   Wed, 18 May 2022 10:21:40 -0700
In-Reply-To: <CAN3rvwBWBPLB+Pm14S5Nb9LOV6ajhT8qMbwi5bBm1pK_8AgN5g@mail.gmail.com>
        (Theodore Dubois's message of "Tue, 17 May 2022 10:02:36 -0700")
Message-ID: <xmqqh75mwycb.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB8E684C-D6CE-11EC-A106-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>   git -c diff.noprefix=no format-patch ...
>>
>> to cancel the config. (If that config really does want to be on, that
>> is.)
>>
>> That said, something like
>>
>>   git am -p0 ...
>>
>> should help on the receiving side, by way of skipping fewer path
>> components when applying the patch.

While it is very reasonable for end-users to make the output of
their local "git diff" output to their taste by setting the
diff.noprefix and other configuration options in the diff.*
namespace, it is wrong to inflict such a personal preference on
other project participants by sending such a no-prefix patch via
"git format-patch", when the convention at the receiving project is
to use "git am -p1" to accept them.

We would need to tweak the configuration system so that we can more
easily introduce "format.noprefix" that overrides "diff.noprefix"
only when the command being run is "git format-patch", perhaps?  

As things stand, we could teach builtin/log.c::git_format_config()
about "format.noprefix" and make "git format-patch" pay attention to
that in addition to "diff.noprefix" fairly easily, but such an
approach poorly scales.  When a new configuration gets introduced in
diff.c::git_diff_ui_config(), builtin/log.c::git_format_config()
would also need to be updated.

I initially started writing this with "left over bits" mark, but it
seems it is a bit larger in scope than that.

I also noticed that some format.* configuration variables are parsed
in git_log_config(), not git_format_config(), so "git log" would end
up honoring format.pretty and format.subjectprefix, etc., which look
wrong but probably is way too late to "fix".


