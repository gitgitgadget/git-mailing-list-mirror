Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365441F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 20:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJLDeL (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 23:34:11 -0400
Received: from esg260-1.itc.swri.org ([129.162.252.140]:55529 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeJLDeL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 23:34:11 -0400
Received: from rlstrain.wireless.dyn.datasys.swri.edu (virtual-FW-D10.netmgmt.swri.org [129.162.230.100])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTP id w9BJk5dF013030
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:46:05 -0500
From:   Roger Strain <rstrain@swri.org>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/4] Multiple subtree split fixes regarding complex repos
Date:   Thu, 11 Oct 2018 14:46:01 -0500
Message-Id: <20181011194605.19518-1-rstrain@swri.org>
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
 mlxlogscore=774 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After doing some testing at scale, determined that one call was taking too long; replaced that with an alternate call which returns the same data significantly faster.

Also, if anyone has any other feedback on these I'd really love to hear it. It's working better for us (as in, it actually generates a compatible tree version to version) but still isn't perfect, and I'm not sure perfect is achievable, but want to make sure this doesn't things for anyone else.

Changes since v1:
diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 1c157dbd9..7dd643998 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -633,7 +633,7 @@ process_split_commit () {
        else
                # processing commit without normal parent information;
                # fetch from repo
-               parents=$(git show -s --pretty=%P "$rev")
+               parents=$(git log --pretty=%P -n 1 "$rev")
                extracount=$(($extracount + 1))
        fi

Strain, Roger L (4):
  subtree: refactor split of a commit into standalone method
  subtree: make --ignore-joins pay attention to adds
  subtree: use commits before rejoins for splits
  subtree: improve decision on merges kept in split

 contrib/subtree/git-subtree.sh | 129 +++++++++++++++++++++------------
 1 file changed, 83 insertions(+), 46 deletions(-)

-- 
2.19.1

