Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3C8C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 19:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbiFITvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 15:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiFITvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 15:51:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509AB3A8FB4
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 12:50:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3718199B8E;
        Thu,  9 Jun 2022 15:50:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3g6JFHbkFoheZY9zQzfFp1gN0Snn/wR1lAbLrc
        QbaYI=; b=Z1YEfZJCLLPVDuuzKRKPn9H3bu8NrhThv4pmQVeYb9ZIQDvRDLliPv
        JIDlRUlCFTJzZXDQ41DefcLfBYIM+OXP9hrU/+CDRrJ2oCcuCf4WucghpQY787JX
        hWKzcFvvSLvwKQFlp+1Wq4tcmDUwpFMXKdsXrfZcHPiIr0oKdv1A4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC227199B8D;
        Thu,  9 Jun 2022 15:50:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F02A199B8C;
        Thu,  9 Jun 2022 15:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] ls-files.c: add --object-only option
References: <pull.1250.git.1654509678718.gitgitgadget@gmail.com>
        <pull.1250.v2.git.1654778272871.gitgitgadget@gmail.com>
Date:   Thu, 09 Jun 2022 12:50:53 -0700
In-Reply-To: <pull.1250.v2.git.1654778272871.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Thu, 09 Jun 2022 12:37:52 +0000")
Message-ID: <xmqq35gdk44i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 798C22A6-E82D-11EC-AB1B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> `git ls-files --stage` default output format is:
>
> [<tag> ]<mode> <object> <stage> <file>
>
> sometime we want to find a path's corresponding objectname,

"sometime" -> "When", perhaps.  If you really want to say that,
"Sometimes, " is also good, though.

By the way, I do not think you are "want to find a path's
corresponding objectname" at all with this feature.  The output from
"ls-files -s" will have many object names, one per each path if the
index is merged, and if you discard the path, you no longer can tell
which object name corresponds to which path.

> we will parse the output and extract objectname from it
> again and again.

Why is that a problem?  "again and again" is over-exaggerating;
you'd munge each line just once.

It would help readers if you say WHY you want to find object names.
Perhaps you want to find the set of objects that are registered in
the index, regardless of their paths?

In any case, the paragraph needs a rewrite.

> So introduce a new option `--object-only` which can only
> output objectname when giving `--stage` or `--resolve-undo`.

"which can only" makes it sound like you are complaining about its
limitation.

I read these two lines to mean "git ls-files -s --object-only" does
not even give me the stage information, but that would make the
command completely useless, so I am assuming that is not what you
meant to say.  The same comment applies for resolve-undo, which is
merely "what 'ls-files -s' may have given before you resolved".

If you borrowed a feature from another existing command, say that
explicitly, which will allow your commit to gain confidence by
reviewers and future readers by showing that you care about overall
consistency in the system.

	Add a new option `--object-only` that omits the mode and
	filename from the output, taking inspiration from the option
	with the same name in the `git ls-tree` command.

or something like that, perhaps.

How does/should this interact with the `--deduplicate` option?

If we are not giving stages and truly giving only object names
(which I doubt is what we want, by the way), then we can and should
deduplicate the output when the option is given.  If we have two
identical blobs at different paths, or two identical blobs at the
same path but at different stages, shouldn't we get only a single
copy of output for that blob, as we are not showing paths nor
stages, right?

How does/should this behave when --stage is not given?

I have a suspicion that this whole thing is misdesigned.  Instead of
making it piggy back on --stage, don't you want to make it an
independent option?  I.e.

	git ls-files --object-only

with no other option would behave like

	git ls-files -s | sed -e 's/^[0-6]* \([0-9a-f]*\) .*/\1/'

and it is an error to combine it with -s or --deduplicate.  If the
purpose is to learn the set of objects registered in the index, then
it might even make sense to make it an equivalent to

	git ls-files -s |
	sed -e 's/^[0-6]* \([0-9a-f]*\) .*/\1/' |
	sort -u

as duplicates or order of the entries is no use for such a use
case.  

It entirely depends on WHY you want to find object names, and that
is why I asked it much earlier in this message.

And I do not think it makes any sense to give resolve-undo
information without paths nor stages at all.  Please do not tie this
with that mode.

In short

 - this probably is better done as a separate independent mode
   "--object-only", rather than a piggy-back feature on top of
    existing other features like "-s" and "--resolve-undo".

 - the new mode should be made mutually incompatible with "-s" and
   "--resolve-undo".  There may be other options that this should be
   incompatible, like "--tag" and "--full-name".

Thanks.
