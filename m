Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770011F516
	for <e@80x24.org>; Tue, 26 Jun 2018 19:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeFZTRh (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 15:17:37 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:38344 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752985AbeFZTRg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 26 Jun 2018 15:17:36 -0400
X-Greylist: delayed 1168 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2018 15:17:36 EDT
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1fXtAC-0004K1-TN; Tue, 26 Jun 2018 19:58:04 +0100
Message-ID: <1530039484.9819.8.camel@hellion.org.uk>
Subject: Re: [PATCH v2] filter-branch: skip commits present on --state-branch
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Michael Barabanov <michael.barabanov@gmail.com>, gitster@pobox.com
Cc:     git@vger.kernel.org
Date:   Tue, 26 Jun 2018 19:58:04 +0100
In-Reply-To: <20180626040733.30757-1-michael.barabanov@gmail.com>
References: <20180623043639.7727-1-michael.barabanov@gmail.com>
         <20180626040733.30757-1-michael.barabanov@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2018-06-25 at 21:07 -0700, Michael Barabanov wrote:
> The commits in state:filter.map have already been processed, so don't
> filter them again. This makes incremental git filter-branch much
> faster.
> 
> Also add tests for --state-branch option.
> 
> Signed-off-by: Michael Barabanov <michael.barabanov@gmail.com>

Acked-by: Ian Campbell <ijc@hellion.org.uk>

> ---
>  git-filter-branch.sh     |  1 +
>  t/t7003-filter-branch.sh | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index ccceaf19a..5c5afa2b9 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -372,6 +372,7 @@ while read commit parents; do
>  	git_filter_branch__commit_count=$(($git_filter_branch__commi
> t_count+1))
>  
>  	report_progress
> +	test -f "$workdir"/../map/$commit && continue
>  
>  	case "$filter_subdir" in
>  	"")
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index ec4b160dd..e23de7d0b 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -107,6 +107,21 @@ test_expect_success 'test that the directory was
> renamed' '
>  	test dir/D = "$(cat diroh/D.t)"
>  '
>  
> +V=$(git rev-parse HEAD)
> +
> +test_expect_success 'populate --state-branch' '
> +	git filter-branch --state-branch state -f --tree-filter
> "touch file || :" HEAD
> +'
> +
> +W=$(git rev-parse HEAD)
> +
> +test_expect_success 'using --state-branch to skip already rewritten
> commits' '
> +	test_when_finished git reset --hard $V &&
> +	git reset --hard $V &&
> +	git filter-branch --state-branch state -f --tree-filter
> "touch file || :" HEAD &&
> +	test_cmp_rev $W HEAD
> +'
> +
>  git tag oldD HEAD~4
>  test_expect_success 'rewrite one branch, keeping a side branch' '
>  	git branch modD oldD &&
