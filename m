Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D873C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCIGWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCIGWg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:22:36 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E253219C57
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:22:29 -0800 (PST)
Received: (qmail 6327 invoked by uid 109); 9 Mar 2023 06:22:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 06:22:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28412 invoked by uid 111); 9 Mar 2023 06:22:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 01:22:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 01:22:28 -0500
From:   Jeff King <peff@peff.net>
To:     Sudheer D <Sudheer.D@ibm.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git diff without intermediate commits
Message-ID: <ZAl7JI3FZdUgrvkq@coredump.intra.peff.net>
References: <MN2PR15MB3454AE2CE41E79F2B260DDD3E1B59@MN2PR15MB3454.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN2PR15MB3454AE2CE41E79F2B260DDD3E1B59@MN2PR15MB3454.namprd15.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 05:52:15AM +0000, Sudheer D wrote:

> Is there a feature readily available in git that will compare just
> commit1 & commit2 without considering the intermediate merge commits?

No. A diff is comparing two endpoints, without regards to the history.
You can choose different endpoints, but I don't think that really helps
your case (sometimes using the merge base as the preimage, which you can
access via the three-dot "diff commit1...commit2" can help, but I don't
think it does in your case).

> If the answer to the above question to is 'no', if I am providing a
> patch for the same for 'git diff' & 'git difftool' probably with a new
> command line option, would you accept it?

We'd never say "yes" to accepting a patch without seeing it. I'm not
inherently against such a feature, but I have trouble seeing how it
could even be implemented. You are really asking for a diff between the
state of "commit2" and "commit1 as if it had been applied on top of
those merges". But there is no guarantee that commit1 can be applied
there. If the merges touch some of the same lines, it won't work (and
likewise, if you try to do clever things like subtracting out bits of
the diff that come from the intermediate merges, it won't always work).

You can try something like:

  # use a detached HEAD for looking around; we go
  # the parent of commit2 here, which should be merge_commit_n
  git checkout --detach $commit2^

  # this may fail if commit1 conflicts with any of the merges
  git cherry-pick $commit1

  # but now we can see just the differences from commit1->commit2
  git diff HEAD $commit2

which will work sometimes, but I don't think it would be a good idea to
build a feature around it.

-Peff
