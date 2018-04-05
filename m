Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13091F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeDERey (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:34:54 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39122 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751417AbeDERex (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Apr 2018 13:34:53 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w35HY9JY005759;
        Thu, 5 Apr 2018 10:34:49 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h286rvn7n-1;
        Thu, 05 Apr 2018 10:34:48 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B8FED2212A62;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id B0B152CDEB1;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sxlijin@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/7] Fix `git clean` with pathspecs
Date:   Thu,  5 Apr 2018 10:34:39 -0700
Message-Id: <20180405173446.32372-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.7.g0b50f94d69
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=662 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804050181
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes, multiple `git clean $ARGS` invocations (with the exact same
flags and parameters for each invocation) are needed to properly clean
out the desired files.  Sometimes, `git clean $PATHS` just refuses to
clean the files it was explicitly told to clean.  This patch series
aims to address these (very old) problems.

I was made aware of the problems when a user brought to me the
following testcase:
    mkdir d{1,2}
    touch d{1,2}/ut
    touch d1/t
    git add d1/t
With this setup, the user would need to run
    git clean -ffd */ut
twice to delete both ut files.  Digging further, I found multiple
interesting variants.

However, I am still slightly unsure of what the correct behavior is
supposed to be for one particular case, namely, if the clean command
were instead:
    git clean -f '*ut'
(note that the glob is quoted to protect from shell expansion, and
that the -d option was removed), should the files still be cleaned?  I
assumed yes and implemented that in patches 5-6, but the commit message
discusses this case, and patch 7 exists to change the implementation
to answer this question with a 'no'.  Patch 7 should NOT should not be
accepted as-is -- it should either be dropped or squashed into earlier
commits, but which depends on the desired behavior.

Patches 1-2 are almost independent one-line fixes that could be
submitted independently.  However, if we decide to keep the changes
from patch 7, then this series does depend on patch 2 for the tests to
pass.

Patch 3 adds four new testcases covering the variants I noticed.

Patch 4 fixes clean with explicit pathspecs and the -d option.

Patches 5-7 fixes clean with explicit pathspecs without the -d option.

Elijah Newren (7):
  dir.c: Fix typo in comment
  dir.c: fix off-by-one error in match_pathspec_item
  t7300: Add some testcases showing failure to clean specified pathspecs
  dir: Directories should be checked for matching pathspecs too
  dir: Make the DO_MATCH_SUBMODULE code reusable for a non-submodule
    case
  dir: If our pathspec might match files under a dir, recurse into it
  If we do not want globs to recurse into subdirs without -d...

 dir.c            | 23 +++++++++++++++--------
 dir.h            |  5 +++--
 t/t7300-clean.sh | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.17.0.7.g0b50f94d69

