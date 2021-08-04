Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EF4C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2712C60F38
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhHDVQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 17:16:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64135 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHDVQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 17:16:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F0A2713813D;
        Wed,  4 Aug 2021 17:16:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fhW1W6TifFglJ3QDsr1sn1UGAF0tSGtWPHBaWL
        qFzeo=; b=KDsT3bS+ySIoJfhl3/ylB9Wqb1GG8b/yC6rjHRGab3J61J/rRwo/7c
        3NvLVRcMIDjxNv7L1nekNGKNpr2WTyq3vg4uXaLfazqNVgFCWknevZnNyHI7+XJA
        91Bz227UNiO+GEOcUTL3VwGuuctKZ8m+2B00Rt+y0kN7ZZ0VxJDGM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E930613813B;
        Wed,  4 Aug 2021 17:16:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 314EF138138;
        Wed,  4 Aug 2021 17:16:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v3] upload-pack.c: treat want-ref relative to namespace
References: <20210730135845.633234-1-kim@eagain.st>
        <20210731203415.618641-1-kim@eagain.st>
        <20210804203829.661565-1-kim@eagain.st>
Date:   Wed, 04 Aug 2021 14:15:58 -0700
In-Reply-To: <20210804203829.661565-1-kim@eagain.st> (Kim Altintop's message
        of "Wed, 04 Aug 2021 20:42:42 +0000")
Message-ID: <xmqq35rooqr5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2ABAA402-F569-11EB-8B86-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kim Altintop <kim@eagain.st> writes:

> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index e9e471621d..4a828042bb 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -298,6 +298,134 @@ test_expect_success 'fetching with wildcard that matches multiple refs' '
>  	grep "want-ref refs/heads/o/bar" log
>  '
>
> +REPO="$(pwd)/repo-ns"
> +
> +write_fetch_want_ref() {

Style; missing SP before ().

> +	local wanted_ref="$1"
> +
> +	write_command fetch
> +	echo "0001"
> +	echo "no-progress"
> +	echo "want-ref $1"
> +	echo "done"
> +	echo "0000"
> +}

All other helper shell functions in this file are defined near the
top.  If we compare them with this, we notice that this does not
check for any errors.  We should string these steps together with
"&&".

Also, having this in the middle looks a bit out of place.  If this
helper is useful only in the tests that are being added by this
patch, that may be OK, but we may want to have a preliminary
clean-up step before the main patch that adds this helper function
near the top (perhaps after "write_command" is defined), and use it
in existing tests.  It seems that 'invalid want-ref line', 'basic
want-ref', and 'multiple want-ref lines' tests among others may
benefit from a slightly expanded variant, something along the lines
of ...

    write_fetch_command () {
	write_command fetch &&
	echo "0001" &&
	echo "no-progress" || return
        # want-ref ...
	# --
	# want ...
	# --
	# have ...
	# --
        while :
	do
		case $# in 0) break ;; esac &&
		case "$1" in --) shift; break ;; esac &&
		echo "want-ref $1" &&
		shift || return
	done &&
        while :
	do
		case $# in 0) break ;; esac &&
		case "$1" in --) shift; break ;; esac &&
		echo "want $1" &&
		shift || return
	done &&
        while :
	do
		case $# in 0) break ;; esac &&
		case "$1" in --) shift; break ;; esac &&
		echo "have $1" &&
		shift || return
	done &&
	echo "done" &&
	echo "0000"
    }

and with something like that, an existing test like this one:

test_expect_success 'mix want and want-ref' '
	oid=$(git rev-parse f) &&
	cat >expected_refs <<-EOF &&
	$oid refs/heads/main
	EOF
	git rev-parse e f >expected_commits &&

	test-tool pkt-line pack >in <<-EOF &&
	$(write_command fetch)
	0001
	no-progress
	want-ref refs/heads/main
	want $(git rev-parse e)
	have $(git rev-parse a)
	done
	0000
	EOF

	test-tool serve-v2 --stateless-rpc >out <in &&
	check_output
'

may become

test_expect_success 'mix want and want-ref' '
	oid=$(git rev-parse f) &&
	cat >expected_refs <<-EOF &&
	$oid refs/heads/main
	EOF
	git rev-parse e f >expected_commits &&

	test-tool pkt-line pack >in <<-EOF &&
	$(write_fetch_command
		refs/heads/main
		--
		$(git rev-parse e)
		--
		$(git rev-parse a)
	)
	EOF

	test-tool serve-v2 --stateless-rpc >out <in &&
	check_output
'

And after preparing a reusable helper like that, we can add
namespace tests using the same helper in the main patch (so it would
become an at least 2-patch series).

> +
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
> +	git -C "$REPO" config uploadpack.allowRefInWant true

I do not see a reason why the last step wants to be done outside the
subshell, which we would be using anyway.  Does it clarify something?

> +test_expect_success 'with namespace: want-ref is considered relative to namespace' '
> +	wanted_ref=refs/heads/ns-yes &&
> +
> +	oid=$(git -C "$REPO" rev-parse $wanted_ref) &&
> +	cat >expected_refs <<-EOF &&
> +	$oid $wanted_ref
> +	EOF
> +	git -C "$REPO" rev-parse a $wanted_ref >expected_commits &&
> +
> +	test-tool pkt-line pack >in <<-EOF &&
> +	$(write_fetch_want_ref $wanted_ref)
> +	EOF
> +
> +	env GIT_NAMESPACE=ns test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&

I am not sure why we want "env" in front (it does not hurt, but it
should be unnecessary, as test-tool is a plain-vanilla binary
executable, not a shell function).  Is this a workaround for a buggy
test linter or something?

> +	check_output
> +'
> +
> +test_expect_success 'with namespace: want-ref outside namespace is unknown' '
> +	wanted_ref=refs/heads/ns-no &&
> +
> +	test-tool pkt-line pack >in <<-EOF &&
> +	$(write_fetch_want_ref $wanted_ref)
> +	EOF
> +
> +	test_must_fail env GIT_NAMESPACE=ns \
> +		test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&

Note that this one does need "env" here.

> diff --git a/upload-pack.c b/upload-pack.c
> index 297b76fcb4..6ce07231d3 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1417,21 +1417,25 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
>  			  struct string_list *wanted_refs,
>  			  struct object_array *want_obj)
>  {
> -	const char *arg;
> -	if (skip_prefix(line, "want-ref ", &arg)) {
> +	const char *refname_nons;
> +	if (skip_prefix(line, "want-ref ", &refname_nons)) {
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
> +			die("unknown ref %s", refname_nons);

Looks good.

>  		}
> +		strbuf_release(&refname);
>
> -		item = string_list_append(wanted_refs, arg);
> +		item = string_list_append(wanted_refs, refname_nons);
>  		item->util = oiddup(&oid);
>
> -		o = parse_object_or_die(&oid, arg);
> +		o = parse_object_or_die(&oid, refname_nons);
>  		if (!(o->flags & WANTED)) {
>  			o->flags |= WANTED;
>  			add_object_array(o, NULL, want_obj);
> --
> 2.32.0
