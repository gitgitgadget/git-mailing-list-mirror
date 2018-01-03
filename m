Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1D31F404
	for <e@80x24.org>; Wed,  3 Jan 2018 10:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeACK5V (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 05:57:21 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:57442 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbeACK5U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 05:57:20 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zBSYp4Zywz5tlJ;
        Wed,  3 Jan 2018 11:57:18 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0C9F141F8;
        Wed,  3 Jan 2018 11:57:17 +0100 (CET)
Subject: Re: [PATCH v5 00/34] Add directory rename detection to git
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>
References: <20171228041352.27880-1-newren@gmail.com>
 <CABPp-BEnpm=OEXZXMeuaxBaOLimucoEKH643jm516YufrtQ-iA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7ecea1b4-d713-7298-1697-ae25532e26e0@kdbg.org>
Date:   Wed, 3 Jan 2018 11:57:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BEnpm=OEXZXMeuaxBaOLimucoEKH643jm516YufrtQ-iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.01.2018 um 01:02 schrieb Elijah Newren:
> On Wed, Dec 27, 2017 at 8:13 PM, Elijah Newren <newren@gmail.com> wrote:
>> This patchset introduces directory rename detection to merge-recursive.  See
>>    https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
>> for the first series (including design considerations, etc.), and follow-up
>> series can be found at
>>    https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/
>>    https://public-inbox.org/git/20171121080059.32304-1-newren@gmail.com/
>>    https://public-inbox.org/git/20171129014237.32570-1-newren@gmail.com/
>>
>> Changes since v4:
>>    * Squashed Junio's GETTEXT_POISON fixes into the appropriate commits
> 
> As per Jonathan's request[1], shamelessly re-sending Stefan's request
> for further review.  :-)
> 
> Quoting Stefan:
> 
> "I have reviewed the first three patches (which could form an
> independent series)
> that it would warrant a Reviewed-By: Stefan Beller <sbeller@google.com>
> 
> While I reviewed the earlier versions of the later patches, I would
> prefer if there is another reviewer for these as it seems like a bigger
> contribution at a core functionality.
> 
> I cc'd some people who were active in some form of rename detection
> work earlier; could you review this series, please?"
> 
> My note: Stefan also looked through the testcases pretty closely and
> even suggested additional tests, which would account for another 11
> patches or so, but extra eyes on any part of the series always
> welcome.

I tested the series on Windows recently. It requires the patch below.
I don't know whether this is indicating some portability issues of grep
(^ being used in the middle of a RE instead of at the very beginning) or
just a quirk in my setup.

But it still does not pass the test suite because the system does not
like file names such as y/c~HEAD:

++ grep 'Refusing to lose dirty file at z/c' out
Refusing to lose dirty file at z/c
++ grep -q stuff x/b y/a y/c y/c~HEAD z/c
grep: y/c: Invalid request code
error: last command exited with $?=2
not ok 94 - 11d-check: Avoid losing not-uptodate with rename + D/F conflict

I haven't debugged this any further, yet.

---- 8< ----
From: Johannes Sixt <j6t@kdbg.org>
Date: Fri, 22 Dec 2017 09:33:13 +0100
Subject: [PATCH] fixup directory rename tests

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t6043-merge-rename-directories.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index f0af66b8a9..b8cd428341 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2940,8 +2940,8 @@ test_expect_success '10b-check: Overwrite untracked with dir rename + delete' '
 		echo contents >y/e &&
 
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/delete).*Version B^0 of y/d left in tree at y/d~B^0" out &&
-		test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B^0 instead" out &&
+		test_i18ngrep "CONFLICT (rename/delete).*Version B\^0 of y/d left in tree at y/d~B\^0" out &&
+		test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B\^0 instead" out &&
 
 		test 3 -eq $(git ls-files -s | wc -l) &&
 		test 2 -eq $(git ls-files -u | wc -l) &&
@@ -3010,7 +3010,7 @@ test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)
 
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
 		test_i18ngrep "CONFLICT (rename/rename)" out &&
-		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B^0 instead" out &&
+		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B\^0 instead" out &&
 
 		test 6 -eq $(git ls-files -s | wc -l) &&
 		test 3 -eq $(git ls-files -u | wc -l) &&
-- 
2.14.2.808.g3bc32f2729
