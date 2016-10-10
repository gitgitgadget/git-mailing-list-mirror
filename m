Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AD5220989
	for <e@80x24.org>; Mon, 10 Oct 2016 15:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbcJJP0v (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 11:26:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:55040 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752497AbcJJP0u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 11:26:50 -0400
Received: (qmail 29159 invoked by uid 109); 10 Oct 2016 15:26:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 15:26:28 +0000
Received: (qmail 31271 invoked by uid 111); 10 Oct 2016 15:26:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 11:26:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 11:26:26 -0400
Date:   Mon, 10 Oct 2016 11:26:26 -0400
From:   Jeff King <peff@peff.net>
To:     Eduard Egorov <Eduard.Egorov@icl-services.com>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: git merge deletes my changes
Message-ID: <20161010152626.frc3ypflwnhzidea@sigill.intra.peff.net>
References: <AM4PR03MB1636D18D727968F332F16021DBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM4PR03MB1636D18D727968F332F16021DBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 09:39:13AM +0000, Eduard Egorov wrote:

> A week ago, I've reset a state of 'ceph-ansible' folder in %current%
> branch with code from corresponding branch (that tracks an upstream
> from github):
> 
> # git read-tree --prefix=ceph-ansible/ -u ceph_ansible

This pulls in the subtree files, but there's no actual relationship with
the commit history in ceph_ansible.

So later...

> Then I've committed several changes, including:
> 
> 1. Renamed file and commited:
> # git mv site.yml.sample site.yml
> 
> 2. Made some changes and committed
> 
> 3. Pulled updates from original branch by:
> # git merge -s subtree --squash ceph_ansible
> 
> It said:
>     Auto-merging ceph-ansible/site.yml.sample
>     blablabla
>     Squash commit -- not updating HEAD
>     Automatic merge went well; stopped before committing as requested

When you merge from ceph_ansible, there is no shared history, and git
uses the empty tree as a common ancestor. It looks like the other side
added site.yml.sample, for instance, because that is a change from the
empty tree.

> A post on SO: http://stackoverflow.com/questions/39954265/git-merge-deletes-my-changes

As you noted on SO, modern git disallows merges of unrelated history by
default, because it's usually a mistake to do so.

If you are doing repeated merges into the subtree, you need to somehow
tell git how the histories are related. The obvious answer is to do a
"git merge -s ours ceph_ansible" after your initial read-tree, so that
git knows you've pulled in the changes up to that point. But I'd guess
from your use of "--squash" that you don't want to carry the
ceph_ansible history in your project.

So you need to record the original upstream commit somewhere (probably
in the commit message when you commit the read-tree result), and then
ask git to use that as the merge-base during subsequent merges (which
will require using plumbing codes, as git-merge wants to compute the
merge base itself).  I believe the git-subtree command (in
contrib/subtree of git.git) handles this use case, but I haven't used it
myself.

-Peff
