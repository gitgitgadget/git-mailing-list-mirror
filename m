Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52FEC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 22:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CF320738
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 22:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=smartsoftwareinc.com header.i=@smartsoftwareinc.com header.b="h6gRFgPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgFVWR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:17:27 -0400
Received: from mail.smartsoftwareinc.com ([24.230.151.194]:53778 "EHLO
        mail.smartsoftwareinc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgFVWR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 18:17:26 -0400
Received: from mward.lin.pirsss (unknown [10.0.0.166])
        by mail.smartsoftwareinc.com (Postfix) with ESMTPSA id 68C1A63454;
        Mon, 22 Jun 2020 17:17:22 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smartsoftwareinc.com;
        s=default; t=1592864242;
        bh=YtpLU/6qJTqKUiAIOEeR130+8j9Sk2U3w1b8JiFtB2Q=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=h6gRFgPAwA/mr0EfalgmDnoh6Jd60SoHAJdwCw8PZRclGzXd7J/H4yYWBDziVH5g9
         PyJ6o0w8ldg9bXgIMq71bF7hF07I4kF6OIDl2Gzu7DRskVd7KQGCS8W8tpnEXRqiq2
         6frIPl7/AXSnmkrAtliQDi5nHGZQwAyiECk7xKQo=
Subject: Re: Git 2 force commits but Git 1 doesn't
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
 <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
 <20200622204346.GP6531@camp.crustytoothpaste.net>
 <8ad16219-2426-6127-b41d-bb3007a9b993@smartsoftwareinc.com>
 <20200622210953.GQ6531@camp.crustytoothpaste.net>
From:   Michael Ward <mward@smartsoftwareinc.com>
Organization: Smart Software Solutions, Inc.
Message-ID: <2e43580c-9952-9ccf-6b35-27a4333fb83e@smartsoftwareinc.com>
Date:   Mon, 22 Jun 2020 17:17:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622210953.GQ6531@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-smartsoftware-MailScanner-Information: Please contact the ISP for more information
X-smartsoftware-MailScanner-ID: 68C1A63454.A6485
X-smartsoftware-MailScanner: Found to be clean
X-smartsoftware-MailScanner-SpamCheck: not spam (whitelisted),
        SpamAssassin (not cached, score=-1.6, required 4, autolearn=not spam,
        ALL_TRUSTED, BAYES_05, DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU)
X-smartsoftware-MailScanner-From: mward@smartsoftwareinc.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is assuming that the repository is completely empty to start. Setup:

git clone [repository] repo1
git clone [repository] repo2
cd repo1
echo "test1" > testfile
git add testfile
git commit -m 'initializing test from 1'
git push
cd ../repo2
git pull
cd ../repo1

Now for the issue:

echo "test1 update" >> testfile
git add testfile
git commit -m 'update test from 1'
git push
cd ../repo2
echo "test2" >> testfile
git commit -m 'update test from 2'
git push

At this point using the git 2.26 client if I pull in repo1, the commit 
with comment "update test from 1" is gone and the head is now the commit 
from 2 with "update test from 2" as the comment along with a borked 
tree. Using the 1.18 client, the push from 2 will prompt to pull first.

Michael

On 6/22/20 4:09 PM, brian m. carlson wrote:
> On 2020-06-22 at 20:52:50, Michael Ward wrote:
>> Using the steps from my original email for how I had the repository set up
>> (any user authentication scheme works), clone 2 copies from that repository
>> (call them A and B). Make, commit, and push a change in A. Then make,
>> commit, and push a change in B (without first pulling). With the 1.8 client,
>> B will prompt that you're out of date and need to update. With the 2.26
>> client, B's commit will be pushed and be forced.
> I think we're going to need a more specific set of reproduction steps,
> because adding the following to t5540 succeeds (starting on branch
> "dev"):
>
> test_expect_success 'non-force push fails if not up to date' '
> 	git push origin dev &&
> 	git reset --hard HEAD^ &&
> 	: >path3 &&
> 	git add path3 &&
> 	test_tick &&
> 	git commit -m dev &&
> 	test_must_fail git push origin dev &&
> 	git push origin +dev
> '
>
> That means that this is working in at least some cases.  If you're still
> seeing this, can you provide a set of commands (e.g., a shell script) to
> initialize and create a new repository that triggers this, provided that
> "origin" refers to a suitable remote?
