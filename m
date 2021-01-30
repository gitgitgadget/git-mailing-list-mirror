Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9133C433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD1764DE2
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhA3JPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:15:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56770 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhA3JOy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:14:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE4301089C5;
        Sat, 30 Jan 2021 03:08:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=1HmPVRoHFRQWEHAYYUjgQwakcz8=; b=QQNafoxCV6qObIGd4b4P
        KAGLpvuH5aXqmZqQ9mify+2oawpqdiL4q0QwLCUqL8amS9nGybyxDGgrfWNLgANB
        OQYRYvw5yM8lZz54hrbjsHi6MtkQVcBR5j2jFwTBeodAQEKe6AVHdPWdqqzNhdgL
        KkEXuvCS+ODyWgvSNHNi31M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ArGJlWsc7vsD+WntkKg8xeCgUNsnqeEsjpw8XoipGpnG1j
        4EI0Uw450Le+28YDc1CgfDmwkWnBYheq7kcknJpxuNX4J5Un8HkSf2tMchwhfcSh
        zBwijQYBPz0WQNuy1n8DLbbadY3Pt9XQ7geCeFv87XO1oLTtHqgZSciawG/d4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D73D01089C3;
        Sat, 30 Jan 2021 03:08:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 283E21089C1;
        Sat, 30 Jan 2021 03:08:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v10 3/3] mergetool: add per-tool support and overrides
 for the hideResolved flag
References: <20201228192919.1195211-1-seth@eseth.com>
        <20210130054655.48237-1-seth@eseth.com>
        <20210130054655.48237-4-seth@eseth.com>
Date:   Sat, 30 Jan 2021 00:08:06 -0800
Message-ID: <xmqqsg6iq23d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49909730-62D2-11EB-9C56-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> Keep the global mergetool flag and add a per-tool override flag so that
> users may enable the flag for one tool and disable it for another. In
> addition, the author or maintainer of a mergetool may optionally elect
> to set the default `hideResolved` value for that mergetool.

OK.

> To disable the feature for a specific tool, edit the `mergetools/<tool>`
> shell script for that tool and add a `hide_resolved_enabled` function:
>
>     hide_resolved_enabled () {
>         return 1
>     }
>
> Disabling may be desirable if the mergetool wants or needs access to the
> original, unmodified 'LOCAL' and 'REMOTE' versions of the conflicted
> file.

The above sounds as if it is a hint/help for end users, but it is
unreasonable to expect all end users of a particular <tool> to edit
part of their Git installation.  I suspect that you didn't mean it
that way, and instead it is meant to advise (new) tool authors who
will add mergetools/<tool> for their own tool, and when read with
that in mind, it does make sort-of sense (except that when you are
author of this thing, you won't "edit" as if you are modifying
something that already exists---you'd be the one who is adding the
<tool> under mergetools/ directory).

For an end-user, to disable the feature for a tool, you'd just
configure mergetool.<tool>.hideResolved to 'false', right?

> For example:
>
> - A tool may use a custom conflict resolution algorithm and prefer to
>   ignore the results of Git's conflict resolution.
> - A tool may want to visually compare/constrast the version of the file
>   from before the merge (saved to 'LOCAL', 'REMOTE', and 'BASE') with
>   Git's conflict resolution results (saved to 'MERGED').
>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Seth House <seth@eseth.com>
> ---
>  Documentation/config/mergetool.txt |  6 ++++++
>  git-mergetool--lib.sh              |  4 ++++
>  git-mergetool.sh                   | 14 ++++++++++++--
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index 3171bacf91..046816fb07 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -13,6 +13,12 @@ mergetool.<tool>.cmd::
>  	merged; 'MERGED' contains the name of the file to which the merge
>  	tool should write the results of a successful merge.
>  
> +mergetool.<tool>.hideResolved::
> +	A mergetool-specific override for the global `mergetool.hideResolved`
> +	configuration flag. This allows individual mergetools to enable or
> +	disable the flag regardless of the global setting. See
> +	`mergetool.hideResolved` for the full description.

This description is iffy.  

The configuration allows "users" to enable or disable the feature
for individual mergetools, overriding the 'mergetool.hideResolved'
global setting, no?  The above paragraph reads as if the tool author
is enabling/disabling it.

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index e059b3559e..11f00dde41 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -164,6 +164,10 @@ setup_tool () {
>  		return 1
>  	}
>  
> +	hide_resolved_enabled () {
> +		return 0
> +	}
> +
>  	translate_merge_tool_path () {
>  		echo "$1"
>  	}
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 865f12551a..6cf3884277 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -333,9 +333,19 @@ merge_file () {
>  	checkout_staged_file 2 "$MERGED" "$LOCAL"
>  	checkout_staged_file 3 "$MERGED" "$REMOTE"
>  
> -	if test "$(git config --get mergetool.hideResolved)" != "false"
> +	# hideResolved preferences hierarchy:
> +	# First respect user's tool-specific configuration if exists.
> +	if test "$(git config --get "mergetool.$merge_tool.hideResolved")" != "false"

The same "--type=bool" comment applies to this step, too.

>  	then
> +		# Next respect tool-specified configuration.
> +		if hide_resolved_enabled
> +		then
> +			# Finally respect if user has a global disable.
> +			if test "$(git config --get "mergetool.hideResolved")" != "false"
> +			then
> +				hide_resolved
> +			fi
> +		fi
>  	fi

I am not sure if I understand this logic.

If the user says "for the tool <tool>, set hideresolved to
true/false" explicitly, I think it should be final.  Even if the
tool's author expresses that s/he prefers not to have to work on a
pre-munged input by setting hide_resolved_enabled to false, if the
end-user says s/he wants to use it on that tool, we do not want to
help the tool to override the user's wish.

If the user says "use hideresolved feature, as I like it in general"
by setting mergetool.hideResolved, on the other hand, it may be also
reasonable to heed "no, I recommend against it for this tool" for
individual tool whose hide_resolved_enabled returns false.  And if
the global is set to 'false', the user says "I do not want it", and
it may be iffy to let individual tool to countermand it.

WHen dealing with either of these variables, therefore, you'd need
to know if the variable is not set at all, or if the variable is set
to true, or to false.  Even if we default to enabled, we need to be
able to tell if the user didn't say anything (and we enabled the
feature for the user because of our default choice), or if the user
explicitly said s/he wants it.

In other words, you'd need to treat mergetool.hideResolved and
mergetool.$merge_tool.hideResolved as tristates.

Here is how "git config --type=bool" can be used to normalize
various ways to spell true/false and tell between "not set" and "set
to some value":

    $ git -c a.b config --type=bool a.b; echo $?
    true
    0
    $ git -c a.b=yes config --type=bool a.b; echo $?
    true
    0
    $ git -c a.b=0 config --type=bool a.b; echo $?
    false
    0
    $ git config --type=bool a.b; echo $?
    1

IOW, if "git config --type=bool" fails, the user does not have the
variable set.  If it succeeds, you'd get normalized 'true/false'
string on its standard output.

Using that technique, here is my attempt to rewrite the above logic,
with commentary.

    global_config=mergetool.hideResolved
    tool_config=mergetool.$merge_tool.hideResolved

    if enabled=$(git config --type=bool "$tool_config")
    then
	# The user explicitly says true or false, so there
	# is no point in asking any other source of preferences
	;
    elif enabled=$(git config --type=bool "$global_config")
    then
	# There is a blanket preference for all tools, and 'true'
	# means "I like the hide-resolved in general, so use it
	# when appropriate" by the user.  We can let the tool
	# author to override and disable, though.
	#
	# On the other hand, when set to 'false', it is "I really
	# don't like the feature in general, so do not use it
	# anywhere", which we take it as final, without letting
	# the tool override it.
        if test "$enabled" = true && hide_resolved_enabled
	then
		enabled=true
	else
		enabled=false
	fi
    else
	# The user does not have preference.  Ask the tool
	if hide_resolved_enabled
	then
		enabled=true
	else
		enabled=false
	fi
    fi

    # Now we know if the feature should be used.
    if test "$enabled" = true
    then
	hide_resolved
    fi

