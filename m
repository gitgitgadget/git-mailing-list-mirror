Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F2FC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 07:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbiCJHUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 02:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiCJHUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 02:20:44 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BB59A4FF
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 23:19:43 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0D081852C1;
        Thu, 10 Mar 2022 02:19:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SBYI1s1VXONqcrb+ZSbARFKbFPs/fX3b5k5zjS
        EQq6Y=; b=I0KqFoxO+aA4XpFlYPrSuZRLStdUa4v1sDOwQa7RLsN1YaBOylGVgt
        5sI6h0LWtEGtLxzmxUvh0Ko2BG+n/JDO8GotaOTrgCZLL1mq6M+B9M5FwGwgOn45
        WsjVeDvq1CwCSQgXN/ejlJhfYIu0PXgfYDEdgExGM8kW6FDz9Q00s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBD501852C0;
        Thu, 10 Mar 2022 02:19:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 247DE1852BF;
        Thu, 10 Mar 2022 02:19:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 3/5] core.fsync: introduce granular fsync control
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <e31886717b42837f4e1538a13c8954aa07865af5.1646866998.git.gitgitgadget@gmail.com>
        <xmqqo82eirnv.fsf@gitster.g>
        <CANQDOddU_WXD-6ncDGBrgpsuKT-XDGC=SeaaQTNQFdODFZ7TkQ@mail.gmail.com>
Date:   Wed, 09 Mar 2022 23:19:39 -0800
In-Reply-To: <CANQDOddU_WXD-6ncDGBrgpsuKT-XDGC=SeaaQTNQFdODFZ7TkQ@mail.gmail.com>
        (Neeraj Singh's message of "Wed, 9 Mar 2022 18:53:45 -0800")
Message-ID: <xmqqcziugtpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 732445C0-A042-11EC-A21B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> This is modeled after whitespace_rule_names.  What if I change this to
> the following?
> static const struct fsync_component_name {
> ...
> } fsync_component_names[]

That's better.

> At the conclusion of this series, I defined 'default' as an aggregate
> option that includes
> the platform default.  I'd prefer not to have any statefulness of the
> core.fsync setting so
> that there is less confusion about the final fsync configuration.

Then scratch your preference ;-) 

Our configuration files are designed to be "hierarchical" in that
system-wide default can be set in /etc/gitconfig, which can be
overridden by per-user default in $HOME/.gitconfig, which can in
turn be overridden by per-repository setting in .git/config, so
starting from the compiled-in default, reading/augmenting "the value
we tentatively decided based on what we have read so far" with what
we read from lower-precedence files to higher-precedence files is a
norm.

Don't make this little corner of the system different from
everything else; that will only confuse users.

The git_config() callback should expect to see the same var with
different values for that reason.  Always restarting from zero will
defeat it.

And always restarting from zero will mean "none" is meaningless,
while it would be a quite nice way to say "forget everything we have
read so far and start from scratch" when you really want to refuse
what the system default wants to give you.

>> > @@ -1613,7 +1684,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>> >       }
>> >
>> >       if (!strcmp(var, "core.fsyncobjectfiles")) {
>> > -             fsync_object_files = git_config_bool(var, value);
>> > +             warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));
>>
>> This is not deprecating but removing the support, which I am not
>> sure is a sensible thing to do.  Rather we should pretend that
>> core.fsync = "loose-object" (or "-loose-object") were found in the
>> configuration, shouldn't we?
>>
>
> The problem I anticipate is that figuring out the final configuration
> becomes pretty
> complex in the face of conflicting configurations of fsyncObjectFiles
> and core.fsync.

Don't start your thinking from too complex configuration that mixes
and matches.  Instead, think what happens to folks who are *NOT*
interested in the new way of doing this.  They aren't interested in
setting core.fsync, and they already have core.fsyncObjectFiles set.
You want to make sure their experience does not suck.

The quoted code simply _IGNORES_ their wish and forces whatever
default configuration core.fsync codepath happens to choose, which
is a grave regression from their point of view.

One way to handle this more gracefully is to delay the final
decision until the end of the configuraiton file processing, and
keep track of core.fsyncObjectFiles and core.fsync separately.  If
the latter is never set but the former is, then you are dealing with
such a user who hasn't migrated.  Give them a warning (the text
above is fine---we can tell them "that's deprecated and you should
use the other one instead"), but in the meantime, until deprecation
turns into removal of support, keep honoring their original wish.
If core.fsync is set to something, you can still give them a warning
when you see core.fsyncObjectFiles, saying "that's deprecated and
because you have core.fsync, we'll ignore the old one", and use the
new method exclusively, without having to worry about mixing.
