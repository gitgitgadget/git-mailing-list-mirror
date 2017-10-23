Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3D3202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 14:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbdJWOQt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 10:16:49 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:38094 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932258AbdJWOQt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 10:16:49 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e6dX3-00009c-Fq; Mon, 23 Oct 2017 16:16:45 +0200
Date:   Mon, 23 Oct 2017 16:16:44 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, Jens.Lehmann@web.de, bmwill@google.com,
        git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 1/2] t5526: check for name/path collision in submodule
 fetch
Message-ID: <20171023141644.GC85043@book.hvoigt.net>
References: <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com>
 <20171019181109.27792-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019181109.27792-1-sbeller@google.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 11:11:08AM -0700, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> This is just to test the corner case we're discussing.
> Applies on top of origin/hv/fetch-moved-submodules-on-demand.
> 
> 
>  t/t5526-fetch-submodules.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index a552ad4ead..c82d519e06 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -571,6 +571,7 @@ test_expect_success 'fetching submodule into a broken repository' '
>  '
>  
>  test_expect_success "fetch new commits when submodule got renamed" '
> +	test_when_finished "rm -rf downstream_rename" &&
>  	git clone . downstream_rename &&
>  	(
>  		cd downstream_rename &&
> @@ -605,4 +606,45 @@ test_expect_success "fetch new commits when submodule got renamed" '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success "warn on submodule name/path clash, but new commits fetched in renamed" '
> +	test_when_finished "rm -rf downstream_rename" &&
> +	git clone . downstream_rename &&
> +	(
> +		cd downstream_rename &&
> +		git submodule update --init &&
> +# NEEDSWORK: we omitted --recursive for the submodule update here since
> +# that does not work. See test 7001 for mv "moving nested submodules"
> +# for details. Once that is fixed we should add the --recursive option
> +# here.
> +		git checkout -b rename &&
> +		git mv submodule submodule_renamed &&
> +		(
> +			cd submodule_renamed &&
> +			git checkout -b rename_sub &&
> +			echo a >a &&
> +			git add a &&
> +			git commit -ma &&
> +			git push origin rename_sub &&
> +			git rev-parse HEAD >../../expect
> +		) &&
> +		git add submodule_renamed &&
> +		git commit -m "update renamed submodule" &&
> +		# produce collision, note that we use no submodule command
> +		git clone ../submodule submodule &&
> +		git add submodule &&

A small note even though this is not meant for inclusion: This would
break when I start working on teaching 'git add' to set default values
in .gitmodules when available.

But I guess I will discover a few other places, when starting that, that
will break in the tests anyway.

Cheers Heiko
