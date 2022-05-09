Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5731C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiEIP4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbiEIP4P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 11:56:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0A1C7669
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:52:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA079133756;
        Mon,  9 May 2022 11:52:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0LuUHTQt1E//
        RIMAC+WBKVdJbbi5CZgoxVJAlC7FnOc=; b=XHLZd8DjIcFlYdezgpgrLSxj1KsE
        sutVJ8h9TvLgLRpqoqBuR9EI7y6ZW7bY9DKDDsIA+mxmGlfp1DsnOdzaw8o3tZAB
        B++QDeH2bxWunLSUxQi3rIaDSCIBoJXhto9CdkaomRi/fjXUGdv1b0VK+wEiAg+w
        afDCdP5tqj8+NPQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF714133755;
        Mon,  9 May 2022 11:52:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 36D1E133754;
        Mon,  9 May 2022 11:52:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] detect-compiler: make detection independent of locale
References: <cover.1651859773.git.git@grubix.eu>
        <f306f43f375bc9b9c98e85260587442e5d9ef0ba.1652094958.git.git@grubix.eu>
Date:   Mon, 09 May 2022 08:52:16 -0700
In-Reply-To: <f306f43f375bc9b9c98e85260587442e5d9ef0ba.1652094958.git.git@grubix.eu>
        (Michael J. Gruber's message of "Mon, 9 May 2022 13:22:02 +0200")
Message-ID: <xmqq7d6ug0un.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 012A8AC2-CFB0-11EC-B255-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> `detect-compiler` has accumulated a few compiler dependent workarounds
> lately for the more and more ubiquitious gcc12. This is intended to mak=
e
> CI set-ups work across tool-chain updates, but also help those
> developers who build with `DEVELOPER=3D1`.
>
> Alas, `detect-compiler` uses the locale dependent output of `$(CC) -v`
> to parse for the version string, which fails unless it literally
> contains ` version`.
>
> Use `LANG=3DC $(CC) -v` instead to grep for stable output.

I think this patch is a bit insufficient.

    $ LC_ALL=3Dja_JP.utf8 LANG=3DC gcc -v 2>&1 | head -n 1
    =E7=B5=84=E3=81=BF=E8=BE=BC=E3=81=BF spec =E3=82=92=E4=BD=BF=E7=94=A8=
=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E3=80=82
    $ LC_ALL=3DC LANG=3Dja_JP.utf8 gcc -v 2>&1 | head -n 1
    Using built-in specs.

In theory overriding LC_ALL alone may be sufficient these days where
everybody seems to know about LC_*, but just out of habit, I would
recommend forcing both, i.e.

>  get_version_line() {
> -	$CC -v 2>&1 | grep ' version '
> +	LANG=3DC $CC -v 2>&1 | grep ' version '

this on top of the posted patch, which is what I'll squash in when
queuing this patch (no need to resend if you agree with the above
and unless you have other changes and improvements).

Thanks.

diff --git i/detect-compiler w/detect-compiler
index 473f3bd4fe..50087f5670 100755
--- i/detect-compiler
+++ w/detect-compiler
@@ -9,7 +9,7 @@ CC=3D"$*"
 #
 # FreeBSD clang version 3.4.1 (tags/RELEASE...)
 get_version_line() {
-	LANG=3DC $CC -v 2>&1 | grep ' version '
+	LANG=3DC LC_ALL=3DC $CC -v 2>&1 | grep ' version '
 }
=20
 get_family() {
