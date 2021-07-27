Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B650C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 20:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2099060D07
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 20:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhG0Uol (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:44:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51633 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhG0Uol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 16:44:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82CE21416B7;
        Tue, 27 Jul 2021 16:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xOG483vNjDsg/HR8YHiB0vcfCI+GxlO14GkoDY
        YEeRM=; b=eVkdKz7uYvvyL7yKx5ixAcZgHRZJdu05GMzsQFBKiTUluAyAQRLUJW
        VgYglACiwhcTvf9b+Y3K3lkqCkpXmx8lv+95hlT0v4zuR7Mm1rNpjo3ema9ZnJmh
        jpPdJOV2qocHMJgoitvc9UwGotinP6C4F1IybiJVuQb+jRKmF/3PA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B2901416B4;
        Tue, 27 Jul 2021 16:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C29381416B3;
        Tue, 27 Jul 2021 16:44:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
        <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com>
        <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
Date:   Tue, 27 Jul 2021 13:44:36 -0700
In-Reply-To: <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com> (Phillip Wood's
        message of "Tue, 27 Jul 2021 20:43:35 +0100")
Message-ID: <xmqq1r7jebbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 756CA0C6-EF1B-11EB-88A7-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> This will break git-rebase--preserve-merges.sh which uses
> GIT_CHERRY_PICK_HELP to set the help and ensure CHERRY_PICK_HEAD is 
> removed when picking commits.

Ahh, I didn't realize we still had scripted rebase backends that
called cherry-pick as an executable.  I was hoping that all rebase
backends by now would be calling into the cherry-pick machinery
directly, bypassing cmd_cherry_pick(), and that was why I suggested
to catch stray one the end-users set manually in the environment
and clear it there.

> I'm a bit confused as to what the
> problem is - how is 'git cherry-pick' being run with
> GIT_CHERRY_PICK_HELP set in the environment outside of a rebase (your
> explanation in [1] does not mention how GIT_CHERRY_PICK_HELP is set)?

I didn't press for the information too hard, but I guessed that it
was perhaps because somebody like stackoverflow suggested to set a
message in their environment to get a "better message."
