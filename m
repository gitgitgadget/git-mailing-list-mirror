Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEE8C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 20:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1322072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 20:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xGvfXhiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgAJUSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:18:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64937 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgAJUSi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 15:18:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15C99B0A93;
        Fri, 10 Jan 2020 15:18:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a+1L4HKje9qp0KIBet3qnT9Pf90=; b=xGvfXh
        iQt0VY9auOljyTkcQtAB2sZIpHlTbDzw23tDSEb0Fdb/wgBVl2qOLWKUP/WHeN30
        Dy1tVbvYcm6Ky7bV8h1XjOS73tUDhmeBjauFzmEcsT2dkwGCizpfDBJG6cd8QZBg
        Y1qsETV1c0s2PsyclKjsjKxX+7P19Gg8REUMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=etJq2S0jyoCDanyxsiZ9kyKoqVdEUuH8
        8gboDFGG2xIZdYW4ydIjcff02VGKHYyJa/wLctRfG4I81RbggvAHlk36lEUH/jKD
        PrIZtEBl34i6a7QJjki5eA27/pCH8sr6d3/IAnZA+MtND2RuFWD9d+FR3J8IhFne
        pXykWJXqruA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DF7AB0A92;
        Fri, 10 Jan 2020 15:18:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2856AB0A91;
        Fri, 10 Jan 2020 15:18:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: emphasize failure during submodule fetch
References: <20200110195533.6416-1-emilyshaffer@google.com>
Date:   Fri, 10 Jan 2020 12:18:30 -0800
In-Reply-To: <20200110195533.6416-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Fri, 10 Jan 2020 11:55:33 -0800")
Message-ID: <xmqqtv53kquh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FD98658-33E6-11EA-9EC5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> In cases when a submodule fetch fails when there are many submodules, the error
> from the lone failing submodule fetch is buried under activity on the other
> submodules if more than one fetch fell back on fetch-by-oid. Call out a failure
> late so the user is aware that something went wrong.
>
> Example without this change:

>   $ git pull --rebase
>   remote: Counting objects: 1591, done
>   remote: Finding sources: 100% (4317/4317)
>   remote: Total 4317 (delta 1923), reused 4252 (delta 1923)
>   Receiving objects: 100% (4317/4317), 2.09 MiB | 8.15 MiB/s, done.
>   Resolving deltas: 100% (1923/1923), completed with 101 local objects.
>   From https://android.googlesource.com/platform/superproject
>   [snip ~100 lines]
>   From https://android.googlesource.com/platform/prebuilts/fullsdk/platforms/android-29
>    * branch            a97149980b7d8acf48392af591b35689f7205d9e -> FETCH_HEAD
>   From https://android.googlesource.com/platform/prebuilts/fullsdk-darwin/platform-tools
>    * branch            98f9454af8ca210818eff4f502097c471d7327b5 -> FETCH_HEAD
>   From https://android.googlesource.com/platform/prebuilts/checkstyle
>    * branch            6fb3e23f05ed186908ea9f48d6692220891363b0 -> FETCH_HEAD
>    * branch            f21d92f6339f0993a946b25fa2172c2ceb5e332b -> FETCH_HEAD
>   From https://android.googlesource.com/platform/prebuilts/androidx/studio
>    * branch            bed5e7b5866b8698bbcd1879134b03ac312a2ba8 -> FETCH_HEAD
>   From https://android.googlesource.com/platform/prebuilts/androidx/internal
>    * branch                179375220f834de5dfbee169f4c2f948d850a203 -> FETCH_HEAD
>    * branch                1dcf3ceef9a86001c693fa34b3513f0c4af26178 -> FETCH_HEAD
>    * branch                2ea3ccef4c98f5de1b74affd1dda33f5b2834a45 -> FETCH_HEAD
>    * branch                a09de09c3814c3d31cc770d5351b92d29ea624ae -> FETCH_HEAD
>    * branch                d2ae6add8b2c0e28899e4faeb2d6889ceefb0b62 -> FETCH_HEAD
>    * branch                e244e2a5f7d98f47f75d06ef57ef1c6c5701a38d -> FETCH_HEAD
>   Auto packing the repository in background for optimum performance.
>   See "git help gc" for manual housekeeping.
>   From https://android.googlesource.com/platform/prebuilts/androidx/external
>    * branch              c3df2fa7f3e63b8714ac8d24f86a26cc50ee4af5 -> FETCH_HEAD
>   fatal: remote error: want c5bd7796550b3742772c8fb8c73a1311013b5159 not valid
>   From https://android.googlesource.com/platform/external/noto-fonts
>    * branch            02969d3046f6944a5a211d2331d1c82736487f01 -> FETCH_HEAD
>    * branch            9ee45fcd0b8bb8621c1cdbc6de5fe7502eff7393 -> FETCH_HEAD
>   From https://android.googlesource.com/platform/external/dokka
>    * branch            03a8ed966a7b847931a0ee20327f989837aaff13 -> FETCH_HEAD
>    * branch            cb1684602b5b4e18385d890c972764c55d177704 -> FETCH_HEAD
>    * branch            fd4521e89ab0e01447dda9b42be2b9bbc000f02f -> FETCH_HEAD
>   From https://android.googlesource.com/platform/external/doclava
>    * branch            04ddf3962f0cd40c81a2e144f27f497223782457 -> FETCH_HEAD
>    * branch            44bf22680e939b21a21a365f6038d5883d5163c8 -> FETCH_HEAD
>    * branch            66f673f4a3865f3b4ab645655a6484101dbd051f -> FETCH_HEAD
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> As hinted by the snippet in the commit-message (should I remove it? I
> think it's a poignant example, I couldn't see the fatal without grepping
> even after being told it was there) this manifested to an end user via
> 'git pull'.

It indeed is too noisy, especially without showing what happens with
this patch.

Is it clear to the users that a block of lines starting "From $URL"
and ending before the next "From $AnotherURL" is about the same
repository, including error messages?

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b4c6d921d0..0c19781cb9 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1857,6 +1857,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  						    verbosity < 0,
>  						    max_children);
>  		argv_array_clear(&options);
> +		if (result)
> +			fprintf(stderr, _("Failure during submodule fetch.\n"));

How does a user find out which submodule had trouble with after
seeing this message?  Or is it something you still need to find by
scrolling back?

If the latter, I am not sure if there is much point to add a
half-way solution like this.  It is a different story if "fetch"
exits with success status when this happens, but I do not think the
"result" that is non-zero is being lost before the function returns,
so...

>  	}
>  
>  	string_list_clear(&list, 0);
