Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68114C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393C2238A1
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgLGToC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:44:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57891 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgLGToC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:44:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E00911CFE1;
        Mon,  7 Dec 2020 14:43:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a10dh5EcWhyZsBghmj4Z9M/9ddU=; b=iuVdO2
        yaaECk3P/NDNliwVS3sgF9G7hyi7pgwMvMGg+ouR0etbtmBI5r0hWs66nsIVEOBf
        zSfvdWyXiU0MtPWgdjMB45OwGopx47TkJjN+Uzi+Zb5V5xWJ0o+ry+v/qP70eOdz
        fk2s/6CpmXb25atEYuZiDCiYrHfYwUs7soag0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cs3CtFLWrD9l8XwG05WRh36hbZpl+qw/
        7vF0lDFmZMmlYyHS6vnXPu94p9tSOGmj1kxOa+Qf7fZ41O/idBVGHmj3PEMFYVnl
        SlT7Zf6akciLVafcNTXTNEKj7vf5se35wK4cQBjEQwuyhmbgVUWyBZIUaj7tIXMq
        iQumEqMAwS0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9752411CFE0;
        Mon,  7 Dec 2020 14:43:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DD18B11CFDF;
        Mon,  7 Dec 2020 14:43:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v2] submodules: fix of regression on fetching of
 non-init subsub-repo
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
        <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
        <613FAD04-0D5A-4DE0-8FE8-0C5C5619B7BC@gmail.com>
Date:   Mon, 07 Dec 2020 11:43:13 -0800
In-Reply-To: <613FAD04-0D5A-4DE0-8FE8-0C5C5619B7BC@gmail.com> (Philippe
        Blain's message of "Mon, 7 Dec 2020 13:42:08 -0500")
Message-ID: <xmqqpn3l9zce.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7269937E-38C4-11EB-A33B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Maybe a personal preference, but I would have gone for something a
> little simpler, like the following:
>
> diff --git a/submodule.c b/submodule.c
> index b3bb59f066..4200865174 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1486,7 +1486,7 @@ static int get_next_submodule(struct child_process *cp,
>                          * the submodule is not initialized
>                          */
>                         if (S_ISGITLINK(ce->ce_mode) &&
> -                           !is_empty_dir(ce->name)) {
> +                           !is_empty_dir(repo_worktree_path(spf->r, "%s", ce->name))) {

But then you leak the return value from repo_worktree_path(), no?

>> +test_expect_success 'recursive fetch with uninit submodule' '
>> +	# depends on previous test for setup
>> +
>> +	git -C main submodule deinit -f sub &&
>
> Here you are deiniting the submodule, such that 
> the Git directory will stay in .git/modules/sub. This is not the same thing
> as a submodule that was never initialized ("uninitialized"), for which .git/modules/sub
> will not yet exist. So maybe we could harden the tests by also testing
> for that scenario ? I don't know... maybe the infinite loop only happens
> if .git/modules/sub actually already exists. If so, the test name should be
> "recursive fetch with deinitialized submodule", I think.

Even if the original breakage happens only for deinitialized case,
it would be sensible to test uninitialized one as well, I would
think.

> Thanks for working on that, and sorry for not having the time to comment before
> you sent v2.

Thanks, all.  

It's not like we corral everybody to a single place on a single day
to work on a single thing.  Reviews ov v2 by reviewers who have not
seen v1 is totally expected and very much appreciated.
