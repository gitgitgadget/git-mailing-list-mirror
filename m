Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AEBECAAD3
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 16:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiINQkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiINQkL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 12:40:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A4A1261D
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 09:40:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49EB61C778C;
        Wed, 14 Sep 2022 12:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Vg11RCb9D5Dg
        bx/xYWlZJar2H0CBiieuCoPXNmUJlYE=; b=nn3n4LCl8d5x0JeSr1Guc6DQEIqF
        UPAh4LfMe3tMxmNMkIqELUWBBbH04gkVYTYgp12EfhG4GLlxYkP+jAgO7IXRZ2Ih
        xOnmpWUbxVuiQ84c7zUCANzlJQKGhtccL/7Ns9SGiYL5Ryq3mxnQEGNj8v7pG6Ii
        vPUBg8TXclAvVcE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 417971C778B;
        Wed, 14 Sep 2022 12:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE81E1C7788;
        Wed, 14 Sep 2022 12:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth()
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
        <20220914151333.3309-1-tboegi@web.de>
Date:   Wed, 14 Sep 2022 09:40:04 -0700
In-Reply-To: <20220914151333.3309-1-tboegi@web.de> (tboegi@web.de's message of
        "Wed, 14 Sep 2022 17:13:33 +0200")
Message-ID: <xmqqpmfx52qj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E346BA7A-344B-11ED-A684-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The basic idea is to change code in diff.c like this
> strbuf_addf(&out, "%-*s", len, name);
>
> into something like this:
> int padding =3D len - utf8_strwidth(name);
> if (padding < 0)
> 	padding =3D 0;
> strbuf_addf(&out, " %s%*s", name, padding, "");
> ...
> Reported-by: Alexander Meshcheryakov <alexander.s.m@gmail.com>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  diff.c                 | 27 ++++++++++++++++-----------
>  t/t4012-diff-binary.sh | 14 +++++++-------
>  2 files changed, 23 insertions(+), 18 deletions(-)

> diff --git a/diff.c b/diff.c
> index 974626a621..35b9da90fe 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2620,7 +2620,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
>  			continue;
>  		}
>  		fill_print_name(file);
> -		len =3D strlen(file->print_name);
> +		len =3D utf8_strwidth(file->print_name);
>  		if (max_len < len)
>  			max_len =3D len;

The changes in this patch are isolated to the show_stats() helper
function, and looking at use of "len", "max_len", and "name_len", it
may be a good clean-up to make them based on "width".  A bit of care
needs to be taken because the way existing variables are used is a
bit convoluted at times:

 - "width" already exists.  "len" and "max_len" are used in an early
   loop to eventually derive "name_width".

 - "len" is later used in the loop for each pathname to hold a copy
   of "name_width" that can locally be adjusted to accomodate "..."
   abbreviation/munging of the pathname.

 - "name_width" already exists in addition to "name_len".  The
   former holds how many display columns a pathname can occupy in the
   diffstat output, while the latter is used in a loop to hold the
   display columns of the pathname each iteration is looking at, to
   see if it is wider than "name_width" (in which case there is the
   "..." abbreviation that is NOT UTF-8 aware even after this patch)
   or narrower (in which case we'd do the padding).  As the existing
   "name_width" is how we want to name our variables (i.e. the width
   allocated for names), the "name_len", if we were to follow "len
   misleads us to think it is byte length, so use width instead",
   would need to become something like "this_name_width" (i.e. the
   width of the name of the pathname in this iteration of the loop).

But I am OK to do WITHOUT any such renaming, and I do not want to
see such renaming in the same patch ("preliminary clean-up" or
"clean-up after the dust settles" are good, thoguh).  Counting
display columns correctly is more important.

I think I spotted two remaining "bugs" that are left unfixed with
this patch..

There is "stat_width is -1 (auto)" case, which reads like so:

	if (options->stat_width =3D=3D -1)
		width =3D term_columns() - strlen(line_prefix);
	else
		width =3D options->stat_width ? options->stat_width : 80;

Here line_prefix eventually comes from the "git log --graph" and
shows the colored graph segments on the same output line as the
diffstat.

This patch is probably not making anything worse, but by leaving it
strlen(), it is likely overcounting the width of it.  We can
presumably use utf8_strnwidth() that can optionally be told to be
aware of the ANSI color sequence to count its width correctly to fix
it.

> @@ -2743,7 +2743,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
>  		 * "scale" the filename
>  		 */
>  		len =3D name_width;
> -		name_len =3D strlen(name);
> +		name_len =3D utf8_strwidth(name);
>  		if (name_width < name_len) {
>  			char *slash;
>  			prefix =3D "...";

The code around here between this and the next hunk needs cleaning up.

		if (name_width < name_len) {
			char *slash;
			prefix =3D "...";
			len -=3D 3;
			name +=3D name_len - len;
			slash =3D strchr(name, '/');
			if (slash)
				name =3D slash;
		}

We found the display columns of the current item "name_len" is wider
than what we allocated "name_width" for the names.  We are going to
chomp as many pathname components from the front as needed, at '/'
boundary, to turn "aaaa/bbbb/cccc/dddd.txt" into ".../cccc/dddd.txt"
to make the result fit.

But the way to ensure that '/' before "cccc" is the one we want (as
opposed to the one before "bbbb" or "dddd") is initially based on
columns (i.e. because we want "...", we first subtract 3 from len
which is a local synonym for name_width and then subtract that from
"name_len", i.e. we ask: "how many display columns do we have in the
current pathname that is excess of what we can afford to allocate?"
The intention is to skip that many columns from the beginning of "name"
and start looking for '/' from there.

But we move "name" pointer by that many *bytes*!  We end up scanning
starting at a middle of a character.  What we look for is '/' and when
we find it we know the byte is a standalone character, so we do not
chomp a character in the middle, but it is very likely that we find
a slash that leaves the remaining string still too long, because
skipping say 2 columns may need skipping 4 bytes, but we only
skipped the same number of bytes as the number of columns we need to
skip.

This is the other remaining bug.

I think this needs to become a loop that loops while the width of
the current suffix is still wider than we can afford, discarding one
leading pathname component at a time at '/', measuring the resulting
width, or something like that.  Something along the lines of this
not-even-compile-tested sketch:

        /* we assume strlen(prefix) =3D=3D utf8_strwidth(prefix) */
	while (name_width < utf8_strwidth(name) + strlen(prefix)) {
		char *slash;
		if (name[0] =3D=3D '/')
			name++;
                slash =3D strchr(name);
		if (slash)
			name =3D slash;
		else
			break; /* Give Up */
		prefix =3D "...";
	}

> @@ -2753,10 +2753,14 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
>  			if (slash)
>  				name =3D slash;
>  		}
> +		padding =3D len - utf8_strwidth(name);
> +		if (padding < 0)
> +			padding =3D 0;

Here "len" cannot become "name_length" because the former has to be
narrower than the latter by the display width of "prefix"
(i.e. "..."), so while this looks "strange", it is correct.

I think the remainder of the patch I did not quote looked quite
straight-forward and correct.

Thanks for working on this topic.
