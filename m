Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03D3C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 17:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347668AbiDARxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244792AbiDARx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 13:53:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A98287884
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 10:51:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3AB61192CAB;
        Fri,  1 Apr 2022 13:51:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5e61jueaZp9IpD10reHr4J4Tqc+vwVi8fgTj1v
        xs9Jo=; b=XoeHxhqMEFr1eo7Njpj9DExCZRp9TrA/x92IA/jpC0lu9N/GbcCGnK
        SRzSttNx/UFYn/OVFTccFhOZZhJQO49KZsd+nC+KiPZZeVBE/xtYPdJYlFqBALxT
        uRuHK1TlUOHllBObUl7XNBxvmMf3vs1/xF+btg+3jPl4/XjRoxrZE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34F4B192CAA;
        Fri,  1 Apr 2022 13:51:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A0A97192CA9;
        Fri,  1 Apr 2022 13:51:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miklos Vajna <vmiklos@vmiklos.hu>
Cc:     git@vger.kernel.org
Subject: Re: git log --since to not stop after first old commit?
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu>
Date:   Fri, 01 Apr 2022 10:51:34 -0700
In-Reply-To: <Yka2GSGs3EIXm6Xt@vmiklos.hu> (Miklos Vajna's message of "Fri, 1
        Apr 2022 10:21:45 +0200")
Message-ID: <xmqq1qygy9nd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FA14EFE-B1E4-11EC-9134-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miklos Vajna <vmiklos@vmiklos.hu> writes:

> I wanted to look at commits of a contributor from the last year, and
> noticed that I only see commits from this year, not last year when I use:
>
>         git log --author="that person" --since="1 year ago"
>
> Digging around in the history, one other contributor pushed a mistake on
> 1st Jan, where the author date was supposed to be 2022-01-01, but
> happened to be 2021-01-01. Knowing that, it makes sense that 'git log'
> stopped at that commit by default.
>
> I wonder though, is there any option to "force" git log to walk all
> reachable commits from HEAD, but just show the ones which match the
> --since criteria?
>
> Or is this need so special that the best is to parse the output of 'git
> rev-list' and do my own filtering for author and date?

Currently yes.  I am not sure if it is (or is not) worth changing,
though.

Many "git log" options make commits hidden from the output by
filtering each commit we find but keep digging the history further,
but some options make commits hidden by stopping the traversal.
"--until" is the former (there is no way to implement it as the
latter) but "--since" is the latter.

If we can implement more of these "commit hiding operations" as
traversal stoppers, it allows "log" to avoid doing unnecessary work,
and in a history without skewed timestamps, "--since" is a prime
candidate to take advantage of the fact that parent must be older
than any of its children (hence we can safely stop traversal once we
see an old enough commit) to be implemented as a "traversal stopper".
But in the presense of skewed timestamps, those commits behind one
commit with an incorrectly old timestamp will end up being hidden.

We could add a --since-as-filter= option or something, but then the
user needs to be careful when to stop (and digging down to the root
of the history, i.e. "never stop", may be an acceptable answer to
some projects).  We may be able to, when commit-graph (v2) with
adjusted timestamp data exist, stop before going down to the root,
but we would still need to add it as a different option because the
existing behaviour of "--since", to immediately stop upon seeing a
commit with a timestamp that is older than the given time, is so
well established and it would irritate users of existing scripts if
it changes all of a sudden.


