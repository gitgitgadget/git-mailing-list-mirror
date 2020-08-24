Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB4C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E022074D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eL9wIRok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHXSf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:35:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56755 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHXSf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 14:35:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 465956AF17;
        Mon, 24 Aug 2020 14:35:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4o0cZ+0wY7k49sSZG8njwTSE98k=; b=eL9wIR
        ok76CJS+04uRzy0rZQkcu2urT/5pC1FCtVHSBVBszcVOyUPWPLhzOndQUVYbOVVw
        jEND832cvJxZzDClYtLywkwM93fDFvPW0K0jT5mM7G6ZSS7aQSmdEKV1rO5YKz5w
        EaWbz8YatT80DvdSLaPg0MUpGp5FjarlQhaiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VqpUlnXoYkF5My70TI2tyDpwhiPw/CK4
        ujlN6AWD5CrHlKnmMQ0kncdjBfatfdS46bVGxLR8cqLf+iksJfJiAl2cJcOANqDR
        YwGVA1PmD1nV8FHtbRxS/ti8YjLi64VIO8s6uScmaLoWUHxVcqyjZ3FZDSpvj4nn
        HW8+mmFcZVE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C4416AF16;
        Mon, 24 Aug 2020 14:35:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1C8F6AF13;
        Mon, 24 Aug 2020 14:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from shell to C
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
Date:   Mon, 24 Aug 2020 11:35:20 -0700
In-Reply-To: <20200824090359.403944-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Mon, 24 Aug 2020 14:33:59 +0530")
Message-ID: <xmqq8se36gev.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 913CF04A-E638-11EA-B797-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> 	if test -z "$force"
> 	then
> 		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
> 		die "$(eval_gettext "'\$sm_path' already exists in the index")"
> 	else
> 		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
> 		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
> 	fi

Hmph.  So,

 - if we are not being 'force'd, we see if there is anything in the
   index for the path and error out, whether it is a gitlink or not.

 - if there is 'force' option, we see what the given path is in the
   index, and if it is already a gitlink, then die.  That sort of
   makes sense, as long as the remainder of the code deals with the
   path that is not a submodule in a sensible way.

> This is what I have done in C:
>
> 	if (!force) {
> 		if (is_directory(path) && submodule_from_path(the_repository, &null_oid, path))
> 			die(_("'%s' already exists in the index"), path);

The shell version would error out with anything in the index, so I'd
expect that a faithful conversion would not call is_directory() nor
submodule_from_path() at all---it would just look path up in the_index
and complains if anything is found.  For example, the quoted part in
the original above is what gives the error message when I do

	$ git submodule add ./Makefile
	'Makefile' already exists in the index.

I think.  And the above code won't trigger the "already exists" at
all because 'path' is not a directory.

> 	} else {
> 		int err;
> 		if (index_name_pos(&the_index, path, strlen(path)) >= 0 &&
> 		    !is_submodule_populated_gently(path, &err))
> 			die(_("'%s' already exists in the index and is not a "
> 			      "submodule"), path);

Likewise.  The above does much more than the original.

The original was checking if the found cache entry has 160000 mode
bit, so the second test would not be is_submodule_populated_gently()
but more like !S_ISGITLINK(ce->ce_mode)

Now it is a different question if the original is correct to begin
with ;-).  

> 	}
>
> Is this part correct? I am not very sure about this. This particular
> part is not covered in any test or test script, so, I do not have a
> solid method of knowing the correctness of this segment.
> Feedback and reviews are appreciated.
