Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894D8C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 20:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6785B20739
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 20:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vdbJnPhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGHUyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:54:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61929 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGHUyF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 16:54:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AD85E8CDF;
        Wed,  8 Jul 2020 16:54:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d7LvYHgaydgONNhJG8gB5EzDJ9c=; b=vdbJnP
        hqAvrwDZTIXCeOIANzwN+YxCLYlAEU7qrI/qZwo9OtO0RZfWsheQPpxROsfE2Ddk
        y4OWzobhUvM38PwyeIQBSxSVlyze2DcvO+0b0shDEi5GsekD1wJqyV1AY10dd0b8
        mpg3tK14f1D7TeUVQqIcrKjL+hJBn9d6bA3NU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CCZWFBDgrT8NGLCUvuRE2myttx4+fI7I
        tRpbdbLiho5Kswb8QTSv9kSOQ/n8FLsLoD9RvfPzzz2+vki55uyXAReIeXPTl/OL
        S+nN513XHTUiwtkR5+yV9UuG5bAHHzohdNdWxqcKRRtRBjbKIhu9fxAjPIRbjJlW
        ieibEm4QV2s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 938E8E8CDE;
        Wed,  8 Jul 2020 16:54:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA13AE8CDD;
        Wed,  8 Jul 2020 16:53:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Bektchiev via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Martin Bektchiev <martinb@gmail.com>,
        Martin Bektchiev <martin.bektchiev@progress.com>
Subject: Re: [PATCH] commit: correctly escape @ of stashes
References: <pull.815.git.git.1593768655179.gitgitgadget@gmail.com>
        <xmqqv9j19mgn.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2007070114060.50@tvgsbejvaqbjf.bet>
Date:   Wed, 08 Jul 2020 13:53:56 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2007070114060.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 7 Jul 2020 01:14:59 +0200 (CEST)")
Message-ID: <xmqqo8op20ez.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24A450A4-C15D-11EA-968C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In fact, I just tried
>>
>>     $ git stash show stas<TAB>
>>
>> in a test repository where there is only one stash entry and got it
>> completed to
>>
>>     $ git stash show stash@{0}
>>
>> and pressing <Enter> from this state did exactly what I expected to
>> see.
>>
>> > Reproducible on `GNU bash, version 3.2.57(1)-release` and
>> > `macOS Catalina 10.15.5`.
>>
>> What did you reproduce?  The completion gave me "stash@{0}" (without
>> surrounding double quotes) in my above experiment?  If so, that does
>> seem reproducible, but I do not see "suggestions ... are broken" here.
>
> The problem is visible when you have more than one stash. If
> you press TABm autocompletion stops at the `{` and if you then
> press TAB once more for a list of all stashes instead of that
> the completion changes to `stashstash{` and becomes broken at
> this point.

That does not reproduce for me.

    $ git stash show stas<TAB>

completes to

    $ git stash show stash@{

and any more <TAB> changes the command line, which is what I expect,
as it would be stupid to offer stash@{0} and stash@{1} (and others)
as possible completion candidates.

Also I just tried this (manually)

    $ git stash show stash\@{<TAB>

and did not get any more extra completion.

    $ set | grep ^BASH_VERSION=
    BASH_VERSION='5.0.16(1)-release'

As long as the change does not make things worse for users of newer
bash, it is OK to make things better for users of ancient versions
of bash.  It might already be considered a worse end-user experience
than what we have now to show partly-spelled stash reference as
"stash\@{" with backslash, though.

Another thing I noticed is that you shouldn't need two separate
processes of "sed" to do what you want to do.

>> > @@ -2999,12 +2999,14 @@ _git_stash ()
>> >  				__git_complete_refs
>> >  			else
>> >  				__gitcomp_nl "$(__git stash list \
>> > -						| sed -n -e 's/:.*//p')"
>> > +						| sed -n -e 's/:.*//p' \
>> > +						| sed 's/@/\\@/')"

The first and the original one -n -e "s/:.*//p" wants to show no
lines by default, unless it finds a colon on the line and strip it
and everything that follows.  You then further want to tweak that
and prefix a backslash before the first '@' you find.  So perhaps
something along the lines of...

	sed -n -e '/:/{
		s/:.*//
		s/@/\\@/
		p
	}'

... which is "show no lines by default, but on a line with a colon,
strip the colon and everything that follows, and then prefix the
first '@' on the line, if exists, with backslash, and show the result".

Having said that, I am very skeptical to any "solution" that has to
show "stash\@{" to end-users.  And with the patch, newer versions of
bash does seem to show the stupid "all stash entries, numbered",
i.e.

    $ git stash show stas<TAB>
    -->
    $ git stash show stash\@{
    
    $ git stash show stash\@{<TAB>
    stash\@{0}   stash\@{1}

I wonder what unpleasant end-user experience I may have to endure if
I had dozens of stash entries.  The list shows only the numbers, so
it does not help me decide which number to type at all.

A solution to allow older versions of bash to complete

    $ git stash show stas<TAB>
    -->
    $ git stash show stash@{

    $ git stash show stash@{<TAB>
    -->
    $ git stash show stash@{

would be very much welcomed, though.

Thanks.


