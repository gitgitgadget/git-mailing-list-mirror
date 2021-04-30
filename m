Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD5C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 02:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399A161409
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 02:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhD3Cje (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 22:39:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58306 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3Cjc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 22:39:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DC751353AC;
        Thu, 29 Apr 2021 22:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=swy11+tVM6Xpo3AwbIS0S+06hUEQQyZHX78fFi
        A/mdM=; b=OPabssiLSTcbzXQcZjggEcGwmtwsyP3zfZW9oN73sV63AvrlBoiN5D
        ab5oRcrMfQvIU6KeF+vAdhahdcsNlRKtfC6KbM0pU8x7MugWp/qHhVfU7ZoEBB05
        BNDWYtvJstu9H0tv8mcb5qlK76NRP6oyoM0TtIduBesGuyMboFmrI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35EB71353AB;
        Thu, 29 Apr 2021 22:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 691FD1353A9;
        Thu, 29 Apr 2021 22:38:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/8] refs: remove EINVAL specification from the errno
 sideband in read_raw_ref_fn
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <7e8181e77d409af7595e357ad233b7781e026b78.1619710329.git.gitgitgadget@gmail.com>
Date:   Fri, 30 Apr 2021 11:38:40 +0900
In-Reply-To: <7e8181e77d409af7595e357ad233b7781e026b78.1619710329.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 29 Apr 2021
        15:32:01 +0000")
Message-ID: <xmqqk0okebtb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D727A06-A95D-11EB-826E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> A grep for EINVAL */*c reveals that no code inspects EINVAL after reading
> references.

We often use a pattern (which is common) like this:

	if (some_func_in_ref_API(...) < 0) {
		if (errno == ENOENT || errno == EISDIR)
			... it is OK for the file to be missing ...
		else
			... error ...
	}

If a piece of code currently sets EINVAL to errno manually when
signalling a failure by returning a negative value to communicate
with such a caller, we wouldn't see EINVAL mentioned, so such a grep
alone would not help us guarantee the correctness of an update to
stop assignment of EINVAL at all.  The callers must be vetted more
carefully than "we are happy that nobody explicitly mentions EINVAL".

> The files ref backend does use EINVAL so parse_loose_ref_contents() can
> communicate to lock_raw_ref() about garbage following the hex SHA1, or a short
> read in files_read_raw_ref(), but the files backend does not call into
> refs_read_raw_ref(), so its EINVAL sideband error is unused.

This paragraph is confusing.  It says EINVAL is used to signal
lock_raw_ref(), and it says EINVAL is not used by the same files
backend.  Which is correct?  If one part of the backend uses it, and
other parts don't, wouldn't the backend as a whole still use it?

Having said that, ...

> - * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
> - * and return -1. If the ref exists but is neither a symbolic ref nor
> - * an object ID, it is broken; set REF_ISBROKEN in type, set errno to
> - * EINVAL, and return -1. If there is another error reading the ref,
> - * set errno appropriately and return -1.

... the mention (and requirement) of EINVAL seems redundant, as it
sounds sufficient for the caller to inspect 'type' to see if it is
REF_ISBOKEN.  So it may be OK for the code that gives REF_ISBROKEN
to type *not* to set errno to EINVAL, as long as it won't leave it
as ENOENT (meaning, an unrelated system call failed earlier may have
set errno to ENOENT, and after having dealt with such an error, the
control may have reached to the codepath we are interested in
here---errno must be cleared to some value other than ENOENT, and
assigning EINVAL is as good as any).

That is because there is a codeflow like this:

	if (files_read_raw_ref(...)) {
		if (errno == ENOENT) {
			... do various things ...
		} else if (errno == EISDIR) {
			... do different and various things ...
		} else if (errno == EINVAL && (*type & REF_ISBROKEN)) {
			... deal with broken ref ...
		}
		 ...
	}

where errno is looked at.

> + * Return 0 on success. If the ref doesn't exist, set errno to ENOENT and return
> + * -1. If the ref exists but is neither a symbolic ref nor an object ID, it is
> + * broken; set REF_ISBROKEN in type, and return -1. If there is another error
> + * reading the ref, set errno appropriately and return -1.

So, this is not sufficient to let caller correctly and safely handle
errors.  "set REF_ISBROKEN in type, set errno to something other
than ENOENT or EISDIR, and then return -1" is necessary, I would
think.
