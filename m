Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088201F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 20:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeJLDaL (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 23:30:11 -0400
Received: from esg260-1.itc.swri.edu ([129.162.252.140]:54899 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeJLDaL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 23:30:11 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 23:30:10 EDT
Received: from rlstrain.wireless.dyn.datasys.swri.edu (virtual-FW-D10.netmgmt.swri.org [129.162.230.100])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTP id w9BJk5dJ013030
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:46:06 -0500
From:   Roger Strain <rstrain@swri.org>
To:     git@vger.kernel.org
Subject: [PATCH v2 4/4] subtree: improve decision on merges kept in split
Date:   Thu, 11 Oct 2018 14:46:05 -0500
Message-Id: <20181011194605.19518-5-rstrain@swri.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20180928183540.48968-1-roger.strain@swri.org>
References: <20180928183540.48968-1-roger.strain@swri.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=651 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Strain, Roger L" <roger.strain@swri.org>

When multiple identical parents are detected for a commit being considered
for copying, explicitly check whether one is the common merge base between
the commits. If so, the other commit can be used as the identical parent;
if not, a merge must be performed to maintain history.

In some situations two parents of a merge commit may appear to both have
identical subtree content with each other and the current commit. However,
those parents can potentially come from different commit graphs.

Previous behavior would simply select one of the identical parents to
serve as the replacement for this commit, based on the order in which they
were processed.

New behavior compares the merge base between the commits to determine if
a new merge commit is necessary to maintain history despite the identical
content.

Signed-off-by: Strain, Roger L <roger.strain@swri.org>
---
 contrib/subtree/git-subtree.sh | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index eef4199ae..7dd643998 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -541,6 +541,7 @@ copy_or_skip () {
 	nonidentical=
 	p=
 	gotparents=
+	copycommit=
 	for parent in $newparents
 	do
 		ptree=$(toptree_for_commit $parent) || exit $?
@@ -548,7 +549,24 @@ copy_or_skip () {
 		if test "$ptree" = "$tree"
 		then
 			# an identical parent could be used in place of this rev.
-			identical="$parent"
+			if test -n "$identical"
+			then
+				# if a previous identical parent was found, check whether
+				# one is already an ancestor of the other
+				mergebase=$(git merge-base $identical $parent)
+				if test "$identical" = "$mergebase"
+				then
+					# current identical commit is an ancestor of parent
+					identical="$parent"
+				elif test "$parent" != "$mergebase"
+				then
+					# no common history; commit must be copied
+					copycommit=1
+				fi
+			else
+				# first identical parent detected
+				identical="$parent"
+			fi
 		else
 			nonidentical="$parent"
 		fi
@@ -571,7 +589,6 @@ copy_or_skip () {
 		fi
 	done
 
-	copycommit=
 	if test -n "$identical" && test -n "$nonidentical"
 	then
 		extras=$(git rev-list --count $identical..$nonidentical)
-- 
2.19.1

