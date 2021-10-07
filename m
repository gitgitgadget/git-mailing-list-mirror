Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AF8C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 19:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7C260FA0
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 19:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbhJGTn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:43:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55756 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhJGTnU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 15:43:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD653F2A21;
        Thu,  7 Oct 2021 15:41:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SztpyIT8SVbVEcr44tMkZDrQZfHEU7wqIZVNe2
        HyScs=; b=cGyVfgLd0Gc8Id8tXzqPJsutFAp90D6BOT80SVSlH5F9aem1rMWege
        8XYj+hX5qaQ8CxAle8x1gzbaxwV8DIV6olQZu4e0ITEXeR9s+02RL9NS1FGxwWXD
        El8ABcBGfLkhuidpbghuKRa/HavK3heI0WWAzQtU1QEw9NQUX7qaQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1F51F2A20;
        Thu,  7 Oct 2021 15:41:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3EDDF2A1E;
        Thu,  7 Oct 2021 15:41:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Mugdha Pattnaik <mugdhapattnaik@gmail.com>
Subject: Re: [PATCH v6] submodule: absorb git dir instead of dying on deinit
References: <pull.1078.v5.git.git.1633521772731.gitgitgadget@gmail.com>
        <pull.1078.v6.git.git.1633523057369.gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 12:41:23 -0700
In-Reply-To: <pull.1078.v6.git.git.1633523057369.gitgitgadget@gmail.com>
        (Mugdha Pattnaik via GitGitGadget's message of "Wed, 06 Oct 2021
        12:24:17 +0000")
Message-ID: <xmqqwnmopqqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E7CEF44-27A6-11EC-9AFB-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: mugdha <mugdhapattnaik@gmail.com>

This line is called "in-body header" that is used to override the
author name that is automatically obtained from the e-mail's "From:"
header (which is set to "Mugdha Pattnaik via GitGitGadget" by GGG,
which is obviously not your name, hence we use an in-body header to
override it).  It should match what you use to sign off your patches,
the one we see below.

I'll hand-edit so that "git show" will say that the author is
"Mugdha Pattnaik", not "mugdha", while applying, but please make
sure your further submissions will not have this problem.

> Currently, running 'git submodule deinit' on repos where the
> submodule's '.git' is a directory, aborts with a message that is not
> exactly user friendly. Let's change this to instead warn the user
> to rerun the command with '--force'.

OK.  That sounds like an improvement, albeit possibly an overly
cautious one, as a casual "deinit" user will get an error as before
without "--force", which may or may not be a good thing.  Requiring
"--force" means it is safer by default by not changing the on-disk
data.  But requiring "--force" also means we end up training users
to say "--force" when it shouldn't have to be.

A plausible alternative is to always absorb but with a warning "we
absorbed it for you", without requiring "--force".  If we didn't
have "git submodule deinit" command now and were designing it from
scratch, would we design it to fail because the submodule's git
directory is not absorbed?  I doubt it, as I do not think of a good
reason to do so offhand.

Does "git submodule" currently reject a "deinit" request due to some
_other_ conditions or safety concerns and require the "--force"
option to continue?  Requiring the "--force" option to resolve ".git
is a directory, and the user wants to make it absorbed" means that
the user will be _forced_ to bypass these _other_ safety valves only
to save the submodule repository from destruction when running
"deinit", which may not be a good trade-off between the safety
requirements of these _other_ conditions, if exists, and the one we
are dealing with.

> This internally calls 'absorb_git_dir_into_superproject()', which
> moves the git dir into the superproject and replaces it with
> a '.git' file. The rest of the deinit function can operate as it
> already does with new-style submodules.

This is not wrong per-se, but such an implementation detail is
something best left for the patch.  

> We also edit a test case such that it matches the new behaviour of
> deinit.

"match the new behaviour" in what way?

    In one test, we used to require "git submodule deinit" to fail
    even with the "--force" option when the submodule's .git/
    directory is not absorbed.  Adjust it to expect the operation to
    pass.

would be a description at the right level of detail, I think.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ef2776a9e45..040b26f149d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1539,16 +1539,24 @@ static void deinit_submodule(const char *path, const char *prefix,
>  		struct strbuf sb_rm = STRBUF_INIT;
>  		const char *format;
>  
> -		/*
> -		 * protect submodules containing a .git directory
> -		 * NEEDSWORK: instead of dying, automatically call
> -		 * absorbgitdirs and (possibly) warn.
> -		 */
> -		if (is_directory(sub_git_dir))
> -			die(_("Submodule work tree '%s' contains a .git "
> -			      "directory (use 'rm -rf' if you really want "
> -			      "to remove it including all of its history)"),
> -			    displaypath);
> +		if (is_directory(sub_git_dir)) {
> +			if (!(flags & OPT_FORCE))
> +				die(_("Submodule work tree '%s' contains a "
> +				      ".git directory.\nUse --force if you want "
> +				      "to move its contents to superproject's "
> +				      "module directory and convert .git to a file "
> +				      "and then proceed with deinit."),
> +				    displaypath);
> +
> +			if (!(flags & OPT_QUIET))
> +				warning(_("Submodule work tree '%s' contains a .git "
> +					  "directory. This will be replaced with a "
> +					  ".git file by using absorbgitdirs."),
> +					displaypath);
> +
> +			absorb_git_dir_into_superproject(displaypath, flags);

Shouldn't the first argument to this call be "path" not
"displaypath"?  The paths in messages may want to have the path from
the top to the submodule location prefixed for human consumption,
but the called function only cares about the path to the submodule
from the current directory, no?

The second parameter of this call seems totally bogus to me.  What
is the vocabulary of bits the called function takes?  Is that from
the same set the flags this function takes?  Does the called
function even understand OPT_QUIET, or does the bitpattern that
happens to correspond to OPT_QUIET have a totally different meaning
to the called function and we will trigger a behaviour that this
caller does not expect at all?

Thanks.
