Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEFCC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 19:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiFWTY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiFWTYP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 15:24:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA953120C
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 11:32:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6245141F26;
        Thu, 23 Jun 2022 14:32:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PQ5p1iTCUE8c23XJ9facSw+8U/7vVuBKAedunP
        2bHdQ=; b=Cxpqf7MwaOp6XdH8S62sPXv6qlGIq54tvYF2fx32LbmUw9Hc4sGse2
        isDtw8nha6IG4UDRzFiCXh7KSngUIItm7kY8Xzo/6fqy0ftgSraEzkcpFbskevFA
        oXsQPZGCFz0BrdOTvNbWqewtfKWKxz30MbJDtzFp7REpf3rVgKIh4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB354141F25;
        Thu, 23 Jun 2022 14:32:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42AF8141F24;
        Thu, 23 Jun 2022 14:32:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v4 0/5] config: introduce discovery.bare and protected
 config
References: <20220622220331.3734584-1-jonathantanmy@google.com>
        <kl6lr13fi9qn.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 23 Jun 2022 11:32:27 -0700
In-Reply-To: <kl6lr13fi9qn.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 23 Jun 2022 10:13:20 -0700")
Message-ID: <xmqqo7yjz0w4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5CB373C-F322-11EC-BF82-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> Glen Choo (5):
>>>   Documentation/git-config.txt: add SCOPES section
>>>   Documentation: define protected configuration
>>
>> Forgot to mention when I was sending my comments on patch 2: we should
>> standardize on "protected config" and not use "protected configuration"
>> anywhere.
>
> Makes sense.

Using a single word consistently does make sense, but why favor a
non-word over a proper word ;-)?

> I suppose that the idea behind this is that we only parse and store each
> config file exactly once. It's a good goal, but the whole point of the
> configset is that we can query a single struct to figure out the value
> of a config variable. Having multiple configsets starts to shift more of
> the burden to the callers because they now have to query multiple
> configsets to find their desired config value, and we already start to
> see some of this unpleasantness in this series.

Yes, I was worried about this, too.  "parse and store exactly once"
may merely be a performance thing, but it still matters, even though
it is not worse than making duplicate callbacks to overwrite globals
that have been already set earlier, which will affect correctness ;-)

> An alternative that I'd been thinking about is to make a few changes to
> the git_config_* + configset API to allow us to use a single configset
> for all of our needs:
>
> 1. Keep track of what config we've read when reading into
>    the_repository->config, i.e. instead of a boolean "all config has
>    been [un]read", we can express "system and global config has been
>    read, but not local or command config". Then, use this information to
>    load config from sources as they become available. This will allow us
>    to read incomplete config for trace2 and setup.c (discovery.bare and
>    safe.directory), and only read what we need later on.

That is not a bad direction to go, but are we sure that we always
read in the right order (and there is one single right order) and
stop at the right step?

config.c::do_git_config_sequence() reads the system and then the
global before the local, the worktree, and the command line.  We
would allow the values of "protected" configuration variables to be
inspected by stopping after the first two and inspecting the result
before the local and the rest overrides them, but will we need
*only* that kind of partial configuration reading that stops exactly
there?  Even with the proposed "protected" scheme, I thought we plan
to honor the command line ones, so we may need to read
system+global+command without reading anything else to grab the
values only from the protected sources (ah, I like the application
of the adjective "protected" to the source, not variables, because
that is what we are really talking about---alternatively we could
call it "safe").  But if we later read local and worktree ones
lazily, unless we _insert_ them before what we read from the command
line, we'll break the last-one-wins property, so we need to be
careful.  I guess each configuration value in the configset knows
where it came from, so it probably is possible to insert the ones
you read lazily later in the right spot.

> 2. Add an additional argument that specifies what scopes to respect when
>    reading config (maybe as a set of flags). This gives us extra
>    specificity when using the git_config*() functions, so we could get
>    rid of git_protected_config() like so:
>
>     /* Change enum config_scope into flags first... */
>
>     #define WIP_SCOPES_PROTECTED = CONFIG_SCOPE_SYSTEM & \
>       CONFIG_SCOPE_GLOBAL & CONFIG_SCOPE_COMMAND
>
>     static enum discovery_bare_allowed get_discovery_bare(void)
>     {
>       enum discovery_bare_allowed result = DISCOVERY_BARE_ALWAYS;
>       git_config(discovery_bare_cb, &result, WIP_SCOPES_PROTECTED);
>       return result;
>     }

Alternatively, we could make the callback aware of the scope for
each var-value it is called and have it filter, but that would be a
bigger surgery.

I think a new iterator git_config_in_scope(), instead of updating
git_config(), would make sense.  By definition, all existing
git_config() callers do not need the scope specifiers, and
"protected" may be the first one but will not be the last one that
needs to read from particular scopes.
