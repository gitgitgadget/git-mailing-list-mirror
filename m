Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BFCC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F2464E25
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhBVTcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:32:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52478 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbhBVTae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 14:30:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 151BD11F0EA;
        Mon, 22 Feb 2021 14:29:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=agnorrQrygak2lAdQAdnIEHbfvw=; b=FGQya6
        cMaL/xw0ZE+nHo8lA3g6BsazspTfz3SdKnoH6pcpay2p8CZ9oAc2UDhC0Ys/Dc3Z
        1CIFloFeRsp8mYJ4odpKIB7F40Be1HLazWrpX0A5zh9lYMCiCvdRsWaDAUmu4tkk
        WQoJTSNjBO9PP8YAOOk/m4NtPO70r/1YqR5dU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gXCgd99BJPKRtpfg3Prm7OzIY79aYpkM
        V7k65AbdidMNF1D6dqVeg9Tg4P4kCrsph7FZZaf+5Skpu30WtqXl5c88DQy8l5Cl
        cQeUcVHblN6kHDGEBbc8KFL18Epg6KIEzZpDoRRH4TknwdmcN/aRv3rCnDejGc4M
        IDCchdbUToc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CA2E11F0E9;
        Mon, 22 Feb 2021 14:29:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC88B11F0E7;
        Mon, 22 Feb 2021 14:29:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        levraiphilippeblain@gmail.com,
        Javier Mora <javier.moradesambricio@rtx.com>
Subject: Re: [PATCH v2 1/1] rm: stage submodule removal from '.gitmodules'
 when using '--cached'
References: <20210218184931.83613-1-periperidip@gmail.com>
        <20210222172623.69313-1-periperidip@gmail.com>
        <20210222172623.69313-2-periperidip@gmail.com>
Date:   Mon, 22 Feb 2021 11:29:46 -0800
In-Reply-To: <20210222172623.69313-2-periperidip@gmail.com> (Shourya Shukla's
        message of "Mon, 22 Feb 2021 22:56:23 +0530")
Message-ID: <xmqqo8gb7vf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5321D0FA-7544-11EB-ABF5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

> +	if (git_config_rename_section_in_file(index_only ? GITMODULES_INDEX :
> +					      GITMODULES_FILE, sect.buf, NULL) < 0) {

Also, is it really sufficient to pass GITMODULES_INDEX as the first
argument to this function to tweak what is in the index?

git_config_copy_or_rename_section_in_file() which is the
implementation of that helper seems to always want to work with a
file that is on disk, by making unconditional calls to
hold_lock_file_for_update(), fopen(), fstat(), chmod(), etc.

So I suspect that there are much more work needed.  

It seems to me that the config editing API is one of the older and
hackier parts of the system and requires quite a lot of work to
teach it to work with anything but a on-disk file.  In the longer
term, it may be a good thing to clean it up, but I suspect that it
is way too much work for too little benefit to do so as a part of
this topic, so an easier way out for now would be to:

 - write out the .gitmodules in the index to a temporary file (learn
   how to correctly call entry.c::checkout_entry() by studying how
   builtin/checkout-index.c::checkout_file() calls it, especially to
   a temporary file with the --temp option).

 - use git_config_rename_section_in_file() on that temporary file to
   remove the section about the submodule.

 - read that temporary file back into memory and write it out as a
   blob object by calling sha1-file.c::write_object_file().

 - add that back to the index as .gitmodules (studying how
   builtin/update-index.c::add_cacheinfo() calls add_cache_entry()
   would be a good way to learn how to do this).

The working tree side can stay as is, but as I said in the earlier
message, I think you need to update the .gitmodules in the working
tree and .gitmodules in the index separately (and without doing any
equivalent of "git add .gitmodules").

