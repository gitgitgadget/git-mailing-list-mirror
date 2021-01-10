Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620E4C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2895A229C4
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbhAJUwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 15:52:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61624 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJUwq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 15:52:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F5EC11E062;
        Sun, 10 Jan 2021 15:52:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oNLOE8LVDLkXi35WZO7/EqMnM/I=; b=QK5UXK
        PX1xeC4hmZ4iMyR+5EMXlgZCTvyhHWSlpCY0hylfHAKd77L3PdCGMZLDflKR/Mi/
        Tx1gtpQbDj03DHW73MZr5iErYvMdd0+VWef4ITCvJDc6ucPn91ZuCSmBX/tJjC2k
        OgZiiNijI7Um4VakzAeTyc1ZjMJ0+edpgfUeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mOYhgxWKmrAK5GbIxsCSZNHSXKZ8zaMH
        frW3oP2A2z5S0CVGqFjmvnfm0hKNltY2mjnLGs/cHIevhL1b0Sif/nsKiDxqc9cm
        AZ6okHhgKFCkP1WkDbWHF2gLVSGRN7xSD8EV6/hAEYUqFuEUWM3e36gFNEucZcxi
        saSO9D6tcZI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0680B11E061;
        Sun, 10 Jan 2021 15:52:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C8EED11E05E;
        Sun, 10 Jan 2021 15:51:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 06/13] merge-index: don't fork if the requested
 program is `git-merge-one-file'
References: <20201116102158.8365-1-alban.gruin@gmail.com>
        <20201124115315.13311-1-alban.gruin@gmail.com>
        <20201124115315.13311-7-alban.gruin@gmail.com>
        <44c9189d-9d2f-c437-d0d6-9529708d2c99@gmail.com>
        <411b68ad-dee5-5a19-ae94-c2b6a249161a@gmail.com>
        <xmqqv9cax1le.fsf@gitster.c.googlers.com>
        <f7d7cc3b-b53d-ed48-8aa4-2b26a0ce7da3@gmail.com>
Date:   Sun, 10 Jan 2021 12:51:58 -0800
In-Reply-To: <f7d7cc3b-b53d-ed48-8aa4-2b26a0ce7da3@gmail.com> (Alban Gruin's
        message of "Sun, 10 Jan 2021 18:15:52 +0100")
Message-ID: <xmqqzh1g8qhd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF19A5A8-5385-11EB-858F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>> These days, there exists an optional installation option exists that
>> won't even install built-in commands in $GIT_EXEC_PATH, which
>> invalidates the assessment made in 2019 in the article you cited
>> above, so the code might still be OK, but the old justification no
>> longer would apply.
>> 
>> In any case, if two people who reviewed a patch found the same thing
>> in it fishy, it is an indication that the reason why the apparently
>> fishy code is OK needs to be better explained so that future readers
>> of the code do not have to be puzzled about the same thing.
>
> Perhaps we could try to check if the provided command exists (with
> locate_in_PATH()), if it does, run it through merge_one_file_spawn(),
> else, use merge_one_file_func()?

So you think your current implementation will be broken if the "no
dashed git binary on disk" installation option is used?

I do not think "first check if an on-disk command exists and use it,
otherwise check its name" alone would work well in practice.  Both
the 'cat' example that appears in the manual page, and the typical
invocation of git-merge-one-file from merge-resolve:

	git merge-index cat MM
	git merge-index git-merge-one-file -a

would work just as well as before, but does not give you a way to
bypass fork() for the latter.  And changing the order of checks
would mean the users won't have a way to override a buggy builtin
implementation of merge_one_file function.  Besides, using the name
of the binary feels like a bad hack.  

As the invocation from merge-resolve is purely an internal matter,
it may make more sense to introduce a new option and explicitly tell
merge-index that the command line is not asking for an external
program to be spawned, e.g.

	git merge-index --use=merge-one-file -a

You'd prepare a table of internally implemented "take info on a
single path that is being merged and give an automated resolution"
functions, which begins with a single entry that maps the string
"merge-one-file" to your merge_one_file_func function.  Any value to
the "--use" option that names a function not in the table would
cause an error.

Note that in the above the "table of functions" is merely
conceptual.  It is perfectly OK to implement the single entry table
by codeflow (i.e. "if (!strcmp()) ... else error();").  But thinking
in terms of "a table of functions the user can choose from" helps to
form the right mental picture.

Hmm?
