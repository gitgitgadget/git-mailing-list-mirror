Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB422CE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 19:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjIST1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjIST1j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 15:27:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0A29D
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 12:27:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCAD619B4E6;
        Tue, 19 Sep 2023 15:27:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=f/3/zOff+QS+
        dxgkCecV1eBU8OPu5S6lCfO6WkO3DF8=; b=Rv/43q4fRe5aSqwZtZ1B/og/pgMb
        CQ+7NV8+QWg4icTlCqX7EHSOn6rPWzA9iQ8whFaRIAM+q4KAlwZBijl9NAHNXLm5
        gaJisPZDHgP1qi+RuSIoXsOxUWR850JUEROZwNyRhzaOINfc13cGAz0hi5Z2P8G8
        AczHUTPsipttvPM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4D4B19B4E5;
        Tue, 19 Sep 2023 15:27:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B49A19B4E4;
        Tue, 19 Sep 2023 15:27:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/1] range-diff: treat notes like `log`
In-Reply-To: <244e102cc4693bb6291e03cffea6df05cdb29df3.1695144790.git.code@khaugsbakk.name>
        (Kristoffer Haugsbakk's message of "Tue, 19 Sep 2023 20:05:32 +0200")
References: <cover.1694383247.git.code@khaugsbakk.name>
        <cover.1695144790.git.code@khaugsbakk.name>
        <244e102cc4693bb6291e03cffea6df05cdb29df3.1695144790.git.code@khaugsbakk.name>
Date:   Tue, 19 Sep 2023 12:27:30 -0700
Message-ID: <xmqqled2ezfh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 941EFAC0-5722-11EE-8E8D-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Currently, `range-diff` shows the default notes if no notes-related
> arguments are given. This is also how `log` behaves. But unlike
> `range-diff`, `log` does *not* show the default notes if
> `--notes=3D<custom>` are given. In other words, this:
>
>     git log --notes=3Dcustom
>
> is equivalent to this:
>
>     git log --no-notes --notes=3Dcustom
>
> While:
>
>     git range-diff --notes=3Dcustom
>
> acts like this:
>
>     git log --notes --notes-custom
>
> This can=E2=80=99t be how the user expects `range-diff` to behave given=
 that the
> man page for `range-diff` under `--[no-]notes[=3D<ref>]` says:
>
>> This flag is passed to the `git log` program (see git-log(1)) that
>> generates the patches.
>
> This behavior also affects `format-patch` since it uses `range-diff` fo=
r
> the cover letter. Unlike `log`, though, `format-patch` is not supposed
> to show the default notes if no notes-related arguments are given.[1]
> But this promise is broken when the range-diff happens to have somethin=
g
> to say about the changes to the default notes, since that will be shown
> in the cover letter.
>
> Remedy this by introducing `--show-notes-by-default` that `range-diff` =
can
> use to tell the `log` subprocess what to do.

Very well described.  I think the rest of the proposed log message
is redundant now we have quite a good write-up above.

>  ifndef::git-rev-list[]
> +--show-notes-by-default::
> +	Show the default notes (see `--notes`) unless subsequent arguments
> +	are used to display specific notes.
> +
>  --notes[=3D<ref>]::
>  	Show the notes (see linkgit:git-notes[1]) that annotate the
>  	commit, when showing the commit log message.  This is the default

I think the new entry should come after the description of `--notes`,
which is the primary option around the "notes" feature.

In the description, I think "subsequent" is misphrased.  It makes it
sound as if

    $ git log --show-notes-by-default --notes=3Damlog

would stop showing the notes from the default notes tree (because
the notes from the .git/refs/notes/amlog is explicitly asked for),
while

    $ git log --notes=3Damlog --show-notes-by-default

would show both the default and the custom notes, which is not what
the code does, I think, in this hunk:

> @@ -3054,6 +3056,11 @@ int setup_revisions(int argc, const char **argv,=
 struct rev_info *revs, struct s
>  	if (revs->expand_tabs_in_log < 0)
>  		revs->expand_tabs_in_log =3D revs->expand_tabs_in_log_default;
> =20
> +	if (!revs->show_notes_given && revs->show_notes_by_default) {
> +		enable_default_display_notes(&revs->notes_opt, &revs->show_notes);
> +		revs->show_notes_given =3D 1;
> +	}
> +
>  	return left;
>  }

Other than the above minor nits, looks very good.

Thanks.

