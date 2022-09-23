Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A720BC6FA8B
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 16:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiIWQTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiIWQS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 12:18:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7F714DAC3
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 09:17:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F7BE1B763E;
        Fri, 23 Sep 2022 12:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2EzjoL8+GdPF6n/Gb7ymGl5wtJMtbvgr26QJGE
        bx6EQ=; b=DLJoI+Ot0vPn5HQO05JyGh/vxZ8+T4qOR02PTS/52cn5wWRXvMdem8
        VuY1I+MzUZ/HHTr++nRFsGDHZesTIz94RFQbz0B6KSIlqRU/9tWVSKEqxUj2rbDA
        ea9Y3Mvfaf8wCjG1kqrIPLlrmIF9E8YTdBZ96umcbW5SVsPTxb1Lk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15DB81B763C;
        Fri, 23 Sep 2022 12:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 89DB31B763B;
        Fri, 23 Sep 2022 12:17:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
References: <20220922061824.16988-1-jacob@initialcommit.io>
        <20220922232536.40807-1-jacob@initialcommit.io>
Date:   Fri, 23 Sep 2022 09:17:10 -0700
In-Reply-To: <20220922232536.40807-1-jacob@initialcommit.io> (Jacob Stopak's
        message of "Thu, 22 Sep 2022 16:25:36 -0700")
Message-ID: <xmqqillevzeh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DDC03A4-3B5B-11ED-A64E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Stopak <jacob@initialcommit.io> writes:

> To justify why the new year/month groups should have shorthand flags
> while "--group=trailer:value" does not, I'd say that the fact that
> trailer requires a custom value would make the shorthand version clunky,
> and it wouldn't fit in well with other shorthand options like -n or -s.
> Since year/month have no custom value, the flags make a bit more sense
> and would match up with how "-c, --committer" currently works.

It is an explanation why it is easier to implement and design --year
etc., and does not justify why adding --year etc. is a good idea at
all.  Let's not add the "aliases" in the same patch.

>   - `author`, commits are grouped by author
>   - `committer`, commits are grouped by committer (the same as `-c`)
> + - `month`, commits are grouped by month (the same as `-m`)
> + - `year`, commits are grouped by year (the same as `-y`)

It is unclear what timestamp is used, how a "month" is defined, etc.
As "git shortlog --since=2.years" cuts off based on the committer
timestamp, I would expect that the committer timestamps are used for
this grouping as well?  If I make a commit on the first day of the
month in my timezone, but that instant happens to be still on the
last day of the previous month in your timezone, which month would
your invocation of "git shortlog --group=month" would the commit be
attributed?  My month, or your month?

Does it make sense to even say "group by month and year"?  I expect
that it would mean the same thing as "group by month", and if that
is the case, the command probably should error out or at least warn
if both are given.  An alternative interpretation could be, when
told to "group by month", group the commits made in September 2022
into the same group as the group for commits made in September in
all other years, but I do not know how useful it would be.

Not a suggestion to use a different implementation or add a new
feature on top of this --group-by-time-range idea, but I wonder if
it is a more flexible and generalizeable approach to say "formulate
this value given by the --format=<format> string, apply this regular
expression match, and group by the subexpression value".  E.g.

    git shortlog \
	--group-by-value="%cI" \
	--group-by-regexp="^(\d{4}-\d{2})"

would "formulate the 'committer date in ISO format' value, and apply
the 'grab leading 4 digits followed by a dash followed by 2 digits'
regexp, and group by the matched part".

That's a better way to implement "group by month" internally, and
allow more flexibility.  If a project is well disciplined and its
commit titles follow the "<area>: <description>" convention, you
probably could do

    git shortlog --no-merges \
	--group-by-value="%s" \
	--group-by-regexp="^([^:]+):"

and group by <area> each commit touches.  Of course, existing
--committer and --author can also be internally reimplemented using
the same mechanism.

> @@ -80,6 +82,14 @@ counts both authors and co-authors.
>  --committer::
>  	This is an alias for `--group=committer`.
>  
> +-m::
> +--month::
> +	This is an alias for `--group=month`.
> +
> +-y::
> +--year::
> +	This is an alias for `--group=year`.
> +

Let's not add this in the same patch.  I am fairly negative on
adding more, outside "--group".  Besides, we do not have a good
answer to those who want to group by week.  -w is already taken.
