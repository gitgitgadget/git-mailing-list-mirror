Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C34C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CB364D9A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhBQTuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:50:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50058 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbhBQTul (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:50:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3127122CA5;
        Wed, 17 Feb 2021 14:49:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pdvAJmb40WEPbSMPLrpC2E32w/k=; b=c20VoF
        kk5CnTehM/rikF0GZIFXdU+RVa29cXT2Sd91eLB6jpSvPFEvx3ckFRyrst6Vi9iX
        nsfeM2e2HIffcs3LN97LBlowocuHjLT8aTxie6/jcc1RiXD497PQCpBDU18VoZtJ
        hQ4CVmjVFVQdesyOXNCwkPWqQ80UKf2Ri0mhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BpGUnHr9dBtBM8v7xXaHR4BB7UipekP6
        /GgZkn+cx6d/NEgAN2JM5sKkw28hOYLqoaetXsrrMl5U/pM++QwSHtzAzzJnJWln
        GSBIzOhvN5NQyOeUNjyjki5jxmaL2XMdSiFuIC5dCXyV1s4tDzJNMJyylZb3Rack
        WOU0G1oop24=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB620122CA4;
        Wed, 17 Feb 2021 14:49:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3C7C8122CA3;
        Wed, 17 Feb 2021 14:49:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210217073725.16656-1-charvi077@gmail.com>
        <20210217073725.16656-2-charvi077@gmail.com>
Date:   Wed, 17 Feb 2021 11:49:55 -0800
In-Reply-To: <20210217073725.16656-2-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Wed, 17 Feb 2021 13:07:21 +0530")
Message-ID: <xmqq35xulbj0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FF7D508-7159-11EB-A775-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> `git commit --fixup=amend:<commit>` will create an "amend!" commit.
> The resulting commit message subject will be "amend! ..." where
> "..." is the subject line of <commit> and the initial message
> body will be <commit>'s message. -m can be used to override the
> message body.
>
> The "amend!" commit when rebased with --autosquash will fixup the
> contents and replace the commit message of <commit> with the
> "amend!" commit's message body.
>
> Inorder to prevent rebase from creating commits with an empty
> message we refuse to create an "amend!" commit if commit message
> body is empty.
>
> Example usage:
> $ git commit --fixup=amend:HEAD
> $ git commit --fixup=amend:HEAD -m "clever commit message"

Sorry, but it is not so clear what these examples are trying to
illustrate.

The first one is to add a new commit to later amend the tip commit
(It is a bit of mystery why the user does not do a more usual "git
commit --amend" right there, though, and such a mystery may distract
readers.  If the commit were not at the tip, e.g.  HEAD~3, it may be
less distracting).

The second one, even with s|HEAD|HEAD~3| is even less clear.
Without the "-m", the resulting commit will have the subject that
begins with !amend but the log message body is taken from the given
commit, but with "-m", what happens?  Does a single-liner 'clever
commit message' _replace_ the log message of the named commit,
resulting in an !amend commit that has no message from the original?
Or does 'clever commit message' get _appended_ the log message?

I think we can just remove the "example" from here and explain the
feature well in the end-user facing documentation.

> +	if (fixup_message) {
> +		/*
> +		 * check if ':' occurs before '^' or '@', otherwise
> +		 * fixup_message is a commit reference.
> +		 */

Isn't it that you only intend to parse:

    --fixup
    --fixup=amend:<any string that names a commit>
    --fixup=<any string that names a commit>

and later extend it to allow keywords other than "amend"?

I can understand that you are trying to avoid getting fooled by
things like

	--fixup='HEAD^{/commit message with a colon : in it}'

but why special case only ^ and @?  This feels brittle (note that I
said "things like", exactly because I do not know if any string that
can name a commit must have "@" or "^" appear before ":" if it is to
have ":" in anywhere, which is what this code assumes).

Instead, you can find the first colon, check for known keywords (or
a string that consists only of alnums to accomodate for future
enhancement), and treat any garbage that happens to have a colon
without the "keyword" as fixup_commit.  I.e.  something along this
line...

		const char alphas[] = "abcde...xyz";
		size_t kwd_len;

		kwd_len = strspn(fixup_message, alphas);
		if (kwd_len && fixup_message[kwd_len] == ':') {
			/* found keyword? */
			fixup_message[kwd_len] = '\0';
			if (!strcmp("amend", fixup_message)) {
				... do the amend:<commit> thing ...
#if in-next-step-when-you-add-support-for-reword
			} else if (!strcmp("reword", fixup_message)) {
				... do the reword:<commit> thing ...
#endif
			} else {
				die(_("unknown --fixup=%s:<commit>",
					fixup_message));
			}
		} else {
			/* the entire fixup_message is the commit */
		}

