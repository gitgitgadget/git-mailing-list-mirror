Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0FF1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeGIUWf (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:22:35 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36628 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933002AbeGIUWe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2018 16:22:34 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69KIXeX010273;
        Mon, 9 Jul 2018 13:22:31 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2k2uchbmr7-1;
        Mon, 09 Jul 2018 13:22:31 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 93B432230FC2;
        Mon,  9 Jul 2018 13:22:31 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 805922CDE78;
        Mon,  9 Jul 2018 13:22:31 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/6] Add merge recursive testcases with undetected conflicts
Date:   Mon,  9 Jul 2018 13:22:29 -0700
Message-Id: <20180709202229.10222-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.135.gd4ea5491ab
In-Reply-To: <xmqqr2kce1mw.fsf@gitster-ct.c.googlers.com>
References: <xmqqr2kce1mw.fsf@gitster-ct.c.googlers.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090230
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> When a merge succeeds, we expect the resulting contents to depend only
>> upon the trees and blobs of the branches involved and of their merge
>> base(s).  Unfortunately, there are currently about half a dozen cases
>> where the contents of a "successful" merge depend on the relative
>> commit timestamps of the merge bases.  Document these with testcases.
>>
>> (This series came out of looking at modifying how file collision
>> conflict types are handled, as discussed at [1].  I discovered these
>> issues while working on that topic.)
>
> I have a topic branch for this series but not merged to 'pu' as
> test-lint gives these:
>
> t6036-recursive-corner-cases.sh:1222: error: "export FOO=bar" is not portable (please use FOO=bar && export FOO):               echo "export PATH=~/bin:$PATH" >source_me.bash &&
> t6036-recursive-corner-cases.sh:1227: error: "export FOO=bar" is not portable (please use FOO=bar && export FOO):               echo "export PATH=~/bin:$PATH" >source_me.bash &&
> Makefile:77: recipe for target 'test-lint-shell-syntax' failed
> make: *** [test-lint-shell-syntax] Error 1
>
> Arguably these are false positives because "source_me.bash" file is
> a mere payload to go through the merge process to be munged and we
> never intend to actually execute its contents with bash, but then
> the test payload probably does not even have to be a string that
> triggers such a false positive to begin with ;-)

Oh, I didn't know about test-lint.  Is there a place that documents the various checks you run, so I can avoid slowing you down?  Ones I know about:

Already documented:
  * `make DEVELOPER=1` (from CodingGuidelines)
  * running tests (from SubmittingPatches)

Stuff I've seen you mention in emails over time:
  * linux/scripts/checkpatch.pl
  * git grep -e '\<inline\>' --and --not -e 'static inline' -- \*.h
  * make -C t/ test-lint

Are there others?


Also, here's a fixup to the topic; as you pointed out, the exact contents
of the script being written were actually irrelevant; it was just an
input to a merge.

-- 8< --
Subject: [PATCH] fixup! t6036: add a failed conflict detection case: regular
 files, different modes

---
 t/t6036-recursive-corner-cases.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index f8f7b30460..5a8fe061ab 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1219,12 +1219,12 @@ test_expect_success 'setup conflicting modes for regular file' '
 		git tag A &&
 
 		git checkout -b B A &&
-		echo "export PATH=~/bin:$PATH" >source_me.bash &&
+		echo "command_to_run" >source_me.bash &&
 		git add source_me.bash &&
 		git commit -m B &&
 
 		git checkout -b C A &&
-		echo "export PATH=~/bin:$PATH" >source_me.bash &&
+		echo "command_to_run" >source_me.bash &&
 		git add source_me.bash &&
 		test_chmod +x source_me.bash &&
 		git commit -m C &&
-- 
2.18.0.135.gd4ea5491ab

