Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D189BC0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 22:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjGMWvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjGMWvB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 18:51:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B72D45
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 15:50:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 975D91EA89;
        Thu, 13 Jul 2023 18:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KkgWNDU+VuC5VDAjIzgavBS44UqYksMC+t0PBm
        KADE4=; b=lSyAwum8KmenB1WpESE+lofsKo0s9oLO/mblBh3NlWmtuP6fg5lOMj
        kk5lZA008cT6Y5ye86CqHTfzn7RdZxqwgqQ0M9cenZxAe/rU3JyiSYecqqBoaU5c
        WDZSp+RQylLGKq28Plfb82L333pHYeup+NmwG9x+pvYk0Zf/gzOx0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FB001EA88;
        Thu, 13 Jul 2023 18:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 117FA1EA80;
        Thu, 13 Jul 2023 18:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 2/4] t4216: test changed path filters with high bit
 paths
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1689283789.git.jonathantanmy@google.com>
        <94a4c7af38525d04f3effc035084e661fe382dcd.1689283789.git.jonathantanmy@google.com>
Date:   Thu, 13 Jul 2023 15:50:53 -0700
In-Reply-To: <94a4c7af38525d04f3effc035084e661fe382dcd.1689283789.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 13 Jul 2023 14:42:09 -0700")
Message-ID: <xmqq4jm7l92q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B99986EA-21CF-11EE-B4B5-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Subsequent commits will teach Git another version of changed path
> filter that has different behavior with paths that contain at least
> one character with its high bit set, so test the existing behavior as
> a baseline.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t4216-log-bloom.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index fa9d32facf..0cf208fdf5 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -404,4 +404,51 @@ test_expect_success 'Bloom generation backfills empty commits' '
>  	)
>  '
>  
> +get_bdat_offset () {
> +	perl -0777 -ne \
> +		'print unpack("N", "$1") if /BDAT\0\0\0\0(....)/ or exit 1' \
> +		.git/objects/info/commit-graph
> +}

Hopefully the 8-byte anchoring pattern is unique enough at least for
the purpose of this test script.
