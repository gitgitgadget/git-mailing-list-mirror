Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3B520964
	for <e@80x24.org>; Tue,  4 Apr 2017 16:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbdDDQix (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 12:38:53 -0400
Received: from avasout07.plus.net ([84.93.230.235]:34333 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932070AbdDDQiw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 12:38:52 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id 4Gen1v0021keHif01Geoxk; Tue, 04 Apr 2017 17:38:49 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Y8KIilWN c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=bt3WUTiwAAAA:8 a=yMhMjlubAAAA:8 a=WYlB7MQR0JCKIof-WEIA:9
 a=QEXdDO2ut3YA:10 a=OXx4ngWzwLx9h_IvVXMu:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 1/2] test-online-cpus: helper to return cpu count
To:     git@jeffhostetler.com, git@vger.kernel.org
References: <20170403151642.2889-1-git@jeffhostetler.com>
 <20170403151642.2889-2-git@jeffhostetler.com>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <45b6c815-bae4-e33e-f4d6-172fdc7de7e2@ramsayjones.plus.com>
Date:   Tue, 4 Apr 2017 17:38:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170403151642.2889-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/04/17 16:16, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Created helper executable to print the value of online_cpus()
> allowing multi-threaded tests to be skipped when appropriate.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Makefile                    | 1 +
>  t/helper/.gitignore         | 1 +
>  t/helper/test-online-cpus.c | 8 ++++++++
>  3 files changed, 10 insertions(+)
>  create mode 100644 t/helper/test-online-cpus.c
> 
> diff --git a/Makefile b/Makefile
> index 9b36068..3bb31e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -626,6 +626,7 @@ TEST_PROGRAMS_NEED_X += test-line-buffer
>  TEST_PROGRAMS_NEED_X += test-match-trees
>  TEST_PROGRAMS_NEED_X += test-mergesort
>  TEST_PROGRAMS_NEED_X += test-mktemp
> +TEST_PROGRAMS_NEED_X += test-online-cpus
>  TEST_PROGRAMS_NEED_X += test-parse-options
>  TEST_PROGRAMS_NEED_X += test-path-utils
>  TEST_PROGRAMS_NEED_X += test-prio-queue
> diff --git a/t/helper/.gitignore b/t/helper/.gitignore
> index 758ed2e..b05d67c 100644
> --- a/t/helper/.gitignore
> +++ b/t/helper/.gitignore
> @@ -16,6 +16,7 @@
>  /test-match-trees
>  /test-mergesort
>  /test-mktemp
> +/test-online-cpus
>  /test-parse-options
>  /test-path-utils
>  /test-prio-queue
> diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
> new file mode 100644
> index 0000000..c881073
> --- /dev/null
> +++ b/t/helper/test-online-cpus.c
> @@ -0,0 +1,8 @@
> +#include "stdio.h"
> +#include "thread-utils.h"
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	printf("%d\n", online_cpus());
> +	return 0;
> +}
> 

In order to suppress a warning (for lack of extern declaration of
cmd_main), we need to include git-compat-util.h ( or cache.h etc,.),
like so:

  $ git diff
  diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
  index c88107360..b5277fb50 100644
  --- a/t/helper/test-online-cpus.c
  +++ b/t/helper/test-online-cpus.c
  @@ -1,3 +1,4 @@
  +#include "git-compat-util.h"
   #include "stdio.h"
   #include "thread-utils.h"
 
  $ 

Otherwise, this series fixes the test for me.

Thanks!

ATB,
Ramsay Jones


