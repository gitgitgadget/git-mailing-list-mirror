Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3622047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdGZX3Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:29:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55008 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751406AbdGZX3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 19:29:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEBEA9358B;
        Wed, 26 Jul 2017 19:29:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fcrmt9FWFNxibRJzs1d8g+luZrc=; b=uW8Bwt
        pT85WrCuAlnVljomZ7dQU2C72e7OcqigXnI9u2NlIXys+G0ZEIj9UW8DwEWZY1cr
        lxhOW0YCZ0KRQZT1dV9xwCKEYDQxtnwQQm3zA8qLAzS3Y6wNXWol8/VI14gAXkP+
        jAV9uzw4/fALfoalxB468Nbq0bPjHQ3mwdB04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ILJS2fzGtyH9Y4EN0srTaHQAjjzyJ65g
        fs0+0+42EB9v+v3/mEr983/GilX+iD1FdMmgd0kHLMg48Wdjw9b/qCptgTre5iML
        08AFq4eAz8pyC5gej0ilAhU4rdntzxu+bmEyYWfZ7KyLMfqoy7JwYEv1bMuTZ/6r
        W+uNbJ+SYUM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7D179358A;
        Wed, 26 Jul 2017 19:29:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48E5D93589;
        Wed, 26 Jul 2017 19:29:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv2] builtin/blame: highlight interesting things
References: <20170613023151.9688-1-sbeller@google.com>
        <20170726230425.24307-1-sbeller@google.com>
Date:   Wed, 26 Jul 2017 16:29:12 -0700
In-Reply-To: <20170726230425.24307-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 26 Jul 2017 16:04:25 -0700")
Message-ID: <xmqqwp6uojzr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C57F8A4-725A-11E7-924F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When using git-blame lots of lines contain redundant information, for
> example in hunks that consist of multiple lines, the metadata (commit name,
> author) are repeated. A reader may not be interested in those, so darken
> (commit, author) information that is the same as in the previous line.
>
> Choose a different approach for dates and imitate a 'temperature cool down'
> for the dates. Compute the time range of all involved blamed commits
> and then color
>  * lines of old commits dark (aged 0-50% in that time range)
>  * lines of medium age normal (50-80%)
>  * lines of new age red (80-95%)
>  * lines just introduced bright yellow (95-100%)
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>   I played around with it a bit more, using a different color scheme
>   for dates, http://i.imgur.com/redhaLi.png

I do agree with what this one tries to do, in that a block of lines
tend to share the same metainfo as they come from the same commit
and it is distracting to see them repeatedly---doing something to
make their "these are in one group" nature stand out will give us a
much better presentation.

But does this particular implementation work well for people who use
black in on white background?  "Darken to make it less distracting"
may not work on both white-on-black and black-on-white users.

"Show the background only by replacing the letters with SP for
metainfo that are same as previous line" would work for folks from
either camp, I would imagine.  And that should be a single feature,
that can be enabled independently from the age based coloring.

The age coloring is much harder to make it work for folks from both
camps at the same time with the same color selection.  Yellow on
white would be terribly unreadable for black-on-white folks, for
example.

If you make "make it less distracting by blanking them out (not
'darken them')" feature without the age coloring, that can be usable
immediately by folks from both camps, even if you cannot find a way
to do the age coloring that would satisfy both groups.  One group
can just leave the knob off and not use the age coloring, while the
other group can use it and people from both camps will be happier
than the status quo.

Thanks.
