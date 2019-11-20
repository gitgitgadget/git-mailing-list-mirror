Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9923C432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 02:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B3E223D8
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 02:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TZzsmYUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKTCiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 21:38:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57684 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfKTCiU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 21:38:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C5C3A23C7;
        Tue, 19 Nov 2019 21:38:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0PvvvhWlF39H7pZ2oXs1WQ1J04g=; b=TZzsmY
        UpCqp+87OYnrK5NGhkMunNS7BC9L2kxIAhus0WrCo7BDmmknDd9yKb9fWeJKnIu6
        qe6aL73N444fhK9mMs3PT5VSQJWKjdiSAzJhlfAoYBUHP2j49J6s5w25gVPFFr58
        gw6MkOqfHMwsGLDm4HlwKlM5Uv+gFJXKZdKOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JhTJA0T41rYHozpmWZNCVRTO2NAbka0h
        snZJUHU+O2yf8KZwQ88yGgD6jJyv3olAFWSRw4UOAMg/cM7dhaj1dxXhRLZbM3hJ
        tnEXfi5j5EtXaiOOxGhaMv5YDhgYsViEC7brZkMd5hjr+Cm+x/RIE0AY419+26YY
        LhqLXbwttmE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 946A9A23C6;
        Tue, 19 Nov 2019 21:38:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C37FFA23C5;
        Tue, 19 Nov 2019 21:38:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Nicolay <m.nicolay@osm-ag.de>
Cc:     git@vger.kernel.org, yuelinho777@gmail.com, mhagger@alum.mit.edu,
        pclouds@gmail.com
Subject: Re: [PATCH v3] lockfile: learn core.filesLockTimeout configuration
References: <20191118134750.1901ED756F@wsmn.osm-gmbh.de>
        <20191119150747.E5AF2D756F@wsmn.osm-gmbh.de>
Date:   Wed, 20 Nov 2019 11:38:07 +0900
In-Reply-To: <20191119150747.E5AF2D756F@wsmn.osm-gmbh.de> (Martin Nicolay's
        message of "Tue, 19 Nov 2019 15:56:05 +0100")
Message-ID: <xmqqd0dne0hc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA4CA64E-0B3E-11EA-97A1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Nicolay <m.nicolay@osm-ag.de> writes:

> The new function get_files_lock_timeout_ms reads the config
> core.filesLockTimeout similar to get_files_ref_lock_timeout_ms.
> This value is used in hold_lock_file_for_update instead of the
> fixed value 0.
>
> While working with complex scripts invoking git multiple times
> my editor (emacs with standard version control) detects the
> changes and apparently calls "git status". This leads to abort
> in "git stash". With this patch and an appropriate value
> core.filesLockTimeout this problem goes away.
>
> While it may be possible to patch the elisp scripts of emacs (and
> all other similar callers) to call "git status" with
> --no-optional-locks it seems to me a better approarch to solve this
> problem at its root: calling hold_lock_file_for_update_timeout with
> a timeout of 0 ms.
>
> The implementation with the function get_files_lock_timeout_ms is
> adopted from a similar usage of get_files_ref_lock_timeout_ms.
> ---

Missing sign-off before the three-dash line.

I think the last paragraph can be left without.  It is not like
there are many other sensible ways to get a configured value without
making repeated calls to git_config_get_int().

> +core.filesLockTimeout::
> +	The length of time, in milliseconds, to retry when trying to
> +	lock an individual file. Value 0 means not to retry at
> +	all; -1 means to try indefinitely. Default is 0 (i.e., don't
> +	retry at all).

Will there be *NO* callers of the lockfile API functions that do not
honor the value taken from this configuration variable after this
patch is applied?

Otherwise, users who set this configuration variable and hit a
codepath that locks files without asking get_files_lock_timeout_ms()
how it should retry would find the above description inaccurate,
wouldn't they?

There is another question---is it safe to make all attempts to
create a lockfile retry, possibly forever?  I do not offhand think
of any concrete example, but I would not be surprised if there is a
codepath that would never want to retry but want to fail upon the
first failure (i.e. wants to always use value 0 without allowing the
users to configure).

So, unless the answers to the above two questions are "with this
patch, all attempts to lock will honor this variable" and "yes it is
safe because ...", some tweak of the description may be necessary to
hint the readers that not all the locks will retry by honoring this
variable.

> diff --git a/lockfile.c b/lockfile.c
> index 8e8ab4f29f..7301f393d6 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -145,6 +145,22 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
>  	}
>  }
>  
> +/*
> + * Get timeout for hold_lock_file_for_update.
> + */
> +long get_files_lock_timeout_ms(void)

Shouldn't this return "int", which is the type you get from the
underlying configuration API?

I also wondered if this has to be extern at all; the reason why this
patch makes it extern is purely because hold_lock_file_for_update()
is defined as a static inline in lockfile.h to expand to another
function, so any file that includes lockfile.h and calls that static
inline must be able to see this name.

Because all of the lockfile public API functions are about accessing
filesystem entities, I am not sure if making this many thin wrappers
static inlines to potentially save one extra intermediate call is
worth it (there are 10 of them).  For now, I think the organization
this patch leaves is OK, but we may later want to examine these
static inline wrappers and consider turning them into a regular
extern functions.

I do not think other static inline wrappers in the lockfile.h is
hurting right now, but with this change, hold_lock_file_for_update()
certainly is.  If it becomes just a usual extern function, we do not
have to expose the get-files-lock-timeout-ms helper at all (and
worry about its name, as globally visible names needs extra care to
help developers).  In any case, that is outside the scope of this
patch, but a potential follow-on work after this patch stabilizes.

> +{
> +	static int configured = 0;
> +
> +	static int timeout_ms = 0; /* default */
> +	if (!configured) {

 - Do not explicitly initialize statics to zero (instead, let BSS take
   care of it).
 - Lose the blank line between the declarations.
 - Have a blank line after the last decl and the first statement.

> +		git_config_get_int("core.fileslocktimeout", &timeout_ms);
> +		configured = 1;
> +	}
> +
> +	return timeout_ms;
> +}

By the way, why are these called file*S*locktimeout (both the
end-user facing configuration variable and the function name)?

Also, "lock timeout" is a misleading name for both the configuration
variable and the function.  It sounds as if after that many
milliseconds, the system will automatically break your lock if you
do not perform the action under the lock quickly enough, but that is
a wrong message to send to the end users.

The timeout is about retrying to acquire the lock, so the name most
likely needs to have words "lock", "retry", and "timeout" somewhere
in it.

Perhaps core.lockRetryTimeout or something?  I dunno.  You may want
to wait before others offer a better name before rerolling, as I am
not very good at naming things.

Thanks.
