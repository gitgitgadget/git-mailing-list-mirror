Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E321F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 13:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeJLVZI (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 17:25:08 -0400
Received: from esg260-1.itc.swri.org ([129.162.252.140]:58065 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeJLVZH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 17:25:07 -0400
Received: from pps.reinject (esg260-1.itc.swri.edu [127.0.0.1])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTPS id w9CDqYN5044209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 08:52:34 -0500
Received: from esg260-1.itc.swri.edu (esg260-1.itc.swri.edu [127.0.0.1])
        by pps.reinject (8.16.0.20/8.16.0.20) with SMTP id w9CDqYgC044203
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 08:52:34 -0500
Received: from rlstrain.wireless.dyn.datasys.swri.edu (virtual-FW-D10.netmgmt.swri.edu [129.162.230.100])
        by esg260-1.itc.swri.edu with ESMTP id w9CDqXxr044200;
        Fri, 12 Oct 2018 08:52:33 -0500
From:   Roger Strain <rstrain@swri.org>
To:     git@vger.kernel.org
Cc:     Roger Strain <rstrain@swri.org>
Subject: [PATCH] subtree: performance improvement for finding unexpected parent commits
Date:   Fri, 12 Oct 2018 08:52:18 -0500
Message-Id: <20181012135218.14439-1-rstrain@swri.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810120138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After testing a previous patch at larger scale, a performance issue was
detected when using git show to locate parent revisions, with a single
run of the git show command taking 2 seconds or longer in a complex repo.
When the command is required tens or hundreds of times in a run of the
script, the additional wait time is unaccepatable. Replacing the command
with git rev-parse resulted in significantly increased performance, with
the command in question returning instantly.

Signed-off-by: Roger Strain <rstrain@swri.org>
Thanks-to: Junio C Hamano <gitster@pobox.com>
---
 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 1c157dbd9..147201dc6 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -633,7 +633,7 @@ process_split_commit () {
 	else
 		# processing commit without normal parent information;
 		# fetch from repo
-		parents=$(git show -s --pretty=%P "$rev")
+		parents=$(git rev-parse "$rev^@")
 		extracount=$(($extracount + 1))
 	fi
 
-- 
2.19.1

