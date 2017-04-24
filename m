Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9125B207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 17:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1172810AbdDXR02 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 13:26:28 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:9770 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1172793AbdDXR01 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 13:26:27 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wBYD05Z2hz5tlF;
        Mon, 24 Apr 2017 19:26:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7B23213A;
        Mon, 24 Apr 2017 19:26:23 +0200 (CEST)
Subject: Re: [PATCH v7] read-cache: force_verify_index_checksum
To:     git@jeffhostetler.com
References: <20170414203221.43015-1-git@jeffhostetler.com>
 <20170414203221.43015-2-git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <870a8a36-fc6c-6b07-d09e-eec8a9f46a5c@kdbg.org>
Date:   Mon, 24 Apr 2017 19:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170414203221.43015-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.04.2017 um 22:32 schrieb git@jeffhostetler.com:
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 33a51c9..677e15a 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -689,4 +689,17 @@ test_expect_success 'bogus head does not fallback to all heads' '
>  	! grep $blob out
>  '
>
> +test_expect_success 'detect corrupt index file in fsck' '
> +	cp .git/index .git/index.backup &&
> +	test_when_finished "mv .git/index.backup .git/index" &&
> +	echo zzzzzzzz >zzzzzzzz &&
> +	git add zzzzzzzz &&
> +	sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&

sed on a binary file? Sooner or later we are going to run into 
portability issues.

> +	mv .git/index.yyy .git/index &&
> +	# Confirm that fsck detects invalid checksum
> +	test_must_fail git fsck --cache &&

You should ensure that this failure is really because of an invalid 
checksum. The failure could also be due to an extra LF at the end that 
sed inserted, no?

> +	# Confirm that status no longer complains about invalid checksum
> +	git status
> +'
> +
>  test_done

-- Hannes

