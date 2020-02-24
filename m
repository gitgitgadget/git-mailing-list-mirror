Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78535C38BE1
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480C120880
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eh62BLi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgBXSYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:24:45 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56117 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgBXSYo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:24:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B365A6005;
        Mon, 24 Feb 2020 13:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o9/Ix/k5ivxnrJp06gq3jVtG5Sk=; b=eh62BL
        i+p+dADh207EwePq+naJILkSjFCp+OqOL1mdqWTsOM9Gj4kgYKzygN2nNtfuypV/
        WgBY/QNUHFGv0VpUZ2gAhQjgRcWBnQU7/teCzLx/BzEVBAxzB6WIkRoNDX2SCgaW
        5xuN+SpeDgsvNTiC42SrrA7eLB3Q5PpEUBXZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EerPyzAygmAB2W4gilaa7iL1uEXJK2cV
        aJWjvRj4ZQ8dOz3Ns2c28asarq/lEtOKfhtgislLk7EslmYfp+Lf4wgjL09cZ+33
        wYWS65BpWTmk56maQR+HiRwXS6X4ICu1Kyjp6uZWm5DnNNnsOWjgp5XklDySACgU
        Vgor8UX1494=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9342AA6003;
        Mon, 24 Feb 2020 13:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BC86AA6002;
        Mon, 24 Feb 2020 13:24:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 17/24] commit: use expected signature header for SHA-256
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-18-sandals@crustytoothpaste.net>
Date:   Mon, 24 Feb 2020 10:24:34 -0800
In-Reply-To: <20200222201749.937983-18-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 22 Feb 2020 20:17:42 +0000")
Message-ID: <xmqqd0a3rggt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9A13420-5732-11EA-8808-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 7ba33a3bec..798d362a2e 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1659,7 +1659,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (amend) {
> -		const char *exclude_gpgsig[2] = { "gpgsig", NULL };
> +		const char *exclude_gpgsig[3] = { "gpgsig", "gpgsig-sha256", NULL };

For futureproofing, we should eventually revamp the machinery of
read_commit_extra_headers() so that we do not have to maintain this
array.  Instead, the second parameter, that is passed down to
read_commit_extra_header_lines() helper, should become a callback
function that lets the caller say "no, I do not want this header",
and we can use it to exclude "gpgsig", "gpgsig-sha256", and anything
that begins with "gpgsig-" in the future.  We might even want to
exclude "gpgsig-$algo" where "$algo" is the name of the algorithm
that this version of Git does not yet recognise while giving a
warning, or perhaps we may want to cause read_commit_extra_headers()
to yield an error on gpgsig with unknown hashalgo.  These become
easier to arrange with such a machinery update.

One question I have is if it makes sense to do so now before this
series, or we leave a "NEEDSWORK:" note and complete SHA-2 transition
with the current mechanism.

> +test_expect_success 'commit with multiple signatures is okay' '
> +	git cat-file commit HEAD >basis &&
> +	cat >sigs <<-EOF &&
> +	gpgsig -----BEGIN PGP SIGNATURE-----
> +	  VGhpcyBpcyBub3QgcmVhbGx5IGEgc2lnbmF0dXJlLg==
> +	  -----END PGP SIGNATURE-----
> +	gpgsig-sha256 -----BEGIN PGP SIGNATURE-----
> +	  VGhpcyBpcyBub3QgcmVhbGx5IGEgc2lnbmF0dXJlLg==
> +	  -----END PGP SIGNATURE-----
> +	EOF
> +	sed -e "/^committer/q" basis >okay &&
> +	cat sigs >>okay &&
> +	echo >>okay &&
> +	sed -e "1,/^$/d" basis >>okay &&
> +	cat okay &&
> +	new=$(git hash-object -t commit -w --stdin <okay) &&
> +	test_when_finished "remove_object $new" &&
> +	git update-ref refs/heads/bogus "$new" &&
> +	test_when_finished "git update-ref -d refs/heads/bogus" &&
> +	git fsck 2>out &&
> +	cat out &&
> +	! grep "commit $new" out
> +'

There seem to be a few debugging leftover cats in the above.
