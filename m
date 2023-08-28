Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57AFC83F15
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 16:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjH1QQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjH1QPh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 12:15:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646D9123
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 09:15:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 586821B7C35;
        Mon, 28 Aug 2023 12:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BXHgKkZrJaLdKhzvctHr7BqqYi6kz4PUFy6725
        GnMnA=; b=Nn8epjcw3KCd4eqBuj6WmSXGqwdYp8KE18pzdP3xh//+lRqFuGrnat
        4noyG1GbXKzyTxHQHvw9AIj2zW58y6Aw7jhVcK6uGoNtDDVJXpJvn+HkU/oVXS3S
        FaAX6rqSUuMzQhk/m+/zkkvSV7f2oKTgqyt5z+va5JrqVVweotEeo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 502F41B7C34;
        Mon, 28 Aug 2023 12:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4F861B7C33;
        Mon, 28 Aug 2023 12:15:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/log.c: prepend "RFC" on --rfc
References: <20230828144940.18245-1-sir@cmpwn.com>
Date:   Mon, 28 Aug 2023 09:15:30 -0700
In-Reply-To: <20230828144940.18245-1-sir@cmpwn.com> (Drew DeVault's message of
        "Mon, 28 Aug 2023 16:48:49 +0200")
Message-ID: <xmqqa5ubi1nh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C6538AC-45BE-11EE-943F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> Rather than replacing the configured subject prefix (either through the
> git config or command line) entirely with "RFC PATCH", this change
> prepends RFC to whatever subject prefix was already in use.
>
> This is useful, for example, when a user is working on a repository that
> has a subject prefix considered to disambiguate patches:
>
> 	git config format.subjectPrefix 'PATCH my-project'
>
> Prior to this change, formatting patches with --rfc would lose the
> 'my-project' information.
>
> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> ---
> v2 incorporates feedback from Jeff King regarding the lifetime of the
> heap-allocated "RFC %s" formatted string.

For future reference, you can signal that by adding

	Helped-by: Jeff King <peff@peff.net>

before [*] your Sign-off.  I'll do that on the receiving end so no
need to resend this patch only to correct for this.

    Side note: in other words, in the chronological order of what
    happened to this particular version of the patch that you expect
    to hit my tree (you wrote this version with the help by peff,
    and after proofreading the end product certify that you are
    contributing to this project under DCO 1.1).

>  Documentation/git-format-patch.txt |  6 +++---
>  builtin/log.c                      | 12 +++++++++++-
>  t/t4014-format-patch.sh            |  9 +++++++++
>  3 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 373b46fc0d..fdc52cf826 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -229,9 +229,9 @@ populated with placeholder text.
>  	variable, or 64 if unconfigured.
>  
>  --rfc::
> -	Alias for `--subject-prefix="RFC PATCH"`. RFC means "Request For
> -	Comments"; use this when sending an experimental patch for
> -	discussion rather than application.
> +	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
> +	default). RFC means "Request For Comments"; use this when sending
> +	an experimental patch for discussion rather than application.

Looks good.  

Nowhere in the manual page we hint how the separation between
"fairly permanent" customization with format.subjectPrefix and "per
invocation" customization with this option, which has now become
possible, is expected to be useful.  Do we expect it is too obvious
for our readers and they will figure it out themselves?

It might be sufficient to add mention of format.subjectPrefix to the
description of "--subject-prefix=<subject prefix>" option on the
same page, with possible rephrasing of "useful naming of a patch
series", which leans toward "per invocation" customization (i.e.
even for the same project, different names may be used depending on
a patch series).

> diff --git a/builtin/log.c b/builtin/log.c
> index db3a88bfe9..854216ee9c 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1476,9 +1476,19 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
>  
>  static int rfc_callback(const struct option *opt, const char *arg, int unset)
>  {
> +	/*
> +	 * The subject_prefix in rev_info is not heap-allocated except in this
> +	 * specific case, so there is no obvious place to free it. Since this
> +	 * value is retained for the lifetime of the process, we just
> +	 * statically allocate storage for it here.
> +	 */
> +	static char *prefix;
>  	BUG_ON_OPT_NEG(unset);
>  	BUG_ON_OPT_ARG(arg);
> -	return subject_prefix_callback(opt, "RFC PATCH", unset);
> +
> +	free(prefix);
> +	prefix = xstrfmt("RFC %s", ((struct rev_info *)opt->value)->subject_prefix);
> +	return subject_prefix_callback(opt, prefix, unset);
>  }

In the current code before this patch, the rev.subject_prefix member
holds one of:

 * hardcoded "PATCH" in BSS (i.e. fmt_patch_subject_prefix)
 * hardcoded "RFC PATCH" in BSS when "--rfc" is given
 * value given to command line arg "--subject-prefix=<prefix>"
 * value given to format.subjectprefix

and the last one should be freed.  We are removing the second one
and replacing it with whatever we will do when adding this feature
so we should be able to make it freeable.  And I do not think it is
hard to make the third one freeable.

I wonder how far we can go to plug this leak by simply 

 - making subject_prefix_callback() xstrdup() its arg and free the
   current value, unless it is the same pointer as
   fmt_patch_subject_prefix, before assigning a new value, and 

 - making "format.subjectprefix" take the value in a temporary
   variable from git_config_string(), call
   subject_prefix_callback(), and free that temporary.

Then unless you use --rfc, --subject-prefix, or the
format.subjectprefix variable, we will have no allocation, and if
you use any of these, you'll allocate and do the right thing, no?

Of course, as this is "we compute the value once and keep using it
without reallocating or updating", coming up with overly complex
solution is not worth it, so the "we only have one allocated string
pointed at by a static, but repeated use of options will not leak"
we see above is probably good enough.

> +test_expect_success '--rfc does not overwrite prefix' '
> +	cat >expect <<-\EOF &&
> +	Subject: [RFC PATCH foobar 1/1] header with . in it
> +	EOF
> +	git format-patch -n -1 --stdout --subject-prefix "PATCH foobar" --rfc >patch &&

This is OK but it does not really test the expected use case, does
it?  Nobody sane would give both --subject-prefix and --rfc from the
command line---they will do --subject-prefix="RFC PATCH foobar"
instead, of course.

	git -c format.subjectPrefix="PATCH foobar" \
		-n -1 --stdout --rfc >patch

may be much closer to what we expect to see in the real life, I
would think.

> +	grep ^Subject: patch >actual &&

While it is not wrong per se, let's quote the pattern.  Visually,
any token with a colon at the end attracts whatever comes after it
and pulls the readers into an illusion that they are part of the
same single command line argument.  I.e.

	grep -e "^Subject: " patch >actual &&

Thanks.

> +	test_cmp expect actual
> +'
> +
>  test_expect_success '--from=ident notices bogus ident' '
>  	test_must_fail git format-patch -1 --stdout --from=foo >patch
>  '
