Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E55E11F403
	for <e@80x24.org>; Sun,  3 Jun 2018 06:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbeFCG6b (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 02:58:31 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41284 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751028AbeFCG6Q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 02:58:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w536w23k027363;
        Sat, 2 Jun 2018 23:58:13 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbr4js7ry-1;
        Sat, 02 Jun 2018 23:58:13 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id A2F1C228A26A;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 9C49F2CDEEA;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 7/7] merge: fix misleading pre-merge check documentation
Date:   Sat,  2 Jun 2018 23:58:10 -0700
Message-Id: <20180603065810.23841-8-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.49.g3c08dc0fef
In-Reply-To: <20180603065810.23841-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806030084
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/merge.c contains this important requirement for merge strategies:

    ...the index must be in sync with the head commit.  The strategies are
    responsible to ensure this.

However, Documentation/git-merge.txt says:

    ...[merge will] abort if there are any changes registered in the index
    relative to the `HEAD` commit.  (One exception is when the changed
    index entries are in the state that would result from the merge
    already.)

Interestingly, prior to commit c0be8aa06b85 ("Documentation/git-merge.txt:
Partial rewrite of How Merge Works", 2008-07-19),
Documentation/git-merge.txt said much more:

    ...the index file must match the tree of `HEAD` commit...
    [NOTE]
    This is a bit of a lite.  In certain special cases [explained
    in detail]...
    Otherwise, merge will refuse to do any harm to your repository
    (that is...your working tree...and index are left intact).

So, this suggests that the exceptions existed because there were special
cases where it would case no harm, and potentially be slightly more
convenient for the user.  While the current text in git-merge.txt does
list a condition under which it would be safe to proceed despite the index
not matching HEAD, it does not match what is actually implemented, in
three different ways:

    * The exception is written to describe what unpack-trees allows.  Not
      all merge strategies allow such an exception, though, making this
      description misleading.  'ours' and 'octopus' merges have strictly
      enforced index==HEAD for a while, and the commit previous to this
      one made 'recursive' do so as well.

    * If someone did a three-way content merge on a specific file using
      versions from the relevant commits and staged it prior to running
      merge, then that path would technically satisfy the exception listed
      in git-merge.txt.  unpack-trees.c would still error out on the path,
      though, because it defers the three-way content merge logic to other
      parts of the code (resolve, octopus, or recursive) and has no way of
      checking whether the index entry from before the merge will match
      the end result of the merge.

    * The exception as implemented in unpack-trees actually only checked
      that the index matched the MERGE_HEAD version of the file and that
      HEAD matched the merge base.  Assuming no renames, that would indeed
      provide cases where the index matches the end result we'd get from a
      merge.  But renames means unpack-trees is checking that it instead
      matches something other than what the final result will be, risking
      either erroring out when we shouldn't need to, or not erroring out
      when we should and overwriting the user's staged changes.

In addition to the wording behind this exception being misleading, it is
also somewhat surprising to see how many times the code for the special
cases were wrong or the check to make sure the index matched head was
forgotten altogether:

* Prior to commit ee6566e8d70d ("[PATCH] Rewrite read-tree", 2005-09-05),
  there were many cases where an unclean index entry was allowed (look for
  merged_entry_allow_dirty()); it appears that in those cases, the merge
  would have simply overwritten staged changes with the result of the
  merge.  Thus, the merge result would have been correct, but the user's
  uncommitted changes could be thrown away without warning.

* Prior to commit 160252f81626 ("git-merge-ours: make sure our index
  matches HEAD", 2005-11-03), the 'ours' merge strategy did not check
  whether the index matched HEAD.  If it didn't, the resulting merge
  would include all the staged changes, and thus wasn't really an 'ours'
  strategy.

* Prior to commit 3ec62ad9ffba ("merge-octopus: abort if index does not
  match HEAD", 2016-04-09), 'octopus' merges did not check whether the
  index matched HEAD, also resulting in any staged changes from before
  the commit silently being folded into the resulting merge.  commit
  a6ee883b8eb5 ("t6044: new merge testcases for when index doesn't match
  HEAD", 2016-04-09) was also added at the same time to try to test to
  make sure all strategies did the necessary checking for the requirement
  that the index match HEAD.  Sadly, it didn't catch all the cases, as
  evidenced by the remainder of this list...

* Prior to commit 65170c07d466 ("merge-recursive: avoid incorporating
  uncommitted changes in a merge", 2017-12-21), merge-recursive simply
  relied on unpack_trees() to do the necessary check, but in one special
  case it avoided calling unpack_trees() entirely and accidentally ended
  up silently including any staged changes from before the merge in the
  resulting merge commit.

* The commit immediately before this one in this series noted that the
  exceptions were written in a way that assumed no renames, making it
  unsafe for merge-recursive to use.  merge-recursive was modified to
  use its own check to enforce that index==HEAD.

This history makes it very tempting to go into builtin/merge.c and replace
the comment that strategies must enforce that index matches HEAD with code
that just enforces it.  At this point, that would only affect the
'resolve' strategy; all other strategies have each been modified to
manually enforce it.  (However, note that index==HEAD is not strictly
enforced for fast-forward merges, as those are not considered a merge
strategy and they trigger in builtin/merge.c before the section in the
code where the relevant comment is found.)

But, even if we don't take the step of just fixing these problems by
enforcing index==HEAD for all strategies, we at least need to update this
misleading documentation in git-merge.txt.  For now, just modify the claim
in Documentation/git-merge.txt to fix the error.  The precise details
around combination of merges strategies and special cases probably is not
relevant to most users, so simply state that exceptions may exist but are
narrow and vary depending upon which merge strategy is in use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index d5dfd8430f..141bd72284 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -122,9 +122,9 @@ merge' may need to update.
 
 To avoid recording unrelated changes in the merge commit,
 'git pull' and 'git merge' will also abort if there are any changes
-registered in the index relative to the `HEAD` commit.  (One
-exception is when the changed index entries are in the state that
-would result from the merge already.)
+registered in the index relative to the `HEAD` commit.  (Special
+narrow exceptions to this rule may exist depending on which merge
+strategy is in use, but generally, the index must match HEAD.)
 
 If all named commits are already ancestors of `HEAD`, 'git merge'
 will exit early with the message "Already up to date."
-- 
2.18.0.rc0.49.g3c08dc0fef

