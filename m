Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0921F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 01:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfJLBEC (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 21:04:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52770 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfJLBEC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 21:04:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB9C7A0D62;
        Fri, 11 Oct 2019 21:03:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AG8/ny0bOqLBVnK/kb0oM4TV0PQ=; b=lJS9tT
        LhJRIHQalL/JVnXZrJUfFR2CPN2yo/Cl2noGFEJM3D8/es2kO26OKGza/zeaxT4Q
        Dms+97wxYRO4ulUk07cDK1SsxxGb3DFjWkoqFxwEOctO9PJAnTEOZv5l9YByU6JO
        8scaWCjRacVQH3QAb84PcxO3LGcw8IxkpZt9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HdQekOEBHeKmlKbY6wtFiJFOFvj/prFm
        /DTTZUXDtGHExV9RqLhqkapbCHmjZ5q/XtzM2qG6O+9ON2gOmyk+88fSxOEEeaqk
        bcW0vq5iZIeCEDge6FKaQS0Y3ARADYx+HoawamiznyX/JLqtjreBcbKjvwRP4TQl
        cl1YROEYp6U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A36C9A0D61;
        Fri, 11 Oct 2019 21:03:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D0778A0D60;
        Fri, 11 Oct 2019 21:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     git@vger.kernel.org
Subject: Re: Adding a line after the signed-off git am -s
References: <6797ef7d-5444-4c77-59e6-1d78fd3ccb0c@linaro.org>
Date:   Sat, 12 Oct 2019 10:03:54 +0900
In-Reply-To: <6797ef7d-5444-4c77-59e6-1d78fd3ccb0c@linaro.org> (Daniel
        Lezcano's message of "Fri, 11 Oct 2019 16:43:45 +0200")
Message-ID: <xmqq7e5ag4g5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AC5D77E-EC8C-11E9-904A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> I would like to do something:
>
> git am -s -l "Link: https://lore.kernel.org/r/<msgid>"
>
> Which will give:
>
> blabla
>
> Signed-off-by: author@kairnail.org
> Signed-off-by: commiter@kairnail.org
> Link: https://lore.kernel.org/r/<msgid>
>
> This way it is compatible with patchwork, git-pw, etc...

There is the post-applypatch hook you can define after the patch
gets applied and produces a commit.

I use it to maintain the amlog notes in my repository (iow, I do not
amend the commit, but add notes to the resulting commit so that I
can tell, given a commit, which message resulted in it).  

If you want to amend the resulting commit instead, the place to do
so would be where I call "git notes --ref amlog" in the sample
script.

-- >8 -- post-applypatch hook example -- >8 --
#!/bin/sh

GIT_DIR=.git
dotest="$GIT_DIR/rebase-apply"

prec=4 &&
this=$(cat 2>/dev/null "$dotest/next") &&
msgnum=$(printf "%0${prec}d" $this) &&
test -f "$dotest/$msgnum" &&
message_id=$(sed -ne '
	/^[ 	]/{
		# Append continuation line to hold space
		H
		# Swap hold and pattern
		x
		# Remove the LF, making it a single line
		s/\n//
		# Swap hold and pattern back
		x
		# Discard the pattern and go on
		n
	}
	# Hold this new line, and look at what is in the hold space
	x
	# Is it the Message-ID line?  If so, spit it out and finish.
	/^[Mm][Ee][Ss][Ss][Aa][Gg][Ee]-[Ii][Dd]:[ 	]*/{
		s///p
		q
	}
	# Otherwise, check if this new line is empty
	x
	# Is it?  Then we are done with the header
	/^$/b end
	# Otherwise we need to hold onto this header line
	x
	# And start the next cycle
	b
: end
	# ??? do we want to check if we held onto the last message-id line
	# and process it here if we did???
	q
' "$dotest/$msgnum") &&

if	test -n "$message_id" &&
	head=$(git rev-parse --verify HEAD 2>/dev/null)
then
	echo "$head $message_id" >>"$GIT_DIR"/am.log &&
	git notes --ref amlog add -f -m "Message-Id: $message_id" "$head"
fi
