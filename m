Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EF5C433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 19:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5B220708
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 19:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TGCCdalT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgGHTwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:52:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63354 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHTwL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 15:52:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E73AE8598;
        Wed,  8 Jul 2020 15:52:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Akyk/3UKoN5Zq2vi3yjA56R73U=; b=TGCCda
        lT/4SqpLdg6/3WfmMxoYI/7gYtj4WJs6tU5069yttx1/WJCgixvuV+NgYQxztLWr
        vNmomN1KIi6tdDWR5Kiw4zf0E+jYrxhpzu8t9DH2bisMYvbAaCuPa9PpV6QT5N5I
        i41Ia6p1RDutgplIHMDvU6RGyn3ZZQrB7WStM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mnqi4Kha1xcAOXKGl4n1/fYFb3+jWysz
        Iz8nTEBUqrVEShHGV+TcmYU+bfbDLQY650NEKYTAlVkftJ5TEVg6L0znnnzypNQi
        BKORyxPI1rBi8tMR0TisP4b5LY8nATYSNIPdCyssLXVm/a8PF9Ri7oPoH0vi4/59
        X6bUOUorm3g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4820FE8597;
        Wed,  8 Jul 2020 15:52:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E29EE8596;
        Wed,  8 Jul 2020 15:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 03/13] bisect--helper: introduce new `write_in_file()` function
References: <20200701133504.18360-1-mirucam@gmail.com>
        <20200701133504.18360-4-mirucam@gmail.com>
Date:   Wed, 08 Jul 2020 12:52:03 -0700
In-Reply-To: <20200701133504.18360-4-mirucam@gmail.com> (Miriam Rubio's
        message of "Wed, 1 Jul 2020 15:34:54 +0200")
Message-ID: <xmqqwo3d23a4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FE46A70-C154-11EA-9805-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> +static int write_in_file(const char *path, const char *mode, const char *format, va_list args)
> +{
> +	FILE *fp = NULL;
> +	int res = 0;
> +
> +	if (!strcmp(mode, "a") && !strcmp(mode, "w"))
> +		return error(_("wrong writing mode '%s'"), mode);

How can a string "mode" be equal to "a" and "w" at the same time?

The only caller you have at this point passes "w" and nothing else.
It may be easier to follow the evolution of the code in the series 
if you left this as

	if (strcmp(mode, "w"))
		BUG("write-in-file does not support '%s' mode", mode);

at this step, and turned it into

	if (strcmp(mode, "w") && strcmp(mode, "a"))
		BUG("write-in-file does not support '%s' mode", mode);

in the step where a caller starts to call it for appending.

> +	fp = fopen(path, mode);
> +	if (!fp)
> +		return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
> +	res = vfprintf(fp, format, args);
> +
> +	if (!res) {

Shouldn't this check for negative return?  It is not an error to
pass format that ends up writing nothing, but any error should be
reported by returning a negative value from vfprintf(), I would
think.

    (a tip for a student/mentee)

    Any time you call a system library you are not familiar with,
    make it a habit to always consult its manual page for return
    values and its error reporting convention.

>  	if (!strcmp(bad, good))
> @@ -113,12 +144,8 @@ static int write_terms(const char *bad, const char *good)
>  	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
>  		return -1;
>  
> -	fp = fopen(git_path_bisect_terms(), "w");
> -	if (!fp)
> -		return error_errno(_("could not open the file BISECT_TERMS"));
> +	res = write_to_file(git_path_bisect_terms(), "%s\n%s\n", bad, good);
>  
> -	res = fprintf(fp, "%s\n%s\n", bad, good);
> -	res |= fclose(fp);
>  	return (res < 0) ? -1 : 0;

Shouldn't this now be just

	return res;

as all the error codepaths that can reach here are returning error()
or error_errno() after this patch?

>  }
