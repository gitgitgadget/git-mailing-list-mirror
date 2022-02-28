Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3428FC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbiB1SXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbiB1SWz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:22:55 -0500
X-Greylist: delayed 189 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 10:01:18 PST
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7903AD5DDD
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:01:18 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 107041930B1;
        Mon, 28 Feb 2022 12:57:57 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=vr2QmRTMsOvxj/QAhFCR20n+OKSgLufEU2hEP8K
        Y5Bw=; b=yYHA+WI0eLgcldCRxt9gbov97fFIitSTisOsJST0UxvVRYOtTHqh1mZ
        +I9ZlO9deiJ9KwZn49C0ubzZqVDUfD6aflP2DEYJ6J1c64qtHLbGzW9LLbg/gLho
        y5oA/EXtGmrxyC6GwLNoGJJhvGZnhq4cdZPpKv3N7zgpgf5ALvH4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A07E1930B0;
        Mon, 28 Feb 2022 12:57:57 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 615391930AE;
        Mon, 28 Feb 2022 12:57:53 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Mon, 28 Feb 2022 12:57:50 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] gpg-interface/gpgsm: fix for v2.3
Message-ID: <Yh0NHkyquB7nht3W@pobox.com>
References: <20220203123724.47529-1-fs@gigacodes.de>
 <20220224100628.612789-1-fs@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224100628.612789-1-fs@gigacodes.de>
X-Pobox-Relay-ID: F3D01D5A-98BF-11EC-B6AB-C85A9F429DF0-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Fabian Stelzer wrote:
> gpgsm v2.3 changed some details about its output:
>  - instead of displaying `fingerprint:` for keys it will print `sha1
>    fpr:` and `sha2 fpr:`
>  - some wording of errors has changed
>  - signing will omit an extra debug output line before the [GNUPG]: tag
> 
> This change adjusts the gpgsm test prerequisite to work with v2.3 as
> well by accepting `sha1 fpr:` as well as `fingerprint:`. To make this
> parsing more robust switch to gpg's `--with-colons` output format.
> Also allow both variants of errors for unknown certs.

I ran this series through the fedora buildsystem on releases
with gnupg 2.2 and 2.3.  All the tests pass, as expected.

I think we may be able to simplify the wording above and the
patch below regarding the fingerprint/shaN fpr output
change, I'll add a comment below the changed hunk.

> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 3e7ee1386a..e997ce10ea 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -72,12 +72,10 @@ test_lazy_prereq GPGSM '
>  		--passphrase-fd 0 --pinentry-mode loopback \
>  		--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
>  
> -	gpgsm --homedir "${GNUPGHOME}" -K |
> -	grep fingerprint: |
> -	cut -d" " -f4 |
> -	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
> +	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
> +	awk -F ":" "/^(fpr|fingerprint):/ {printf \"%s S relax\\n\", \$10}" \
> +		>"${GNUPGHOME}/trustlist.txt" &&

Using --with-colons to parse the output, we shouldn't be
affected by the changed output.  The pattern for awk can be
simplified to '^fpr:' as older and newer versions of gnupg
have used that string in the --with-colons output for many,
many years.

Perhaps that allows the commit message to say less about the
specific's the gnugp-2.3 output change and just mention that
it changed and using --with-colons is the preferred way to
parse the output (where we must parse output at all).

    Switch to gpg's `--with-colons` output format to make
    parsing more robust.  This avoids issues where the
    human-readable output from gpg commands changes.

or something?

Thanks,

-- 
Todd
