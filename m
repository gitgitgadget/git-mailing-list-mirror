Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC031C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 18:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347762AbiFOSQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbiFOSQq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 14:16:46 -0400
Received: from dalaran.tastycake.net (dalaran.tastycake.net [IPv6:2001:ba8:0:1c0::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C71544EF
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 11:16:44 -0700 (PDT)
Received: from 77.116.2.81.in-addr.arpa ([81.2.116.77] helo=lucy.dinwoodie.org)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <adam@dinwoodie.org>)
        id 1o1XZK-0005cp-KN; Wed, 15 Jun 2022 19:16:42 +0100
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1o1XZJ-001A4P-Hy; Wed, 15 Jun 2022 19:16:41 +0100
Date:   Wed, 15 Jun 2022 19:16:41 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6+ 2/7] archive --add-virtual-file: allow paths
 containing colons
Message-ID: <20220615181641.vltm3qtbsckp5s56@lucy.dinwoodie.org>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
 <20220528231118.3504387-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528231118.3504387-3-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 28, 2022 at 04:11:13PM -0700, Junio C Hamano wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> By allowing the path to be enclosed in double-quotes, we can avoid
> the limitation that paths cannot contain colons.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * Tightened shell variable quoting
> 
> <snip>
>
> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index d6027189e2..3992d08158 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -207,13 +207,21 @@ check_zip with_untracked
>  check_added with_untracked untracked untracked
>  
>  test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
> +	if test_have_prereq FUNNYNAMES
> +	then
> +		PATHNAME="pathname with : colon"
> +	else
> +		PATHNAME="pathname without colon"
> +	fi &&
>  	git archive --format=zip >with_file_with_content.zip \
> +		--add-virtual-file=\""$PATHNAME"\": \
>  		--add-virtual-file=hello:world $EMPTY_TREE &&
>  	test_when_finished "rm -rf tmp-unpack" &&
>  	mkdir tmp-unpack && (
>  		cd tmp-unpack &&
>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
>  		test_path_is_file hello &&
> +		test_path_is_file "$PATHNAME" &&
>  		test world = $(cat hello)
>  	)
>  '

This test is currently failing on Cygwin: it looks like it's exposing a
bug in Cygwin that means files with colons in their name aren't
correctly extracted from zip archives.  I'm going to report that to the
Cygwin mailing list, but I wanted to note it for the record here, too.

Adam
