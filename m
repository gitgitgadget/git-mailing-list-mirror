Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941AF1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 22:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeKHHyF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 02:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeKHHyF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 02:54:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C15E73082B70;
        Wed,  7 Nov 2018 22:21:40 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-90.rdu2.redhat.com [10.10.120.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B59574242;
        Wed,  7 Nov 2018 22:21:39 +0000 (UTC)
Subject: Re: [PATCH v2] format-patch: respect --stat in cover letter's
 diffstat
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, leif.lindholm@linaro.org
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20181106104811.14625-1-leif.lindholm@linaro.org>
 <20181107164953.24965-1-pclouds@gmail.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <f0f95dd0-1a9e-01d0-70f4-3c6d5450df70@redhat.com>
Date:   Wed, 7 Nov 2018 23:21:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181107164953.24965-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 07 Nov 2018 22:21:41 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07/18 17:49, Nguyễn Thái Ngọc Duy wrote:
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
> 
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

Because I plan to use the patch on top of v2.19.1 (until the next major
release, v2.20, is made), that's also where I applied and tested the patch.

With master @ a4b8ab5363a3, this patch targets show_diffstat(). At
v2.19.1, commit fa5b7ea670f4 ("format-patch: allow additional generated
content in make_cover_letter()", 2018-07-23) had not occurred yet, so
there the subject code still lived in make_cover_letter(). On my end,
git-am has applied the hunk to make_cover_letter() seamlessly.

I tested the patch with "--stat=1000 --stat-graph-width=20", formatting
an edk2 series that contained commit 1ed6498c4a02
("UefiCpuPkg/CommonFeature: Skip locking when the feature is disabled",
2018-11-07). The long pathname
"UefiCpuPkg/Library/CpuCommonFeaturesLib/FeatureControl.c" is no longer
truncated in the cumulative diffstat, in the cover letter.

Tested-by: Laszlo Ersek <lersek@redhat.com>

> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> [...]

I didn't try to run the test suite (I wasn't conscious of it anyway); I
built & installed git with

  nice make -j4 prefix=... all doc info
  nice make prefix=... install install-doc install-html install-info

I also wasn't watching the make log. So if those make targets don't
include the test suite, then I didn't exercise the new test case.

Thank you!
Laszlo
