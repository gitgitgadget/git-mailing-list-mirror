Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C240C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5132085B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 17:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390531AbgJTRRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 13:17:36 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:3397 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389652AbgJTRRg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 13:17:36 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2020 13:17:35 EDT
Received: from [84.175.188.231] (helo=[192.168.2.222])
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1kUv65-0006R7-Ts; Tue, 20 Oct 2020 19:06:53 +0200
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, jonathantanmy@google.com,
        Marc Strapetz <marc.strapetz@syntevo.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Questions about partial clone with '--filter=tree:0'
Message-ID: <aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com>
Date:   Tue, 20 Oct 2020 19:09:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a edited copy of message I sent 2 weeks ago, which unfortunately
didn't receive any replies. I tried to make make it shorter this time :)

----

We are implementing a git UI. One interesting case is the repository
cloned with '--filter=tree:0', because it makes it a lot harder to
run basic git operations such as file log and blame.

The problems and potential solutions are outlined below. We should be
able to make patches for (2) and (3) if it makes sense to patch these.

(1) Is it even considered a realistic use case?
-----------------------------------------------
Summary: is '--filter=tree:0' a realistic or "crazy" scenario that is
not considered worthy of supporting?

I decided to use Linux repo, which is reasonably large, and it seems
that '--filter=tree:0' could be desired because it helps with disk
space (~0.66gb) and network (~0.54gb):

https://github.com/torvalds/linux.git
   951025 commits total.

   git clone --bare <url>
	7'624'042 objects
	   2.86gb network
	   3.10gb disk
   git clone --bare --filter=blob:none <url>
	5'484'714 (71.9%) objects
	   1.01gb (35.3%) network
	   1.16gb (37.4%) disk
   git clone --bare --filter=tree:0 <url>
	  951'693 (12.5%) objects
	   0.47gb (16.4%) network
	   0.50gb (16.1%) disk
   git clone --bare --depth 1 --branch master <url>
	   74'380 ( 0.9%) objects
	   0.19gb ( 6.6%) network
	   0.19gb ( 6.1%) disk

(2) A command to enrich repo with trees
---------------------------------------
There is no good way to "un-partial" repository that was cloned with
'--filter=tree:0' to have all trees, but no blobs.

There seems to be a dirty way of doing that by abusing 'fetch --deepen'
which happens to skip "ref tip already present locally" check, but
it will also re-download all commits, which means extra ~0.5gb network
in case of Linux repo.

(3) A command to download ALL trees and/or blobs for a subpath
-----------------------------------------------
Summary: Running a Blame or file log in '--filter=tree:0' repo is
currently very inefficient, up to a point where it can be discussed
as not really working.

The suggested command will be able to accept a path and download ALL
trees and/or blobs that match it.

This will solve many problems at once:
* Solve (2)
* Make it possible to prepare for efficient blame and file log
* Make a new experience with super-mono-repos, where user will now
   be able to only download a part of it by path.

Currently '--filter=sparse:oid' is there to support that, but it is
very hard to use on client side, because it requires paths to be
already present in a commit on server.

For a possible solution, it sounds reasonable to have such filter:
   --filter=sparse:pathlist=/1/2'
Path list could be delimited with some special character, and paths
themselves could be escaped.
