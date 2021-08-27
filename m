Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197C9C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 17:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15C360F44
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 17:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhH0R3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 13:29:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57028 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhH0R3o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 13:29:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BBB615DA2D;
        Fri, 27 Aug 2021 13:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wcEwcO0BWp9O
        bpF7NfoeoX8FsNIuNpHmwNWGyh2Edbg=; b=Wf9lyOfFfYXCfLUsLjyugFDbWlNj
        pVKOzVWgw1+H2TqjbsIiHuhVEFW9I8smxTmWoMGbz0kZdKdoMD/+qz7ph6Ce6Cfe
        P9Ef+EV/gZqZiAprUL4lXuqjrlVp2+ecX+F9YdOE1I5Izri2Bo58PdewfTHz8JI9
        j5BK9yi0apga4Jk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6484B15DA2C;
        Fri, 27 Aug 2021 13:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9ADB215DA2B;
        Fri, 27 Aug 2021 13:28:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Mugdha Pattnaik via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, mugdha <mugdhapattnaik@gmail.com>
Subject: Re: [PATCH v2] submodule: absorb git dir instead of dying on deinit
References: <pull.1078.git.git.1630002794889.gitgitgadget@gmail.com>
        <pull.1078.v2.git.git.1630044219145.gitgitgadget@gmail.com>
        <m28s0nc8gv.fsf@gmail.com>
Date:   Fri, 27 Aug 2021 10:28:51 -0700
In-Reply-To: <m28s0nc8gv.fsf@gmail.com> (Atharva Raykar's message of "Fri, 27
        Aug 2021 18:50:23 +0530")
Message-ID: <xmqqsfyuajak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F90FBEC-075C-11EC-BC1F-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> "Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: mugdha <mugdhapattnaik@gmail.com>
>>
>> Currently, running 'git submodule deinit' on repos where the
>> submodule's '.git' is a folder aborts with a message that is not
>> exactly user friendly. Let's change this to instead warn the user
>> to rerun the command with '--force'.
>
> This makes sense, a lot of commands seem to follow this pattern of
> requiring a user to '--force' when the behaviour might not be different
> from what is normally expected.
>
>> This internally calls 'absorb_git_dir_into_superproject()', which
>> moves the '.git' folder into the superproject and replaces it with
>> a '.git' file. The rest of the deinit function can operate as it
>> already does with new-style submodules.
>
> Nice. Just like what the NEEDSWORK comment suggested.

Indeed.  Many use of the word "folder", especially when the thing is
called "git dir" in the title, irritates me, though.  We use files
and directories, not folders.

> BTW, I see you linked downthread the documentation[1] which says:
>
>   When [old-form submodules] deinitialized or deleted (see below), the
>   submodule=E2=80=99s Git directory is automatically moved to
>   $GIT_DIR/modules/<name>/ of the superproject.
>
> This was not what Git was doing before this patch, it used to die() out
> instead. So I think this actually is a bug fix (although I am not sure
> why the test suite also did not agree with the documentation).

Curious.

I see the description was added by d4803455 (submodules: overhaul
documentation, 2017-06-22), which claimed to "detangle" by "move"
various existing pieces of documentation into a new file.

I guess we added a wish without marking it as such ;-)
