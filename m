Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A86A1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 01:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeKMLBo (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 06:01:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63546 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMLBn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 06:01:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1ECA61E85A;
        Mon, 12 Nov 2018 20:06:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h/FmvTSAD45Kb5tnLC8tgd74uUA=; b=Tuvxp/
        rJeQRHW7OTrpyyTjVDYv/oxdPst9T9SioQgNQm1EHrPvI7MhfN4IdmUBEE0ebp5h
        IRn/y+qKcueNAv5pDdDXnamvi/Z+KcSV1gum5NU/RwbrK6Kq8cpvNmCwTalUw7xE
        b/aPsGjAvClU1EnA/7hUPMbhgOQW85ex9UjuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eAiWigGSyKEotJzicbpxqFPh0F5r5sK6
        CPgEx+b2DOe5MK+doVtTtejk7Ojc0t1H6QPXlQEJhWW2eVGeSqw4JJl23J+vLkDU
        fBQ+x4QKGo8+5h7Q7R+K+oAIY2cCI/IUkjSk0BXsNINkLVD4EmltAauNZcD3gVFD
        uYgQZ8RNKcc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 174A81E859;
        Mon, 12 Nov 2018 20:06:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 19A1F1E857;
        Mon, 12 Nov 2018 20:05:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 1/3] eoie: default to not writing EOIE section
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113003911.GB170017@google.com>
Date:   Tue, 13 Nov 2018 10:05:56 +0900
In-Reply-To: <20181113003911.GB170017@google.com> (Jonathan Nieder's message
        of "Mon, 12 Nov 2018 16:39:11 -0800")
Message-ID: <xmqqtvklzszv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4814D6F2-E6E0-11E8-91DD-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Since 3b1d9e04 (eoie: add End of Index Entry (EOIE) extension,
> 2018-10-10) Git defaults to writing the new EOIE section when writing
> out an index file.  Usually that is a good thing because it improves
> threaded performance, but when a Git repository is shared with older
> versions of Git, it produces a confusing warning:
>
>   $ git status
>   ignoring EOIE extension
>   HEAD detached at 371ed0defa
>   nothing to commit, working tree clean
>
> Let's introduce the new index extension more gently.  First we'll roll
> out the new version of Git that understands it, and then once
> sufficiently many users are using such a version, we can flip the
> default to writing it by default.
>
> Introduce a '[index] recordEndOfIndexEntries' configuration variable
> to allow interested users to benefit from this index extension early.

Thanks.  I am in principle OK with this approach.  In fact, I
suspect that the default may want to be dynamically determined, and
we give this knob to let the users further force their preference.
When no extension that benefits from multi-threading is written, the
default can stay "no" in future versions of Git, for example.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 41a9ff2b6a..d702379db4 100644

The timing is a bit unfortunate for any topic to touch this file,
and contrib/cocci would not help us in this case X-<.

> diff --git a/read-cache.c b/read-cache.c
> index f3a848d61c..4bfe93c4c2 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2698,6 +2698,15 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
>  		rollback_lock_file(lockfile);
>  }
>  
> +static int record_eoie(void)
> +{
> +	int val;
> +
> +	if (!git_config_get_bool("index.recordendofindexentries", &val))
> +		return val;
> +	return 0;
> +}

Unconditionally defaulting to no in this round is perfectly fine.
Let's make a mental note that this is the place to decide dynamic
default in the future when we want to.  It would probably have to
ask around various "extension writing" helpers if they want to have
a say in the outcome (e.g. if there are very many cache entries in
the istate, the entry offset table may want to be written and
otherwise not).

> @@ -2945,7 +2954,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  	 * read.  Write it out regardless of the strip_extensions parameter as we need it
>  	 * when loading the shared index.
>  	 */
> -	if (offset) {
> +	if (offset && record_eoie()) {
>  		struct strbuf sb = STRBUF_INIT;
>  
>  		write_eoie_extension(&sb, &eoie_c, offset);
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 2ac47aa0e4..0cbac64e28 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -25,14 +25,17 @@ test_expect_success 'enable split index' '
>  	git update-index --split-index &&
>  	test-tool dump-split-index .git/index >actual &&
>  	indexversion=$(test-tool index-version <.git/index) &&
> +
> +	# NEEDSWORK: Stop hard-coding checksums.

Also let's stop hard-coding the assumption that the new knob is off
by default.  Ideally, you'd want to test both cases, right?

Perhaps you'd call "git update-index --split-index" we see in the
precontext twice, with "-c VAR=false" and "-c VAR=true", to prepare
"actual.without-eoie" and "actual.with-eoie", or something like
that?

Thanks.

>  	if test "$indexversion" = "4"
>  	then
> -		own=3527df833c6c100d3d1d921a9a782d62a8be4b58
> -		base=746f7ab2ed44fb839efdfbffcf399d0b113fb4cb
> +		own=432ef4b63f32193984f339431fd50ca796493569
> +		base=508851a7f0dfa8691e9f69c7f055865389012491
>  	else
> -		own=5e9b60117ece18da410ddecc8b8d43766a0e4204
> -		base=4370042739b31cd17a5c5cd6043a77c9a00df113
> +		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
> +		base=39d890139ee5356c7ef572216cebcd27aa41f9df
>  	fi &&
> +
>  	cat >expect <<-EOF &&
>  	own $own
>  	base $base
