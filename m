Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943E9C433DB
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 20:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DB465168
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 20:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhCGUaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 15:30:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57026 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhCGU3f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 15:29:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADE9C12FA98;
        Sun,  7 Mar 2021 15:29:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aGGTU5+E2fECLnReTSDzIQoidLg=; b=MhBLwE
        +gDVZucQgekgJwul4z3gFPGEGjruv4eGh5QJPV3AipPkvyktIKbVe58CGAnok5ON
        SKO+zJpc4wFyZGnEsar6iJQI3UoaAkzGEyS8i1lI7LAv5aEDjSOd1ILKAz22b48z
        1wPUl5fUhbrDv0loH5u6zofPX4Di0nLNwi0no=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GdZDoLXRCWAdjqrZdgTHs+Fo5w3+y7HY
        buUKZ2MU4HfDGdfc2H4maboQ/oKhkn2PVe9ioB3dEVEOyUPxfLRonLAUizuFlURI
        /nMyPQ6pWfWq+tC9Fnb9RVlEZx/OeYh+5rwWqcE0kdd1pu2UHIpUvQ3yN+Yw99EF
        c3fRywI1GXI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A368E12FA97;
        Sun,  7 Mar 2021 15:29:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF53612FA96;
        Sun,  7 Mar 2021 15:29:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v2 1/1] rm: stage submodule removal from '.gitmodules'
 when using '--cached'
References: <20210218184931.83613-1-periperidip@gmail.com>
        <20210222172623.69313-1-periperidip@gmail.com>
        <20210222172623.69313-2-periperidip@gmail.com>
        <xmqqo8gb7vf9.fsf@gitster.g> <20210307164644.GA8702@konoha>
Date:   Sun, 07 Mar 2021 12:29:30 -0800
In-Reply-To: <20210307164644.GA8702@konoha> (Shourya Shukla's message of "Sun,
        7 Mar 2021 22:16:44 +0530")
Message-ID: <xmqqblbu907p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2D13D56-7F83-11EB-B28C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

> On 22/02 11:29, Junio C Hamano wrote:
>> Shourya Shukla <periperidip@gmail.com> writes:
>> 
>> > +	if (git_config_rename_section_in_file(index_only ? GITMODULES_INDEX :
>> > +					      GITMODULES_FILE, sect.buf, NULL) < 0) {
>> 
>> Also, is it really sufficient to pass GITMODULES_INDEX as the first
>> argument to this function to tweak what is in the index?
>> 
>> git_config_copy_or_rename_section_in_file() which is the
>> implementation of that helper seems to always want to work with a
>> file that is on disk, by making unconditional calls to
>> hold_lock_file_for_update(), fopen(), fstat(), chmod(), etc.
>> 
>> So I suspect that there are much more work needed.  
>
> I am not able to comprehend _why_ we need so much more work. To me it
> seems to work fine.

> The flow now is something like:
>
> 1. If !index_only i.e., '--cached' is not passed then remove the entry
> of the SM from the working tree copy of '.gitmodules' i.e.,
> GITMODULES_FILE. If there are any unstaged mods in '.gitmodules', we do
> not proceed with 'git rm'.

That side is fine, especially if we are extending the "when doing
'git rm PATH' (without '--cached'), PATH must match between the
index and the working tree" to "when doing 'git rm SUBMODULE', not
just SUBMODULE but also '.gitmodules' must match between the index
and the working tree", then adjusting the entry for SUBMODULE in
'.gitmodules' in the working tree and adding the result to the index
would give the same result as editing '.gitmodules' both in the
index and in the working tree independently.

But the problem is that there is no way "--cached" case would work
with your code.

> What exactly do we need to change then?

Have you traced what happens when you make this call

>> > +	if (git_config_rename_section_in_file(index_only ? GITMODULES_INDEX :
>> > +					      GITMODULES_FILE, sect.buf, NULL) < 0) {

with index_only set?  i.e. GIT_MODULES_INDEX passed as the
config_filename argument?

The first parameter to the git_config_rename_section_in_file() names
a filename in the working tree to be edited.  Writing ':.gitmodules'
does not make the function magically work in-core without touching
the working tree.  It will make it update a file (likely not
tracked) whose name is ":.gitmodules" in the working tree, no?

Presumably you want to edit in-index .gitmodules without touching
the working tree file, but the call is not doing that---and it would
take much more work to teach it do so.

And a cheaper way out would be how I outlined in the message you are
responding to, i.e. write out the in-index .gitmodules to a
temporary file, let git_config_rename_section_in_file() tweak that
temporary file, and add it back into the index.

