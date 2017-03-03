Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB86420133
	for <e@80x24.org>; Fri,  3 Mar 2017 20:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbdCCUXL (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 15:23:11 -0500
Received: from avasout01.plus.net ([84.93.230.227]:40788 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdCCUXK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 15:23:10 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id rYMd1u00422aPyA01YMeyT; Fri, 03 Mar 2017 20:21:39 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=B8fG9ZomWbkNBijddGsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] config: check if config path is a file before parsing
 it
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170303094252.11706-1-pclouds@gmail.com>
 <20170303094252.11706-2-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a88c1a06-0bdb-aab5-850d-3b5627eca605@ramsayjones.plus.com>
Date:   Fri, 3 Mar 2017 20:21:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170303094252.11706-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/03/17 09:42, Nguyễn Thái Ngọc Duy wrote:
> If a directory is given as a config file by accident, we keep open it
> as a file. The behavior of fopen() in this case seems to be
> undefined.
> 
> On Linux, we open a directory as a file ok, then get error (which we
> consider eof) on the first read. So the config parser sees this "file"
> as empty (i.e. valid config). All is well and we don't complain
> anything (but we should).
> 
> The situation is slighly different on Windows. I think fopen() returns
> NULL. And we get a very unhelpful message:
> 
>     $ cat >abc <<EOF
>     [include]
>         path = /tmp/foo
>     EOF
>     $ mkdir /tmp/foo
>     $ git config --includes --file=abc core.bare
>     fatal: bad config line 3 in file abc
> 
> Opening a directory is wrong in the first place. Avoid it. If caught,
> print something better. With this patch, we have
> 
>     $ git config --includes --file=abc core.bare
>     error: '/tmp/foo' is not a file
>     fatal: bad config line 3 in file abc
> 
> It's not perfect (line should be 2 instead of 3). But it's definitely
> improving.
> 
> The new test is only relevant on linux where we blindly open the
> directory and consider it an empty file. On Windows, the test should
> pass even without this patch.
> ---
>  abspath.c              | 7 +++++++
>  cache.h                | 1 +
>  config.c               | 9 +++++++++
>  t/t1300-repo-config.sh | 5 +++++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/abspath.c b/abspath.c
> index 2f0c26e0e2..373cc3abb2 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -11,6 +11,13 @@ int is_directory(const char *path)
>  	return (!stat(path, &st) && S_ISDIR(st.st_mode));
>  }
>  
> +int is_not_file(const char *path)
> +{
> +	struct stat st;
> +
> +	return !stat(path, &st) && !S_ISREG(st.st_mode);
> +}
> +
>  /* removes the last path component from 'path' except if 'path' is root */
>  static void strip_last_component(struct strbuf *path)
>  {
> diff --git a/cache.h b/cache.h
> index 80b6372cf7..bdd1402ab9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1149,6 +1149,7 @@ static inline int is_absolute_path(const char *path)
>  	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
>  }
>  int is_directory(const char *);
> +int is_not_file(const char *);
>  char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error);
>  const char *real_path(const char *path);
> diff --git a/config.c b/config.c
> index c6b874a7bf..c21c0ce433 100644
> --- a/config.c
> +++ b/config.c
> @@ -13,6 +13,7 @@
>  #include "hashmap.h"
>  #include "string-list.h"
>  #include "utf8.h"
> +#include "dir.h"

Something is a bit odd here - nothing in this commit (that I can
see, anyway) would require the addition of this include. Also, this
include is already there in the 'pu' branch, brought in by your
conditional include changes. So, ...

ATB,
Ramsay Jones
