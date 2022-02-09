Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339A6C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 17:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiBIReT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiBIReS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 12:34:18 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A47C05CB82
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 09:34:21 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD0C418E026;
        Wed,  9 Feb 2022 12:34:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u5eIafAhOm3J6GF5zreZoZrDn6GnX5sxRJWpZg
        kbqxU=; b=IVS94gBQAkEzCM9UC0r4L4iNrYL1hWRqrcmRD6Xq4YmkRCJGZRdzxJ
        wP4kFNIv5RKp04fgKzmVWza4c3iwHaWrV/nACbL2KBrj9GiXaJQsd5HGQgyhMOfW
        72NlenYGx198rXnmNawkOn9XWO6Md5HifQDPDGaL/N73vEXgZ3gMo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4BBA18E025;
        Wed,  9 Feb 2022 12:34:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AFF1D18E023;
        Wed,  9 Feb 2022 12:34:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 2/6] worktree: create init_worktree_config()
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
        <5d0cc242d92c68bf239f9e17eab9c80ec6b2d469.1644269583.git.gitgitgadget@gmail.com>
        <xmqq1r0dc8om.fsf@gitster.g>
        <5f7f10df-f048-a663-a98c-536025be0040@gmail.com>
Date:   Wed, 09 Feb 2022 09:34:15 -0800
In-Reply-To: <5f7f10df-f048-a663-a98c-536025be0040@gmail.com> (Derrick
        Stolee's message of "Tue, 8 Feb 2022 21:21:17 -0500")
Message-ID: <xmqq5ypo9c6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 814F633A-89CE-11EC-B309-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 2/8/2022 5:09 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> +static int move_config_setting(const char *key, const char *value,
>>> +			       const char *from_file, const char *to_file)
>>> +{
>>> +	if (git_config_set_in_file_gently(to_file, key, value))
>>> +		return error(_("unable to set %s in '%s'"), key, to_file);
>>> +	if (git_config_set_in_file_gently(from_file, key, NULL))
>>> +		return error(_("unable to unset %s in '%s'"), key, from_file);
>>> +	return 0;
>>> +}
>> 
>> Interesting.
>> 
>> The verb "move" in its name made me expect a "get (and remove)
>> whatever value(s) defined out of the old file, and set them
>> identically in the new file" sequence, but that is not what is done
>> here.  "set to this new single value in the new file and unset from
>> the old one".
>
> I think this "copy into the worktree-specific config, then remove
> from the common file" is an important sequence of events in case a
> concurrent process comes in and reads the two config files in the
> intermediate state and does not see the config value anywhere.
>
> But perhaps that's not actually what you are concerned about,
> because you're saying that the 'value' being provided does not
> actually guarantee that we are moving the setting.

Yes.  "Why are we _ignoring_ what is in the old file when we claim
to be _moving_?" was the question I had upon seeing this function.

>> I can see the need to say "move it only when its value is X",
>> so having the caller to extract the value before deciding to call
>> the function (hence not "moving from old") does make sense, but then
>> the function is misnamed---it is not "moving", it is doing something
>> else.

> I think the end state is correct for all uses here, since we only
> run this after checking to see if the config value exists in the
> 'from_file', so 'value' is correct (and this is a static method,
> not a generally-useful method for config.h).

As long as this is used on a single-valued "last one wins" variable,
the callers and this helper taken together will do the right thing.

> Perhaps a "write_in_new_and_remove_from_old()" would be a better,
> if verbose, name. I struggle to find a less cumbersome name, and
> "move" seems to match the intent pretty well in the context of its
> use.

The name is fine as long as the requirement for the caller is made
clear.  A short comment to help the next reader from having to ask
the same question before the helper may be sufficient.

>> Is the assumption that the secondary worktrees are never bare, but
>> the primary one could be (iow, adding worktrees to a bare repository
>> would leave the original bare repository as the primary "worktree"
>> that does not have "working tree")?  I am trying to see what downsides
>> it tries to avoid by not moving the core.bare==false setting.  Shouldn't
>> core.bare be set to false when "worktree add" creates a new one anyway,
>> if the secondaries are never bare?
>
> Secondary worktrees cannot be bare. If Git interprets the worktree config
> to have core.bare=true in a secondary worktree, it errors out.
>
> You seem to be suggesting that we should explicitly write core.bare=false
> into each of the worktree-specific config files. Is that right? This move
> is effectively the same, since 'false' is the default.

Unless there is a lower-precedence configuration file that we have
to override, yes, not writing core.bare=false upon "worktree add" is
fine.  I simply do not know if we need to do something special in
order to defeat /etc/gitconfig or $HOME/.gitconfig with the repository
or the worktree specific configuration file.

> Here, the verbal gymnastics are somewhat necessary because secondary
> worktrees have a .git _file_, not a git directory, so using "common
> Git dir" is a way to explicitly reference the Git dir. And the
> strangeness here is exactly that core.worktree can change this working
> tree to be something other than the parent of the (common) Git dir.

OK.  The .git _file_ is our moral equivalent to a symbolic link, and
I forgot about that.

I also wonder if we should do something like what we do for refs
(i.e. the API knows which refs are per-worktree and which are
global, so the callers do not have to care and just can say things
like "update HEAD to this value", and "give me the value of
refs/bisect/good") when repo_set_config*() is called, but that is
outside the scope of this step, which is about one-time migration.

As the code for migration go, I think I am happy with what it wants
to do and how it does it.

Thanks.
