Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C38C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D23B207F7
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJEXCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:02:52 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:22129 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgJEXCw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 19:02:52 -0400
X-Greylist: delayed 23070 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 19:02:50 EDT
Received: from [24.134.116.61] (helo=[192.168.92.203])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1kPTSU-0004Nw-36
        for git@vger.kernel.org; Mon, 05 Oct 2020 18:35:30 +0200
To:     git@vger.kernel.org
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Optimizing for partial clone with '--filter=tree:0'
Message-ID: <58274817-7ac6-b6ae-0d10-22485dfe5e0e@syntevo.com>
Date:   Mon, 5 Oct 2020 18:38:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are implementing a git UI. One interesting case is the repository
cloned with '--filter=tree:0', because it makes it a lot harder to
run basic git operations such as file log and blame.

Eventually we arrived at a number of problems. We should be able to
make patches, at least for (2) and (4), if deemed worthy and the plan
is clear enough. Note that optimal patches (as we see it) will involve
a protocol change.

(1) Is it even considered a realistic use case?
-----------------------------------------------
I used Linux repository as an example of reasonably large repo:
   https://github.com/torvalds/linux.git (951025 commits)

I cloned Linux repository with various filters and got these stats:
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

My conclusion is that '--filter=tree:0' could be desired because it
reasonably saves disk space and network.

(2) A command to enrich repo with trees
---------------------------------------
Since all filters currently include commit objects, it doesn't seem
possible to append the trees alone to a repository that already has
commits. It seems that it could be possible to download trees+commits
like this:

   git -c "remote.origin.partialclonefilter=blob:none" fetch
   --deepen=999999 origin

   Here, '--deepen' is a dirty hack to convince git to re-download
   commits that are already present locally (without trees though).

   Here, '-c' is a workaround for the problem where 'git fetch'
   overwrites filter in config. This problem is probably solved in
   cooking topic: 'fetch: do not override partial clone filter'.

However, according to figures in (1), re-downloading commits should
cost around the cost of 'clone --filter=tree:0', that is 0.5gb extra in
case of Linux repo. It would be nice to avoid that by having a filter
like "trees only please".

It would also be nice to get rid of '--deepen' hack.

(3) Properly supporting 'git blame' and 'git log -- path'
---------------------------------------------------------
Currently, promisor will download things one at a time, which is very
slow. For example, 'git blame' will download trees for commits,
processing one commit at a time. See (4) for a possible solution.

(4) Command to download ALL trees for a subpath
-----------------------------------------------
E.g. for blamed path '/1/2/3/4.txt', only parent trees will be
downloaded:
   '/1'
   '/1/2'
   '/1/2/3'

Such minimal approach should fall in line with user's intention for
using '--filter=tree:0' - user obviously wanted to minimize something,
be that disk or network used. It doesn't sound nice if the first
'git blame' reverts to a repo with all trees, as if cloned with
'--filter=blob:none'.

Currently '--filter=sparse:oid' is there to support that, but it is
very hard to use on client side, because it requires paths to be
already present in a commit on server.

For a possible solution, it sounds reasonable to have such filter:
   --filter=sparse:pathlist=/1/2'
Path list could be delimited with some special character, and paths
themselves could be escaped.

On top of helping with 'git blame' and 'git log', this feature should
help a lot with sparse clones of large mono-repos, such as Google's
super-mono-repo.
