Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC58AC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958BD61038
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhJUOpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:45:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:43640 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231425AbhJUOpK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:45:10 -0400
Received: (qmail 15856 invoked by uid 109); 21 Oct 2021 14:42:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Oct 2021 14:42:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7034 invoked by uid 111); 21 Oct 2021 14:42:51 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Oct 2021 10:42:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Oct 2021 10:42:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 6/8] generate-cmdlist.sh: replace for loop by printf's
 auto-repeat feature
Message-ID: <YXF8a7OoStzdEwZF@coredump.intra.peff.net>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <patch-6.8-e0b11514b8d-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.8-e0b11514b8d-20211020T183533Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 08:39:57PM +0200, Ævar Arnfjörð Bjarmason wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> This is just a small code reduction. There is a small probability that
> the new code breaks when the category list is empty. But that would be
> noticed during the compile step.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  generate-cmdlist.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index e517c33710a..a1ab2b1f077 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -67,10 +67,7 @@ print_command_list () {
>  	while read cmd rest
>  	do
>  		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
> -		for cat in $(echo "$rest" | get_category_line)
> -		do
> -			printf " | CAT_$cat"
> -		done
> +		printf " | CAT_%s" $(echo "$rest" | get_category_line)
>  		echo " },"

I think this is fine, but regardless of what happens in patch 7, it's
probably worth dropping this get_category_line call. All it does is sort
and de-dup the tokens in $rest, but we don't care because we're just
OR-ing them together. And of the 3 processes spawned by each loop, it is
responsible for 2 of them.

Even if this loop is broken out into individual bits of Makefile
snippet, avoiding the extra processes is worth doing.

The patch below gives me:

  $ git show HEAD:generate-cmdlist.sh >generate-cmdlist.sh.old
  $ hyperfine --warmup 1 -L s ,.old -p 'make clean' 'sh generate-cmdlist.sh{s} command-list.txt'
  Benchmark #1: sh generate-cmdlist.sh command-list.txt
    Time (mean ± σ):     591.3 ms ±  31.5 ms    [User: 392.9 ms, System: 243.7 ms]
    Range (min … max):   543.7 ms … 630.6 ms    10 runs
   
  Benchmark #2: sh generate-cmdlist.sh.old command-list.txt
    Time (mean ± σ):      1.236 s ±  0.060 s    [User: 1.100 s, System: 0.556 s]
    Range (min … max):    1.089 s …  1.275 s    10 runs
   
  Summary
    'sh generate-cmdlist.sh command-list.txt' ran
      2.09 ± 0.15 times faster than 'sh generate-cmdlist.sh.old command-list.txt'

---
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index a1ab2b1f07..fab9e6a671 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -67,7 +67,7 @@ print_command_list () {
 	while read cmd rest
 	do
 		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
-		printf " | CAT_%s" $(echo "$rest" | get_category_line)
+		printf " | CAT_%s" $rest
 		echo " },"
 	done
 	echo "};"

I think you could also delete get_category_line, as it was inlined in
the other caller.

-Peff
