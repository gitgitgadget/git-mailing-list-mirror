Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06E7920281
	for <e@80x24.org>; Fri, 10 Nov 2017 18:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbdKJSNY (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:13:24 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42012 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751541AbdKJSNX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 13:13:23 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAHceb5009806
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e536317d3-1
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 45A7D22F4444
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 3411E2CDE6A
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 09:39:57 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] Fix issues with rename detection limits
Date:   Fri, 10 Nov 2017 09:39:52 -0800
Message-Id: <20171110173956.25105-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100246
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a repo with around 60k files with deep directory hierarchies (due to
being predominantly java code) and which had a few high level directories
moved around (making it appear to git as dozens of thousands of individual
file renames), attempts to cherry-pick commits across product versions
resulted in non-sensical delete/modify conflicts (rather than
rename/modify as expected).  We had a few teams who were in the unenviable
position of having to backport hundreds or thousands of commits across
such product versions, and the result was months of pain, which could have
been alleviated were it not for a few small git bugs:

  * When you try to cherry-pick changes, unlike when you merge two
    branches, git will not notify you when you need to set a higher
    merge.renameLimit.

  * If you know git internals well enough, you can try to trick git into
    telling you the correct renameLimit by doing a merge instead of a
    cherry-pick.  If you do that, and have a renameLimit that is too
    small, git will let you know the value you need.  You can then undo
    the merge and proceed with the cherry-pick.  Except that...

  * If you are performing a merge and specify a large renameLimit that
    isn't large enough, and the necessary renameLimit you need is greater
    than 32767, then git tells you nothing, leading you to believe that
    the limit you specified is high enough, but only to watch it still
    mess up the merge badly.

  * If you happen to specify a merge.renameLimit that *is* high enough,
    but just happens to be greater than 32767, then git will silently
    pretend you specified 32767, determine that 32767 is not high enough,
    not tell you anything about it's silent clamping, and then proceed to
    mess up the merge or cherry-pick badly.  Not only do you get no
    feedback, the clamping to 32767 isn't documented anywhere even if you
    tried to read every manual page.

Folks did discover the merge.renameLimit and tried setting it to various
values, spread over the spectrum from 1000 (the default) up to 999999999
(or maybe more, that's just the highest number I heard), completely
unaware that most their attempts were ignored and wondering why git
couldn't handle things and couldn't explain why either.

Eventually folks wrote scripts that would run the output of format-patch
through a bunch of sed commands to pretend patches were against the
filename on the other side of history and then pipe back through git-am.
Such scripts grew as more and more rename rules were added.

I eventually learned of one of these scripts and said something close to,
"You don't need these pile of rename rules; just set merge.renameLimit to
something higher."  When they responded that merge.renameLimit didn't
work, I didn't believe them.  This patch series, along with two others
that I will be sending shortly, represent my attempt to continue to not
believe them.  :-)

Elijah Newren (4):
  sequencer: Warn when internal merge may be suboptimal due to
    renameLimit
  Remove silent clamp of renameLimit
  progress: Fix progress meters when dealing with lots of work
  sequencer: Show rename progress during cherry picks

 diff.c            |  2 +-
 diffcore-rename.c | 15 ++++++---------
 progress.c        | 22 +++++++++++-----------
 progress.h        |  8 ++++----
 sequencer.c       |  2 ++
 5 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.15.0.5.g9567be9905

