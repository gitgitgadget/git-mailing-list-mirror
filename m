Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916EA20899
	for <e@80x24.org>; Wed,  2 Aug 2017 21:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbdHBVOK (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 17:14:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56791 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751032AbdHBVOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 17:14:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC52094503;
        Wed,  2 Aug 2017 17:14:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=H3y36QjqO8cf
        j2WmQ1iFOps5zLo=; b=E+4f3gSrV/ueuzmBwNpUH4v1LX4pm5Bild1eqFlgcT/z
        a96AipNY/BqNK5QWnJD+6dSnYOa2idOGVryhDoEz2py8TY9SwdoC0SaeeBWQKYzG
        oTgD2PTOHprM9h06VMHgEnwXlJRKqLDGSnSe6kzKTW9mE6/q5CUy9UoNYhkTns4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=K/6uOl
        xTul92JdyhRSvRCKhO7alwfq7nUz0M7WQsp9OPjokXtWq35pj8WBbqAc/nYOnoOS
        t9nr/w+qOEynP03kwgg40JqAd8lxixcGWsafcY6rIPuewN+HtuvEZHq3P9yh8WsG
        mvcKJRx3rzsWfAquPyRSbwf7YrMsp5f6Nh93E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AEEF94501;
        Wed,  2 Aug 2017 17:14:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14B6A94500;
        Wed,  2 Aug 2017 17:14:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH v1 1/1] correct apply for files commited with CRLF
References: <cceaf377-73e0-e733-20ba-c4e547226382@web.de>
        <20170802204203.29484-1-tboegi@web.de>
Date:   Wed, 02 Aug 2017 14:13:59 -0700
In-Reply-To: <20170802204203.29484-1-tboegi@web.de> (tboegi@web.de's message
        of "Wed, 2 Aug 2017 22:42:03 +0200")
Message-ID: <xmqqwp6lr7u0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 80CA583E-77C7-11E7-9A73-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> git apply does not find the source lines when files have CRLF in the in=
dex
> and core.autocrlf is true:
> These files should not get the CRLF converted to LF. Because cmd_apply(=
)
> does not load the index, this does not work, CRLF are converted into LF
> and apply fails.
>
> Fix this in the spirit of commit a08feb8ef0b6,
> "correct blame for files commited with CRLF" by loading the index.
>
> As an optimization, skip read_cache() when no conversion is specified
> for this path.

What happens when the input to apply is a patch to create a new file
and the patch uses CRLF line endings?  In such a case, shouldn't
core.autocrlf=3Dtrue cause the patch to be converted to LF and then
succeed in applying?  An extra read_cache() would not help as there
must be no existing index entry for the path in such a case.

If you did "rm .git/index" after you did the "git checkout -- ." in
your test patch, "git apply" ought to succeed, as it is working as
a substitute for "patch -p1" and should not be consulting the index
at all.

I cannot shake this feeling that it is convert_to_git() that needs
to be fixed so that it does not need to refer to the current
contents in the index.  Why does it even need to look at the index?
If it is for the "safe CRLF" thing (which I would think is misguided),
shouldn't it be checking the original file in the working tree, not
the index?  After all, that is what we are patching, not the contents
stored in the index.

>
> Reported-by: Anthony Sottile <asottile@umich.edu>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  apply.c         |  2 ++
>  t/t0020-crlf.sh | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/apply.c b/apply.c
> index f2d599141d..66b8387360 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2278,6 +2278,8 @@ static int read_old_data(struct stat *st, const c=
har *path, struct strbuf *buf)
>  	case S_IFREG:
>  		if (strbuf_read_file(buf, path, st->st_size) !=3D st->st_size)
>  			return error(_("unable to open or read %s"), path);
> +		if (would_convert_to_git(&the_index, path))
> +			read_cache();
>  		convert_to_git(&the_index, path, buf->buf, buf->len, buf, 0);
>  		return 0;
>  	default:
> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> index 71350e0657..6611f8a6f6 100755
> --- a/t/t0020-crlf.sh
> +++ b/t/t0020-crlf.sh
> @@ -386,4 +386,16 @@ test_expect_success 'New CRLF file gets LF in repo=
' '
>  	test_cmp alllf alllf2
>  '
> =20
> +test_expect_success 'CRLF in repo, apply with autocrlf=3Dtrue' '
> +	git config core.autocrlf false &&
> +	printf "1\r\n2\r\n" >crlf &&
> +	git add crlf &&
> +	git commit -m "commit crlf with crlf" &&
> +	git config core.autocrlf true &&
> +	printf "1\r\n2\r\n\r\n\r\n\r\n" >crlf &&
> +	git diff >patch &&
> +	git checkout -- . &&
> +	git apply patch
> +'
> +
>  test_done
