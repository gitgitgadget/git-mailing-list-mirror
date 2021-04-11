Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECE8C43460
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 01:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F87A610C8
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 01:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhDKBbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 21:31:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58671 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhDKBbP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 21:31:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0D99121512;
        Sat, 10 Apr 2021 21:30:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k/FOO6+ekOsCpvBr/IuTiXDE8tk=; b=kqeHYG
        p6ShDU53nSAcQZAUSICsKfa8wXhDKcOHsHwOQIKwIliPMXuF2yZ83FrDqFTp2DVH
        lmJeBQop3n839Zn20Owv8vueLOOV224UwwPQcKi/6CdjiBOK5ehhOpm8UFiGo1y9
        HURY9jJf4/rEF2NT9iFEFwLtAQxHnGnrrshoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RsiDa77sN7uQjgSK6L8dgvkSFMSlrMJh
        sirkaHQevB9i7YPRfsmGxDDtfrUQAHoEgQWHYRdZmeHu5rgHHIx3Vj1uPCQoJMkM
        N/SMWReoFI9JDBasqjRHVFUvF7ITRjT9NL8/W/MrQukCYgpFT923vB4V63IvzNed
        Qbiq4quS/JY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E97DA121510;
        Sat, 10 Apr 2021 21:30:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3552B12150C;
        Sat, 10 Apr 2021 21:30:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Albert Cui via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Albert Cui <albertqcui@gmail.com>
Subject: Re: [PATCH v2] fetch: show progress for packfile uri downloads
References: <pull.907.git.1616007794513.gitgitgadget@gmail.com>
        <pull.907.v2.git.1618008249632.gitgitgadget@gmail.com>
Date:   Sat, 10 Apr 2021 18:30:54 -0700
In-Reply-To: <pull.907.v2.git.1618008249632.gitgitgadget@gmail.com> (Albert
        Cui via GitGitGadget's message of "Fri, 09 Apr 2021 22:44:09 +0000")
Message-ID: <xmqqy2dpip4h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 908AECF6-9A65-11EB-9794-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Albert Cui via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Albert Cui <albertqcui@gmail.com>
>
> Git appears to hang when downloading packfiles as this part of the
> fetch is silent, causing user confusion. This change implements
> progress for the number of packfiles downloaded; a progress display
> for bytes would involve deeper changes at the http-fetch layer
> instead of fetch-pack, the caller, so we do not do that in this
> patch.

... meaning, hopefully later we'd hook into transport->progress and
implement the byte-level progress display down there?  And when that
happens, we'd remove this file-level progress as it would be too
confusing to have both at the same time?

Is this start_progress() call a way to unconditionally enable the
progress display?  How does it interact with transport->progress
that is driven by transport_set_verbosity(), which in turn is called
by builtin/fetch.c and friends?  If it doesn't, shouldn't this
codepath pay attention to the transport->progress and enable the
progress meter only when it is enabled (i.e. the stderr going to a
terminal, or --progress explicitly being asked)?

> @@ -1585,6 +1586,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	struct fetch_negotiator *negotiator;
>  	int seen_ack = 0;
>  	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
> +	struct progress *packfile_uri_progress;
>  	int i;
>  	struct strvec index_pack_args = STRVEC_INIT;
>  	struct oidset gitmodules_oids = OIDSET_INIT;
> @@ -1689,6 +1691,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		}
>  	}
>  
> +	packfile_uri_progress = start_progress(_("Downloading packs"), packfile_uris.nr);
> +
>  	for (i = 0; i < packfile_uris.nr; i++) {
>  		int j;
>  		struct child_process cmd = CHILD_PROCESS_INIT;
> @@ -1696,6 +1700,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		const char *uri = packfile_uris.items[i].string +
>  			the_hash_algo->hexsz + 1;
>  
> +		display_progress(packfile_uri_progress, i + 1);
>  		strvec_push(&cmd.args, "http-fetch");
>  		strvec_pushf(&cmd.args, "--packfile=%.*s",
>  			     (int) the_hash_algo->hexsz,
> @@ -1739,6 +1744,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  						 get_object_directory(),
>  						 packname));
>  	}
> +
> +	stop_progress(&packfile_uri_progress);
> +
>  	string_list_clear(&packfile_uris, 0);
>  	strvec_clear(&index_pack_args);
>  
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 2e1243ca40b0..0476b3f50455 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -848,10 +848,12 @@ test_expect_success 'part of packfile response provided as URI' '
>  	configure_exclusion "$P" my-blob >h &&
>  	configure_exclusion "$P" other-blob >h2 &&
>  
> -	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
> +	GIT_PROGRESS_DELAY=0 GIT_TRACE=1 GIT_TRACE2_EVENT=1 \
> +	GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
>  	git -c protocol.version=2 \
>  		-c fetch.uriprotocols=http,https \
> -		clone "$HTTPD_URL/smart/http_parent" http_child &&
> +		clone "$HTTPD_URL/smart/http_parent" http_child \
> +		--progress 2>progress &&
>  
>  	# Ensure that my-blob and other-blob are in separate packfiles.
>  	for idx in http_child/.git/objects/pack/*.idx
> @@ -875,6 +877,8 @@ test_expect_success 'part of packfile response provided as URI' '
>  	test -f hfound &&
>  	test -f h2found &&
>  
> +	test_i18ngrep "Downloading packs" progress &&
> +
>  	# Ensure that there are exactly 3 packfiles with associated .idx
>  	ls http_child/.git/objects/pack/*.pack \
>  	    http_child/.git/objects/pack/*.idx >filelist &&
>
> base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
