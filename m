Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE4B1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 20:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJLDeN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 23:34:13 -0400
Received: from esg260-1.itc.swri.edu ([129.162.252.140]:55531 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeJLDeN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 23:34:13 -0400
Received: from rlstrain.wireless.dyn.datasys.swri.edu (virtual-FW-D10.netmgmt.swri.org [129.162.230.100])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTP id w9BJk5dG013030
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:46:05 -0500
From:   Roger Strain <rstrain@swri.org>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/4] subtree: refactor split of a commit into standalone method
Date:   Thu, 11 Oct 2018 14:46:02 -0500
Message-Id: <20181011194605.19518-2-rstrain@swri.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20180928183540.48968-1-roger.strain@swri.org>
References: <20180928183540.48968-1-roger.strain@swri.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Strain, Roger L" <roger.strain@swri.org>

In a particularly complex repo, subtree split was not creating
compatible splits for pushing back to a separate repo. Addressing
one of the issues requires recursive handling of parent commits
that were not initially considered by the algorithm. This commit
makes no functional changes, but relocates the code to be called
recursively into a new method to simply comparisons of later
commits.

Signed-off-by: Strain, Roger L <roger.strain@swri.org>
---
 contrib/subtree/git-subtree.sh | 78 ++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index d3f39a862..2cd7b345b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -598,6 +598,47 @@ ensure_valid_ref_format () {
 		die "'$1' does not look like a ref"
 }
 
+process_split_commit () {
+	local rev="$1"
+	local parents="$2"
+	revcount=$(($revcount + 1))
+	progress "$revcount/$revmax ($createcount)"
+	debug "Processing commit: $rev"
+	exists=$(cache_get "$rev")
+	if test -n "$exists"
+	then
+		debug "  prior: $exists"
+		return
+	fi
+	createcount=$(($createcount + 1))
+	debug "  parents: $parents"
+	newparents=$(cache_get $parents)
+	debug "  newparents: $newparents"
+
+	tree=$(subtree_for_commit "$rev" "$dir")
+	debug "  tree is: $tree"
+
+	check_parents $parents
+
+	# ugly.  is there no better way to tell if this is a subtree
+	# vs. a mainline commit?  Does it matter?
+	if test -z "$tree"
+	then
+		set_notree "$rev"
+		if test -n "$newparents"
+		then
+			cache_set "$rev" "$rev"
+		fi
+		return
+	fi
+
+	newrev=$(copy_or_skip "$rev" "$tree" "$newparents") || exit $?
+	debug "  newrev is: $newrev"
+	cache_set "$rev" "$newrev"
+	cache_set latest_new "$newrev"
+	cache_set latest_old "$rev"
+}
+
 cmd_add () {
 	if test -e "$dir"
 	then
@@ -706,42 +747,7 @@ cmd_split () {
 	eval "$grl" |
 	while read rev parents
 	do
-		revcount=$(($revcount + 1))
-		progress "$revcount/$revmax ($createcount)"
-		debug "Processing commit: $rev"
-		exists=$(cache_get "$rev")
-		if test -n "$exists"
-		then
-			debug "  prior: $exists"
-			continue
-		fi
-		createcount=$(($createcount + 1))
-		debug "  parents: $parents"
-		newparents=$(cache_get $parents)
-		debug "  newparents: $newparents"
-
-		tree=$(subtree_for_commit "$rev" "$dir")
-		debug "  tree is: $tree"
-
-		check_parents $parents
-
-		# ugly.  is there no better way to tell if this is a subtree
-		# vs. a mainline commit?  Does it matter?
-		if test -z "$tree"
-		then
-			set_notree "$rev"
-			if test -n "$newparents"
-			then
-				cache_set "$rev" "$rev"
-			fi
-			continue
-		fi
-
-		newrev=$(copy_or_skip "$rev" "$tree" "$newparents") || exit $?
-		debug "  newrev is: $newrev"
-		cache_set "$rev" "$newrev"
-		cache_set latest_new "$newrev"
-		cache_set latest_old "$rev"
+		process_split_commit "$rev" "$parents"
 	done || exit $?
 
 	latest_new=$(cache_get latest_new)
-- 
2.19.1

