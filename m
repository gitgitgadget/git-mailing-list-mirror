Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B6DC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 20:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532B1613C0
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 20:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhFAUqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 16:46:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56357 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAUqf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 16:46:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47D72C6EF2;
        Tue,  1 Jun 2021 16:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=XL3aihqW6J2AfCgMMM3mQT6Hist1F4DUYPxakJ4acW4=; b=H0gf
        DRR+0jJpFwXA0OHkq1wCwIbjVR5A/bxJkgEC3ueKkIX8TxfC4cA8uBsL3IAlpypT
        pmzjPbV1mJWnrgOjKwB1QXkJjcNrvEom60PPpFuiLCgB0TGbrpb7r21qDaXxJJjC
        h1ke2HDgdPseDKkEz0AehphJCv4no7SoeHWEGks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E989C6EF1;
        Tue,  1 Jun 2021 16:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B90E0C6EF0;
        Tue,  1 Jun 2021 16:44:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 07/22] t1413: use tar to save and restore entire .git
 directory
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
        <f6ab40c4e6599540da38ae5af8e574dc65909e79.1622480197.git.gitgitgadget@gmail.com>
        <51a802ff-0789-4051-6d45-5b9c6e55ba8a@gmail.com>
        <CAFQ2z_O2t2cDvTs0aNqB+9FVSy51CKrJxxdvu9WGg1s6gZziHw@mail.gmail.com>
Date:   Wed, 02 Jun 2021 05:44:51 +0900
Message-ID: <xmqqeedls4ak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3735920E-C31A-11EB-88BE-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Tue, Jun 1, 2021 at 6:55 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On 31/05/21 23.56, Han-Wen Nienhuys via GitGitGadget wrote:
>> > diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
>> > index bde05208ae6a..934688a1ee82 100755
>> > --- a/t/t1413-reflog-detach.sh
>> > +++ b/t/t1413-reflog-detach.sh
>> > @@ -7,8 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> >   . ./test-lib.sh
>> >
>> >   reset_state () {
>> > -     git checkout main &&
>> > -     cp saved_reflog .git/logs/HEAD
>> > +     rm -rf .git && "$TAR" xf .git-saved.tar
>> >   }
>> >
>>
>> Why do you do rm -rf git directory then extract tar archive to reset?
>
> I'm not sure I understand your question. Are you asking why we have to
> do a reset, or why we'd use rm + tar? The rm + tar restores the former
> state reliably, so we can be sure it is correct. It's also independent
> of the storage format details.

I think a short answer is "without rm -rf .git, a stale file in that
directory will stay there when .git-saved.tar gets extracted", but
the whole arrangement makes me worried what would happen if somebody
manages to interrupt "rm -rf" without killing the whole test
framework (or letting the when-finished handlers run).  The test
framework thinks it is working in a throw-away repository but the
$TRASH_DIRECTORY that was supposed to be removed and extracted but
failed to do so due to interruption in the middle may not look like
a git repository, in which case it may try to do the usual repository
discovery and trash the git project repository instead.
