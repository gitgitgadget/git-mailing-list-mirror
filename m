Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B34E2021E
	for <e@80x24.org>; Sun,  6 Nov 2016 19:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbcKFTbZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 14:31:25 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:51120 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbcKFTbY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 14:31:24 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tBm094ySyz5tlF;
        Sun,  6 Nov 2016 20:31:21 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D9C8C14C;
        Sun,  6 Nov 2016 20:31:19 +0100 (CET)
Subject: Re: [PATCH (optional)] t0021: use arithmetic expansion to trim
 whitespace from wc -c output
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
 <20161016232038.84951-14-larsxschneider@gmail.com>
 <3b09d218-33bd-dc7c-235c-8954a46afc41@kdbg.org>
 <3763DDDB-9D53-4877-8399-32DF1780CAB7@gmail.com>
 <fb4d62de-fbb5-a2b4-8eba-b135125dafa9@kdbg.org>
 <3b58b90d-5435-1503-d052-413a947a5ab5@kdbg.org>
 <C61D1F80-7B7A-4111-9418-75D178AF4353@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com, tboegi@web.de
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b87ddffd-3de1-4481-b484-9f03a73b6ad1@kdbg.org>
Date:   Sun, 6 Nov 2016 20:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <C61D1F80-7B7A-4111-9418-75D178AF4353@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.11.2016 um 16:45 schrieb Lars Schneider:
> 
>> On 03 Nov 2016, at 21:22, Johannes Sixt <j6t@kdbg.org> wrote:
>> This is a pure optimization that reduces the number of forks, which
>> helps a bit on Windows.
>>
>> There would be a solution with perl that does not require trimming
>> of whitespace, but perl startup times are unbearable on Windows.
>> wc -c is better.

I was wrong here. I had looked at the perl invocations due to
git-sendemail, and they are awfully slow. A do-almost-nothing perl
invocation is in the same ballpark as wc. Therefore I changed my mind
and suggest the patch below instead.

> Since the file size function became very simple with your patch,
> shouldn't we get rid of it? If you agree, then we could squash the 
> patch below into your patch.

In the new patch, the function is not that trivial (it uses perl), and
the call sites can remain as they are (simple shell variables and
substitutions).

---- 8< ----
[PATCH] t0021: compute file size with a single process instead of a pipeline

Avoid unwanted coding patterns (prodigal use of pipelines), and in
particular a useless use of cat.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0021-conversion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index db71acacb3..cb72fa49de 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -22,7 +22,7 @@ generate_random_characters () {
 }
 
 file_size () {
-	cat "$1" | wc -c | sed "s/^[ ]*//"
+	perl -e 'print -s $ARGV[0]' "$1"
 }
 
 filter_git () {
-- 
2.11.0.rc0.55.gd967357

