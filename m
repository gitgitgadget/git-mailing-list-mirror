Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8CF201C2
	for <e@80x24.org>; Sun, 12 Mar 2017 04:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755671AbdCLEox (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 23:44:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755666AbdCLEov (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 23:44:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 206F17CBEC;
        Sat, 11 Mar 2017 23:44:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XVuUarJiq8eJ
        4WywI6Y4Sm5J3hk=; b=sGOsftl94syqu2DQw7xVG7SN1CodMxdMPJs8APpkTKxx
        Ow8f7DGFZhwB4tllvGxiLh3Y+b3NFIz5MFbe4oHqtx4KR6ObqYtXcM7gLedgS7R+
        4s57F+3x+bD77sdKuaUPIvhnzwZX0ZPNnuDa3WxES/5cPpVYYohgFY1miFj4sEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=di3P5J
        n3iUrAxqf1cImPhlyNDsDbgPTE+3mPxWA+MyVvlPjhCNZe9xTKcMK9TmJGVWmwEb
        7pIDrTHMTMNBVgUdVyHzHGp/PP/YsGEopmFKMqtv+wqSbvSgR6bJmmqUj7F2YZL+
        JzWtWD5Uxtk4/2uvHk7Q+vrqEQRS5ZpVvIF2E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18A167CBEB;
        Sat, 11 Mar 2017 23:44:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F7C17CBEA;
        Sat, 11 Mar 2017 23:44:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4] ref-filter: Add --no-contains option to tag/branch/for-each-ref
References: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
        <20170311201858.27555-1-avarab@gmail.com>
Date:   Sat, 11 Mar 2017 20:44:47 -0800
In-Reply-To: <20170311201858.27555-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 11 Mar 2017 20:18:58 +0000")
Message-ID: <xmqqwpbvumrk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F63B754-06DE-11E7-9983-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the tag, branch & for-each-ref commands to have a --no-contains
> option in addition to their longstanding --contains options.
>
> The use-case I have for this is to find the last-good rollout tag
> given a known-bad <commit>. Right now, given a hypothetically bad
> commit v2.10.1-3-gcf5c7253e0, you can find which git version to revert
> to with this hacky two-liner:
>
>     (./git tag -l 'v[0-9]*'; ./git tag -l 'v[0-9]*' --contains v2.10.1-=
3-gcf5c7253e0) \
>         |sort|uniq -c|grep -E '^ *1 '|awk '{print $2}' | tail -n 10
>
> But with the --no-contains option you can now get the exact same
> output with:
>
>     ./git tag -l 'v[0-9]*' --no-contains v2.10.1-3-gcf5c7253e0|sort|tai=
l -n 10

This command line, while it may happen to work, logically does not
make much sense.  Move the pattern to the end, i.e.

	git tag -l --no-contains v2.10.1-3-gcf5c7253e0 'v[0-9]*'

Also if an overlong line in an example disturbs you, do not solve it
by omitting SP around pipe.  If you are trying to make the result
readable, pick a readable solution, e.g.

    git tag -l --no-contains v2.10.1-3-gcf5c7253e0 'v[0-9]*' |
    sort | tail -n 10

Oh, drop ./ from ./git while at it ;-)

> The filtering machinery is generic between the tag, branch &
> for-each-ref commands, so once I'd implemented it for tag it was
> trivial to add support for this to the other two.

Also, we tend not to say "I did this, I do that".

	Because the filtering machinery is generic ..., support it
	for all three consistently.

> I'm adding a --without option to "tag" as an alias for --no-contains
> for consistency with --with and --contains. Since we don't even
> document --with anymore (or test it). The --with option is
> undocumented, and possibly the only user of it is Junio[1]. But it's
> trivial to support, so let's do that.

The sentence that begins "Since we don't" is unfinished.  I think
it can safely removed without losing any information (the next
sentence says the same thing).

> Where I'm changing existing documentation lines I'm mainly word
> wrapping at 75 columns to be consistent with the existing style.

Reviewers would appreciate you refrain from doing that in the same
patch.  Do a minimum patch so that the review can concentrate on
what got changed (i.e. contents), followed by a mechanical reflow as
a follow-up, or something like that, would be much nicer to handle.

> Most of the test changes I've made are just doing the inverse of the
> existing --contains tests, with this change --no-contains for tag,
> branch & for-each-ref is just as well tested as the existing
> --contains option.

Again, we tend to try our commits not about "I, my, me".

	Add --no-contains tests for tag, branch and for-each-ref
	that mostly do the inverse of the existing tests we have for
	--contains.

> This is now based on top of pu, which has Jeff King's "fix object flag
> pollution in "tag --contains" series.

Thanks for this note.  I obviously cannot queue on top of 'pu' ;-)
but will fork this topic off of the jk/ref-filter-flags-cleanup
topic.

>  'git for-each-ref' [--count=3D<count>] [--shell|--perl|--python|--tcl]
>  		   [(--sort=3D<key>)...] [--format=3D<format>] [<pattern>...]
>  		   [--points-at <object>] [(--merged | --no-merged) [<object>]]
> -		   [--contains [<object>]]
> +		   [(--contains | --no-contains) [<object>]]

THis notation makes sense.  We have to have one of these but
<object> at the end could be omitted (to default to HEAD).  I guess
the same notation can be used in the log for the other "filtering
implies --list mode for 'git tag'" topic.

> +--no-contains [<commit>]::
> +	Only list tags which don't contain the specified commit (HEAD if
> +	not specified).

Just being curious.  Can we do

	for-each-ref --contains --no-contains=20

and have both default to HEAD?  I know that would not make sense as
a set operation, but I am curious what our command line parser
(which is oblivious to what the command is doing) does.  I am guessing
that it would barf saying "--contains" needs a commit but "--no-contains"
is not a commit (which is very sensible)?

> +
>  --points-at <object>::
>  	Only list tags of the given object.

This is not a new issue (and certainly not a problem caused by your
patch), but unlike "--contains", this does not default to HEAD when
<object> is not explicitly given?  It seems a bit inconsistent to me.

> @@ -618,7 +620,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>  	if (!delete && !rename && !edit_description && !new_upstream && !unse=
t_upstream && argc =3D=3D 0)
>  		list =3D 1;
> =20
> -	if (filter.with_commit || filter.merge !=3D REF_FILTER_MERGED_NONE ||=
 filter.points_at.nr)
> +	if (filter.with_commit || filter.no_commit || filter.merge !=3D REF_F=
ILTER_MERGED_NONE || filter.points_at.nr)
>  		list =3D 1;

OK.

> diff --git a/parse-options.h b/parse-options.h
> index dcd8a0926c..0eac90b510 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -258,7 +258,9 @@ extern int parse_opt_passthru_argv(const struct opt=
ion *, const char *, int);
>  	  PARSE_OPT_LASTARG_DEFAULT | flag, \
>  	  parse_opt_commits, (intptr_t) "HEAD" \
>  	}
> -#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
> +#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PAR=
SE_OPT_NONEG)
> +#define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, =
h, PARSE_OPT_NONEG)
>  #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_H=
IDDEN)
> +#define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE=
_OPT_HIDDEN)

Hmph, perhaps WITH/WITHOUT also do not take "--no-" form hence need OPT_N=
ONEG?

> @@ -1586,11 +1587,11 @@ static enum contains_result contains_tag_algo(s=
truct commit *candidate,
>  }
> =20
>  static int commit_contains(struct ref_filter *filter, struct commit *c=
ommit,
> -			   struct contains_cache *cache)
> +			   struct commit_list *list, struct contains_cache *cache)
>  {
>  	if (filter->with_commit_tag_algo)
> -		return contains_tag_algo(commit, filter->with_commit, cache) =3D=3D =
CONTAINS_YES;
> -	return is_descendant_of(commit, filter->with_commit);
> +		return contains_tag_algo(commit, list, cache) =3D=3D CONTAINS_YES;
> +	return is_descendant_of(commit, list);
>  }
> =20
>  /*
> @@ -1780,13 +1781,17 @@ static int ref_filter_handler(const char *refna=
me, const struct object_id *oid,
>  	 * obtain the commit using the 'oid' available and discard all
>  	 * non-commits early. The actual filtering is done later.
>  	 */
> -	if (filter->merge_commit || filter->with_commit || filter->verbose) {
> +	if (filter->merge_commit || filter->with_commit || filter->no_commit =
|| filter->verbose) {
>  		commit =3D lookup_commit_reference_gently(oid->hash, 1);
>  		if (!commit)
>  			return 0;
> -		/* We perform the filtering for the '--contains' option */
> +		/* We perform the filtering for the '--contains' option... */
>  		if (filter->with_commit &&
> -		    !commit_contains(filter, commit, &ref_cbdata->contains_cache))
> +		    !commit_contains(filter, commit, filter->with_commit, &ref_cbdat=
a->contains_cache))
> +			return 0;
> +		/* ...or for the `--no-contains' option */
> +		if (filter->no_commit &&
> +		    commit_contains(filter, commit, filter->no_commit, &ref_cbdata->=
no_contains_cache))
>  			return 0;
>  	}

When asking "--contains A --contains B", we show refs that contain
_EITHER_ A or B.  Two predicates are ORed together, and I think it
makes sense.

When asking "--contains A --no-contains B", we show refs that
contain A but exclude refs that contains B.  Two predicates are
ANDed together, and I think this also makes sense.

When asking "--no-contains A --no-contains B", what should we show?
This implementation makes the two predicates ANDed together [*1*].

The behaviour is sensible, but is it consistent with the way now
existing --no-merged works?

I think the rule is something like:

    A match with any positive selection criterion (like --contains
    A) makes a ref eligible for output, but then a match with any
    negatigve selection criterion (like --no-merged) filters it out.

Is it easy to explain to the users?  Do we need doc updates to
clarify, or does the description for existing --no-merged already
cover this?

Thanks.


[Footnote]

*1* ... because it uses the same commit_contains() machinery that
computes "contains either A or B" used for the first one and then
negates its result.
