Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB75C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 23:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiAMXFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 18:05:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63633 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiAMXFC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 18:05:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB90616126C;
        Thu, 13 Jan 2022 18:05:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xAFoCEqlj3szw+3gHY9zFAiMoMJuOQxxn6GmePQ09K4=; b=Mi/2
        D0SpI886B/DgtDlqJ266NW1U41p9XFV2XpH0oxtqJwHlBVEGvzGYFolQ1M1vqtjZ
        QNoMw9aFxUWyKkdwiZfXEJWUyDIQRe8IIT7z33BJ5IEaloMDLZhFe5VjTWra4pJd
        TV4IlNL6M4soW6vm0yo9gjazC+d+0apRkNjMdtA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3B4C16126B;
        Thu, 13 Jan 2022 18:05:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A987161268;
        Thu, 13 Jan 2022 18:04:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH ab/fsck-unexpected-type] t1450-fsck: exec-bit is not
 needed to make loose object writable
References: <529d99f3-13c8-ffc1-dd4c-3fc70330262a@kdbg.org>
Date:   Thu, 13 Jan 2022 15:04:58 -0800
Message-ID: <xmqqpmovfd9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B384286-74C5-11EC-8EBB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> A test case wants to append stuff to a loose object file to ensure
> that this kind of corruption is detected. To make a read-only loose
> object file writable with chmod, it is not necessary to also make
> it executable. Replace the bitmask 755 with the instruction +w to
> request only the write bit and to also heed the umask. And get rid
> of a POSIXPERM prerequisite, which is unnecessary for the test.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I happened to notice this by chance when I built on Windows today.

Thanks.  Looks quite sensible.

>
>  t/t1450-fsck.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 6337236fd8..de50c0ea01 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -94,13 +94,13 @@ test_expect_success 'object with hash and type mismatch' '
>  	)
>  '
>  
> -test_expect_success POSIXPERM 'zlib corrupt loose object output ' '
> +test_expect_success 'zlib corrupt loose object output ' '
>  	git init --bare corrupt-loose-output &&
>  	(
>  		cd corrupt-loose-output &&
>  		oid=$(git hash-object -w --stdin --literally </dev/null) &&
>  		oidf=objects/$(test_oid_to_path "$oid") &&
> -		chmod 755 $oidf &&
> +		chmod +w $oidf &&
>  		echo extra garbage >>$oidf &&
>  
>  		cat >expect.error <<-EOF &&
