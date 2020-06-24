Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360FFC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018A220723
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wJKoQx66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404147AbgFXP0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:26:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59576 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403831AbgFXP0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:26:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3A1BCA26F;
        Wed, 24 Jun 2020 11:26:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hJtaGhdni501egGQdHxcH6psTGM=; b=wJKoQx
        66DSRcJlx/hiayl8G0mBcP6XWPo7K7t8kISmtf5nKq+1wXyg//rbrRPpozxNQVnM
        yss/iWPeoLya/ZFu/wj0+Eah7iXd3vz5Myj7CGkb2qw8/vwrHmW5oHsZ3vdmFJFu
        VZsJYoDzEk9M0eI5ymUCFAM4NGAZ/mm+H6RJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XJxWbDm/5ROcEd9U2w1c43vr+gby8Koi
        TqIxgBUneNxLIaJEaQt6ABz3iwA//1j8ibpXipYMr9uX0etQdUZsS5fpsdTsUNgk
        AI0ufRB5wj9z7AvbzyrRhNHhW6xENc619Q/4aQ6HOF+jgeC7qAx1iI3QxYKbcVNw
        GLV5RcWwDkA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC6AFCA26C;
        Wed, 24 Jun 2020 11:26:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5AF03CA268;
        Wed, 24 Jun 2020 11:26:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: Re: [PATCH v2 1/3] diff-files --raw: handle intent-to-add files correctly
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
        <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
        <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com>
        <xmqqzh8t9vf5.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006241517320.54@tvgsbejvaqbjf.bet>
Date:   Wed, 24 Jun 2020 08:26:33 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006241517320.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 24 Jun 2020 15:26:20 +0200 (CEST)")
Message-ID: <xmqqy2oc8oye.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17011D1C-B62F-11EA-BD20-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Sure, but my intention was to synchronize the `--raw` vs the `--patch`
> output: the latter _already_ shows the correct hash. This here patch makes
> the hash in the former's output match the latter's.

That is shooting for a wrong uniformity and breaking consistency
among the `--raw` modes.

 $ git reset --hard
 $ echo "/* end */" >cache.h ;# taint
 $ git diff-files --raw
 ... this shows (M)odified with 0{40} on the postimage
 ... 0{40} for side that is known to have contents from low-level diff
 ... means "object name unknown; figure it out yourself if you need it"
 $ git update-index cache.h
 $ git diff-files --raw
 ... of course we see nothing here.  Wait for a bit.
 $ touch cache.h ;# smudge
 $ git diff-files --raw
 ... this shows (M)odified with 0{40} on the postimage
 ... again, it says "it is stat dirty so I do not bother to compute"
 $ git update-index --refresh
 $ git diff-files --raw
 ... again we see nothing.

Any tools that work on "--raw" output must be already prepared to
see 0{40} on the side that is known to have contents and must know
to grab the contents from the working tree file if they need them,
so showing the 0{40} for i-t-a entry (whose definition is "the user
said in the past that the final contents of the file will be added
later, but Git does not know what object it will be yet") cannot
break them.  And the behaviour of giving 0{40} in such a case aligns
well with what is already done for paths already added to the index
when Git does not have an already-computed object name handy.

> Besides, we're talking about the post-image of `diff-files`, i.e. the
> worktree version, here. I seem to remember that the pre-image already uses
> the all-zero hash to indicate precisely what you mentioned above.

The 0{40} you see for pre-image for (A)dded paths means a completely
different thing from the 0{40} I have been explaining in the above,
so that is not relevant here.

By definition, there is *no* contents for the pre-image side of
(A)dded paths (that is why I stressed the "side that must have
contents" in the above description---it is determined by the type of
the change), but because the format requires us to place some
hexadecimal there, we fill the space with 0{40}.  

When we do not know the object name for the side that is known to
have contents without performing extra computation (including "stat
dirty so we cannot tell without rehashing"), we also use 0{40} as a
signal to say "we do not know the actual contents", but the consumer
of "--raw" format is expected to know the difference between "this
side is known to have no data and 0{40} is here as filler" and "this
side must have contents but we see 0{40} because Git does not have
it handy in precomputed form".

The above is the same for "diff-index --raw" without "--cached";
when we have to hash before we can give the object name (e.g. the
path is stat-dirty), we give 0{40} and let the consumer figure it
out if it needs to.

 $ git reset --hard
 $ touch COPYING
 $ git diff-index --raw HEAD
 ... we see (M)odified with 0{40} on the right hand side.

When the caller asks for "--patch" or any other output format that
actually needs contents for output, however, these low-level tools
do read the contents, and as a side effect, they may hash to obtain
the object name and show it [*1*].

By the way, as I do not want to see you waste your time going in a
wrong direction just to be "different", let me make it clear that as
far as the design of low level diff plumbing is concerned, what I
said here is final.  Please don't waste your time on arguing for
changing the design now after 15 years.  I want to see your time
used in a more productive way for the project.

Thanks.


[Footnote]

*1* This division of labor to free "--raw" mode of anything remotely
    unnecessary stems from the original diff plumbing design in May
    2005 where the "--raw" mode was the only output mode, and there
    was a separate "git-diff-helper" (look for it in the mailing
    list archive if you want to learn more) that reads a "--raw"
    output and transforms it into the patch form.  That "once we
    have the raw diff, we can pipe it to post-processing and do more
    interesting things" eventually led to the design of the diffcore
    pipeline where we match up (A)dded and (D)eleted entries to
    detect renames, etc.

