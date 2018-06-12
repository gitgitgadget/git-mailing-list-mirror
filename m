Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2343E1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 23:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934794AbeFLX6D (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 19:58:03 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59874 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934625AbeFLX6C (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jun 2018 19:58:02 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5CNhWFa020446;
        Tue, 12 Jun 2018 16:57:59 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jjpaa06bj-1;
        Tue, 12 Jun 2018 16:57:58 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id CA4DD2230FC2;
        Tue, 12 Jun 2018 16:57:58 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id C179F2CDE76;
        Tue, 12 Jun 2018 16:57:58 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH] RelNotes 2.18: clarify where directory rename detection applies
Date:   Tue, 12 Jun 2018 16:57:55 -0700
Message-Id: <20180612235755.11309-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.3.gda9bce4c68
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120263
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mention that this feature works with some commands (merge and cherry-pick,
implying that it also works with commands that build on these like rebase
-m and rebase -i).  Explicitly mentioning two commands hopefully implies
that it may not always work with other commands (am, and rebase without
flags that imply either -m or -i).

Also, since the directory rename detection from this cycle was
specifically added in merge-recursive and not diffcore-rename, remove the
'in "diff" family" phrase from the note.  (Folks have requested in the
past that `git diff` detect directory renames and somehow simplify its
output, so it may be helpful to avoid implying that diff has any new
capability here.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
After thinking for a while about my RFC at
  https://public-inbox.org/git/CABPp-BF4gbwVRHA3D1vqXuSnh3aS9XVLqtEUEmfmLDKPccyxtA@mail.gmail.com/
this commit seems like a simple fix.  We can discuss during the 2.19 and
2.20 cycles what to do with rebase, if anything.

Also, if the above commit message feels incomplete without an explanation
of why directory rename detection doesn't work with git-am, the following
could be included:


More details about the git-am limitation for the curious:

git-am tries to avoid a full three way merge, instead calling git-apply.
That prevents us from detecting renames at all, which may defeat the
directory rename detection.  There is a fallback, though; if the initial
git-apply fails and the user has specified the -3 option, git-am will
fall back to a three way merge.  However, git-am lacks the necessary
information to do a "real" three way merge.  Instead, it has to use
build_fake_ancestor() to get a merge base that is missing files whose
rename may have been important to detect for directory rename detection
to function.

am-based rebases work by first generating a bunch of patches (which no
longer record what the original commits were and thus don't have the
necessary info from which we can find a real merge-base), and then
calling `git am`.  This implies that am-based rebases will not always
successfully detect directory renames either.  merged-based rebases
(rebase -m) and cherry-pick-based rebases (rebase -i) are not affected
by this shortcoming.

 Documentation/RelNotes/2.18.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.18.0.txt b/Documentation/RelNotes/2.18.0.txt
index ed80e5485b..449e49e0eb 100644
--- a/Documentation/RelNotes/2.18.0.txt
+++ b/Documentation/RelNotes/2.18.0.txt
@@ -6,7 +6,7 @@ Updates since v2.17
 
 UI, Workflows & Features
 
- * Rename detection logic in "diff" family that is used in "merge" has
+ * Rename detection logic that is used in "merge" and "cherry-pick" has
    learned to guess when all of x/a, x/b and x/c have moved to z/a,
    z/b and z/c, it is likely that x/d added in the meantime would also
    want to move to z/d by taking the hint that the entire directory
-- 
2.18.0.rc0.3.gda9bce4c68

