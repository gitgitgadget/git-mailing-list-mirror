Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD301F453
	for <e@80x24.org>; Tue, 25 Sep 2018 14:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeIYVHe convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 25 Sep 2018 17:07:34 -0400
Received: from esg260-1.itc.swri.org ([129.162.252.140]:33113 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbeIYVH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 17:07:29 -0400
Received: from smtp.swri.org (MBX260.adm.swri.edu [129.162.29.125])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTPS id w8PExXii112141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 09:59:33 -0500
Received: from MBX260.adm.swri.edu (129.162.29.125) by MBX260.adm.swri.edu
 (129.162.29.125) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Sep
 2018 09:59:33 -0500
Received: from MBX260.adm.swri.edu ([10.10.10.3]) by MBX260.adm.swri.edu
 ([10.10.10.3]) with mapi id 15.00.1395.000; Tue, 25 Sep 2018 09:59:33 -0500
From:   "Strain, Roger L." <roger.strain@swri.org>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Subtree question and possible issue
Thread-Topic: Subtree question and possible issue
Thread-Index: AdRU3V8vE6djEX+VRCWIWDwiWjpkdQ==
Date:   Tue, 25 Sep 2018 14:59:32 +0000
Message-ID: <56c1495583484686a9865c7dee4d7fe1@MBX260.adm.swri.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [129.162.26.93]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250149
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've got a fairly large codebase that's been through two previous source control systems, and recently converted to git. We have shared modules (but with customization) between projects, so subtrees looked like a good approach to sharing the code between projects. I've encountered a problem pushing commits back to the subtree repo which generated a question and maybe exposed an issue, though the issue could be with our repo for all I know.

[first attempt 2.16.0 (windows), retried with same results 2.19.0 (windows)]

Easier one first. Repo is set up to include code from another repo via subtree. We push code to the subtree using split --rejoin and get a commit linking the two together. New work is done on a branch that has a parent *before* the rejoin, and then merges back *after* the rejoin. When we later want to sync code using split --rejoin, am I right in believing that commit will appear parentless in the subtree repo, since the split will not process any commits which were reachable from the rejoin?  If that's right, is there any workaround other than --ignore-rejoins? Doing the split already takes quite a while, and if we don't get the benefit of rejoins, that process will only grow longer.

Harder part now. The actual problem I encountered was the remote claiming that my push couldn't be accepted because it was behind the remote HEAD of the branch. After looking closer at the local split, I discovered that the rejoin commit was not part of the new commit graph, which meant the commits were completely independent of the remote branch (hence the rejection). I reran the script with debug info turned on, and found the following result which was suspicious:

Processing commit: c3630d64ec64c56b3395bb9df573031d770803af
  parents: 8a1d1a97bfd04a77b2cd624038f64a256753fa09 24b59e2a5f198d97a132a1c3080321a7238e176f
  newparents: 7da344d52155ec5cc3c67dde3577c6a99510ad05 224fa84a093a3b0fc801d0ee1a2f7732a94e3f98
  tree is: 4b26d4dbe94c2ca43a4faa6c8e09f567400752d5
  newrev is: 224fa84a093a3b0fc801d0ee1a2f7732a94e3f98

This commit is the merge which links the parentless new-work commits (merged as 224fa8) to the rejoin commit (accessible through 7da344). This particular commit should have been parented by both, but instead the script considered the two parents to be identical and simplified the graph to only use one. After digging into the script, it seems that this is because the tree hashes of the commits are the same. I've run a similar command to the one in the script to evaluate the hash information for both commits, including both tree hashes and commit hashes. There are some duplicate lines between the two, but they are clearly different commits with different histories. I've uploaded that output here, flagging the duplicate lines for convenience: https://gist.github.com/FoxFireX/41328a87bceeb3542c7a968348a92fa5

To further test this, I ran the script directly in (windows) bash, with the -x debug flag enabled on the script. It shows the comparison of the tree hashes, which is causing it to lose the parent that would link the branches together. That output is available here: https://gist.github.com/FoxFireX/d6b254d0f01af6533874eff2bb9ac135

I also went down the path of running the split with --ignore-joins (which I may need to do due to the first question anyway) but that process ended up creating an incorrect history that doesn't match the existing subtree, including a variety of commits which are completely unrelated to the subtree prefix. I haven't fully gone through the troubleshooting I want there, but may come back with other questions as I work through that process.

So, am I right about branching from pre-rejoin causing ugly commits in the subtree later? And what can I do about this split that refuses to properly join back up? Any help or insight would be most appreciated.

-- 
Roger Strain
