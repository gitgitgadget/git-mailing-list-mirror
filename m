Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9FFC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00CE61362
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhJUQ1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:27:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:43778 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhJUQ1V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:27:21 -0400
Received: (qmail 16072 invoked by uid 109); 21 Oct 2021 16:25:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Oct 2021 16:25:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8309 invoked by uid 111); 21 Oct 2021 16:25:01 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Oct 2021 12:25:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Oct 2021 12:25:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 6/8] generate-cmdlist.sh: replace for loop by printf's
 auto-repeat feature
Message-ID: <YXGUXEjoB3qofs0U@coredump.intra.peff.net>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <patch-6.8-e0b11514b8d-20211020T183533Z-avarab@gmail.com>
 <YXF8a7OoStzdEwZF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXF8a7OoStzdEwZF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 10:42:52AM -0400, Jeff King wrote:

> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index a1ab2b1f07..fab9e6a671 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -67,7 +67,7 @@ print_command_list () {
>  	while read cmd rest
>  	do
>  		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
> -		printf " | CAT_%s" $(echo "$rest" | get_category_line)
> +		printf " | CAT_%s" $rest
>  		echo " },"
>  	done
>  	echo "};"
> 
> I think you could also delete get_category_line, as it was inlined in
> the other caller.

Just for fun, I did a pure-shell loop to drop get_synopsis, which means
we don't exec any processes inside the loop. That patch is below, which
yields the timings (orig is up to your patch 6, no-sort is the patch
above, and pure-shell is the patch below on top):

  $ hyperfine --warmup 1 -L v orig,no-sort,pure-shell -p 'make clean' 'sh generate-cmdlist.sh.{v} command-list.txt'
  Benchmark #1: sh generate-cmdlist.sh.orig command-list.txt
    Time (mean ± σ):      1.286 s ±  0.148 s    [User: 1.503 s, System: 0.781 s]
    Range (min … max):    0.938 s …  1.451 s    10 runs
   
  Benchmark #2: sh generate-cmdlist.sh.no-sort command-list.txt
    Time (mean ± σ):     553.6 ms ± 143.3 ms    [User: 396.7 ms, System: 198.3 ms]
    Range (min … max):   192.6 ms … 683.5 ms    10 runs
   
  Benchmark #3: sh generate-cmdlist.sh.pure-shell command-list.txt
    Time (mean ± σ):      29.7 ms ±  15.6 ms    [User: 22.6 ms, System: 19.4 ms]
    Range (min … max):    12.0 ms …  49.1 ms    10 runs
   
  Summary
    'sh generate-cmdlist.sh.pure-shell command-list.txt' ran
     18.65 ± 10.93 times faster than 'sh generate-cmdlist.sh.no-sort command-list.txt'
     43.33 ± 23.32 times faster than 'sh generate-cmdlist.sh.orig command-list.txt'

So that's building all of the commands faster than I could get even
"touch Documentation/git-add.txt && make command-list.h" to run with
your patch (not entirely fair; I'm not invoking make here, which
probably does add 100ms of overhead, but I think it's still a net win).

The patch below doesn't enforce the /NAME/ section as the sed does. IMHO
that's not of much value because it uses the line with the command-name
as the lower bound. But it could be done pretty easily with an extra
$seen_name variable.

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index fab9e6a671..eae4bbb4c7 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -22,16 +22,6 @@ category_list () {
 	LC_ALL=C sort -u
 }
 
-get_synopsis () {
-	sed -n '
-		/^NAME/,/'"$1"'/H
-		${
-			x
-			s/.*'"$1"' - \(.*\)/N_("\1")/
-			p
-		}' "Documentation/$1.txt"
-}
-
 define_categories () {
 	echo
 	echo "/* Command categories */"
@@ -66,7 +56,18 @@ print_command_list () {
 	command_list "$1" |
 	while read cmd rest
 	do
-		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
+		synopsis=
+		while read line
+		do
+			case "$line" in
+			"$cmd - "*)
+				synopsis=${line#$cmd - }
+				break
+				;;
+			esac
+		done <"Documentation/$cmd.txt"
+
+		printf '\t{ "%s", N_("%s"), 0' "$cmd" "$synopsis"
 		printf " | CAT_%s" $rest
 		echo " },"
 	done
