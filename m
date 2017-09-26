Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22AD820A26
	for <e@80x24.org>; Tue, 26 Sep 2017 05:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965135AbdIZFhe (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 01:37:34 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:23925 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965051AbdIZFhd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 01:37:33 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3y1V8W1bXLz5tlb;
        Tue, 26 Sep 2017 07:37:31 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8F80C211D;
        Tue, 26 Sep 2017 07:37:30 +0200 (CEST)
Subject: Re: [PATCH] t7406: submodule.<name>.update command must not be run
 from .gitmodules
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
References: <20170925200448.GY27425@aiede.mtv.corp.google.com>
 <20170925225054.10819-1-sbeller@google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0aa754b4-93fb-3f23-be51-4af5227ac847@kdbg.org>
Date:   Tue, 26 Sep 2017 07:37:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170925225054.10819-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.09.2017 um 00:50 schrieb Stefan Beller:
> submodule.<name>.update can be assigned an arbitrary command via setting
> it to "!command". When this command is found in the regular config, Git
> ought to just run that command instead of other update mechanisms.
> 
> However if that command is just found in the .gitmodules file, it is
> potentially untrusted, which is why we do not run it.  Add a test
> confirming the behavior.
> 
> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>   updated to use the super robust script.
>   Thanks Jonathan,
>   
>   Stefan
> 
>   t/t7406-submodule-update.sh | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 034914a14f..d718cb00e7 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -406,6 +406,20 @@ test_expect_success 'submodule update - command in .git/config' '
>   	)
>   '
>   
> +test_expect_success 'submodule update - command in .gitmodules is ignored' '
> +	test_when_finished "git -C super reset --hard HEAD^" &&
> +
> +	write_script must_not_run.sh <<-EOF &&
> +	>$TEST_DIRECTORY/bad
> +	EOF

I am pretty confident that this does not test what you intend to test. 
Notice that $TEST_DIRECTORY is expanded when the script is written. But 
that path contains a blank, and we have something like this in the test 
script:

	#!/bin/sh
	>/the/build/directory/t/trash directory.t7406/bad

If you inject the bug against which this test protects into 
git-submodule, you should find a file "trash" in your t directory, and 
the file "bad" still absent. Not to mention that the script fails 
because it cannot run "directory.t7406/bad".

To fix that, you should use and exported variable and access that from 
the test script, for example:

	write_script must_not_run.sh <<-\EOF &&
	>"$TEST_DIRECTORY"/bad
	EOF
...
	(
		export TEST_DIRECTORY &&
		git -C super submodule update submodule
	) &&
	test_path_is_missing bad

> +
> +	git -C super config -f .gitmodules submodule.submodule.update "!$TEST_DIRECTORY/must_not_run.sh" &&
> +	git -C super commit -a -m "add command to .gitmodules file" &&
> +	git -C super/submodule reset --hard $submodulesha1^ &&
> +	git -C super submodule update submodule &&
> +	test_path_is_missing bad
> +'
> +
>   cat << EOF >expect
>   Execution of 'false $submodulesha1' failed in submodule path 'submodule'
>   EOF
> 

-- Hannes
