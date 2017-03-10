Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794D01FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 16:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbdCJQBB (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 11:01:01 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:16790 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbdCJQBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 11:01:00 -0500
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v2AG0nWM020110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2017 16:00:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v2AG0mvL027413
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2017 16:00:48 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v2AG0ldE007113;
        Fri, 10 Mar 2017 16:00:47 GMT
Received: from [10.175.181.186] (/10.175.181.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Mar 2017 08:00:47 -0800
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
To:     gitster@pobox.com
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
Cc:     peff@peff.net, git@vger.kernel.org
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <636b65b5-2a19-0416-beef-fbc57aa4d89d@oracle.com>
Date:   Fri, 10 Mar 2017 17:00:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170310151556.18490-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/03/2017 16:15, Vegard Nossum wrote:
> I've used AFL to generate a corpus of pack files that maximises the edge
> coverage for 'git index-pack'.
>
> This is a supplement to (and not a replacement for) the regular test cases
> where we know exactly what each test is checking for. These testcases are
> more useful for avoiding regressions in edge cases or as a starting point
> for future fuzzing efforts.
>
> To see the output of running 'git index-pack' on each file, you can do
> something like this:
>
>   make -C t GIT_TEST_OPTS="--run=34 --verbose" t5300-pack-object.sh
>
> I observe the following coverage changes (for t5300 only):
>
>   path                  old%  new%    pp
>   ----------------------------------------
>   builtin/index-pack.c  74.3  76.6   2.3
>   pack-write.c          79.8  80.4    .6
>   patch-delta.c         67.4  81.4  14.0
>   usage.c               26.6  35.5   8.9
>   wrapper.c             42.0  46.1   4.1
>   zlib.c                58.7  64.1   5.4

And if you add this simple patch on top (sorry, I didn't think of it
until after I'd sent the previous e-mail):

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 19e02ffc2..db705ba5c 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -425,8 +425,10 @@ test_expect_success 'index-pack <pack> works in 
non-repo' '
  test_expect_success 'index-pack edge coverage' '
         for pack in "$TEST_DIRECTORY"/t5300/*.pack
         do
-               rm -rf "${pack%.pack}.idx" &&
-               test_might_fail git index-pack $pack
+               rm -rf "${pack%.pack}.idx" tmp.pack tmp.idx &&
+               test_might_fail git index-pack $pack &&
+               test_might_fail git index-pack --strict $pack &&
+               test_might_fail git index-pack --stdin --fix-thin 
tmp.pack < $pack
         done
  '


you get this change to the coverage profile instead:

path                  old%  new%    pp
----------------------------------------

alloc.c               58.1  67.4   9.3
builtin/index-pack.c  74.3  80.7   6.4
commit.c              13.9  17.4   3.5
date.c                 3.5   4.2    .7
fsck.c                15.7  33.7  18.0
object.c              56.0  58.7   2.7
pack-write.c          79.8  81.4   1.6
patch-delta.c         67.4  81.4  14.0
path.c                31.6  32.1    .5
sha1_file.c           48.9  49.6    .7
tag.c                  3.7  16.8  13.1
tree.c                36.6  37.5    .9
usage.c               26.6  35.5   8.9
wrapper.c             42.0  46.1   4.1
zlib.c                58.7  64.1   5.4

Of course, it's likely some of those gains can be found in other
testcases outside t5300 -- also, coverage isn't everything. Still seems
like a nice gain with very little effort.


Vegard
