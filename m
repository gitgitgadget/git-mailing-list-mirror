Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3440FC433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 20:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbiERUvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 16:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbiERUvj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 16:51:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3166AFB
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:51:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A20E18D172;
        Wed, 18 May 2022 16:51:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5336jWVjL4ndbIXnTjevY01s7Un85N2IfOA0hV
        7adG8=; b=BeDBX5OdRrICbePJCNlLkyIUCSsfxAWMyeoyQN/1WzGA/ohzdi6KDp
        7hEUBy6KAToh4XcC93Yn4zpKm9Mvz1kuHmZuW6O9kAyRMfkIbCowsN+RJRWdhYiN
        egLMD4lV3NHCOhon7vY3RKSoDEgud8DXLB2FJCzZ98y8+raoHc9Tg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92E4218D170;
        Wed, 18 May 2022 16:51:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AADB718D16E;
        Wed, 18 May 2022 16:51:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nadav Goldstein <nadav.goldstein@blazepod.co>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        nadav.goldstein96@gmail.com
Subject: Re: [PATCH] stash: added safety flag for stash clear subcommand
References: <CAApwGmCsQNK42=5x1OxdovgVxdzj2Vs5H1FaUJhAGCXvmA5pzw@mail.gmail.com>
Date:   Wed, 18 May 2022 13:51:31 -0700
In-Reply-To: <CAApwGmCsQNK42=5x1OxdovgVxdzj2Vs5H1FaUJhAGCXvmA5pzw@mail.gmail.com>
        (Nadav Goldstein's message of "Wed, 18 May 2022 21:53:36 +0300")
Message-ID: <xmqqy1yytvho.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C95F7F6-D6EC-11EC-86FC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nadav Goldstein <nadav.goldstein@blazepod.co> writes:

> If we make "git stash clear" to by default not clear the stash and
> just present the stashes to be dropped (and require -f to force
> clearing the stash), wouldn't we essentially make a duplicate of "git
> stash list"?

Correct, but that is not what I would imagine to be a parallel to
"git clean [-f|-n]" with clean.requireForce.  If you haven't played
with "git clean" with various settings of that variable, you should.
Its behaviour illustrates pretty well what I meant in the message
that prompted your response, to which I am responding to.  I would
imagine that "git stash clear [-f|-n]" with stashClear.requireForce
to be more like:

 * stashClear.requireForce that is not set is treated as if it is
   set to true;

 * "git stash clear" without -f or -n will die with a single line of
   message, telling the user to give either -f or -n, unless the
   configuration is set explicitly to 'false'.

It will be more like "confirmation" to those who run "git stash
clear", and then if they are certain, run "git stash clear -f".

Of course, "interactive" can be added like "git clean -i".

Just like "-i" defeats the refusal by "clear.requireForce" when
running "git clean", "git stash clear -i" would go interactive and
should be usable regardless of what value stashClear.requireForce
has.

> Regarding making it opt out instead of opt in, I am afraid there are
> tools that use git stash clean automatically, and making the
> confirmation opt-out (by default confirm) we can potentially break
> them, don't you think it would be more gentle to the git community to
> make it opt in?

It is usually a good idea to introduce such a disruptive feature
gradually by first making it opt-in, with a warning message to tell
users that the default will change in the future.  For this feature,
it may go like this:

 1. Phase one.

 * "git stash clear" learns "-f|--force" and "-n|--dry-run"
   options.

 * A configuration variable stashClear.requireForce is introduced.
   "git stash clear" starts paying attention to it.  When it is

    - set to true, "git stash clear" without "-f" or "-n" errors
      out.

    - set to false, "git stash clear" works just like today.  No
      extra messages, no extra errors.

    - unset, "git stash clear" gives a warning message to tell the
      users two things:

      - The stashClear.requireForce configuration variable exists
        and when it is set to true, you need to pass "-f" to make
        "git stash clear" actually clear.  When it is set to false,
        the stash is cleared just like before.  When it is unset,
        you will see this warning message, but the command clears
        the stash.

      - The default value of stashClear.requireForce will become
        true in a future version of Git, and users are encouraged to
        set their preference early by setting the configuration
        variable now.

      but otherwise it goes ahead and clears the stash.

 * Release notes talks about upcoming default flip for the variable.

 2. Phase two (probably several releases after Phase one).

 * The behaviour of "git stash clear" is changed so that when
   stashClear.requireForce is

    - set to true of false, it behaves identically as phase one.

    - unset, "git stash clear" gives a warning message to tell the
      users about the stashClear.requireForce variable just like in
      phase one (the description needs to be adjusted to say that
      the default value is now 'true'), and behaves as if the
      variable is set to 'true'.

 3. Phase three (probably several releases after Phase two).

 * Long after users have adjusted to the new "safer by default"
   behaviour, we shorten the error message given to those who do not
   have the variable configured, similar to the message "git clean"
   gives to those without clear.requireForce.

