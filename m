Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E82EC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 16:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B7B22B42
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 16:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FRD5mzYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgHDQaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:30:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53733 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHDQaV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 12:30:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7D46D41BF;
        Tue,  4 Aug 2020 12:30:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HsqzJGrpFMEg
        nO2bcXpiHh0w6r8=; b=FRD5mzYeb0H8ynWYd9zu/pGx6dcKpd76uFSpLkhEygwG
        oLmEeS6IwmLigrsrQR73A/Nq5U/lN3ax8qf8Re468d9EU5ZXvrLr8GT8DAE+t0QO
        2zdHKVedVS1NDj/StqQdbUpCI/auj5NEwEOhad6YYM7ifz/8CXw+mV5MI+qPp7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OnDthv
        uUkOGLnvmVN+nF3emX6nr2CClOuf+mqaGPBxUkxzwdPUbwZBLJH/w8zfp/VZHUqD
        g9H6qonC4Yc/RYIOHKsBQeSY1f0zmrK85dj8tucQHeTaGvLtwhyFzTfwgba0KeZI
        25nINQ5Fj8+PPCvNNhS18CDGNk+waGWxIQuqI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEBB6D41BE;
        Tue,  4 Aug 2020 12:30:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0600CD41BC;
        Tue,  4 Aug 2020 12:30:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/3] config: work around gcc-10 -Wstringop-overflow warning
References: <20200804074146.GA190027@coredump.intra.peff.net>
        <20200804074353.GA284046@coredump.intra.peff.net>
Date:   Tue, 04 Aug 2020 09:30:15 -0700
In-Reply-To: <20200804074353.GA284046@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 03:43:53 -0400")
Message-ID: <xmqqv9hys7ag.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C7D250D8-D66F-11EA-8DAD-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Compiling with gcc-10, -O2, and -fsanitize=3Dundefined results in a
> compiler warning:
>
>   config.c: In function =E2=80=98git_config_copy_or_rename_section_in_f=
ile=E2=80=99:
>   config.c:3170:17: error: writing 1 byte into a region of size 0 [-Wer=
ror=3Dstringop-overflow=3D]
>    3170 |       output[0] =3D '\t';
>         |       ~~~~~~~~~~^~~~~~
>   config.c:3076:7: note: at offset -1 to object =E2=80=98buf=E2=80=99 w=
ith size 1024 declared here
>    3076 |  char buf[1024];
>         |       ^~~
>
> This is a false positive. The interesting lines of code are:
>
>   int i;
>   char *output =3D buf;
>   ...
>   for (i =3D 0; buf[i] && isspace(buf[i]); i++)
>           ; /* do nothing */
>   ...
>   int offset;
>   offset =3D section_name_match(&buf[i], old_name);
>   if (offset > 0) {
>           ...
>           output +=3D offset + i;
>           if (strlen(output) > 0) {
> 		  /*
> 		   * More content means there's
> 		   * a declaration to put on the
> 		   * next line; indent with a
> 		   * tab
> 		   */
> 		  output -=3D 1;
> 		  output[0] =3D '\t';
> 	  }
>   }
>
> So we do assign output to buf initially. Later we increment it based on
> "offset" and "i" and then subtract "1" from it. That latter step is wha=
t
> the compiler is complaining about; it could lead to going off the left
> side of the array if "output =3D=3D buf" at the moment of the subtracti=
on.
> For that to be the case, then "offset + i" would have to be 0. But that
> can't happen:
>
>   - we know that "offset" is at least 1, since we're in a conditional
>     block that checks that
>
>   - we know that "i" is not negative, since it started at 0 and only
>     incremented over whitespace
>
> So the sum must be at least 1, and therefore it's OK to subtract one
> from "output".
>
> But that's not quite the whole story. Since "i" is an int, it could in
> theory be possible to overflow to negative (when counting whitespace on
> a very large string). But we know that's impossible because we're
> counting the 1024-byte buffer we just fed to fgets(), so it can never b=
e
> larger than that.
>
> Switching the type of "i" to "unsigned" makes the warning go away, so
> let's do that.
>
> Arguably size_t is an even better type (for this and for the other
> length fields), but switching to it produces a similar but distinct
> warning:
>
>   config.c: In function =E2=80=98git_config_copy_or_rename_section_in_f=
ile=E2=80=99:
>   config.c:3170:13: error: array subscript -1 is outside array bounds o=
f =E2=80=98char[1024]=E2=80=99 [-Werror=3Darray-bounds]
>    3170 |       output[0] =3D '\t';
>         |       ~~~~~~^~~
>   config.c:3076:7: note: while referencing =E2=80=98buf=E2=80=99
>    3076 |  char buf[1024];
>         |       ^~~
>
> If we were to ever switch off of fgets() to strbuf_getline() or similar=
,
> we'd probably need to use size_t to avoid other overflow problems. But
> for now we know we're safe because of the small fixed size of our
> buffer.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thanks.  80 lines of informative log message to explain a one liner
was surprisingly pleasnt to read.  Nicely done.

>  config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index 8db9c77098..2b79fe76ad 100644
> --- a/config.c
> +++ b/config.c
> @@ -3115,7 +3115,7 @@ static int git_config_copy_or_rename_section_in_f=
ile(const char *config_filename
>  	}
> =20
>  	while (fgets(buf, sizeof(buf), config_file)) {
> -		int i;
> +		unsigned i;
>  		int length;
>  		int is_section =3D 0;
>  		char *output =3D buf;
