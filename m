Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D6F203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 06:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbcGZGMt (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 02:12:49 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:42052 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352AbcGZGMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 02:12:44 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rz7883Cfdz5tlB;
	Tue, 26 Jul 2016 08:12:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 8305429CF;
	Tue, 26 Jul 2016 08:12:39 +0200 (CEST)
Subject: Re: [PATCH 3/3] subtree: adjust style to match CodingGuidelines
To:	David Aguilar <davvid@gmail.com>
References: <20160726041416.9438-1-davvid@gmail.com>
 <20160726041416.9438-3-davvid@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brett Cundal <brett.cundal@iugome.com>,
	"David A . Greene" <greened@obbligato.org>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Techlive Zheng <techlivezheng@gmail.com>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <a12604f4-7dc9-7c35-0853-c3bffd734281@kdbg.org>
Date:	Tue, 26 Jul 2016 08:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <20160726041416.9438-3-davvid@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

These caught my eye browsing through my inbox. I'm not a subtree user.

Am 26.07.2016 um 06:14 schrieb David Aguilar:
> @@ -50,87 +51,145 @@ prefix=
>
>  debug()
>  {
> -	if [ -n "$debug" ]; then
> -		printf "%s\n" "$*" >&2
> +	if test -n "$debug"
> +	then
> +		printf "%s\n" "$@" >&2

Are you sure you want this? It prints each argument of the 'debug' 
invocation on its own line.

>  	fi
>  }
>
>  say()
>  {
> -	if [ -z "$quiet" ]; then
> -		printf "%s\n" "$*" >&2
> +	if test -z "$quiet"
> +	then
> +		printf "%s\n" "$@" >&2

Same here.

>  	fi
>  }
>
>  progress()
>  {
> -	if [ -z "$quiet" ]; then
> -		printf "%s\r" "$*" >&2
> +	if test -z "$quiet"
> +	then
> +		printf "%s\r" "$@" >&2

But here I'm pretty sure that this is not wanted; the original is 
clearly correct.

>  	fi
>  }
...
> @@ -139,22 +198,27 @@ debug "command: {$command}"
>  debug "quiet: {$quiet}"
>  debug "revs: {$revs}"
>  debug "dir: {$dir}"
> -debug "opts: {$*}"
> +debug "opts: {$@}"

When the arguments of a script or function are to be printed for the 
user's entertainment/education, then it is safer (and, therefore, 
idiomatic) to use "$*".

>  debug
...
>  cache_get()
>  {
> -	for oldrev in $*; do
> -		if [ -r "$cachedir/$oldrev" ]; then
> +	for oldrev in "$@"
> +	do

It is idiomatic to write this as

	for oldrev
	do

(But your move from bare $* to quoted "$@" fits better under the "fix 
quoting" topic of this patch.)

> +		if test -r "$cachedir/$oldrev"
> +		then
>  			read newrev <"$cachedir/$oldrev"
>  			echo $newrev
>  		fi
...
> @@ -631,17 +749,19 @@ cmd_split()
>  		debug "  parents: $parents"
>  		newparents=$(cache_get $parents)
>  		debug "  newparents: $newparents"
> -		
> +
>  		tree=$(subtree_for_commit $rev "$dir")
>  		debug "  tree is: $tree"
>
>  		check_parents $parents
> -		
> +
>  		# ugly.  is there no better way to tell if this is a subtree
>  		# vs. a mainline commit?  Does it matter?
> -		if [ -z $tree ]; then
> +		if test -z $tree

This works by accident. When $tree is empty, this reduces to 'test -z', 
which happens to evaluate to true, just what we want. But it be 
appropriate to put $tree in double-quotes nevertheless.

> +		then
>  			set_notree $rev
> -			if [ -n "$newparents" ]; then
> +			if test -n "$newparents"
> +			then
>  				cache_set $rev $rev
>  			fi
>  			continue

-- Hannes

