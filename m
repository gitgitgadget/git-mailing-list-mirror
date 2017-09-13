Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118C520286
	for <e@80x24.org>; Wed, 13 Sep 2017 12:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdIMMxP (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 08:53:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:36626 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751120AbdIMMxO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 08:53:14 -0400
Received: (qmail 5997 invoked by uid 109); 13 Sep 2017 12:53:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 12:53:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13778 invoked by uid 111); 13 Sep 2017 12:53:49 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 08:53:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 08:53:12 -0400
Date:   Wed, 13 Sep 2017 08:53:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] archive: queue directories for all types of pathspecs
Message-ID: <20170913125312.awtlbndv5j6kkcmz@sigill.intra.peff.net>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
 <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
 <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de>
 <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
 <20170820090629.tumvqwzkromcykjf@sigill.intra.peff.net>
 <837ff6fe-a645-97fe-4b21-ec36f662ce19@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <837ff6fe-a645-97fe-4b21-ec36f662ce19@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 12:43:57AM +0200, René Scharfe wrote:

> -- >8 --
> Subject: [PATCH] archive: don't add empty directories to archives
> 
> While git doesn't track empty directories, git archive can be tricked
> into putting some into archives.  One way is to construct an empty tree
> object, as t5004 does.  While that is supported by the object database,
> it can't be represented in the index and thus it's unlikely to occur in
> the wild.
> 
> Another way is using the literal name of a directory in an exclude
> pathspec -- its contents are are excluded, but the directory stub is
> included.  That's inconsistent: exclude pathspecs containing wildcards
> don't leave empty directories in the archive.
> 
> Yet another way is have a few levels of nested subdirectories (e.g.
> d1/d2/d3/file1) and ignoring the entries at the leaved (e.g. file1).

s/leaved/leaves/ ?

> The directories with the ignored content are ignored as well (e.g. d3),
> but their empty parents are included (e.g. d2).
> 
> As empty directories are not supported by git, they should also not be
> written into archives.  If an empty directory is really needed then it
> can be tracked and archived by placing an empty .gitignore file in it.
> 
> There already is a mechanism in place for suppressing empty directories.
> When read_tree_recursive() encounters a directory excluded by a pathspec
> then it enters it anyway because it might contain included entries.  It
> calls the callback function before it is able to decide if the directory
> is actually needed.  For that reason git archive adds directories to a
> queue and writes entries for them only when it encounters the first
> child item -- but currently only if pathspecs with wildcards are used.
> 
> Queue *all* directories, no matter if there even are pathspecs present.
> This prevents git archive from writing entries for empty directories in
> all cases.

Nicely explained, and this seems like the right level to be handling it.
Simple, and it will catch the cases we know about _and_ and any new ones
which pop up.

> ---
>  archive.c                       | 19 ++-----------------
>  t/t5001-archive-attr.sh         |  2 +-
>  t/t5002-archive-attr-pattern.sh |  2 +-
>  t/t5004-archive-corner-cases.sh |  4 ++--
>  4 files changed, 6 insertions(+), 21 deletions(-)

I'm not too familiar with this part of the archive code, but it seemed
pretty easy to follow. The patch looks good to me.

-Peff
