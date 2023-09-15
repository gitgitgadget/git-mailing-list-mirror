Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23404EED61A
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 17:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjIORnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjIORne (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 13:43:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41363C6
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 10:43:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 876B419F6BF;
        Fri, 15 Sep 2023 13:43:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Nu7+NrPynGRmLE7qCyeOZ8LSYorc7//fm3N+LG
        dx9jI=; b=tB7a18KqkXM/vxRthnH6QycIOm7j1Fug67K2Vy+0wst6c6z+9SKqgT
        yHqUuvx1QPY2vJLKOxcPfMfR9hmM4UCCnxS0uXzxtdL8RFu6ut2k3O5BExELXJ3B
        cOi2ALdQW8Z4eMZYK4t+tXKfmrchVesZF+QmiYe0kNT7ywKTDujig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FE1A19F6BE;
        Fri, 15 Sep 2023 13:43:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA4E319F6BD;
        Fri, 15 Sep 2023 13:43:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [PATCH] doc: pull: improve rebase=false documentation
In-Reply-To: <owlyedj0jok7.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Thu, 14 Sep 2023 16:57:28 -0700")
References: <226cc3ed753ee809a77ac7bfe958add7a4363390.1694661788.git.dsimic@manjaro.org>
        <xmqqzg1oinq1.fsf@gitster.g> <owlyedj0jok7.fsf@fine.c.googlers.com>
Date:   Fri, 15 Sep 2023 10:43:26 -0700
Message-ID: <xmqqh6nvfi2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60A9B580-53EF-11EE-83AA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Aside: interestingly, there appears to be a "--no-rebase" option that
> means "--rebase=false" (see cd67e4d46b (Teach 'git pull' about --rebase,
> 2007-11-28)):
>
>        --no-rebase
>            This is shorthand for --rebase=false.
> ...
> How about adding something like this instead as the very first paragraph
> for this flag?
>
>     Supplying "--rebase" defaults to "--rebase=true". Running git-pull
>     without arguments implies "--rebase=false", unless relevant
>     configuration variables have been set otherwise.

Phrase nit.

	$ git pull origin

does run the command with arguments.  What you mean is "running
git-pull without any --rebase arguments implies --no-rebase", but
that is saying "not giving --rebase=<any> and not giving --rebase
means not rebasing", which makes my head spin.

"--no-rebase" as a command line option does have use to defeat
configured pull.rebase that is not set to "false", and allowing
"pull.rebase" to be set to "false" does have use to defeat settings
for the same variable made by lower-precedence configuration file.
"--rebase=false" does not have any reason to exist, except for
making the repertoire of "--rebase=<kind>" to be complete.

So, I am still not sure if saying "'git pull' (no other arguments
and no configuration) is equivalent to 'git pull --rebase=false'"
adds much value.

If --no-rebase and --rebase=false are explained in terms of why
these options that specify such an unnatural action (after all, you
say "do this" or "do it this way", but do not usually have to say
"do not do it that way") need to exist.

If I were writing this patch, I would rearrange the existing text
like so:

 * Update the description of "--no-rebase" *NOT* to depend on
   --rebase=false.  Instead move it higher and say

   - The default for "git pull" is to "merge" the other history into
     your history, but optionally you can "rebase" your history on
     top of the other history.

   - There are configuration variables (pull.rebase and
     branch.<name>.rebase) that trigger the optional behaviour, and
     when you set it, your "git pull" would "rebase".

   - The "--no-rebase" option is to defeat such configuration to
     tell the command to "merge" for this particular invocation.

 * Update the description of "--rebase=<kind>" and move the
   paragraph that begins with "When false" to the end, something
   like:

   - `--rebase` alone is equivalent to `--rebase=true`.
   - When set to 'merges'...
   - When set to 'interactive'...
   - See `pull.rebase`, ..., if you want to make `git pull` always
     rebase your history on top of theirs, instead of merging their
     history to yours.
   - `--rebase=false` is synonym to `--no-rebase`.
