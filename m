Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9000E20966
	for <e@80x24.org>; Mon, 10 Apr 2017 14:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbdDJOHG (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 10:07:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:59181 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753339AbdDJOHF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 10:07:05 -0400
Received: (qmail 403 invoked by uid 109); 10 Apr 2017 14:07:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 14:07:04 +0000
Received: (qmail 25135 invoked by uid 111); 10 Apr 2017 14:07:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 10:07:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 10:07:02 -0400
Date:   Mon, 10 Apr 2017 10:07:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Julian Goacher <julian.goacher@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Modifying a bare repo directly
Message-ID: <20170410140702.bndmudfeofchc2ii@sigill.intra.peff.net>
References: <CAG_DJYk3D=sPm6rhGRD_wF4dnJqSU_M+c=NWP4Q5ExBap_-kPw@mail.gmail.com>
 <CACBZZX7aAHdrvH3wucoQYvZ26mNDYvo3ue4XR0TFF7BxBSWaxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7aAHdrvH3wucoQYvZ26mNDYvo3ue4XR0TFF7BxBSWaxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 12:33:18PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Apr 10, 2017 at 12:09 PM, Julian Goacher
> <julian.goacher@gmail.com> wrote:
> > Hi -
> >
> > Is it possible to modify a bare repo directly? e.g. is it possible to
> > insert a file into a bare repo without first cloning a non-bare copy?
> > I'm thinking along the lines of a command or sequence of commands that
> > modifies the file index and then copies the file blob into /objects,
> > but in a situation where the new file exists separately from the
> > target repo.
> 
> Yes you use the plumbing commands (see "man git", search for plumbing), e.g.:
> 
> git init --bare mybare.git
> cd mybare.git
> echo hello | git hash-object --stdin -w >obj
> $ printf "100644 blob $(cat obj)\thello.txt\n" | git mktree
> aaa96ced2d9a1c8e72c56b253a0e2fe78393feb7
> $ git commit-tree -m "1st commit" aaa96ced2d9a1c8e72c56b253a0e2fe78393feb7
> 318448647ab7a2b1f78c87cb8a05ac0cf172fbb8

This is definitely the right track, but if you're going to be modifying
an existing tree (and not just creating a new one), I'd suggest using
using a temporary index:

  export GIT_INDEX_FILE=my-index
  parent=$(git rev-parse HEAD)
  git read-tree $parent
  obj=$(echo hello | git hash-object --stdin -w)
  git update-index --add --cacheinfo 100644,$obj,hello.txt
  [...and other index changes if you want...]
  tree=$(git write-tree)
  commit=$(git commit-tree -p $parent $tree)
  git update-ref HEAD $commit $parent
  rm -f $GIT_INDEX_FILE

That's a bit simpler because it handles modifications to existing trees
(rather than overwriting), and it handles changes to nested subtrees (to
edit "deep/subdir/hello.txt" using mktree, you have to issue three
separate mktree commands).

-Peff
