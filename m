Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE409C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 19:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A322C206C0
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 19:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ml7tfFoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHNT73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:59:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64797 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgHNT73 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 15:59:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B59CBE9C8D;
        Fri, 14 Aug 2020 15:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nMsmqbdT6WnKGnYJS9T6RDXsXKU=; b=ml7tfF
        ocqPbY2nVbta2dos4Hg4r/P9+9Thv5CG2oUXS+T8LSRPM8xyi+d/s4P8aFwv4cDJ
        O19y2sIvNv7gSHM4FgsQMHULtRwsgggTDag16xq24UvjIFzgJcIdnL7a1oH4vFP9
        ppM0qj3035PulRtYZ1Lpt5Tfk/i8ALvrcH+Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fkrz6s7mZpsYmb/BNJ2sWVyxZIG24NSU
        T4jUdPGAl9Dnqb9NzKW14vJuWA0TTBpgOP229dgqoV+Du0aAia6NwrXTfmi8Fye5
        bKHHF5OMZsNl9Y1ylRQeYiDiIEkWE2tYLay/6QpACPgblmLtfLB+zR0/RXeXXm4G
        gVez5sDlWXA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADA39E9C8C;
        Fri, 14 Aug 2020 15:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DEA00E9C8A;
        Fri, 14 Aug 2020 15:59:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: make packfile URIs work with transfer.fsckobjects
References: <20200814193234.3072139-1-jonathantanmy@google.com>
Date:   Fri, 14 Aug 2020 12:59:20 -0700
In-Reply-To: <20200814193234.3072139-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 14 Aug 2020 12:32:34 -0700")
Message-ID: <xmqq8sehvw13.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A549C09A-DE68-11EA-BEDD-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When fetching with packfile URIs and transfer.fsckobjects=1, use the
> --fsck-objects instead of the --strict flag when invoking index-pack so
> that links are not checked, only objects. This is because incomplete
> links are expected. (A subsequent connectivity check will be done when
> all the packs have been downloaded regardless of whether
> transfer.fsckobjects is set.)

Good reasoning.  The change looks surprisingly small, thanks to the
existing need already.

I realize that the code's quality (from readability and
discoverability's point of view) has deteriorated in this area quite
a lot over the past few years, though.  The "from_promisor" field is
set when fetch-pack is run with the corresponding command line
option, but the option is documented nowhere, so it is not
immediately obvious why the new need can be fulfilled by just
piggybacking on the existing codepath.  The meaning of the
only_packfile parameter get_pack() takes is never explained
anywhere, either.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 7f20eca4f8..66631d0034 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -892,7 +892,7 @@ static int get_pack(struct fetch_pack_args *args,
>  	    : transfer_fsck_objects >= 0
>  	    ? transfer_fsck_objects
>  	    : 0) {
> -		if (args->from_promisor)
> +		if (args->from_promisor || !only_packfile)
>  			/*
>  			 * We cannot use --strict in index-pack because it
>  			 * checks both broken objects and links, but we only

I think this is a good way to work around the "we do not have full
set of objects until we grab out-of-line packfiles, but we process
the in-protocol packdata before we grab them, so we cannot validate
yet" problem.  My guess is that "only_packfile" means "after reading
this packfile, the repository should be fully complete and we can
afford to check for connectivity", which would be always true for
protocol below v2 that lack the packfile-uri extension (hence the
call to get_pack() in do_fetch_pack() passes hardcoded 1 in this
parameter).  The v2 codepath in do_fetch_pack_v2() calls get_pack()
with true only when there is no packfile-uri, so we loosen the
validation when we know we will further grab one or more packfiles
out of line.

> +test_expect_success 'packfile-uri with transfer.fsckobjects' '
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
> +	sane_unset GIT_TEST_SIDEBAND_ALL &&
> +	git -c protocol.version=2 -c transfer.fsckobjects=1 \
> +		-c fetch.uriprotocols=http,https \
> +		clone "$HTTPD_URL/smart/http_parent" http_child &&
> +
> +	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
> +	ls http_child/.git/objects/pack/* >filelist &&

Subtle but correct.

> +	test_line_count = 4 filelist
> +'
> +
> +test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
> +	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +	rm -rf "$P" http_child log &&
> +
> +	git init "$P" &&
> +	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> +
> +	cat >bogus-commit <<EOF &&
> +tree $EMPTY_TREE
> +author Bugs Bunny 1234567890 +0000
> +committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
> +
> +This commit object intentionally broken
> +EOF

Use <<-EOF for readablity, please.

> +	BOGUS=$(git -C "$P" hash-object -t commit -w --stdin <bogus-commit) &&
> +	git -C "$P" branch bogus-branch "$BOGUS" &&
> +
> +	echo my-blob >"$P/my-blob" &&
> +	git -C "$P" add my-blob &&
> +	git -C "$P" commit -m x &&
> +
> +	configure_exclusion "$P" my-blob >h &&
> +
> +	sane_unset GIT_TEST_SIDEBAND_ALL &&
> +	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
> +		-c fetch.uriprotocols=http,https \
> +		clone "$HTTPD_URL/smart/http_parent" http_child 2>error &&
> +	test_i18ngrep "invalid author/committer line - missing email" error
> +'
> +
>  # DO NOT add non-httpd-specific tests here, because the last part of this
>  # test script is only executed when httpd is available and enabled.
