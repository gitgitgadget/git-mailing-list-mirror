Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A26C4332B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BBE864E98
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhCQTbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:31:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56061 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhCQTbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:31:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C680A422C;
        Wed, 17 Mar 2021 15:31:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=alZvNu4iBzJbkCfwWG7IomcIB0E=; b=Kil2jW
        zXz75KU3oRVcCvFq5z6k4IdLY1Cejqs0SrrX1fajWhfIMt88/UAz9wTIy7D2LVPT
        iUC2qMw6vgImztDnE/ughI6YHC8Yr+hTi4ZrEpl59vrNjhVmmabPepGXzGugywT9
        0hSPbbmBsDaMqz5mxvarJEsAZWl3tDwghsQhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OP8b/KSNppbd6PT3Qt+pHY0VXfcMAFHr
        eTSdJhah5M9R3fZGpQmjblRvwbrkJqi1COde7eacr5S/yZS9z426fnkFlXTkqbfy
        1A/sw0rEgAXbQTYdY5HfCbRNKjaaTXaZvDNRhBGPyGN6JJtUtAfNVEImOzpLUsEo
        hXmKlZpEODs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1486AA422B;
        Wed, 17 Mar 2021 15:31:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A5E4A4229;
        Wed, 17 Mar 2021 15:31:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Albert Cui via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertqcui@gmail.com>
Subject: Re: [PATCH] fetch: show progress for packfile uri downloads
References: <pull.907.git.1616007794513.gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 12:31:07 -0700
In-Reply-To: <pull.907.git.1616007794513.gitgitgadget@gmail.com> (Albert Cui
        via GitGitGadget's message of "Wed, 17 Mar 2021 19:03:13 +0000")
Message-ID: <xmqqsg4ttw5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52CA419E-8757-11EB-9911-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
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
> instead of fetch-pack, the caller.

... "hence we do not do so in this patch"?  

That's probably a very sensible way to go.

I expect that http-fetch will in the longer term become a mere
fallback default used by those who do not have anything better.
Because we are not in the business of writing a performant HTTP
downloader, we would be better off if we make it easy to plug an
external HTTP downloader other people write in to this codepath.

> +	packfile_uri_progress = start_progress(_("Downloading packs"), packfile_uris.nr);

OK, so we plan to count from 0 up to .nr; and the message is made
localizable.  Good.

> @@ -1696,6 +1700,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		const char *uri = packfile_uris.items[i].string +
>  			the_hash_algo->hexsz + 1;
>  
> +		display_progress(packfile_uri_progress, i+1);

		display_progress(packfile_uri_progress, i + 1);

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 2e1243ca40b0..8964a4003678 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -851,7 +851,8 @@ test_expect_success 'part of packfile response provided as URI' '
>  	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
>  	git -c protocol.version=2 \
>  		-c fetch.uriprotocols=http,https \
> -		clone "$HTTPD_URL/smart/http_parent" http_child &&
> +		clone "$HTTPD_URL/smart/http_parent" http_child \
> +		--progress 2>progress &&

Some existing tests use GIT_PROGRESS_DELAY to protect against an
operation that is too quick to complete.  Don't we need to do the
same?  If not, then perhaps we need to allow delaying the progress
meter we add with this patch for "too quick" case, perhaps?

>  	# Ensure that my-blob and other-blob are in separate packfiles.
>  	for idx in http_child/.git/objects/pack/*.idx
> @@ -875,6 +876,8 @@ test_expect_success 'part of packfile response provided as URI' '
>  	test -f hfound &&
>  	test -f h2found &&
>  
> +	test_i18ngrep "Downloading packs" progress &&

Also, I am not sure with all the terminal control junk, 'grep'
should be expected to reliably pick this substring in the output.
Are we expecting any other output to the standard error stream?
Some tests in t5318 seem to just see if the output is non-empty, and
I am wondering if that is an approach more appropriate here (not
rhetorical---I simply do not know the answer).

>  	# Ensure that there are exactly 3 packfiles with associated .idx
>  	ls http_child/.git/objects/pack/*.pack \
>  	    http_child/.git/objects/pack/*.idx >filelist &&
>
> base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
