Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B1C433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D339220657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d/lPAbVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgERS3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 14:29:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60399 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbgERS3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 14:29:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C35CB4A7BE;
        Mon, 18 May 2020 14:29:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=84uYcx7c6GBl5cYvUebChIGylO8=; b=d/lPAb
        VqOjWVg3JnLJctGdXRsfEgng7rBxj3j+ZULzte4wRvzaGGTOu4LCsBXOKbCGS8Rs
        QpJCdZKzjordKsozp3SoXHqY0xGv11jFUReEt8uQQlHj5JkBXF0HtpnmxkFLgPX0
        SF92yRF/F9BPn4/nUuvpN9nemYr+R8yvpQJho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sdpsXplfhERDgk7IFSp9IHeb3II+gF6X
        38+ZMH+1Erd5O9xmVVNhsZ/SDy28gjPqKpjrzQNEZmzzx8Vt+C0K1CBDkCxIDjm7
        FAVK7hRZiecO4G3VFTNwz2zBaJPl7eySpS9sj/iSpAMKhgs/YLnh/gEMJUDtM4z9
        qhT51cQ+aek=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA8EA4A7BB;
        Mon, 18 May 2020 14:29:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 446FC4A7BA;
        Mon, 18 May 2020 14:29:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Darren Tucker <dtucker@dtucker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/7] Use strtoumax instead of strtoull.
References: <20200518100356.29292-1-dtucker@dtucker.net>
        <20200518100356.29292-4-dtucker@dtucker.net>
Date:   Mon, 18 May 2020 11:29:06 -0700
In-Reply-To: <20200518100356.29292-4-dtucker@dtucker.net> (Darren Tucker's
        message of "Mon, 18 May 2020 20:03:53 +1000")
Message-ID: <xmqqy2pp2j2l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7590A468-9935-11EA-818F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Darren Tucker <dtucker@dtucker.net> writes:

> strtoumax is in the compat library so this works on platforms that don't
> have a native strtoull.

The above description (even though is a good one) alone would leave
the reader wondering if this patch now has removed the last use of
strtoull(), removing the need to have NO_STRTOULL in the Makefile
and configure.ac, and also wonder why the patch does not touch
Makefile etc.  Something like

	We still use strtoull() as a part of the compatibility
	implementation of strtoumax(), so we cannot remove the
	support to detect/configure the use of the function in the
	Makefile and autoconf, though.

may deserve to be made into the second paragraph that follows the
above description.

Shouldn't the type of some variables in the codepath also be changed
to make sure we receive the return value from the function in a
variable that is large enough?

Thanks.

> Signed-off-by: Darren Tucker <dtucker@dtucker.net>
> ---
>  t/helper/test-progress.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
> index 5d05cbe789..3e9eb2abe3 100644
> --- a/t/helper/test-progress.c
> +++ b/t/helper/test-progress.c
> @@ -47,7 +47,7 @@ int cmd__progress(int argc, const char **argv)
>  		char *end;
>  
>  		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
> -			uint64_t item_count = strtoull(end, &end, 10);
> +			uint64_t item_count = strtoumax(end, &end, 10);
>  			if (*end != '\0')
>  				die("invalid input: '%s'\n", line.buf);
>  			display_progress(progress, item_count);
> @@ -55,10 +55,10 @@ int cmd__progress(int argc, const char **argv)
>  				       (const char **) &end)) {
>  			uint64_t byte_count, test_ms;
>  
> -			byte_count = strtoull(end, &end, 10);
> +			byte_count = strtoumax(end, &end, 10);
>  			if (*end != ' ')
>  				die("invalid input: '%s'\n", line.buf);
> -			test_ms = strtoull(end + 1, &end, 10);
> +			test_ms = strtoumax(end + 1, &end, 10);
>  			if (*end != '\0')
>  				die("invalid input: '%s'\n", line.buf);
>  			progress_test_ns = test_ms * 1000 * 1000;
