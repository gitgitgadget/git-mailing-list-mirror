Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AEAC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF54206F8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="csat8Alx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgCYGEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:04:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63054 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgCYGEY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:04:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8E1B6053B;
        Wed, 25 Mar 2020 02:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TERMRFKkDvEhh6k/zKdGL2WJerM=; b=csat8A
        lxEbzCKzh4PMlopFH3CUPtYsYOu9GOVXPfx9/OItEi0HGeX1fmYwvMKiTpvtq2gX
        CRwWT7uxbWTXuPSNfoynxS/AnhjOQ+nIglWOce3uxT2W1JVPt2Hzc6CKwSU8iLAE
        YhnCELtE99PKVKhc4rbc9pHNpIZp1j2VcmAxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P5g1nRxmI/22rkr/pt7fxKO8W1KtWmlK
        tbM+hGTCb6BCWT7xXIja3JSlsa4DOdZynY8abZbE+h8xiUEOIHSNwqt99GDUHo2x
        dRS4JQoYRbNporx0g1rLMkb23uUgfbpY3Tmay/++QmTNu2SgmF+tn4JGUVQq7uTF
        Iv/+T3VRu7M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1EDC6053A;
        Wed, 25 Mar 2020 02:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F7CE60538;
        Wed, 25 Mar 2020 02:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 1/5] transport: not report a non-head push as a branch
References: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
        <20200322131815.11872-2-worldhello.net@gmail.com>
Date:   Tue, 24 Mar 2020 23:04:19 -0700
In-Reply-To: <20200322131815.11872-2-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 22 Mar 2020 09:18:11 -0400")
Message-ID: <xmqq4kudynq4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77AE102A-6E5E-11EA-AD48-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> +# NOTE: Avoid calling this function from a subshell since variable
> +# assignments will disappear when subshell exits.

s/Avoid/Never/; the test_tick helper used in this function has the
same issue.

> +create_commits_in () {
> +	repo="$1" &&
> +	if ! parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null)

Do we need to discard the standard error stream like this?  As long
as this helper function is called inside a test_expect_thing, the
error will not be seen and when debugging the test, we would want to
see a failure (which indicates that we are creating a root commit).

> +format_git_output () {

I suspect this is to make output from _some_ "git" subcommand into a
symbolic form so that exact object names would not have to be used
in comparison, but this obviously cannot take _any_ git subcommand,
but a specific one.  The name does not say which one, which is
disservice to readers.

> +	sed \
> +		-e "s/  *\$//g" \

What's the point of /g?  You are anchoring the pattern (i.e. one or
more SP) to the right end of the line, so it's not like it would
transform "a  b c   " into "abc".  Also it would be sufficient to
say "zero or more" and that would be shorter, I think, i.e.

		-e 's/ *$//' \

> +		-e "s/$A/<COMMIT-A>/g" \
> +		-e "s/$B/<COMMIT-B>/g" \
> +		-e "s/$TAG/<COMMIT-T>/g" \

A and B are commits, so the symbolic <COMMIT-A> and <COMMIT-B> do
make sense, but wouldn't TAG be an annotated tag?  Wouldn't it be
<TAG-A> perhaps?

> +		-e "s/$ZERO_OID/<ZERO-OID>/g" \

Maekes sense.

> +		-e "s/'/\"/g"

I am not sure what is going on here.  Why turn <don't> into <don"t>?
Without exactly knowing what is getting munged, a reader cannot tell
what is going on here.  Let's read on to figure it out.

In any case, I think most of this helper is not about "formatting"
output, but hiding, getting rid of, redacting or censoring the
details for easier comparison.  I'd prefer to see some different
verb to be used for its name.

> +}
> +
> +test_expect_success "setup" '
> +	git init --bare upstream &&
> +	git init workbench &&
> +	create_commits_in workbench A B &&
> +	(
> +		cd workbench &&
> +		git remote add origin ../upstream &&
> +		git config core.abbrev 7 &&

This '7' is "use at least seven hexdigits"; is that really what we
want?  Depending on chance, some objects may be shown using 8 or
more---is our "munge output into symbolic form for comparison"
script prepared for such a case?

> +		git update-ref refs/heads/master $A &&
> +		git tag -m "v1.0.0" v1.0.0 $A &&
> +		git push origin \
> +			$B:refs/heads/master \
> +			$A:refs/heads/next
> +	) &&
> +	TAG=$(cd workbench; git rev-parse v1.0.0) &&

Why not "git -C workbench rev-parse v1.0.0"?

So, at this point, there are two repositories, upstream and
workbench, and two commits A and B (B is newer).  workbench has A at
the tip of its 'master'; upstream has A at the tip of 'next' and B
(which is newer than A) at the tip of 'master'.

> +
> +	# setup pre-receive hook
> +	cat >upstream/hooks/pre-receive <<-EOF &&

Wouldn't it make it easier to read the resulting text if you quoted
the end-of-here-text marker here, i.e. "<<\-EOF"?  That way, you can
lose backslash before $old, $new and $ref.

> +	#!/bin/sh
> +
> +	printf >&2 "# pre-receive hook\n"
> +
> +	while read old new ref
> +	do
> +		printf >&2 "pre-receive< \$old \$new \$ref\n"
> +	done
> +	EOF
> +	# setup post-receive hook
> +	cat >upstream/hooks/post-receive <<-EOF &&

Likewise.

> +test_expect_success "normal git-push command" '
> +	(
> +		cd workbench &&
> +		git push -f origin \
> +			refs/tags/v1.0.0 \
> +			:refs/heads/next \
> +			HEAD:refs/heads/master \
> +			HEAD:refs/review/master/topic \
> +			HEAD:refs/heads/a/b/c
> +	) >out 2>&1 &&

Do we need to worry about progress output (which we would want to
squelch, I presume, for the purpose of comparing with the
"expectation")?  Would it be just the matter of giving --no-progress?

> +	format_git_output <out >actual &&
> +	cat >expect <<-EOF &&
> +	remote: # pre-receive hook
> +	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
> +	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/next
> +	remote: pre-receive< <ZERO-OID> <COMMIT-T> refs/tags/v1.0.0
> +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
> +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c

Do we guarantee the order in which these received refs are reported,
or do we somehow need to sort (presumably inside the hook)?  The
same question applies to the post-receive side, too.

> +	remote: # post-receive hook
> +	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
> +	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/next
> +	remote: post-receive< <ZERO-OID> <COMMIT-T> refs/tags/v1.0.0
> +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
> +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
> +	To ../upstream
> +	 + ce858e6...1029397 HEAD -> master (forced update)
> +	 - [deleted]         next
> +	 * [new tag]         v1.0.0 -> v1.0.0
> +	 * [new reference]   HEAD -> refs/review/master/topic
> +	 * [new branch]      HEAD -> a/b/c
> +	EOF
> +	test_cmp expect actual &&
> +	(
> +		cd upstream &&
> +		git show-ref

This one I know we give output in a reliable order, but I do not
offhand know if we give any written guarantee.  Perhaps we should
document it if we haven't already (i.e. it is OK the "expected"
output below assumes that the output is sorted by full refnames in
ASCII order).

> +	) >out &&
> +	format_git_output <out >actual &&
> +	cat >expect <<-EOF &&
> +	<COMMIT-A> refs/heads/a/b/c
> +	<COMMIT-A> refs/heads/master
> +	<COMMIT-A> refs/review/master/topic
> +	<COMMIT-T> refs/tags/v1.0.0
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_done
> diff --git a/transport.c b/transport.c
> index 1fdc7dac1a..b5b7bb841e 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -501,7 +501,8 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
>  	else if (is_null_oid(&ref->old_oid))
>  		print_ref_status('*',
>  			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
> -			"[new branch]"),
> +			(starts_with(ref->name, "refs/heads/") ? "[new branch]" :
> +			"[new reference]")),
>  			ref, ref->peer_ref, NULL, porcelain, summary_width);

The original is largely to blame, but I couldn't read the above and
understand what the above is doing, before reformatting it like so:

	else if (is_null_oid(&ref->old_oid))
		print_ref_status('*',
				 (starts_with(ref->name, "refs/tags/")
				  ? "[new tag]"
				  : (starts_with(ref->name, "refs/heads/")
				     ? "[new branch]"
				     : "[new reference]")),
				 ref, ref->peer_ref, NULL, porcelain, summary_width);

When long subexpressions are involved, ternary operator ?: is easier
to read, especially when nested, if you can see its parse tree when
you tilt your head 90-degrees sideways (i.e. the same direction as
you can see a smile in ;-).

Thanks.

