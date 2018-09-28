Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630E11F453
	for <e@80x24.org>; Fri, 28 Sep 2018 18:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeI2BBF (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 21:01:05 -0400
Received: from esg260-1.itc.swri.edu ([129.162.252.140]:41820 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeI2BBF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 21:01:05 -0400
Received: from smtp.swri.org (MBX260.adm.swri.edu [129.162.29.125])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTPS id w8SIZfCm110697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 13:35:41 -0500
Received: from MBX260.adm.swri.edu (129.162.29.125) by MBX260.adm.swri.edu
 (129.162.29.125) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 13:35:41 -0500
Received: from csd-17117.dyn.datasys.swri.edu (129.162.105.28) by
 smtp.swri.org (129.162.29.125) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 28 Sep 2018 13:35:41 -0500
From:   "Strain, Roger L" <roger.strain@swri.org>
To:     <git@vger.kernel.org>
CC:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Stephen R Guglielmo <srg@guglielmo.us>,
        Dave Ware <davidw@realtimegenomics.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/4] subtree: refactor split of a commit into standalone method
Date:   Fri, 28 Sep 2018 13:35:37 -0500
Message-ID: <20180928183540.48968-2-roger.strain@swri.org>
X-Mailer: git-send-email 2.19.0.windows.1
In-Reply-To: <20180928183540.48968-1-roger.strain@swri.org>
References: <20180928183540.48968-1-roger.strain@swri.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280182
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.19.0.windows.1

