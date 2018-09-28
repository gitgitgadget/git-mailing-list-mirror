Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBD21F453
	for <e@80x24.org>; Fri, 28 Sep 2018 18:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeI2BA7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 21:00:59 -0400
Received: from esg260-1.itc.swri.edu ([129.162.252.140]:41805 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeI2BA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 21:00:59 -0400
Received: from smtp.swri.org (MBX260.adm.swri.edu [129.162.29.125])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTPS id w8SIZfCn110697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 13:35:42 -0500
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
Subject: [PATCH 2/4] subtree: make --ignore-joins pay attention to adds
Date:   Fri, 28 Sep 2018 13:35:38 -0500
Message-ID: <20180928183540.48968-3-roger.strain@swri.org>
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
2.19.0.windows.1

