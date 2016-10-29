Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A48D320193
	for <e@80x24.org>; Sat, 29 Oct 2016 07:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbcJ2HKp (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 03:10:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:41310 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbcJ2HKo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 03:10:44 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t5WxG0qCkz5tlK;
        Sat, 29 Oct 2016 09:10:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 82356143;
        Sat, 29 Oct 2016 09:10:41 +0200 (CEST)
Subject: Re: [PATCHv2 27/36] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
 <20161028185502.8789-28-sbeller@google.com>
 <xmqqinscxh5g.fsf@gitster.mtv.corp.google.com>
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <484115e7-67a0-a41e-0cca-b0daeb844b5c@kdbg.org>
Date:   Sat, 29 Oct 2016 09:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqinscxh5g.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.10.2016 um 00:06 schrieb Junio C Hamano:
> Probably this needs to be squashed in, now the MinGW discussion has
> settled.

Yes, this looks good. Thank you very much, both of you.

As I said, I won't be able to test this until late next week.

-- Hannes

>
>  attr.c         | 2 +-
>  common-main.c  | 2 ++
>  compat/mingw.c | 4 ----
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 082b5ed343..961218a0d5 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -50,7 +50,7 @@ static struct git_attr *(git_attr_hash[HASHSIZE]);
>
>  #ifndef NO_PTHREADS
>
> -static pthread_mutex_t attr_mutex = PTHREAD_MUTEX_INITIALIZER;
> +static pthread_mutex_t attr_mutex;
>  #define attr_lock()		pthread_mutex_lock(&attr_mutex)
>  #define attr_unlock()		pthread_mutex_unlock(&attr_mutex)
>  void attr_start(void) { pthread_mutex_init(&attr_mutex, NULL); }
> diff --git a/common-main.c b/common-main.c
> index 44a29e8b13..d4699cd404 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "exec_cmd.h"
> +#include "attr.h"
>
>  /*
>   * Many parts of Git have subprograms communicate via pipe, expect the
> @@ -32,6 +33,7 @@ int main(int argc, const char **argv)
>  	sanitize_stdfds();
>
>  	git_setup_gettext();
> +	attr_start();
>
>  	argv[0] = git_extract_argv0_path(argv[0]);
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 51ed76326b..3fbfda5978 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -5,7 +5,6 @@
>  #include "../strbuf.h"
>  #include "../run-command.h"
>  #include "../cache.h"
> -#include "../attr.h"
>
>  #define HCAST(type, handle) ((type)(intptr_t)handle)
>
> @@ -2233,9 +2232,6 @@ void mingw_startup(void)
>  	/* initialize critical section for waitpid pinfo_t list */
>  	InitializeCriticalSection(&pinfo_cs);
>
> -	/* initialize critical sections in the attr code */
> -	attr_start();
> -
>  	/* set up default file mode and file modes for stdin/out/err */
>  	_fmode = _O_BINARY;
>  	_setmode(_fileno(stdin), _O_BINARY);
>

