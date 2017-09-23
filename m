Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6F4202A5
	for <e@80x24.org>; Sat, 23 Sep 2017 03:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbdIWDe3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 23:34:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:47742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751809AbdIWDe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 23:34:28 -0400
Received: (qmail 21368 invoked by uid 109); 23 Sep 2017 03:34:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 03:34:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10562 invoked by uid 111); 23 Sep 2017 03:35:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 23:35:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 23:34:26 -0400
Date:   Fri, 22 Sep 2017 23:34:26 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git: add --no-optional-locks option
Message-ID: <20170923033425.6ilykxl5pi7unlj6@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org>
 <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
 <CAGZ79kaUTdFi5LkgR6zKeb+CH8vpfPQRZf6bFqRfYY-YXy_TNA@mail.gmail.com>
 <20170922212525.kxldygbjrmjqu7ci@sigill.intra.peff.net>
 <CAGZ79kYJH-4qb5hiT1C_aCFXLcdiJs5h+Z7Goz4trp52C5s3Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYJH-4qb5hiT1C_aCFXLcdiJs5h+Z7Goz4trp52C5s3Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 02:41:06PM -0700, Stefan Beller wrote:

> > Ah, thanks. I _thought_ we could already do that but when I went looking
> > for the standard --recursive option I couldn't find it.
> 
> Thanks for checking for submodules there.
> 
> I personally prefer --recurse-submodules despite the longer name,
> because a plain recursive option can mean anything in a sufficiently
> complex program such as Git (recurse into the tree (c.f. ls-tree), or
> for the algorithm used (c.f. merge, diff) or yet another dimension
> I did not think of).

Yeah, I agree that's a better name (mentioning --recursive is probably
just showing my general ignorance of submodules).

> > So yes, I would think we would want this option to apply recursively in
> > that case, even when we cross repository boundaries.
> 
> Regarding the actual patch which is heavily aimed at coping with IDEs
> despite the command line being used, I wonder how many IDEs pass
> --ignore-submodules and recurse themselves (if needed). Reason for
> my suspicion is [1] which does pay attention to submodules:
> 
> >    Our application calls status including the following flags:
> >    --porcelain=v2 --ignored --untracked-files=all --ignore-submodules=none
> 
> [1] https://public-inbox.org/git/2bbb1d0f-ae06-1878-d185-112bd51f75c9@gmail.com/

Yeah, I think that's probably Visual Studio (which is what Johannes
presumably wrote the original patch for). GitHub Desktop does not
currently pass it, though perhaps should consider doing so (though of
course the user could tweak their config, too).

> There might be another option to cope with the situation:
> 
>  4. Teach all commands to spinlock / busywait shortly for important
>      locks instead of giving up. In that case git-status rewriting
>      the index ought to be fine?

We do have all the infrastructure in place to do a reasonable busywait
with backoff. I think the patch is roughly just:

diff --git a/read-cache.c b/read-cache.c
index 65f4fe8375..fc1ba122a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1563,7 +1563,8 @@ static int read_index_extension(struct index_state *istate,
 
 int hold_locked_index(struct lock_file *lk, int lock_flags)
 {
-	return hold_lock_file_for_update(lk, get_index_file(), lock_flags);
+	return hold_lock_file_for_update_timeout(lk, get_index_file(),
+						 lock_flags, 500);
 }
 
 int read_index(struct index_state *istate)

though I think there are a few sites which manually call
hold_lock_file_for_update() on the index that would need similar
treatment.

I suspect it would work OK in practice, unless your index is so big that
500ms isn't enough. The user may also see minor stalls when there's lock
contention. I'm not sure how annoying that would be.

-Peff
