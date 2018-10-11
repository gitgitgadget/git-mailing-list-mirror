Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8076E1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 20:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJLDeN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 23:34:13 -0400
Received: from esg260-1.itc.swri.edu ([129.162.252.140]:54899 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeJLDeM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 23:34:12 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 23:30:10 EDT
Received: from rlstrain.wireless.dyn.datasys.swri.edu (virtual-FW-D10.netmgmt.swri.org [129.162.230.100])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTP id w9BJk5dH013030
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:46:06 -0500
From:   Roger Strain <rstrain@swri.org>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/4] subtree: make --ignore-joins pay attention to adds
Date:   Thu, 11 Oct 2018 14:46:03 -0500
Message-Id: <20181011194605.19518-3-rstrain@swri.org>
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Strain, Roger L" <roger.strain@swri.org>

Changes the behavior of --ignore-joins to always consider a subtree add
commit, and ignore only splits and squashes.

The --ignore-joins option is documented to ignore prior --rejoin commits.
However, it additionally ignored subtree add commits generated when a
subtree was initially added to a repo.

Due to the logic which determines whether a commit is a mainline commit
or a subtree commit (namely, the presence or absence of content in the
subtree prefix) this causes commits before the initial add to appear to
be part of the subtree. An --ignore-joins split would therefore consider
those commits part of the subtree history and include them at the
beginning of the synthetic history, causing the resulting hashes to be
incorrect for all later commits.

Signed-off-by: Strain, Roger L <roger.strain@swri.org>
---
 contrib/subtree/git-subtree.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 2cd7b345b..d8861f306 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -340,7 +340,12 @@ find_existing_splits () {
 	revs="$2"
 	main=
 	sub=
-	git log --grep="^git-subtree-dir: $dir/*\$" \
+	local grep_format="^git-subtree-dir: $dir/*\$"
+	if test -n "$ignore_joins"
+	then
+		grep_format="^Add '$dir/' from commit '"
+	fi
+	git log --grep="$grep_format" \
 		--no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
 	while read a b junk
 	do
@@ -730,12 +735,7 @@ cmd_split () {
 		done
 	fi
 
-	if test -n "$ignore_joins"
-	then
-		unrevs=
-	else
-		unrevs="$(find_existing_splits "$dir" "$revs")"
-	fi
+	unrevs="$(find_existing_splits "$dir" "$revs")"
 
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
-- 
2.19.1

