Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633D41F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 10:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeKLURQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 15:17:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbeKLURQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 15:17:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB0A33001E64;
        Mon, 12 Nov 2018 10:24:40 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-236.rdu2.redhat.com [10.10.120.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEED45D961;
        Mon, 12 Nov 2018 10:24:39 +0000 (UTC)
Subject: Re: [PATCH v2] format-patch: respect --stat in cover letter's
 diffstat
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Leif Lindholm <leif.lindholm@linaro.org>
References: <20181110054646.10149-1-pclouds@gmail.com>
 <20181110054646.10149-2-pclouds@gmail.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <b89707b3-515c-7275-8e56-d901a0c64736@redhat.com>
Date:   Mon, 12 Nov 2018 11:24:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181110054646.10149-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 12 Nov 2018 10:24:41 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/18 06:46, Nguyễn Thái Ngọc Duy wrote:
> Commit 43662b23ab (format-patch: keep cover-letter diffstat wrapped in
> 72 columns - 2018-01-24) uncondtionally sets stat width to 72 when
> generating diffstat for the cover letter, ignoring --stat from command
> line. But it should only do so when stat width is still default
> (i.e. stat_width == 0).
> 
> In order to fix this, we should only set stat_width if stat_width is
> zero. But it will never be. Commit 071dd0ba43 (format-patch: reduce
> patch diffstat width to 72 - 2018-02-01) makes sure that default stat
> width will be 72 (ignoring $COLUMNS, but could still be overriden by
> --stat). So all we need to do here is drop the assignment.
> 
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Helped-by: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/log.c          |  2 --
>  t/t4052-stat-output.sh | 48 +++++++++++++++++++++++++++++-------------
>  2 files changed, 33 insertions(+), 17 deletions(-)

* This submission should have been posted as v3, not v2. V2 was posted at

https://public-inbox.org/git/20181107164953.24965-1-pclouds@gmail.com/

* Comparing the patch emails, the only difference is that this version
renames "expect.40" to "expect.60". This should have been mentioned in a
cover letter, or in the Notes section of the current submission.

* In my response to the (original) v2 posting, at

https://public-inbox.org/git/f0f95dd0-1a9e-01d0-70f4-3c6d5450df70@redhat.com/

I stated that I didn't try to run the test suite, and gave my T-b (under
the circumstances described there). Given that the change in v3 (= this
submission) is limited to the test case, I think my T-b should have been
carried forward.

Thanks
Laszlo



> diff --git a/builtin/log.c b/builtin/log.c
> index 061d4fd864..1a39c6e52a 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1009,8 +1009,6 @@ static void show_diffstat(struct rev_info *rev,
>  
>  	memcpy(&opts, &rev->diffopt, sizeof(opts));
>  	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> -	opts.stat_width = MAIL_DEFAULT_WRAP;
> -
>  	diff_setup_done(&opts);
>  
>  	diff_tree_oid(get_commit_tree_oid(origin),
> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index 6e2cf933f7..28c053849a 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -44,42 +44,50 @@ show --stat
>  log -1 --stat
>  EOF
>  
> -while read cmd args
> +cat >expect.60 <<-'EOF'
> + ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
> +EOF
> +cat >expect.6030 <<-'EOF'
> + ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
> +EOF
> +cat >expect2.60 <<-'EOF'
> + ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
> + ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
> +EOF
> +cat >expect2.6030 <<-'EOF'
> + ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
> + ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
> +EOF
> +while read expect cmd args
>  do
> -	cat >expect <<-'EOF'
> -	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
> -	EOF
>  	test_expect_success "$cmd --stat=width: a long name is given more room when the bar is short" '
>  		git $cmd $args --stat=40 >output &&
>  		grep " | " output >actual &&
> -		test_cmp expect actual
> +		test_cmp $expect.60 actual
>  	'
>  
>  	test_expect_success "$cmd --stat-width=width with long name" '
>  		git $cmd $args --stat-width=40 >output &&
>  		grep " | " output >actual &&
> -		test_cmp expect actual
> +		test_cmp $expect.60 actual
>  	'
>  
> -	cat >expect <<-'EOF'
> -	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
> -	EOF
>  	test_expect_success "$cmd --stat=...,name-width with long name" '
>  		git $cmd $args --stat=60,30 >output &&
>  		grep " | " output >actual &&
> -		test_cmp expect actual
> +		test_cmp $expect.6030 actual
>  	'
>  
>  	test_expect_success "$cmd --stat-name-width with long name" '
>  		git $cmd $args --stat-name-width=30 >output &&
>  		grep " | " output >actual &&
> -		test_cmp expect actual
> +		test_cmp $expect.6030 actual
>  	'
>  done <<\EOF
> -format-patch -1 --stdout
> -diff HEAD^ HEAD --stat
> -show --stat
> -log -1 --stat
> +expect2 format-patch --cover-letter -1 --stdout
> +expect diff HEAD^ HEAD --stat
> +expect show --stat
> +expect log -1 --stat
>  EOF
>  
>  
> @@ -95,6 +103,16 @@ test_expect_success 'preparation for big change tests' '
>  	git commit -m message abcd
>  '
>  
> +cat >expect72 <<'EOF'
> + abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> + abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +EOF
> +test_expect_success "format-patch --cover-letter ignores COLUMNS (big change)" '
> +	COLUMNS=200 git format-patch -1 --stdout --cover-letter >output &&
> +	grep " | " output >actual &&
> +	test_cmp expect72 actual
> +'
> +
>  cat >expect72 <<'EOF'
>   abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  EOF
> 

