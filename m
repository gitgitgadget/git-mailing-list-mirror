Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F92CC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 22:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30BB2078E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 22:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KrPYdVEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDHWAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:00:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56799 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgDHWAA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 18:00:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4D3650C64;
        Wed,  8 Apr 2020 17:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FdcP1+bSK6qTz7xKOJmxMS9EsS0=; b=KrPYdV
        EFEcOcprvsBU0amr5EqjRIClK4GC3axjbWAVbJRQKdCkaNctabfbZ2yNI+X54Fgy
        Q1AZkE2tkWWtgfveWAZdwgYefVTPyINNs5vOnuaueCaiPt6ZzOs74Dp+op1Uxfw3
        sQbnQPxVJGk4QvKV8ydtx1td3UYvO6HBXM77k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tm71PDEtv7sEUT+I8gOhR2UoKXdSGMd3
        U+am86QGHuy5/p2FYHcLWAacTNXI+ijGZ7N8cpWMjrBa1LvMYgS99hKzmQjf09/x
        H/Uoo32G1+sPiD7eWUsP7voseLizXTqYqZTapM7tCXAmpSSWK73RCq7Awu8SQG1n
        oPlSunu3HZg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABFF250C63;
        Wed,  8 Apr 2020 17:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 075FC50C62;
        Wed,  8 Apr 2020 17:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw: make is_hidden tests in t0001/t5611 more robust
References: <pull.603.git.1586374474512.gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 14:59:55 -0700
In-Reply-To: <pull.603.git.1586374474512.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 08 Apr 2020 19:34:34
        +0000")
Message-ID: <xmqqmu7locys.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48491398-79E4-11EA-9B65-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 26f82063267..2456688b281 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -395,7 +395,7 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
>  # Tests for the hidden file attribute on windows
>  is_hidden () {
>  	# Use the output of `attrib`, ignore the absolute path
> -	case "$(attrib "$1")" in *H*?:*) return 0;; esac
> +	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
>  	return 1
>  }

I wondered if this (and the other one) want to be in test-lib but I
am on the fence.  All three tests that call this helper in t0001 are
protected with MINGW prerequisite, but until I realized it, the call
to "attrib" (whether it is given as a full path or relies on $PATH
lookup) looked like a portability nightmare waiting to happen.  It
would make it even worse if we moved the above as-is to test-lib, as
it is harder to see what the callers are doing once we did so.

With a change like this, however

	is_hidden () {
		if ! test_have_prereq MINGW
		then
			BUG "use of is_hidden outside MINGW prerequisite"
		fi
		case "$("$SYSTEMROOT"/system32/attrib "$1")" in 
		*H*?:*)	return 0 ;;
		*)	return 1 ;;
		esac
	}

I think it is OK to consolidate these two copies into one in test-lib

Thanks.


> diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
> index 60c1ba951b7..87b8073cd74 100755
> --- a/t/t5611-clone-config.sh
> +++ b/t/t5611-clone-config.sh
> @@ -95,7 +95,7 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
>  # Tests for the hidden file attribute on windows
>  is_hidden () {
>  	# Use the output of `attrib`, ignore the absolute path
> -	case "$(attrib "$1")" in *H*?:*) return 0;; esac
> +	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
>  	return 1
>  }
>  
>
> base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
