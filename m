Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03211F404
	for <e@80x24.org>; Tue, 27 Mar 2018 12:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeC0Mtp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 08:49:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:44522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750914AbeC0Mtp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 08:49:45 -0400
Received: (qmail 29383 invoked by uid 109); 27 Mar 2018 12:49:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Mar 2018 12:49:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29009 invoked by uid 111); 27 Mar 2018 12:50:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Mar 2018 08:50:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2018 08:49:43 -0400
Date:   Tue, 27 Mar 2018 08:49:43 -0400
From:   Jeff King <peff@peff.net>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: A bug in git merge
Message-ID: <20180327124942.GA18448@sigill.intra.peff.net>
References: <CAGHpTBJ-4a5+5=303_N-n3TtUg_sXt6J1cad0WCQ4Kc-=HDdSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGHpTBJ-4a5+5=303_N-n3TtUg_sXt6J1cad0WCQ4Kc-=HDdSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 12:53:52PM +0300, Orgad Shaneh wrote:

> If I cherry-pick a commit that added a line, then merge another commit
> which removes this line, the line remains in the file instead of being
> removed.
> 
> The following script demonstrates the bug.
> 
> file should be equivalent on both branches
> 
> git init
> seq 1 20 > file
> git add file
> git commit -m 'Initial'
> sed -i "s/^5/5\n55/" file
> git commit -a -m 'Added 55'
> git checkout -b other HEAD^
> git cherry-pick master
> git commit --amend --author 'Author <a@b.c>' --no-edit # generate a new hash
> sed -i '/55/d' file
> git commit -a -m 'Removed 55'
> git checkout master
> git merge --no-edit other
> git diff other # Should be equal

This isn't a bug; it's the expected behavior for a 3-way merge.

The merge looks only at the two final states to be merged, and the merge
base. The three states we have are:

    base: without line 55
    ours: with line 55
  theirs: without line 55

And since only one side made a change, the resolution is to take the
change in the final result. The fact that the other branch actually
manipulated the file (and how it manipulated it) isn't considered at
all.

The fact that it was a cherry-pick doesn't change that. A cherry-pick is
an application of the same changes, but it has no history-relationship
with the original commit in Git.

One could argue for or against the user experience of history as a DAG,
3-way endpoint merges, and how cherry-picks are stored, but this is all
working according to Git's design and not a bug.

-Peff
