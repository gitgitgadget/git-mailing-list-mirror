Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9926C20988
	for <e@80x24.org>; Tue, 18 Oct 2016 19:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933242AbcJRTtq (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 15:49:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58141 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933100AbcJRTto (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 15:49:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF3EF47556;
        Tue, 18 Oct 2016 15:49:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jSLV25pmwLsmb9Q640LnFnJnrlQ=; b=PTiY4V
        dntriQdwASYdmqU62C4C7lLRnxHUdqX0CpkcTSNAZe6K6q2AL++f/a4pQziBwgsV
        p8uAC8MW2W31xQpXqiEnBdMvXShJStMs2YepU8GdOg+4MSbxTO8bpcWZteTXbcg5
        6YuHfcDbL+dUfVI0Qak2Y3E7k++oXItoth4WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mfE80uPkJC6NY+UryPjyoY8RSywrW9q1
        tNzo1oRGomqJFpShDpOF6TwicYPW2rnLa0Kt1g4AmBgVytyQrkU6q7PJcC2eUcnt
        FI3RgRZOFKMFCfwPwW+VkrplVPe+qutec+1V5LXB6YDVcY8c+UPoVIQMD1wNQ6DW
        2cZN4uCNWtU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C712547555;
        Tue, 18 Oct 2016 15:49:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4596E47554;
        Tue, 18 Oct 2016 15:49:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org, Johannes.Schindelin@gmx.de,
        venv21@gmail.com, dennis@kaarsemaker.net, jrnieder@gmail.com,
        bmwill@google.com
Subject: Re: [PATCH] submodule--helper: normalize funny urls
References: <20161018175247.28326-1-sbeller@google.com>
Date:   Tue, 18 Oct 2016 12:49:40 -0700
In-Reply-To: <20161018175247.28326-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 18 Oct 2016 10:52:47 -0700")
Message-ID: <xmqq8ttlphd7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03C52B72-956C-11E6-80CD-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Some users may rely on this by always cloning with '/.' and having
> an additional '../' in the relative path for the submodule, and this
> patch breaks them. So why introduce this patch?
>
> The fix in c12922024 (submodule: ignore trailing slash on superproject
> URL, 2016-10-10) and prior discussion revealed, that Git and Git
> for Windows treat URLs differently, as currently Git for Windows
> strips off a trailing dot from paths when calling a Git binary
> unlike when running a shell. Which means Git for Windows is already
> doing the right thing for the case mentioned above, but it would fail
> our current tests, that test for the broken behavior and it would
> confuse users working across platforms. So we'd rather fix it
> in Git to ignore any of these trailing no ops in the path properly.
>
> We never produce the URLs with a trailing '/.' in Git ourselves,
> they come to us, because the user used it as the URL for cloning
> a superproject. Normalize these paths.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  * reworded the commit message, taken from Junio, but added more explanation
>    why we want to introduce this patch. 

The additional explanation is very good.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 260f46f..ac03cb3 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -76,6 +76,29 @@ static int chop_last_dir(char **remoteurl, int is_relative)
>  	return 0;
>  }
>  
> +static void strip_url_ending(char *url, size_t *_len)
> +{
> +	size_t len = _len ? *_len : strlen(url);

Stare at our codebase and you'd notice that we avoid using names
with leading underscore deliberately and use trailing one instead
when we name a throw-away name like this.  Let's do the same here.
I.e.

	static void strip_url_ending(char *url, size_t *len_)
	{
		size_t len = len_ ? *len_ : strlen(url);

> +	for (;;) {
> +		if (len > 1 && is_dir_sep(url[len-2]) && url[len-1] == '.') {
> +			url[len-2] = '\0';

"len-1" and "len-2" are usually spelled with SP on both sides of
binary operators.

> +			len -= 2;
> +			continue;
> +		}
> +		if (len > 0 && is_dir_sep(url[len-1])) {
> +			url[len-1] = '\0';
> +			len --;

And post-decrement sticks to whatever it is decrementing without SP.

> +			continue;
> +		}
