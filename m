Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9EFC2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 20:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755576AbcKCUMR (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 16:12:17 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:63836 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752132AbcKCUMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 16:12:17 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t8x2k2w6jz5tlG;
        Thu,  3 Nov 2016 21:12:14 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A0A64149;
        Thu,  3 Nov 2016 21:12:13 +0100 (CET)
Subject: [PATCH] t0021: expect more variations in the output of uniq -c
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
 <20161016232038.84951-14-larsxschneider@gmail.com>
 <3b09d218-33bd-dc7c-235c-8954a46afc41@kdbg.org>
 <3763DDDB-9D53-4877-8399-32DF1780CAB7@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com, tboegi@web.de
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fb4d62de-fbb5-a2b4-8eba-b135125dafa9@kdbg.org>
Date:   Thu, 3 Nov 2016 21:12:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <3763DDDB-9D53-4877-8399-32DF1780CAB7@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some versions of uniq -c write the count left-justified, other version
write it right-justified. Be prepared for both kinds.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Here it is as a proper patch.

Am 03.11.2016 um 01:41 schrieb Lars Schneider:
>> On 2 Nov 2016, at 18:03, Johannes Sixt <j6t@kdbg.org> wrote:
>> +        sort "$FILE" | uniq -c |
>> +        sed -e "s/^ *[0-9][0-9]* *IN: /x IN: /" >"$FILE.tmp" &&
> 
> This looks good (thanks for cleaning up the redundant clean/smudge
> stuff - that was a refactoring artifact!). One minor nit: doesn't sed
> understand '[0-9]+' ?

I don't think so.

>> +        mv "$FILE.tmp" "$FILE" || return
> 
> Why '|| return' here?

If there is an error in the pipeline or in the mv command, the for loop
would not exit otherwise. The subsequent test_cmp most likely fails,
but the || return is more correct.

 t/t0021-conversion.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index a20b9f58e3..db71acacb3 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -40,10 +40,9 @@ test_cmp_count () {
 	actual=$2
 	for FILE in "$expect" "$actual"
 	do
-		sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
-			sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
-			sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" >"$FILE.tmp" &&
-		mv "$FILE.tmp" "$FILE"
+		sort "$FILE" | uniq -c |
+		sed -e "s/^ *[0-9][0-9]*[ 	]*IN: /x IN: /" >"$FILE.tmp" &&
+		mv "$FILE.tmp" "$FILE" || return
 	done &&
 	test_cmp "$expect" "$actual"
 }
-- 
2.11.0.rc0.55.gd967357

