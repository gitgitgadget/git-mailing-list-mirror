Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C544C1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 22:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933038AbcLHWxS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 17:53:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65134 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932328AbcLHWxR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 17:53:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B41F574F3;
        Thu,  8 Dec 2016 17:53:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gGAK0QwFuZHfdUxKMbAHPcXffDA=; b=GlSUfT
        DALgKrtWbysm9wJBI0oNvjjULduNb11Yh7JnXowgLuVCORwoEz+e0kQdFXA6SCKs
        wysf4NGHMbpnxMA1O8KP/rnPpoQEY5WeQcNvpy5A9+yp7fcYP2SojL789TtHmME3
        z7NB0qyHkMgMwTrIqgIqo5ik6I/PSjX8S4dRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hjsg5wmt+YKxGT+6c2Y8uxWXZVwGhmqI
        0jtRFK0k9LcByqNiWwdzgWsrel/CBtuXCVUtyHwsH9gPVooMU9goRWX3drStAxSf
        Dv2A9d60EM2jEC74Cxfwy5g9XK9ts4v3cGhtTNt9m9nxiwCadigIb+synF40pKrN
        V0dvEiMq1D4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4130D574F1;
        Thu,  8 Dec 2016 17:53:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A488A574EF;
        Thu,  8 Dec 2016 17:53:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jack Bates <bk874k@nottheoilrig.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jack Bates <jack@nottheoilrig.com>
Subject: Re: [PATCH v4] diff: handle --no-abbrev in no-index case
References: <20161206010134.21856-1-jack@nottheoilrig.com>
        <20161206165614.22921-1-jack@nottheoilrig.com>
Date:   Thu, 08 Dec 2016 14:53:14 -0800
In-Reply-To: <20161206165614.22921-1-jack@nottheoilrig.com> (Jack Bates's
        message of "Tue, 6 Dec 2016 09:56:14 -0700")
Message-ID: <xmqqtwaerq1x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AB195B4-BD99-11E6-8588-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jack Bates <bk874k@nottheoilrig.com> writes:

> There are two different places where the --no-abbrev option is parsed,
> and two different places where SHA-1s are abbreviated. We normally parse
> --no-abbrev with setup_revisions(), but in the no-index case, "git diff"
> calls diff_opt_parse() directly, and diff_opt_parse() didn't handle
> --no-abbrev until now. (It did handle --abbrev, however.) We normally
> abbreviate SHA-1s with find_unique_abbrev(), but commit 4f03666 ("diff:
> handle sha1 abbreviations outside of repository, 2016-10-20) recently
> introduced a special case when you run "git diff" outside of a
> repository.
>
> setup_revisions() does also call diff_opt_parse(), but not for --abbrev
> or --no-abbrev, which it handles itself. setup_revisions() sets
> rev_info->abbrev, and later copies that to diff_options->abbrev. It
> handles --no-abbrev by setting abbrev to zero. (This change doesn't
> touch that.)
>
> Setting abbrev to zero was broken in the outside-of-a-repository special
> case, which until now resulted in a truly zero-length SHA-1, rather than
> taking zero to mean do not abbreviate. The only way to trigger this bug,
> however, was by running "git diff --raw" without either the --abbrev or
> --no-abbrev options, because 1) without --raw it doesn't respect abbrev
> (which is bizarre, but has been that way forever), 2) we silently clamp
> --abbrev=0 to MINIMUM_ABBREV, and 3) --no-abbrev wasn't handled until
> now.
>
> The outside-of-a-repository case is one of three no-index cases. The
> other two are when one of the files you're comparing is outside of the
> repository you're in, and the --no-index option.

Nicely described.  

> diff --git a/diff.c b/diff.c
> index ec87283..84dba60 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3106,7 +3106,8 @@ static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
>  			abbrev = FALLBACK_DEFAULT_ABBREV;
>  		if (abbrev > GIT_SHA1_HEXSZ)
>  			die("BUG: oid abbreviation out of range: %d", abbrev);
> -		hex[abbrev] = '\0';
> +		if (abbrev)
> +			hex[abbrev] = '\0';
>  		return hex;
>  	}
>  }

This is the same since your earlier round and it is correct.  The
code before this part clamps abbrev to be between 0 and 40.

> @@ -3364,6 +3365,7 @@ void diff_setup(struct diff_options *options)
>  
>  	options->file = stdout;
>  
> +	options->abbrev = DEFAULT_ABBREV;

This is a new change relative to your earlier one.  

I looked at all the callers of diff_setup() and noticed that many of
them were initializing "struct diff_options" that is on-stack that
is totally uninitialized, which means they were using a completely
random value that happened to be on the stack.  

Which was surprising and made me wonder how the entire "diff" code
could have ever worked correctly for the past 10 years, as it's not
like all the users always passed --[no-]abbrev[=<value>] from the
command line.

In any case, this cannot possibly be introducing a regression; these
callsites of diff_setup() were starting from a random garbage---now
they start with -1 in this field.  If they were doing the right
thing by assigning their own abbrev to the field after diff_setup()
returned, they will continue to do the same, and otherwise they will
keep doing whatever random things they have been doing when the
uninitialized field happened to contain -1 the same way.

I didn't look carefully at the additional tests, but the code change
looks good.

Thanks.

