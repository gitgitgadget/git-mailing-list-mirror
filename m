Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9737C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJUWak (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJUWah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:30:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742E275DD5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:30:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4348B1B40D3;
        Fri, 21 Oct 2022 18:30:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UUxplj0THuDh
        M0vafjq63O+wAoty5CRc6GvMBgec9LE=; b=PQiIEw1/WXvfI28Ldf6rJNbid4u5
        mNJfQo8Nly8q+EjE61IzKlvxNNYihXNLjFm2+3r41gS/cAkL27KFHQ1Of778FKjB
        sfsbb4ZWohFObYXZC5SG/9NgGrXauw4OvJ+KhDrbEGbL4r7fSBKVRcz3Sgydlrxl
        twc0xSgcth7Bj6Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B8311B40D2;
        Fri, 21 Oct 2022 18:30:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E04D1B40D0;
        Fri, 21 Oct 2022 18:30:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/4] repack: use tempfiles for signal cleanup
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
        <Y1MTJz3wy5xDEPEH@coredump.intra.peff.net>
Date:   Fri, 21 Oct 2022 15:30:29 -0700
In-Reply-To: <Y1MTJz3wy5xDEPEH@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 21 Oct 2022 17:46:15 -0400")
Message-ID: <xmqqmt9oizcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F833BC10-518F-11ED-B176-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This patch also fixes another small problem. We only hook signals, and
> don't set up an atexit handler. So if we see an error that causes us to
> die(), we'll leave the .tmp-* files in place. But since the tempfile AP=
I
> handles this for us, this is now fixed for free. The new test covers
> this by stimulating a failure of pack-objects when generating a cruft
> pack. Before this patch, the .tmp-* file for the main pack would have
> been left, but now we correctly clean it up.
>
> Reported-by: Jan Pokorn=C3=BD <poki@fnusa.cz>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/repack.c  | 17 ++++-------------
>  t/t7700-repack.sh |  8 ++++++++
>  2 files changed, 12 insertions(+), 13 deletions(-)

Nice. =20

>  struct generated_pack_data {
> -	char exts[ARRAY_SIZE(exts)];
> +	struct tempfile *tempfiles[ARRAY_SIZE(exts)];
> ...
> -		data->exts[i] =3D 1;
> +		data->tempfiles[i] =3D register_tempfile(path.buf);

OK.

>  	}
> =20
>  	strbuf_release(&path);
> @@ -867,8 +860,6 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
>  		split_pack_geometry(geometry, geometric_factor);
>  	}
> =20
> -	sigchain_push_common(remove_pack_on_signal);
> -
>  	prepare_pack_objects(&cmd, &po_args);
> =20
>  	show_progress =3D !po_args.quiet && isatty(2);
> @@ -1020,14 +1011,14 @@ int cmd_repack(int argc, const char **argv, con=
st char *prefix)
>  			fname_old =3D mkpathdup("%s-%s%s",
>  					packtmp, item->string, exts[ext].name);
> =20
> -			if (data->exts[ext]) {
> +			if (data->tempfiles[ext]) {
>  				struct stat statbuffer;
>  				if (!stat(fname_old, &statbuffer)) {
>  					statbuffer.st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
>  					chmod(fname_old, statbuffer.st_mode);
>  				}
> =20
> -				if (rename(fname_old, fname))
> +				if (rename_tempfile(&data->tempfiles[ext], fname))
>  					die_errno(_("renaming '%s' failed"), fname_old);

It now got a bit confusing that we have 'fname', 'fname_old', and
the tempfile.  The path.buf used as the argument to register_tempfile()
matches what is used to compute fname_old above.  I wonder if tempfile
API does not give us that name so that we can stop using fname_old here?

