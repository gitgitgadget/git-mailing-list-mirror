Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9551FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 22:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbcLBWhw (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 17:37:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:50920 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbcLBWhw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 17:37:52 -0500
Received: (qmail 12488 invoked by uid 109); 2 Dec 2016 22:37:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Dec 2016 22:37:52 +0000
Received: (qmail 16129 invoked by uid 111); 2 Dec 2016 22:38:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Dec 2016 17:38:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2016 17:37:50 -0500
Date:   Fri, 2 Dec 2016 17:37:50 -0500
From:   Jeff King <peff@peff.net>
To:     thomas.attwood@stfc.ac.uk
Cc:     git@vger.kernel.org
Subject: Re: git 2.11.0 error when pushing to remote located on a windows
 share
Message-ID: <20161202223749.2n7wa37e5w6446uv@sigill.intra.peff.net>
References: <AABB04BF1441D24CB4E9FCF46394F17D666F34E1@exchmbx01>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AABB04BF1441D24CB4E9FCF46394F17D666F34E1@exchmbx01>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 06:02:16PM +0000, thomas.attwood@stfc.ac.uk wrote:

> After updating git from 2.10.0 to 2.11.0 when trying to push any
> changes to a repo located in a windows share, the following error
> occurs:
> 
> $ git push origin test
> Counting objects: 2, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (2/2), 284 bytes | 0 bytes/s, done.
> Total 2 (delta 1), reused 1 (delta 0)
> remote: error: object directory /path/to/dir/objects does not exist; check .git/objects/info/alternates.
> remote: fatal: unresolved deltas left after unpacking
> error: unpack failed: unpack-objects abnormal exit
> To //path/to/dir
>  ! [remote rejected] test -> test (unpacker error)
> error: failed to push some refs to '//path/to/dir'

Hmm. This is probably related to the quarantine-push change in v2.11;
the receiving end will write the objects into a temporary directory but
point to the original via GIT_ALTERNATE_OBJECT_DIRECTORIES. That pointer
isn't working for some reason, so the receiver can't resolve the deltas
it needs.

As you noted, the extra "/" is missing in the error message, and that
sounds like a plausible cause for what you're seeing. I'm not sure where
the slash is getting dropped, though. The value in the environment comes
from calling absolute_path(get_object_directory()), so I suspect the
real problem is not in the quarantine code, but it's just triggering a
latent bug elsewhere (either in absolute_path(), or in the code which
generates the objdir path).

> No error occurs if pushing to the same repo (a direct copy into a local directory) using 2.11.0.
> 
> $ git push local_test test
> Counting objects: 2, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (2/2), 284 bytes | 0 bytes/s, done.
> Total 2 (delta 1), reused 1 (delta 0)
> To C:/path/to/dir
>  * [new branch]      test -> test

The fact that it works using the non-UNC path reinforces my feeling that
something is normalizing the absolute path incorrectly.

> Using `git fsck --full` in both 2.11.0 and 2.10.0, it doesn't reveal any additional problems.

Yeah, I don't think there is anything wrong with your repo. It's just a
path-building issue internal to the receiving process.

-Peff
