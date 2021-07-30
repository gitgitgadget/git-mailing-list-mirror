Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DA7C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 18:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCEF60FE7
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 18:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhG3S5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 14:57:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60035 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhG3S5M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 14:57:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C27A314F4D9;
        Fri, 30 Jul 2021 14:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DAjSX9ten9Y1OB7LLsNHJWFcgLHtE1aSxz/gjg
        GbvUg=; b=VlH5J5ZsRErETPFnzJj7iiz5qPtOiWRAttxtMOKl9hOiSKNCtApj12
        dYYldw1k4H4+PFxpVftzhielgGTlwDyARHXswves1k2d4bnRwJg4D+JNOdjwXNy9
        WWdzKBAUz8btVbiHoDyR6cpZZktkO3CSRKp+SDgOTxquahTynnxGA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BADAC14F4D8;
        Fri, 30 Jul 2021 14:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F33B714F4D7;
        Fri, 30 Jul 2021 14:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliams.eng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] upload-pack.c: treat want-ref relative to namespace
References: <20210730135845.633234-1-kim@eagain.st>
Date:   Fri, 30 Jul 2021 11:57:02 -0700
In-Reply-To: <20210730135845.633234-1-kim@eagain.st> (Kim Altintop's message
        of "Fri, 30 Jul 2021 13:59:16 +0000")
Message-ID: <xmqqbl6j1vgh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDE607E2-F167-11EB-BC65-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kim Altintop <kim@eagain.st> writes:

> When 'upload-pack' runs within the context of a git namespace, treat any
> 'want-ref' lines the client sends as relative to that namespace.
>
> Also check if the wanted ref is hidden via 'hideRefs', and respond with
> an error otherwise. It was previously possible to request any ref, but
> note that this is still the case unless 'hideRefs' is in effect.
>
> Signed-off-by: Kim Altintop <kim@eagain.st>
> ---

Nicely described.  I have a question on the last sentence, though.
Do you mean that any ref can be requested when a namespace is in
use, as long as 'hideRefs' is not in effect?  What does "any ref"
exactly mean---even thouse outside the given namespace (and if so
how?)  I wonder if the last sentence is making the description more
confusing without adding any clarity.  In other words, would this
work as a replacement for the second paragraph, or does it say
something different from what you wanted to say?

    Requests for any ref, even those that are marked to be hidden
    via the 'transfer.hideRefs' configuration, were allowed but it
    is problematic for such and such reasons.  Respond with an error
    if a requested ref is to be hidden.

I couldn't tell why you thought it was problematic, so left "for
such and such reasons" to be filled in, but there still may be an
issue.

How does the error response look like?  We shouldn't be saying "you
requested for the hidden/x branch, but you are not allowed to do so,
as that is hidden".  To hide something, we should pretend that the
thing does not exist, so that we can hide even the fact that we are
hiding it.

To help future readers of "git log" who find this change from you,
we should clarify the "respond with an error" part of your proposed
log message (e.g. "pretend that the wanted ref does not exist when
it is hidden via the 'transfer.hiderefs' configuration" or something
else).

> +test_expect_success 'setup namespaced repo' '
> +	(
> +		git init -b main "$REPO" &&
> +		cd "$REPO" &&
> +		test_commit a &&
> +		test_commit b &&
> +		git checkout a &&
> +		test_commit c &&
> +		git checkout a &&
> +		test_commit d &&
> +		git update-ref refs/heads/ns-no b &&
> +		git update-ref refs/namespaces/ns/refs/heads/ns-yes c &&
> +		git update-ref refs/namespaces/ns/refs/heads/hidden d
> +	) &&
> +    git -C "$REPO" config uploadpack.allowRefInWant true &&
> +    git -C "$REPO" config transfer.hideRefs refs/heads/hidden
> +'

I wonder why the last two are outside the subshell?  IOW, you could
have configured the newly created repository while you were still in
there.

> +test_expect_success 'want-ref with namespaces' '
> +	oid=$(git -C "$REPO" rev-parse c) &&
> +	cat >expected_refs <<-EOF &&
> +	$oid refs/heads/ns-yes
> +	EOF
> +	>expected_commits &&
> +
> +	oid=$(git -C "$REPO" rev-parse c) &&
> +	test-tool pkt-line pack >in <<-EOF &&
> +	$(write_command fetch)
> +	0001
> +	no-progress
> +	want-ref refs/heads/ns-yes
> +	have $oid
> +	done
> +	0000
> +	EOF
> +
> +	GIT_NAMESPACE=ns && export GIT_NAMESPACE &&
> +	test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
> +	check_output
> +'

Unless you mean to make all subsequent tests to be done inside the
'ns' namespace, and even when you do, you do not want to do this
in order to keep each test as independent as possible (iow, make
some of them skippable without affecting the later tests).  Run the
final test in a subshell, e.g.

	oid=$(git -C "$REPO" rev-parse c) &&
	test-tool pkt-line pack >in <<-EOF &&
	...
	EOF

	(
        	export GIT_NAMESPACE=ns &&
		test-tool ... >out <in
	) &&
	check_output

or if the command you want to run with a custom environment variable
is a single external executable like this case, do

	oid=$(git -C "$REPO" rev-parse c) &&
	test-tool pkt-line pack >in <<-EOF &&
	...
	EOF
	GIT_NAMESPACE=ns test-tool ... >out <in &&
	check_output

That way, the environment will be kept clean without GIT_NAMESPACE
outside the invocation of test-tool.

Note that you cannot use this technique directly with test_must_fail
which is *not* an external executable but is a shell function.

	test_must_fail env GIT_NAMESPACE=ns test-tool ...

would be the way to write a step that must fail.

> diff --git a/upload-pack.c b/upload-pack.c
> index 297b76fcb4..008ac75125 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1417,21 +1417,24 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
>  			  struct string_list *wanted_refs,
>  			  struct object_array *want_obj)
>  {
> -	const char *arg;
> +	const char *refname_nons;
>  	if (skip_prefix(line, "want-ref ", &arg)) {

Don't you receive the result in refname_nons here, as arg is no
longer there?

>  		struct object_id oid;
>  		struct string_list_item *item;
>  		struct object *o;
> +		struct strbuf refname = STRBUF_INIT;
>
> -		if (read_ref(arg, &oid)) {
> -			packet_writer_error(writer, "unknown ref %s", arg);
> -			die("unknown ref %s", arg);
> +		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
> +		if (ref_is_hidden(refname_nons, refname.buf) ||
> +		    read_ref(refname.buf, &oid)) {
> +			packet_writer_error(writer, "unknown ref %s", refname_nons);
> +			die("unknown ref %s", refname.buf);
>  		}

OK.  Assuming that it makes sense for the hideRefs mechanism to kick
in here (which I would prefer to hear from others who've worked with
this code, say Jonathan Tan?), the updated code makes sense.

Thanks.


> -		item = string_list_append(wanted_refs, arg);
> +		item = string_list_append(wanted_refs, refname_nons);
>  		item->util = oiddup(&oid);
>
> -		o = parse_object_or_die(&oid, arg);
> +		o = parse_object_or_die(&oid, refname);
>  		if (!(o->flags & WANTED)) {
>  			o->flags |= WANTED;
>  			add_object_array(o, NULL, want_obj);
> --
> 2.32.0
