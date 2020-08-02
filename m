Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A9C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 00:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F1520789
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 00:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TL8DH2uI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHBApT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 20:45:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59454 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBApT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 20:45:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2679DCA14;
        Sat,  1 Aug 2020 20:45:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3XkOXBmEx9kP
        GBevCDmkb8FUqBk=; b=TL8DH2uIPDxu1zb4/V1mv8Fyq0M3bFkGtVSgO7nQvAJG
        1581NRENbhk4FcjZf4hGyVsem8VH7+NhNlBXWu414hp/Iy4IiKgVBKjcgtF4ftG+
        Pt2Bv1dmVzMGECDyfRaIlPpRY12RJ7MNK1fG2E2XZK4swl6j+vucEqvMhZJG/0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZAAmQz
        e3XOoPb26XT9oUy78KMqgr116oiUgb0f88m1wmTDsK6BB4nfmNUJDuRJT/aef1FW
        Nvbw9m7mrjpQ/6+m0YETc1+I/oke7lbMIxdp+76Ld5e79OqSGVU5h1QfyntrljRt
        IkHTAGlbZmjhlfELgzEPveLwcH44uM2vrTjQ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB01FDCA13;
        Sat,  1 Aug 2020 20:45:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 238AFDCA11;
        Sat,  1 Aug 2020 20:45:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] t1450: fix quoting of NUL byte when corrupting pack
References: <20200801220611.10453-1-martin.agren@gmail.com>
Date:   Sat, 01 Aug 2020 17:45:11 -0700
In-Reply-To: <20200801220611.10453-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sun, 2 Aug 2020 00:06:11 +0200")
Message-ID: <xmqqmu3d27vs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6CD9645E-D459-11EA-80D7-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We use
>
>   printf '\0'
>
> to generate a NUL byte which we then `dd` into the packfile to ensure
> that we modify the first byte of the first object, thereby
> (probabilistically) invalidating the checksum. Except the single quotes
> we're using are interpreted to match with the ones we enclose the whole
> test in. So we actually execute
>
>   printf \0
>
> and end up injecting the ASCII code for "0", 0x30, instead.
>
> The comment right above this `printf` invocation says that "at least on=
e
> of [the type bits] is not zero, so setting the first byte to 0 is
> sufficient". Substituting "0x30" for "0" in that comment won't do: we'd
> need to reason about which bits go where and just what the packfile
> looks like that we're modifying in this test.
>
> Let's avoid all of that by actually executing
>
>   printf "\0"
>
> to generate a NUL byte, as intended.

Thanks.  Very well explained.

I wonder if it is an easy way to find similar problems without too
much hand-parsing of the test scripts.  Inside a modern test_expect_*
that begins and ends the test body with a single quote, any line
that has a single quote that is not quoted could be suspect, but
that would probably give us too many false positive.


> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  If my reading is correct, when we substitute 0x30, the type will be 3
>  (blob) and the size will be zero. So there might actually exist
>  formally valid packfiles where this byte that we're modifying is
>  already zero. What matters in the end is whether we might be using suc=
h
>  a packfile in this exact test and from what I can tell, no, we won't b=
e
>  doing that.
>
>  t/t1450-fsck.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 344a2aad82..af2a2c4682 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -714,7 +714,7 @@ test_expect_success 'fsck fails on corrupt packfile=
' '
>  	# at least one of which is not zero, so setting the first byte to 0 i=
s
>  	# sufficient.)
>  	chmod a+w .git/objects/pack/pack-$pack.pack &&
> -	printf '\0' | dd of=3D.git/objects/pack/pack-$pack.pack bs=3D1 conv=3D=
notrunc seek=3D12 &&
> +	printf "\0" | dd of=3D.git/objects/pack/pack-$pack.pack bs=3D1 conv=3D=
notrunc seek=3D12 &&
> =20
>  	test_when_finished "rm -f .git/objects/pack/pack-$pack.*" &&
>  	remove_object $hsh &&
