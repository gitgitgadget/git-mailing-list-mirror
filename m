Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47328C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 13:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AF0224B0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 13:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgLWNfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 08:35:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51812 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgLWNfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 08:35:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30664108870;
        Wed, 23 Dec 2020 08:34:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=NkXyjtSIK8V27AOvPlzXkB/qpeM=; b=tPROhXtf3kS5P6iJwOUG
        kETBUmEH+CMyyLRkLgL20cPUsXRAi3NrzQkCZ3kVeMGlVwv4QD4T6EO9yA2o+Zo2
        q2cLjNG0M330wqXHHl+XdtycanqArUkBpm7BSSN52RW16wx10lPG3nGvR6U9LAep
        1bbVzmuXtEO/5iFb2jzdq0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=odWVfObOBxJuXZSpnkMn2puukzimN70TwslUP4iQ16PnGQ
        Y5xUBqM7zZHKdp93LcKOj7Uaftao3VBr6pUaasUUo4KwSH1cClD2oRQK7KBBFKla
        TbUxE4hcm6AxevNguAVy9ISYpj1v4QIcTTXJjNzqJ8Qu2DNyNOHRUMn/5fe1I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 290BC10886E;
        Wed, 23 Dec 2020 08:34:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B43910886D;
        Wed, 23 Dec 2020 08:34:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Subject: Re: [PATCH v5 1/1] mergetool: add automerge configuration
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
        <20201223045358.100754-2-felipe.contreras@gmail.com>
Date:   Wed, 23 Dec 2020 05:34:24 -0800
Message-ID: <xmqqblekabof.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 936DC0B6-4523-11EB-961E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +auto_merge () {
> +	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
> +	if test -s "$DIFF3"
> +	then

We do not want to ignore the exit status from the command.  IOW, I
think the above wants to be rather

	if git merge-file ... >"$DIFF3" &&
	   test -s "$DIFF3"
	then
		...

to catch a merge-file that writes halfway and then crashes (doing
the same check in different ways are probably possible, of course)

> +		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"

Does everybody's sed take "\?" and interprets it as zero-or-one?
POSIX uses BRE and it doesn't like \? as far as I recall, and "-E"
to force ERE is a GNUism.

> +		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
> +		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"

I'd feel safer if these resulting $BASE, $LOCAL and $REMOTE are
validated to be conflict-marker free (i.e. '^\([<|=>]\)\1\1\1\1\1\1'
does not appear) to make sure there was no funny virtual ancestor
that records a conflicted recursive merge result confused our logic.

When we see an unfortunate sign that it happened, we can revert the
automerge and let the tool handle the original input.

> +	fi
> +	rm -- "$DIFF3"
> +}
> +

"$DIFF3" is always created (unless shell redirection into it fails),
so "rm --" would be fine in practice, I guess, but "rm -f --" would
not hurt.

> +	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"

$MERGETOOL_TMPDIR is either "mktemp -d -t "git-mergetool-XXXXXX" or
".".  Also, we liberally pass "$DIFF3" to "sed" as an argument and
assume that the command would take it as a filename and not an
option.

For the above reason, "rm --", while it is not wrong per-se, can be
just a simple "rm", as there is no funny leading letters in "$DIFF3"
that requires disambiguation.

