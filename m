Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340A6C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 22:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB1E224F9
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 22:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441230AbgLNWpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 17:45:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56370 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441209AbgLNWpR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 17:45:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0080411B327;
        Mon, 14 Dec 2020 17:44:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ggtxmRd0mIw1
        OPMqH2y8DfN9JWk=; b=wP3Xw+dkXnelj6PJo2yDPbeBhD/3qgykh1o/U17UOoGv
        dwZbbEYT78icxHRRXp30D3CQTG6hTlwfIw/k4rk13+GBLnalvsHTDhEgkm8FCDU7
        465DAUowvVe+f0XdUIaPJV3XAoQfaJYqzJgqAv02pnMUs2Drwcl/cWrVVlbHnTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aPz05U
        V3NX0urvcqNMRqoqSvj+qj/pficnS4XwY0YgtIMCGKPu291fuHVJNOACOi4SexS/
        AbeB7W2IpNyqNRqiiNEyEv5lU3V0D2pogPKDpKIEkKPJsfIlyqkZDQsNyKpQZkly
        QtHb4+pG6oTOJAuwIqFj/zglYfmrjItkJxZmE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED95611B326;
        Mon, 14 Dec 2020 17:44:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 34FFA11B324;
        Mon, 14 Dec 2020 17:44:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] refs: warn on non-pseudoref looking .git/<file>
 refs
References: <20201210125321.19456-2-avarab@gmail.com>
        <20201214191700.16405-3-avarab@gmail.com>
Date:   Mon, 14 Dec 2020 14:44:28 -0800
In-Reply-To: <20201214191700.16405-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 14 Dec 2020 20:17:00 +0100")
Message-ID: <xmqqczzcatyr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EE1781FE-3E5D-11EB-94E6-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The refs parsing machinery will first try to parse arbitrary
> .git/<name> for a given <name>, before moving onto refs/<name>,
> refs/tags/<name> etc. See "ref_rev_parse_rules" in refs.c. Things that
> list references such as "for-each-ref" ignore these on the assumption
> that they're pseudorefs such as "HEAD".
>
> Thus if you end up in a repository that contains e.g. .git/master the
> likes of "checkout" can emit seemingly nonsensical error
> messages. E.g. I happened to have a .git/master with a non-commit
> SHA-1:
>
>     $ git checkout master
>     fatal: Cannot switch branch to a non-commit 'master'

Or, without even any funny files created in .git to make it
misbehave, "git checkout config" would already give you

    $ git checkout config
    error: pathspec 'config' did not match any file(s) known to git
    $ git checkout config --
    fatal: invalid reference: config

You were unlucky enough to have 40-hex in that garbage file.  How
did you end up with it, I wonder, but anyway, a move to make it
easier to diagnose the situation is very welcome.

> Let's help the user in this case by doing a very loose check for
> whether the ref name looks like a special pseudoref such as
> "HEAD" (i.e. only has upper case, dashes, underbars), and if not issue
> a warning:
>
>     $ git rev-parse master
>     warning: matched ref .git/master doesn't look like a pseudoref
>     c87c83a2e9eb6d309913a0f59389f808024a58f9

With the problem this patch addressed solved, what should happen if
you did this?

    $ git rev-parse refs/heads/master~4 >.git/master
    $ git checkout master

My knee-jerk reaction to the question is that we should still give
the same warning, even though the "checkout" should successfully
detach the HEAD at the commit, to remind you that the name you used
came from may have been resolved to something you did not expect,
and the value you used may not be what you wanted to use.

> I think it's conservative enough to just turn this on by default, but
> place it under a configurable option similar to the existing
> core.warnAmbiguousRefs. Running the entire test suite with "die"
> instead of "warning" passes with this approach.

Sounds sensible.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> Modified-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Huh?

> +core.warnNonPseudoRefs::
> +	If true, Git will warn you if the `<ref>` you passed
> +	unexpectedly resolves to a top-level ref stored in
> +	`.git/<file>` but doesn't look like a pseudoref such as
> +	`HEAD`, `MERGE_HEAD` etc. True by default.

I'd really prefer to see us to think, design and describe in terms
of a more generic ref API, when we do not have to limit us to the
behaviour only with files backend.  Reading the file `.git/<ref>` on
the filesystem happens to be one way to resolve a ref to its value
(i.e. reference to an object), but even with different ref backends,
we want 'master' that sits next to 'refs/heads/master' to trigger
this warning.  So

	... if the `<ref>` you passed refers to a <ref> outside the
	`refs/{heads,tags,...}/` hierarchy but does not look like
	...

or something like that, perhaps.

> ++
> +These references are ignored by linkgit:for-each-ref[1], but resolved
> +by linkgit:git-show[1], linkgit:git-rev-parse[1] etc. So it can be
> +confusing to have e.g. an errant `.git/mybranch` being confused with
> +`.git/refs/heads/mybranch`.

Here, ".git/mybranch" and ".git/refs/heads/mybranch" are good as
examples.  I just want to avoid tying the main description to the
files backend.

> diff --git a/refs.c b/refs.c
> index 3ec5dcba0be..634ab64cc9e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -649,12 +649,19 @@ static int is_main_pseudoref_syntax(const char *r=
efname)
>  		is_pseudoref_syntax(refname);
>  }
> =20
> +static int is_any_pseudoref_syntax(const char *refname)
> +{
> +	return is_main_pseudoref_syntax(refname) ||
> +		is_pseudoref_syntax(refname);
> +}

Hmph, why is this needed, I wonder.

"git show main-worktree/master" is specific enough to tell us that
the user did not mean "git show main-worktree/refs/heads/master",
no?  If so, then wouldn't it be sufficient to check only with
is_pseudoref_syntax() and nothing else?  I may probably missing
something to make me convince is_main_pseudoref_syntax() matters
here.

>  int expand_ref(struct repository *repo, const char *str, int len,
>  	       struct object_id *oid, char **ref)
>  {
>  	const char **p, *r;
>  	int refs_found =3D 0;
>  	struct strbuf fullref =3D STRBUF_INIT;
> +	static int warned_on_non_pseudo_ref;
> =20
>  	*ref =3D NULL;
>  	for (p =3D ref_rev_parse_rules; *p; p++) {
> @@ -669,6 +676,11 @@ int expand_ref(struct repository *repo, const char=
 *str, int len,
>  					    fullref.buf, RESOLVE_REF_READING,
>  					    this_result, &flag);
>  		if (r) {
> +			if (warn_non_pseudo_refs &&
> +			    !strchr(r, '/') &&
> +			    !is_any_pseudoref_syntax(r) &&
> +			    !warned_on_non_pseudo_ref++)
> +				warning(_(".git/%s doesn't look like a pseudoref"), r);

I do not see much point in reporting only the first one.

Isn't the conditional "if (r)" sufficiently limiting the ref only to
those that the user showed immediate interest in?  In other words,
even if there were .git/foo and .git/bar, both of which happens to
contain something that looks like an object name, "git show foo"
would cause this code to warn only about .git/foo and .git/bar, no?

If there are more than one hits, why shouldn't we report all of
them?

Or is this some performance thing (i.e. there only can be one hit,
so repeated calls to strchr() and is_any_pseudoref_syntax() after
seeing one hit would all be wasteful)?  If so, "have we warned? if
so skip the remainder of checking, as we won't warn" should be the
first in the &&-chain.

Puzzled.

Thanks.
