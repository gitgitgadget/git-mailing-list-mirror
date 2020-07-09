Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD8C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 17:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E0620767
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 17:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HG8XCXym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGIR1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:27:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52444 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGIR1y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 13:27:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A9FC60478;
        Thu,  9 Jul 2020 13:27:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MEk0i6C2wD6k
        fqSVgI9HI7LxxGQ=; b=HG8XCXym1/vUYsC27IMJCZct0bfIFxfLA75Kt1nsN6Z3
        V1WKUTkCz/9L/yRFWytZTW28p6coSTo83K+1mFxd/8vjldXs4eSaAXAyoaJuZ1GX
        0FZ2hCDEyocCbn1kHIwQUN3xMzDfI0bAP2Un8KcUiZyyvIoxz0wDN7bDvN1Wq7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cZiKr/
        cYAt7d6UP5zHrBq5k13BbseJFCYDWqtGcZ2t3torGKz4grLOcBeF35sh++6Zt4vV
        zWiiWKx8Yv8TzTI2IwSIN+1Au5kNFznadWCGD2UlWt4G9y1yZRCts2PvAfbz3g7B
        wxQvDpn/UY3kH0vTU2ekoJdVMD6TJyYxCZ5BA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 318D560477;
        Thu,  9 Jul 2020 13:27:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9800460476;
        Thu,  9 Jul 2020 13:27:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, dstolee@microsoft.com,
        peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: fix progress of reachable commits
References: <20200709165432.2688-1-szeder.dev@gmail.com>
Date:   Thu, 09 Jul 2020 10:27:50 -0700
In-Reply-To: <20200709165432.2688-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 9 Jul 2020 18:54:32 +0200")
Message-ID: <xmqq5zawy4x5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8430C2BC-C209-11EA-9C9A-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> To display a progress line while iterating over all refs,
> d335ce8f24 (commit-graph.c: show progress of finding reachable
> commits, 2020-05-13) should have added a pair of
> start_delayed_progress() and stop_progress() calls around a
> for_each_ref() invocation.  Alas, the stop_progress() call ended up at
> the wrong place, after write_commit_graph(), which does all the
> commit-graph computation and writing, and has several progress lines
> of its own.  Consequently, that new
>
>   Collecting referenced commits: 123
>
> progress line is overwritten by the first progress line shown by
> write_commit_graph(), and its final "done" line is shown last, after
> everything is finished:
>
>   Expanding reachable commits in commit graph: 344786, done.
>   Computing commit changed paths Bloom filters: 100% (344786/344786), d=
one.
>   Collecting referenced commits: 154, done.
>
> Move that stop_progress() call to the right place.
>
> While at it, drop the unnecessary 'if (data.progress)' condition
> protecting the stop_progress() call, because that function is prepared
> to handle a NULL progress struct.

Nicely explained.  Will apply.  Thanks.

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  commit-graph.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 5df3e08718..aaf3327ede 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1354,12 +1354,13 @@ int write_commit_graph_reachable(struct object_=
directory *odb,
>  			_("Collecting referenced commits"), 0);
> =20
>  	for_each_ref(add_ref_to_set, &data);
> +
> +	stop_progress(&data.progress);
> +
>  	result =3D write_commit_graph(odb, NULL, &commits,
>  				    flags, split_opts);
> =20
>  	oidset_clear(&commits);
> -	if (data.progress)
> -		stop_progress(&data.progress);
>  	return result;
>  }
