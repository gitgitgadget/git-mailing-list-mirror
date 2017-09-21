Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3703D202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 18:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbdIUSAn (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 14:00:43 -0400
Received: from siwi.pair.com ([209.68.5.199]:27344 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751693AbdIUSAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 14:00:42 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 084D3845A8;
        Thu, 21 Sep 2017 14:00:42 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 92EB684593;
        Thu, 21 Sep 2017 14:00:41 -0400 (EDT)
Subject: Re: RFC: Design and code of partial clones (now, missing commits and
 trees OK) (part 3)
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     peartben@gmail.com, Christian Couder <christian.couder@gmail.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <af717446-95bf-c5a5-cd27-aaf20531db0f@jeffhostetler.com>
Date:   Thu, 21 Sep 2017 14:00:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(part 3)

Additional overall comments on:
https://github.com/jonathantanmy/git/commits/partialclone2

{} WRT the code in is_promised() [1]

[1] https://github.com/jonathantanmy/git/commit/7a9c2d9b6e2fce293817b595dee29a7eede0dddd#diff-5d5d5dc185ef37dc30bb7d9a7ae0c4e8R1960

    {} it looked like it was adding ALL promisor- and promised-objects to
       the "promised" OIDSET, rather than just promised-objects, but I
       could be mistaken.

    {} Is this iterating over ALL promisor-packfiles?

    {} It looked like this was being used by fsck and rev-list.  I have
       concerns about how big this OIDSET will get and how it will scale,
       since if we start with a partial-clone all packfiles will be
       promisor-packfiles.

    {} When iterating thru a tree object, you add everything that it
       references (everything in that folder).  This adds all of the
       child OIDs -- without regard to whether they are new to this
       version of the tree object. (Granted, this is hard to compute.)

       My concern is that this will add too many objects to the OIDSET.
       That is, a new tree object (because of a recent change to something
       in that folder) will also have the OIDs of the other *unchanged*
       files which may be present in an earlier non-provisor packfile
       from an earlier commit.

       I worry that this will grow the OIDSET to essentially include
       everything.  And possibly defeating its own purpose.  I could be
       wrong here, but that's my concern.


{} I'm not opposed to the .promisor file concept, but I have concerns
    that in practice all packfiles after a partial clone will be
    promisor-packfiles and therefore short-cut during fsck, so fsck
    still won't gain anything.

    It would help if there are also non-promisor packfiles present,
    but only for objects referenced by non-promisor packfiles.

    But then I also have to wonder whether we can even support non-promisor
    packfiles after starting with a partial clone -- because of the
    properties of received thin-packs on a non-partial fetch.
    

Thanks,
Jeff

