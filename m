Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD26BC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9E9207FF
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YbQFjS+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFTdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:33:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59460 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFTdw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 14:33:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2AB223432;
        Mon,  6 Jan 2020 14:33:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z4XCRkAYvzABROnSjT4DAukaRDg=; b=YbQFjS
        +2cJLsSYuraqQoQ905MNLTeZk2pcvKT11QjVX0k1a9DnkpEGRdYhqW4V2Lg4fzkB
        L+T94fajW55W2K54si5VBhnb+qD3uJyritcwyF2qS3rRt5hxoV8J2Au7TIHaP/Ms
        TghRvTXjA7oNGSSzPk50Tgq6mahH0vcWoVFIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q8rtwFPb8eCRBlmLzhEjWobG0REPEDhp
        Jvkbw6d27fYtMlZOw9Dwg7Ucvqahr52qS4CWesMX5Lia+4gYGTdsmLl79ePMBOMl
        BhYvYQKsXyPDGwaE599BhKCQJp915fBwRtYrd6GRjBVyfjkbG2g7kJVvsOc7AlE5
        4YQxjmY8TaE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB60823430;
        Mon,  6 Jan 2020 14:33:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44F242342F;
        Mon,  6 Jan 2020 14:33:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] gpg-interface: support one-line summaries in print_signature_buffer()
References: <20200105135616.19102-1-hji@dyntopia.com>
        <20200105135616.19102-3-hji@dyntopia.com>
Date:   Mon, 06 Jan 2020 11:33:48 -0800
In-Reply-To: <20200105135616.19102-3-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Sun, 5 Jan 2020 13:56:13 +0000")
Message-ID: <xmqqy2uk8jmr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 767B3772-30BB-11EA-9B4C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> Most consumers of the GPG interface use print_signature_buffer() to show
> This patch moves the one-line summary from verify_merge_signature() to
> print_signature_buffer().  It also introduces a GPG_VERIFY_SHORT flag
> that determines whether the summary should be printed.

I think the motivation makes sense.

> -void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
> +void print_signature_buffer(const struct object_id *oid,
> +			    const struct signature_check *sigc, int status,
> +			    unsigned flags)
>  {
>  	const char *output = flags & GPG_VERIFY_RAW ?
>  		sigc->gpg_status : sigc->gpg_output;
> +	char hex[GIT_MAX_HEXSZ + 1];
> +	char *type;
>  
>  	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
>  		fputs(sigc->payload, stdout);
>  
>  	if (flags & GPG_VERIFY_FULL && output)
>  		fputs(output, stderr);
> +
> +	if (flags & GPG_VERIFY_SHORT && oid) {

I am not sure about the wisdom of "&& oid" here.  Wouldn't it be a
bug for a caller who asks for _SHORT format to feed a NULL oid to
us?  I would understand

	if (flags & GPG_VERIFY_SHORT) {
		if (!oid)
			BUG("Caller asking for SHORT without oid???");

much better, but if there is a caller that has a legitimate need
tobe able to pass NULL and still request SHORT, let's see it and
discuss if it is a good idea.

For that matter, the two print routines we have immediately above
share the same issue.

> +		type = xstrdup_or_null(
> +			type_name(oid_object_info(the_repository, oid, NULL)));
> +		if (!type)
> +			type = xstrdup("object");

This is minor, but I wonder if this is easier to follow.

		type = type_name(oid_object_info(the_repository, oid, NULL));
		if (!type)
			type = "object";
		type = xstrdup(type);

> +		*type = toupper(*type);

This is not helpful at all for i18n/l10n, I am afraid.

> +		find_unique_abbrev_r(hex, oid, DEFAULT_ABBREV);
> +
> +		switch (sigc->result) {
> +		case 'G':
> +			if (status)
> +				error(_("%s %s has an untrusted GPG signature, "
> +					"allegedly by %s."),
> +				      type, hex, sigc->signer);

The original was of course

        die(_("Commit %s has an untrusted GPG signature, "
              "allegedly by %s."), hex, signature_check.signer);

so the message can properly localized including the typename.  That
is no longer true with this conversion.

You probably would need to prepare a 3-element array (one element
for each of <object, commit, tag>), each element of the array being
a 3-element array that holds the message for these three cases
(i.e. G, N and default) instead.


