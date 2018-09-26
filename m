Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 512CA1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 20:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeI0DIG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 26 Sep 2018 23:08:06 -0400
Received: from esg260-1.itc.swri.edu ([129.162.252.140]:33721 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeI0DIG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 23:08:06 -0400
Received: from smtp.swri.org (MBX260.adm.swri.edu [129.162.29.125])
        by esg260-1.itc.swri.edu (8.16.0.22/8.16.0.22) with ESMTPS id w8QKrJAQ156021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 15:53:19 -0500
Received: from MBX260.adm.swri.edu (129.162.29.125) by MBX260.adm.swri.edu
 (129.162.29.125) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 15:53:18 -0500
Received: from MBX260.adm.swri.edu ([10.10.10.3]) by MBX260.adm.swri.edu
 ([10.10.10.3]) with mapi id 15.00.1395.000; Wed, 26 Sep 2018 15:53:18 -0500
From:   "Strain, Roger L." <roger.strain@swri.org>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Subtree bugs
Thread-Topic: Subtree bugs
Thread-Index: AdRV18HdtTl0L2a+QC2nyPlE4uNGrQ==
Date:   Wed, 26 Sep 2018 20:53:18 +0000
Message-ID: <544dbf78cd684f74bf1e4da7826ed3e8@MBX260.adm.swri.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [129.162.26.93]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=667 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260195
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I emailed the group yesterday regarding a possible error in the subtree script. I've continued debugging and since have been able to reproduce the problem. In fact, there are two failure cases which may expose three different problems. To demonstrate, the following commands create two repos (main and sub), add a variety of commits, perform some merges, splits, and rejoins, and finally perform two splits. These two splits generate a commit history which cannot be pushed back to the subtree repo in two different manners.

Commands to demonstrate both failures are here:
https://gist.github.com/FoxFireX/1b794384612b7fd5e7cd157cff96269e

Short summary of three problems involved:
1. Split using rejoins fails in some cases where a commit has a parent which was a parent commit further upstream from a rejoin, causing a new initial commit to be created, which is not related to the original subtree commits.
2. Split using rejoins fails to generate a merge commit which may have triaged the previous problem, but instead elected to use only the parent which is not connected to the original subtree commits. (This may occur when the commit and both parents all share the same subtree hash.)
3. Split ignoring joins also ignores the original add commit, which causes content prior to the add to be considered part of the subtree graph, changing the commit hashes so it is not connected to the original subtree commits.

I'm going to start looking at how to fix/work around either or both of these issues because it's holding up some work for us, but if anyone else has seen something like this, or has suggestions, I'd be happy to hear them.  If I do come up with a fix, I'll ask for approval to contribute it back.

-- 
Roger Strain
