Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69351C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352311AbiCXTBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343982AbiCXTBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 15:01:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2776C56437
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:59:37 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CD3E1047D1;
        Thu, 24 Mar 2022 14:59:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E6XzySJOvPrFsioqKOuPthsPf05nATixBKBuME
        Rgq5U=; b=ppLbbPnTaWqze7pTVhL9W0AonSSxmF41TZ+eEwi8iq3+He/3cFRrJ9
        830ACe61L3u+uAB+DgZEv7Ns18DeRtbIrI1hHXE2SjvbJmyVGFMr+KRMdVIKhrn+
        YVgzf6NZ7EGfUCQ8wmadkLdBRc896FUpPWIYUzaQzGx8OIF1z2CdU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71C441047D0;
        Thu, 24 Mar 2022 14:59:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8FE41047CF;
        Thu, 24 Mar 2022 14:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8 21/30] t7527: create test for fsmonitor--daemon
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <c8709da9457eb303132b5cad6a204a1de27aabc0.1648140586.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 11:59:34 -0700
In-Reply-To: <c8709da9457eb303132b5cad6a204a1de27aabc0.1648140586.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Thu, 24 Mar 2022
        16:49:37 +0000")
Message-ID: <xmqqils3gort.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C4C0F70-ABA4-11EC-8686-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

I hadn't signed off on this one yet ;-)

> +is_value () {
> +	test -n "$1" && test "${1::1}" != "-"
> +}

${var:ofs:len} is a bash-ism.  If you run this test under /bin/dash
instead of /bin/dash, you'll likely see it fail.

If it were a good idea to see if $1 begins with a dash, a more
natural (to shell programmers) way to do so is

	case "$1" in -*) false ;; ?*) true ;; *) false ;; esac

but given how this is used below, we do not want to special case
dash.  

There isn't anything wrong in "mkdir ./-foo && start_daemon -C -foo"
in other words.

> +start_daemon () {
> +	r= &&
> +	tf= &&
> +	t2= &&
> +	tk= &&

FYI, you can write these on a single line, i.e.

	r= tf= t2= tk= &&

Spending lines and spaces for the meat of the script would enhance
readability but for things like a boilerplate "we clear variables
before using them", being concise may be less distracting.

> +	while test "$#" -ne 0
> +	do
> +		case "$1" in
> +		-C)
> +			shift;
> +			is_value $1 || BUG "error: -C requires value"
> +			r="-C $1"
> +			shift
> +			;;
> +	...
> +		esac
> +	done &&

A more natural way to write these loops is

	while ...
	do
		case "$1" in
		-C)
			r="-C ${2?}"
			shift
			;;
		... all other options you handle ...
		-*)
			echo >&2 "unknown option $1"
			exit 1
			;;
		*)
			break
			;;
		esac
		shift
	done

i.e. shifting out what we just saw is the default and happens
immediately after the case/esac, and extra shift after consuming
an option parameter happens in each case arm.

An acceptable slight variation is

		-C)
			shift
			r="-C ${1?}"
			;;

but the first form is more logical and clear, i.e. "when we see '-C',
we want two on the command line, -C itself and the parameter it takes"
is conveyed more strongly with "${2?}" there.

For an additional bonus, we could also accept the stuck form, i.e.

		case "$1" in
		-C)
			r="-C ${2?}"
			shift
			;;
		-C*)
			r="-C {$1#-C}"
			;;
		...
