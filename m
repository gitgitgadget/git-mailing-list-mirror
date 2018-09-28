Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1EF1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 18:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeI2BVz (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 21:21:55 -0400
Received: from esg260-1.itc.swri.edu ([129.162.252.140]:44230 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeI2BVz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 21:21:55 -0400
Received: from smtp.swri.org (MBX256.adm.swri.edu [129.162.26.125])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTPS id w8SIue1G127167
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 13:56:40 -0500
Received: from MBX260.adm.swri.edu (129.162.29.125) by MBX256.adm.swri.edu
 (129.162.26.125) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 13:56:40 -0500
Received: from csd-17117.dyn.datasys.swri.edu (129.162.105.28) by
 smtp.swri.org (129.162.29.125) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 28 Sep 2018 13:56:40 -0500
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
Subject: [PATCH 0/4] Multiple subtree split fixes regarding complex repos
Date:   Fri, 28 Sep 2018 13:56:39 -0500
Message-ID: <20180928183540.48968-1-roger.strain@swri.org>
X-Mailer: git-send-email 2.19.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recently (about eight months ago) transitioned to git source control systems for several very large, very complex systems. We brought over several active versions requiring maintenance updates, and also set up several subtree repos to manage code shared between the systems. Recently, we attempted to push updates back to those subtrees and encountered errors. I believe I have identified and corrected the errors we found in our repos, and would like to contribute those fixes back.

Commands to demonstrate both failures using the current version of the subtree script are here:
https://gist.github.com/FoxFireX/1b794384612b7fd5e7cd157cff96269e

Short summary of three problems involved:
1. Split using rejoins fails in some cases where a commit has a parent which was a parent commit further upstream from a rejoin, causing a new initial commit to be created, which is not related to the original subtree commits.
2. Split using rejoins fails to generate a merge commit which may have triaged the previous problem, but instead elected to use only the parent which is not connected to the original subtree commits. (This may occur when the commit and both parents all share the same subtree hash.)
3. Split ignoring joins also ignores the original add commit, which causes content prior to the add to be considered part of the subtree graph, changing the commit hashes so it is not connected to the original subtree commits.

The following commits address each problem individually, along with a single commit that makes no functional change but performs a small refactor of the existing code. Hopefully that will make reviewing it a simpler task. This is my first attempt at submitting a patch back, so apologies if I've made any errors in the process.

Strain, Roger L (4):
  subtree: refactor split of a commit into standalone method
  subtree: make --ignore-joins pay attention to adds
  subtree: use commits before rejoins for splits
  subtree: improve decision on merges kept in split

 contrib/subtree/git-subtree.sh | 129 +++++++++++++++++++++------------
 1 file changed, 83 insertions(+), 46 deletions(-)

-- 
2.19.0.windows.1

