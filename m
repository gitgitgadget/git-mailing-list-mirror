Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D213F1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 20:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJLDeM (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 23:34:12 -0400
Received: from esg260-1.itc.swri.edu ([129.162.252.140]:55531 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeJLDeM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 23:34:12 -0400
Received: from rlstrain.wireless.dyn.datasys.swri.edu (virtual-FW-D10.netmgmt.swri.org [129.162.230.100])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTP id w9BJk5dI013030
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:46:06 -0500
From:   Roger Strain <rstrain@swri.org>
To:     git@vger.kernel.org
Subject: [PATCH v2 3/4] subtree: use commits before rejoins for splits
Date:   Thu, 11 Oct 2018 14:46:04 -0500
Message-Id: <20181011194605.19518-4-rstrain@swri.org>
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
 mlxlogscore=840 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Strain, Roger L" <roger.strain@swri.org>

Adds recursive evaluation of parent commits which were not part of the
initial commit list when performing a split.

Split expects all relevant commits to be reachable from the target commit
but not reachable from any previous rejoins. However, a branch could be
based on a commit prior to a rejoin, then later merged back into the
current code. In this case, a parent to the commit will not be present in
the initial list of commits, trigging an "incorrect order" warning.

Previous behavior was to consider that commit to have no parent, creating
an original commit containing all subtree content. This commit is not
present in an existing subtree commit graph, changing commit hashes and
making pushing to a subtree repo impossible.

New behavior will recursively check these unexpected parent commits to
track them back to either an earlier rejoin, or a true original commit.
The generated synthetic commits will properly match previously-generated
commits, allowing successful pushing to a prior subtree repo.

Signed-off-by: Strain, Roger L <roger.strain@swri.org>
---
 contrib/subtree/git-subtree.sh | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index d8861f306..eef4199ae 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -231,12 +231,14 @@ cache_miss () {
 }
 
 check_parents () {
-	missed=$(cache_miss "$@")
+	missed=$(cache_miss "$1")
+	local indent=$(($2 + 1))
 	for miss in $missed
 	do
 		if ! test -r "$cachedir/notree/$miss"
 		then
 			debug "  incorrect order: $miss"
+			process_split_commit "$miss" "" "$indent"
 		fi
 	done
 }
@@ -606,8 +608,20 @@ ensure_valid_ref_format () {
 process_split_commit () {
 	local rev="$1"
 	local parents="$2"
-	revcount=$(($revcount + 1))
-	progress "$revcount/$revmax ($createcount)"
+	local indent=$3
+
+	if test $indent -eq 0
+	then
+		revcount=$(($revcount + 1))
+	else
+		# processing commit without normal parent information;
+		# fetch from repo
+		parents=$(git log --pretty=%P -n 1 "$rev")
+		extracount=$(($extracount + 1))
+	fi
+
+	progress "$revcount/$revmax ($createcount) [$extracount]"
+
 	debug "Processing commit: $rev"
 	exists=$(cache_get "$rev")
 	if test -n "$exists"
@@ -617,14 +631,13 @@ process_split_commit () {
 	fi
 	createcount=$(($createcount + 1))
 	debug "  parents: $parents"
+	check_parents "$parents" "$indent"
 	newparents=$(cache_get $parents)
 	debug "  newparents: $newparents"
 
 	tree=$(subtree_for_commit "$rev" "$dir")
 	debug "  tree is: $tree"
 
-	check_parents $parents
-
 	# ugly.  is there no better way to tell if this is a subtree
 	# vs. a mainline commit?  Does it matter?
 	if test -z "$tree"
@@ -744,10 +757,11 @@ cmd_split () {
 	revmax=$(eval "$grl" | wc -l)
 	revcount=0
 	createcount=0
+	extracount=0
 	eval "$grl" |
 	while read rev parents
 	do
-		process_split_commit "$rev" "$parents"
+		process_split_commit "$rev" "$parents" 0
 	done || exit $?
 
 	latest_new=$(cache_get latest_new)
-- 
2.19.1

