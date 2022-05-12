Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634D6C433FE
	for <git@archiver.kernel.org>; Thu, 12 May 2022 15:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355924AbiELP6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351802AbiELP6y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 11:58:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8BCC9EF7
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:58:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CADB1191E0;
        Thu, 12 May 2022 11:58:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sAgWOF59tka/BGSWgoqjU0AW0/VcsIsjh0LzpV
        VrkX4=; b=fazv6ifsGDz1dcc5h7GtC3WAqv/SRw9jj7cuYQ1zdCiasjwMIAdqF+
        o5F07yLrjqloSz00t3LzcbQQdHMb0UFJTLBfEoWd04TQBRDU55m0IiX1jfmVnVV6
        GS48POoi2YMS7ui60WDJOeHAllkMVxeW9zeub69m3Eb9QUR/ezPWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 538D91191DF;
        Thu, 12 May 2022 11:58:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B61BD1191D9;
        Thu, 12 May 2022 11:58:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] http: add custom hostname to IP address resolutions
References: <20220504104601.136403-1-chriscool@tuxfamily.org>
        <20220509153834.485871-1-chriscool@tuxfamily.org>
        <CAPUEsphA=q10wCsrf3AxR9fXz9HQHt374tDFoWBu++EPNDA-LA@mail.gmail.com>
        <Yn0FPkoUNacvctAp@ncase>
Date:   Thu, 12 May 2022 08:58:47 -0700
In-Reply-To: <Yn0FPkoUNacvctAp@ncase> (Patrick Steinhardt's message of "Thu,
        12 May 2022 15:01:50 +0200")
Message-ID: <xmqqa6bmhhe0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 692CA1E2-D20C-11EC-9E77-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> Is setting it up as a command line config option the way you expect to
>> use this, and if so why not make it a full blown command line option
>> with the previous caveats that were discussed before?
>
> If you did this as a command-line option, you'd now be forced to add it
> to every single command you want to support this: git-fetch, git-pull,
> git-remote, git-ls-remote and maybe others I forgot about. On the other
> hand, by having this as a configuration variable in `http.c` all of
> those commands benefit the same.

It is not an argument against the command line option that you find
it more work to implement and cumbersome to plumb the information
through the callgraph, though.

Subcommands like "git commit" shouldn't have to know how host names
are mapped to IP addresses, and teaching the option only to
subcommands that the feature is relevant, and documenting the option
in their manual pages, would make it much easier to discover and
learn.

> Overall, I think it is preferable to keep this as an option as opposed
> to adding such an obscure parameter to all of the commands.

I favor implementing this as a configuration that is primarily meant
to be used from the command line (i.e. "git -c var=val"), ONLY
BECAUSE the feature itself is not something that should be widely
used (the users should futz with their DNS if they need something
more permanent), and adding it as a configuration would be a more
quick and dirty way that needs less developer resources now ;-)

To purists, it may make more sense to add this feature and make it
accessible only from the command line without matching configuration
variable---that would enforce the assumed use case (i.e. only after
another part of the system asked DNS, performed some check on the
resulting IP address, and decided to ask Git to interact with that
URL, use this mechanism to ensure Git interacts with that IP address
that was vetted, to avoid TOCTOU mistakes) more clearly.

I am personally open to such a purer counterproposal with working
code ;-)

>> I also think it might be a little confusing (and probably warranted of
>> an advice message) if git will decide based on a configuration
>> somewhere in its resolution tree that the IP I am connecting is
>> different than the one I expect it to use through the system
>> configured resolution mechanism for such a thing.
>
> That's true already though, isn't it? A user may set `url.*.insteadOf`
> and be surprised at a later point that their URLs are getting redirected
> somewhere else. And there's probably a lot more examples where a user
> may be confused when forgetting about certain configuration variables
> that change the way Git behaves.
>
> I also don't think that using an advise here would be ideal. The main
> use case of this configuration variable is going to be servers, and
> there is a high chance that they might actually be parsing output of any
> such commands. Forcing them to always disable this advise doesn't feel
> like the right thing to do.

All correct.  If the users set configuration variables, the fact
that we honored their configuration variables settings and behaved
accordingly is *NOT* an advise-worthy event.

Thanks.
