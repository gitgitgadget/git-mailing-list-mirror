Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08C1C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F51023998
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbhAHTNG convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 8 Jan 2021 14:13:06 -0500
Received: from esg260-1.itc.swri.org ([129.162.252.140]:42142 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbhAHTNG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 14:13:06 -0500
X-Greylist: delayed 1066 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jan 2021 14:13:05 EST
Received: from smtp.swri.org (MBX256.adm.swri.edu [129.162.26.125])
        by esg260-1.itc.swri.edu (8.16.0.42/8.16.0.42) with ESMTPS id 108IsX9r078203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 8 Jan 2021 12:54:33 -0600
Received: from MBX260.adm.swri.edu (129.162.29.125) by MBX256.adm.swri.edu
 (129.162.26.125) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Jan
 2021 12:54:33 -0600
Received: from smtp-us.swri.org (129.162.29.81) by smtp.swri.org
 (129.162.29.125) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jan 2021 12:54:32 -0600
Received: from mbx256b.US.SWRI.ORG (129.162.26.81) by MBX260B.US.SWRI.ORG
 (129.162.29.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4; Fri, 8 Jan 2021
 12:54:32 -0600
Received: from mbx256b.US.SWRI.ORG ([169.254.0.2]) by MBX256B.US.SWRI.ORG
 ([169.254.0.2]) with mapi id 15.02.0659.011; Fri, 8 Jan 2021 12:54:32 -0600
From:   "Strain, Roger L." <roger.strain@swri.org>
To:     Johan Herland <jherland@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [BUG?] 'git subtree split' replicates unrelated mainline merges
 into subtree?
Thread-Topic: [BUG?] 'git subtree split' replicates unrelated mainline merges
 into subtree?
Thread-Index: AQHW5JgAhq+IRM+a/ESCskt9UoxTaaoeEPDB
Date:   Fri, 8 Jan 2021 18:54:32 +0000
Message-ID: <bc2dbc2ea0c343a28f75452e594da0da@swri.org>
References: <20210107015404.3433-1-jherland@gmail.com>
In-Reply-To: <20210107015404.3433-1-jherland@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [129.162.26.94]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_08:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=-40 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080101
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Apologies for message formatting, fighting Outlook)

> I've been trying to understand how the subtree cache (mis)behaves in
> this case. The cache is initially seeded from find_existing_splits(),
> which finds these lines the adc8ecf commit message:
> 
>     git-subtree-mainline: 9b6e8f677b700a00e9f1715e2624bf5ed756dc85
>     git-subtree-split: 5280958b2f997c3ce7bff7192cceb19f55b45cd9
> 
> and adds these corresponding entries to the cache:
> 
>     9b6e8f6 -> 5280958
>     5280958 -> 5280958
> 
> In other words, the cache starts out claiming that 5280958 is the
> equivalent subtree commit for the 9b6e8f6 mainline commit.
> However, in my naive understanding this does not make sense, as
> 9b6e8f6 _precedes_ the subtree addition, and has no content in
> the relevant subdir.


I think you've identified the exact problem right here. In the normal
split/rejoin commits, the mainline commit *prior to* the merge commit
does, in fact, represent the same subtree state as the subtree commit
which is also merged at that point. But in the case of an add, that's
not true, and I'm actually a little surprised the same commit message
markers are generated.

What really should be captured by the initial cache seeding is that
the add merge commit *itself* has the same subtree content. However,
that can't be determined at the time the merge commit is created, as
the hash of that merge commit is determined by the commit message
itself.

I think a possible solution to this would be modifying the initial cache
process to isolate the Add commits and handle them differently.
Rather than using the hashes in the commit message, it should map
the merge commit itself to the subtree-split commit, and either do
nothing with the subtree-mainline commit hash, or explicitly set it
to notree.

However, this will complicate the logic of building the initial cache,
as it currently only cares about the existence of those simple lines,
and adds the mappings, erroneously as you have noted in this case.

It might also be worth changing the commit message provided for
adds so it no longer generates the incorrect assertion that the mainline
commit is identical subtree-wise, but even with that change, support
for correctly handling existing commits would still be ideal.

Currently, we're using a local version of the subtree script based on
some changes laid out here: https://github.com/gitgitgadget/git/pull/493
I'm hopeful that changeset will eventually land here, as it helps with
several complex issues in our repositories. I bring that up also because
it introduces some additional tools for managin the initial cache,
allowing manual mapping of one commit to another. That version might
allow some level of testing on whether this idea would correct the
problem described.

-- 
Roger Strain
