Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F5C433FE
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 00:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJXAVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Oct 2022 20:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXAVE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2022 20:21:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5776AEB9
        for <git@vger.kernel.org>; Sun, 23 Oct 2022 17:21:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 900C01CF55A;
        Sun, 23 Oct 2022 20:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dDTEuvH3Sjck
        3X+Ul8+lsCk3v85OL9VPrRbttGv9LU0=; b=Z1TAOMTes4O77v7Eus6bO0WN0Ych
        xuKkKUbefWlyr4uKKvpbv7uvuD+7YIKN9z/yWlv+Aex4e7TUMkxfBCVdek9P50Y+
        GYZcgiX4vXrPQBaJe2SZwstc615RM+PEuEfzgkIl7vJ864nKByxukmH3q03uSIk0
        twVByfPTFg7P7EU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7ADAF1CF559;
        Sun, 23 Oct 2022 20:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B9E21CF558;
        Sun, 23 Oct 2022 20:20:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: error and informative messages
References: <3f63d53d-2e14-ffe0-6263-2a15f83453ad@gmail.com>
Date:   Sun, 23 Oct 2022 17:20:55 -0700
In-Reply-To: <3f63d53d-2e14-ffe0-6263-2a15f83453ad@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Mon, 24 Oct 2022 00:29:37 +0200")
Message-ID: <xmqq5ygaul5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BA8A7F86-5331-11ED-8F90-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Review die(), error(), warning() and output messages used in branch,
> following the guidelines we have in Documentation/CodingGuideLines.
> Mainly:
> 	Error messages
>
>  	 - Do not end error messages with a full stop.
>
>  	 - Do not capitalize the first word, ...

OK.

>
> Beside applying this rules, some unneeded messages have been removed an=
d
> others reworded to normalize and simplify.
>
>  - Four similar messages has been merged into the most common, the last
>    one:
> 	- "no such branch '%s'"
> 	- "branch '%s' does not exist"
> 	- "invalid branch name: '%s'"
> 	+ "no branch named '%s'"

The third one could be more appropriate than the fourth one when the
error is about failing to create a new branch due to invalid name.
But all the other three seem to refer to a branch that ought to
exist but doesn't, and the one you picked seems reasonable one among
the three (and it is also the shortest).

>  - Two specific messages has been reworded and merged:
> 	- "could not set upstream of HEAD to %s when
> 		it does not point to any branch."
> 	- "could not unset upstream of HEAD when it
> 		does not point to any branch."
> 	+ "cannot modify upstream to detached HEAD"

OK.  I have no strong opinion between "modify" and "set or unset"
but the latter may be closer to the spirit of the former.  I agree
that "HEAD when it does not ..." is quite a mouthful and to those
who understand what a 'detached HEAD' is, the updated phrasing may
be easier to read.

>  - An error message reworded
> 	- "options '%s' and '%s' cannot be used together",
> 		"--column", "--verbose"
> 	+ "options --column and --verbose used together"

This is arguably a regression.  The original ensures that l10n/i18n
folks cannot frob the option names that must be literally spelled,
but the "reworded" one lacks the protection (it also loses the quotes
around dashed options).

>  - An error message reworded
> 	- "The -a, and -r, options to 'git branch' do not take a branch name.\=
n"
> 		"Did you mean to use: -a|-r --list <pattern>?"));
> 	+ "options -a and -r do not take a branch name\n"
> 		"Did you mean to use: -a|-r --list <pattern>?"));

OK.

>  - Two error messages not needed, removed:
> 	- "cannot copy the current branch while not on any."
> 	- "cannot rename the current branch while not on any."

OK (assuming that these are unreachable code).

>  - A deprecation message has been reworded, note the '\n':
> 	- "the '--set-upstream' option is no longer supported."
> 		"Please use '--track' or '--set-upstream-to' instead."
> 	+ "option --set-upstream is no longer supported\n"
> 		"Please use --track or --set-upstream-to instead"

Loss of quotes around option names, and the definite article "the"?

>  - "%s" and "'%s'" was used to format a branch name in different
>    messages.  "'%s'" has been used to normalize as it's the more
>    frequently used in this file and very common in the rest of the
>    codebase.  The opposite has been done for options: "-a" used vs
>    "'-a'".

As the way to display the exact literal string, I think it is good
to have quotes around both of them, the user-chosen names like
branch names, and the system-chosen names like option names.

> A new informative, non-error, message has been introduced for
> create_branch:
> 	+ "New branch '%s' created from '%s'\n"

OK.

> The tests for the modified messages have been updated and a new test fo=
r
> the create_branch message has been added.
>
> Finally, let's change the return code on error for --edit-description,
> from -1 to 1.

OK.  That last one may be better to be a separate patch, as these
wording changes are subject to discussion and bikeshedding.

> -	if ((head_rev !=3D reference_rev) &&
> -	    in_merge_bases(rev, head_rev) !=3D merged) {
> -		if (merged)
> -			warning(_("deleting branch '%s' that has been merged to\n"
> -				"         '%s', but not yet merged to HEAD."),
> -				name, reference_name);
> -		else
> -			warning(_("not deleting branch '%s' that is not yet merged to\n"
> +	if ((head_rev !=3D reference_rev) && in_merge_bases(rev, head_rev) !=3D=
 merged)
> +		warning(merged
> +			? _("deleting branch '%s' that has been merged to\n"
> +				"         '%s', but not yet merged to HEAD.")
> +			: _("not deleting branch '%s' that is not yet merged to\n"
>  				"         '%s', even though it is merged to HEAD."),
>  				name, reference_name);
> -	}

This does not fall into any of the categories the proposed log
message discussed.  Rather, it looks more like "the code
subjectively looks better this way".  It happens to much my
subjective taste, but that does not change the fact that we
shouldn't distract reviewers with such an unrelated change in the
same patch.

> @@ -520,13 +512,6 @@ static void copy_or_rename_branch(const char *oldn=
ame, const char *newname, int
>  	const char *interpreted_newname =3D NULL;
>  	int recovery =3D 0;
> =20
> -	if (!oldname) {
> -		if (copy)
> -			die(_("cannot copy the current branch while not on any."));
> -		else
> -			die(_("cannot rename the current branch while not on any."));
> -	}
> -

Something like

    copy_or_rename_branch() never gets NULL in oldname, because its
    only callers in cmd_branch() calls it with either the end-user's
    command line argument or the result of resolve_refdup("HEAD"),
    and neither can ever be NULL because ...

needs to go into the proposed log message to explain why it is safe
to remove these two messages.

Having said that, the messages may actually be correct and it is the
logic that makes it unreachable that is wrong in this case, I think.
It looks like the code expects that oldname is NULL when we are on
detached HEAD (it could be the old caller did have NULL in head when
this code was written, and it is possible that we regressed over the
course of history).  I.e. Isn't it trying to protect us against

   $ git checkout --detach HEAD^0
   $ git branch -m foo		;# rename .git/HEAD to .git/foo???

(or "-c" for copy)?  The current code happens to catch it a bit
later in this function, when it notices "HEAD" is not a refname in
"refs/heads/" hierarchy, but the user never attempted to rename
refs/heads/HEAD to refs/heads/foo, and "Invalid branch name: 'HEAD'"
is us being wrong, insulting and confusing to the users.

I suspect that this needs to be fixed at the caller's level, just
like the caller reacts to "edit_description" by checking the
filter.detached bit and rejects the request, the caller should
notice that we are on a detached HEAD and die with one of the above
two messages without calling this function.

And that should be a separate patch, that can be reviewed and
applied regardless of the rest of "error messages cleanup" topic.

The hunks before this point that I omitted from quoting and
commenting looked all OK.

The remainder of the patch I didn't look at.  There may be similar
issues like this "oops, the messages are dead for a wrong reason and
code needs to be fixed" or "let's leave subjective improvements out
of this topic that has clearly described rules" to be discovered, so
I may come back to them later, or others may find them before I do.

Thanks for working on this one.


