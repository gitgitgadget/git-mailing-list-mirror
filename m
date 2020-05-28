Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20D4C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE31E20663
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wfk6gvgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404265AbgE1PUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 11:20:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55068 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404236AbgE1PUN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 11:20:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7375FD24AC;
        Thu, 28 May 2020 11:20:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KUFWsiuDx5QN
        aaMXgEqP2BO9LDc=; b=Wfk6gvgLn7sXkOau8HJcelN2/uDVppVTXR1bfFaucH8x
        HVbeANTiHzjw6hI4Q+RWmauCAyHkNtxHMffhUhGjsfBxCOhjTVdFlFnktwsF93Zq
        3JrQ95OGlP47lCGypTR3bdmSPxpy45AHYh/0l1O4oA9PD1sLTfhZWN4BzIilzag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IyOQUL
        ujrKj3A/NLNfezCTYNrQY3MP+wHH49sRgGDCaTG/OS1cK357MVTxYUKqYDyP9B6F
        Zq50WLXy82GJlD3rEYVyJ4WpGs0cdmbR9PhAqiAThAeCP82nETBrldEb0/hoRiol
        NNdHf+uGeg449roAHvrWu6NasEjzd7rZEMEbQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AFB0D24AB;
        Thu, 28 May 2020 11:20:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DE42D24A9;
        Thu, 28 May 2020 11:20:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hji@dyntopia.com
Subject: Re: [PATCH] t: avoid alternation (not POSIX) in grep's BRE
References: <20200528083745.15273-1-carenas@gmail.com>
Date:   Thu, 28 May 2020 08:20:04 -0700
In-Reply-To: <20200528083745.15273-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 28 May 2020 01:37:45 -0700")
Message-ID: <xmqqo8q83x3v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B61CE3CA-A0F6-11EA-B57D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Using and escaped '|' for alternations is allowed in some implementatio=
ns
> of grep (GNU and busybox, al least), but it is no suppored by POSIX[1]
> and therefore will fail in at least macOS and the BSD.
>
> Change syntax to ERE and use Extended regular expression with grep
> explicitly.

Thanks.

> [1] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09=
.html#tag_09_03
>
> Fixes: f1e3df3169 (t: increase test coverage of signature verification
>        output, 2020-03-04)

I do appreciate the information recorded in the log message, but not
like this.  Does everybody's tool understand the "folding" the above
two physical lines require to be able to handle it correctly?

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t4202-log.sh           | 2 +-
>  t/t6200-fmt-merge-msg.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index f1ea7d97f5..a0930599aa 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1692,7 +1692,7 @@ test_expect_success GPG 'log --graph --show-signa=
ture for merged tag with missin
>  	GNUPGHOME=3D. git log --graph --show-signature -n1 plain-nokey >actua=
l &&
>  	grep "^|\\\  merged tag" actual &&
>  	grep "^| | gpg: Signature made" actual &&
> -	grep "^| | gpg: Can'"'"'t check signature: \(public key not found\|No=
 public key\)" actual
> +	grep -E "^| | gpg: Can'"'"'t check signature: (public key not found|N=
o public key)" actual
>  '
> =20
>  test_expect_success GPG 'log --graph --show-signature for merged tag w=
ith bad signature' '
> diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
> index b15582a7a2..e4c2a6eca4 100755
> --- a/t/t6200-fmt-merge-msg.sh
> +++ b/t/t6200-fmt-merge-msg.sh
> @@ -103,7 +103,7 @@ test_expect_success GPG 'message for merging local =
tag signed by unknown key' '
>  	GNUPGHOME=3D. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
>  	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
>  	grep "^# gpg: Signature made" actual &&
> -	grep "^# gpg: Can${apos}t check signature: \(public key not found\|No=
 public key\)" actual
> +	grep -E "^# gpg: Can${apos}t check signature: (public key not found|N=
o public key)" actual
>  '
> =20
>  test_expect_success 'message for merging external branch' '
