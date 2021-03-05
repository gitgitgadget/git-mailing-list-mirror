Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7538C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 18:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7787E6509A
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 18:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCESvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 13:51:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52054 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhCESu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 13:50:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C9BC121042;
        Fri,  5 Mar 2021 13:50:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xMdVs3OdqQ12Tqzjyh26Qw3FFVQ=; b=d1R05c
        e+bFw8J3fwKJaLGxZszCn3+PpbyLSXsJ9SmOS03F/FEUui6NQukl1qEY57uidY//
        H7W8dPO3BKfeBAQN3YkwFZSvtDipm9HLQzoEtUMfTazMKjKTOgTd20ae8zXGnzTM
        5g2d9KbOMELCm/82z4JKzs8SFSRDnRMytTswM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BxPJUQ9sVHYUsbMS66Qxx17loekyZO+Q
        IJ5IJneLOe9L4NsbbqgSWeJKagY57Q+CvQndmbiF88JXynbU/21+/LAq/EyNS0Q2
        cTvhGrsKo9F62NTxg10UQt92NeMbMPaNF95kptJ9Q3ufFtmY2CVxb6LGZlHqjWLS
        s7ajTa0dDak=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73AF2121041;
        Fri,  5 Mar 2021 13:50:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B9BE4121040;
        Fri,  5 Mar 2021 13:50:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <YEF5BfE6eXmhhiAf@google.com>
        <20210305011621.599649-1-jonathantanmy@google.com>
Date:   Fri, 05 Mar 2021 10:50:54 -0800
In-Reply-To: <20210305011621.599649-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 4 Mar 2021 17:16:20 -0800")
Message-ID: <xmqqzgzha0z5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7B00B20-7DE3-11EB-AD0E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When fetching (as opposed to cloning) from a repository with packfile
> URIs enabled, an error like this may occur:
>
>  fatal: pack has bad object at offset 12: unknown object type 5
>  fatal: finish_http_pack_request gave result -1
>  fatal: fetch-pack: expected keep then TAB at start of http-fetch output
>
> This bug was introduced in b664e9ffa1 ("fetch-pack: with packfile URIs,
> use index-pack arg", 2021-02-22), when the index-pack args used when
> processing the inline packfile of a fetch response and when processing
> packfile URIs were unified.

> This bug happens because fetch, by default, partially reads (and
> consumes) the header of the inline packfile to determine if it should
> store the downloaded objects as a packfile or loose objects, and thus
> passes --pack_header=<...> to index-pack to inform it that some bytes
> are missing. 

... and what the values in them are.

> However, when it subsequently fetches the additional
> packfiles linked by URIs, it reuses the same index-pack arguments, thus
> wrongly passing --index-pack-arg=--pack_header=<...> when no bytes are
> missing.
>
> This does not happen when cloning because "git clone" always passes
> do_keep, which instructs the fetch mechanism to always retain the
> packfile, eliminating the need to read the header.
>
> There are a few ways to fix this, including filtering out pack_header
> arguments when downloading the additional packfiles, but ...

Avoiding the condition that exhibits the breakage is possible, and I
think it is what is done here, but I actually think that the only
right fix is to pass correct argument to commands we invoke in the
first place.  Why are we reusing the same argument array to begin
with?

    ... goes back and reads the offending commit ...

commit b664e9ffa153189dae9b88f32d1c5fedcf85056a
Author: Jonathan Tan <jonathantanmy@google.com>
Date:   Mon Feb 22 11:20:08 2021 -0800

    fetch-pack: with packfile URIs, use index-pack arg
    
    Unify the index-pack arguments used when processing the inline pack and
    when downloading packfiles referenced by URIs. This is done by teaching
    get_pack() to also store the index-pack arguments whenever at least one
    packfile URI is given, and then when processing the packfile URI(s),
    using the stored arguments.

THis makes it sound like the entire idea of this offending commit
was wrong, and before it, the codepath that processed the packfile
fetched from the packfile URI were using the index-pack correctly
by using index-pack arguments that are independent from the one that
is used to process the packfile given in-stream.  Why isn't the fix
just a straight revert of the commit???

> This is on jt/transfer-fsck-across-packs.

Ouch.  This definitely is an -rc material.


> -	if (!args->keep_pack && unpack_limit) {
> +	if (!args->keep_pack && unpack_limit && !index_pack_args) {

This one makes sense as an "avoid conditions that reveals how badly
the code is broken" band-aid.  When we have index-pack related
arguments, we cannot use the unpack-objects codepath even if we are
being fed a tiny pack, so there is no point peeking at the beginning
of the pack stream to find out how many objects it has.  OK.

> @@ -885,7 +885,7 @@ static int get_pack(struct fetch_pack_args *args,
>  			strvec_push(&cmd.args, "-v");
>  		if (args->use_thin_pack)
>  			strvec_push(&cmd.args, "--fix-thin");
> -		if (do_keep && (args->lock_pack || unpack_limit)) {
> +		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit)) {
>  			char hostname[HOST_NAME_MAX + 1];
>  			if (xgethostname(hostname, sizeof(hostname)))
>  				xsnprintf(hostname, sizeof(hostname), "localhost");

I do not quite get what this hunk is doing.  Care to explain?

Thanks.

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index b1bc73a9a9..9df1ec82ca 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -853,6 +853,27 @@ test_expect_success 'part of packfile response provided as URI' '
>  	test_line_count = 6 filelist
>  '
>  
> +test_expect_success 'packfile URIs with fetch instead of clone' '
> +	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +	rm -rf "$P" http_child log &&
> +
> +	git init "$P" &&
> +	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> +
> +	echo my-blob >"$P/my-blob" &&
> +	git -C "$P" add my-blob &&
> +	git -C "$P" commit -m x &&
> +
> +	configure_exclusion "$P" my-blob >h &&
> +
> +	git init http_child &&
> +
> +	GIT_TEST_SIDEBAND_ALL=1 \
> +	git -C http_child -c protocol.version=2 \
> +		-c fetch.uriprotocols=http,https \
> +		fetch "$HTTPD_URL/smart/http_parent"
> +'
> +
>  test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
>  	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
>  	rm -rf "$P" http_child log &&
