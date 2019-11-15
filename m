Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB991F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 05:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKOFf2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 00:35:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59273 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOFf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 00:35:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9F7C9B450;
        Fri, 15 Nov 2019 00:35:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PBbRLosdceMdVYEv6dE9nQWZrJc=; b=rMBtg2
        e+BQmXGGOMKG0ZiHoqLVWxeWkZIbaTuSjxTkkspaSuThGiKs+VazKCOPMpc/DtRi
        4IGVVxIPGRI7asmA5TmAPfovq2VdkU6GjxoSRhfxGzXiw8NwCUHhi/RxGyFp6gG+
        gKEqPiT09uwCoV0Bwfkl3Ystc32LG4ycxYHFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vTL2HOS8T1F467gSnoIq439smTrkzzvO
        CGIkcMlHfz+5msWzTrKY1VdtCJ72cMGFCOwZnaejxz45t7F/rOiMACQji29jDiNo
        tWlHD7JCac3jA6OLX2Vr2rjg9SGpmkTBIE+GXL/cpHlnkBlQbWYS7vzZr2GBOL3Z
        YoDslNK2UBg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0BAC9B44F;
        Fri, 15 Nov 2019 00:35:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9CD99B44E;
        Fri, 15 Nov 2019 00:35:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 23/27] t3600: mark git command as failing
References: <cover.1573779465.git.liu.denton@gmail.com>
        <bc4c208f7814c3362fa5949af3cb8d2d2904f386.1573779465.git.liu.denton@gmail.com>
Date:   Fri, 15 Nov 2019 14:35:17 +0900
In-Reply-To: <bc4c208f7814c3362fa5949af3cb8d2d2904f386.1573779465.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 14 Nov 2019 17:01:24 -0800")
Message-ID: <xmqqsgmp7ld6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6398D9E-0769-11EA-8A3A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In a future patch, we plan on running tests with `set -o pipefail`.
> Since we intentionally induce SIGPIPE, before the return code
> was being masked away. However, now `git rm` will cause an error code to
> be returned because of the SIGPIPE.
>
> Mark the failing command with `test_must_fail ok=sigpipe` so that
> failures induced by SIGPIPE don't propogate.

Hmph, would this pipeline _always_ fail?  I somehow thought that a
process that writes into a pipe that is not being read would fail
only if the downstream dies and closes before it write(2)s, and if
the output from this "git rm -n" is small enough (say to fit within
the pipe buffer) and downstream no-op is slow enough to die, the
upstream may probably not notice and happily and successfully exit.

    : with slow downstream
    $ ( ( printf "%s\n" a b c d e); echo "my exit $?" 1>&2 ) |
      ( sleep 2; echo "downstream exit $?" ); echo "overall exit $?"
    my exit 0
    downstream exit 0
    overall exit 0

    : with slow upstream
    $ ( (sleep 2; printf "%s\n" a b c d e); echo "my exit $?" 1>&2 ) |
      ( echo "downstream exit $?" ); echo "overall exit $?"
    downstream exit 0
    my exit 141
    overall exit 0

So, no, I do not think this is a good idea.  It would be racy.


> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t3600-rm.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 0ea858d652..d1b3703edb 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -252,7 +252,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
>  		i=$(( $i + 1 ))
>  	done | git update-index --index-info &&
>  	# git command is intentionally placed upstream of pipe to induce SIGPIPE
> -	git rm -n "some-file-*" | : &&
> +	test_must_fail ok=sigpipe git rm -n "some-file-*" | : &&
>  	test_path_is_missing .git/index.lock
>  '
