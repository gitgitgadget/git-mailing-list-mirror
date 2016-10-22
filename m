Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6611F4F8
	for <e@80x24.org>; Sat, 22 Oct 2016 07:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbcJVHJa (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 03:09:30 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:23922 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbcJVHJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 03:09:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t1DF22CGqz5tlD;
        Sat, 22 Oct 2016 09:09:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6F813529C;
        Sat, 22 Oct 2016 09:09:25 +0200 (CEST)
Subject: Re: [PATCH 2/3] submodule tests: replace cloning from . by "$(pwd)"
To:     Stefan Beller <sbeller@google.com>
References: <20161021235939.20792-1-sbeller@google.com>
 <20161021235939.20792-3-sbeller@google.com>
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        venv21@gmail.com, dennis@kaarsemaker.net, jrnieder@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c6c5ce05-3511-a992-e079-316f0ce90ecd@kdbg.org>
Date:   Sat, 22 Oct 2016 09:09:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161021235939.20792-3-sbeller@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.10.2016 um 01:59 schrieb Stefan Beller:
> When adding a submodule via "git submodule add <relative url>",
> the relative url applies to the superprojects remote. When the
> superproject was cloned via "git clone . super", the remote url
> is ending with '/.'.
>
> The logic to construct the relative urls is not smart enough to
> detect that the ending /. is referring to the directory itself
> but rather treats it like any other relative path, i.e.
>
>     path/to/dir/. + ../relative/path/to/submodule
>
> would result in
>
>     path/to/dir/relative/path/to/submodule
>
> and not omit the "dir" as you may expect.
>
> As in a later patch we'll normalize the remote url before the
> computation of relative urls takes place, we need to first get our
> test suite in a shape with normalized urls only, which is why we should
> refrain from cloning from '.'

But you are removing a valid use case from the tests. Aren't you 
sweeping something under the rug with this patch?

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7064-wtstatus-pv2.sh      | 9 ++++++---
>  t/t7403-submodule-sync.sh    | 3 ++-
>  t/t7406-submodule-update.sh  | 6 ++++--
>  t/t7407-submodule-foreach.sh | 3 ++-
>  t/t7506-status-submodule.sh  | 3 ++-
>  5 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
> index 3012a4d..95514bb 100755
> --- a/t/t7064-wtstatus-pv2.sh
> +++ b/t/t7064-wtstatus-pv2.sh
> @@ -330,7 +330,8 @@ test_expect_success 'verify UU (edit-edit) conflict' '
>  test_expect_success 'verify upstream fields in branch header' '
>  	git checkout master &&
>  	test_when_finished "rm -rf sub_repo" &&
> -	git clone . sub_repo &&
> +	git clone "$(pwd)" sub_repo &&
> +	git -C sub_repo config --unset remote.origin.url &&

Why is it necessary to remove this configuration? Is it because when it 
is present, the submodule does not construct its own reference? And if 
so, should it not be sufficient to only remove the configuration 
(without changing 'git clone' command), but move this patch after the 
patch that fixes the /. treatment?

>  	(
>  		## Confirm local master tracks remote master.
>  		cd sub_repo &&
...

