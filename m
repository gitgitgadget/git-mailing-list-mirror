Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02DAC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656BE2177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GkxaPe5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgH0PbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:31:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60821 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0PbI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:31:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4492AEF0A6;
        Thu, 27 Aug 2020 11:31:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UkqwrIpGfbwWJUYPv4Tj1eDQFog=; b=GkxaPe
        5lpbPf1FLK87nleuehQx8Dxv5Pc2S3cdCSA5Ktlnsu1bdBA33Quk7wBIMLqyYdLb
        DZgUX5pUeQzdIIr5fnRS81LaJ9+psJ58Hyo9rbFZ+F+brlvpM+n/+Ue1VPBxZhG2
        BHoou8guZ2Y2Y2E112VMup/lz605UnORwShm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xqqRTFKkITDJDa4F1l9U8WxqoGkVhzug
        hNEWE5ZmxpxBhd1YQzI86Gd5jiOhBgU9QlQKRcHBVSuJpq4ZMvduyXD5lch4N3tR
        MIhHlbUMuqOeF7ZoyLEZAkLn+iA63FQPRdS7ZsRmdYi5bxOzoRX5LyavsNQ3IoDK
        yegYAoP8zQY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D4B5EF0A5;
        Thu, 27 Aug 2020 11:31:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F584EF09D;
        Thu, 27 Aug 2020 11:31:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] worktree: fix leak in check_clean_worktree()
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
        <20200826194650.4031087-1-gitster@pobox.com>
        <20200826194650.4031087-3-gitster@pobox.com>
        <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
        <xmqqmu2ht58g.fsf_-_@gitster.c.googlers.com>
        <20200827042157.GC3346457@coredump.intra.peff.net>
        <CAPig+cS1uMw6YDVjzb8FbBmC=iVjged-wHu0LF2+trmW-4ZfVw@mail.gmail.com>
        <20200827044420.GA3360616@coredump.intra.peff.net>
        <CAPig+cSA56xgNN0WP4t+YoyNU8fGf5eaz__=4Vh+s=He-tG=DA@mail.gmail.com>
        <20200827052504.GA3360984@coredump.intra.peff.net>
        <CAPig+cQxvq3MzyB3e8-ZeVSdCot04=9p4L8CZRnpYbrmnR70_g@mail.gmail.com>
Date:   Thu, 27 Aug 2020 08:31:01 -0700
In-Reply-To: <CAPig+cQxvq3MzyB3e8-ZeVSdCot04=9p4L8CZRnpYbrmnR70_g@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 27 Aug 2020 01:56:47 -0400")
Message-ID: <xmqq8se0rtqi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51131D2A-E87A-11EA-81D6-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Agreed. The current usage in worktree.c is a bit too familiar with the
> current internal implementation of run_command(). Reinitializing the
> child_process struct or using a separate one would be a good cleanup.
>
>> -- >8 --
>> Subject: [PATCH] worktree: fix leak in check_clean_worktree()
>>
>> We allocate a child_env strvec but never free its memory. Instead, let's
>> just use the strvec that our child_process struct provides, which is
>> cleaned up automatically when we run the command.
>>
>> And while we're moving the initialization of the child_process around,
>> let's switch it to use the official init function (zero-initializing it
>> works OK, since strvec is happy enough with that, but it sets a bad
>> example).
>
> The various memset()'s in worktree.c seem to have been inherited (and
> multiplied) from Duy's original "git checkout --to" implementation
> (which later became the basis for "git worktree add" after which it
> mutated significantly), and "git checkout --to" predates introduction
> of child_process_init().
>
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -924,7 +924,6 @@ static int move_worktree(int ac, const char **av, const char *prefix)
>> -       struct strvec child_env = STRVEC_INIT;
>> @@ -935,15 +934,14 @@ static void check_clean_worktree(struct worktree *wt,
>> -       strvec_pushf(&child_env, "%s=%s/.git",
>> +       child_process_init(&cp);
>> +       strvec_pushf(&cp.env_array, "%s=%s/.git",
>>                      GIT_DIR_ENVIRONMENT, wt->path);
>> -       strvec_pushf(&child_env, "%s=%s",
>> +       strvec_pushf(&cp.env_array, "%s=%s",
>>                      GIT_WORK_TREE_ENVIRONMENT, wt->path);
>> -       memset(&cp, 0, sizeof(cp));
>> -       cp.env = child_env.v;
>
> Looks good to me. For what it's worth:
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Thanks, both.  This looks good.
