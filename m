Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00060C74A5B
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCORIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjCORIB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:08:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAF97DD09
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:07:31 -0700 (PDT)
Received: (qmail 18359 invoked by uid 109); 15 Mar 2023 17:07:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Mar 2023 17:07:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2230 invoked by uid 111); 15 Mar 2023 17:07:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Mar 2023 13:07:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Mar 2023 13:07:30 -0400
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Buggy `git log -- path` behavior
Message-ID: <ZBH7Uiv7fH9UnB4v@coredump.intra.peff.net>
References: <4c02cd71-8bfc-4b6e-9ec0-3d98598a695a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c02cd71-8bfc-4b6e-9ec0-3d98598a695a@app.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2023 at 11:04:12AM -0500, Matthew DeVore wrote:

> I think the below terminal session demonstrates a bug in git log.
> Notice the first git log command gives no output. Any thoughts?
> 
> ~/src$ git clone http://github.com/torvalds/linux
> ...
> ~/src$ cd linux
> ~/src/linux$ git checkout v5.15
> ~/src/linux$ cd Documentation/vm
> ~/src/linux/Documentation/vm$ git log -n2 --name-status --oneline -- pagemap.rst
> ~/src/linux/Documentation/vm$ git log -n2 --name-status --oneline -- 'pagemap.*'
> 1ad1335dc586 docs/admin-guide/mm: start moving here files from Documentation/vm
> D       Documentation/vm/pagemap.rst
> 41ea9dd36b6b docs/vm: pagemap: change document title
> M       Documentation/vm/pagemap.rst
> ~/src/linux/Documentation/vm$

Interesting case. You didn't say what you think the bug is, but I assume
you expected that the first command should produce those two commits and
it didn't.

I think what you're seeing is the correct output, though, due to history
simplification. Along the first-parent history, for example,
Documentation/vm/pagemap.rst never existed.  And so since it does not
exist now, we prune any side branches where it did (because they did not
lead to the current state; the other side of the merge resolution did).

Tracking down the exact sequence of merges is tricky ("git log --graph"
is unreadably huge here). But it looks like the file was added by
ad56b738c5dd (docs/vm: rename documentation files to .rst, 2018-03-21).
That was merged into docs-next via 24844fd33945 (Merge branch 'mm-rst'
into docs-next, 2018-04-16), which then eventually moved it in
1ad1335dc586 (docs/admin-guide/mm: start moving here files from
Documentation/vm, 2018-04-18).

So any merges between history containing those commits (where the file
is gone because it went away) and history that didn't have any of them
(where the file never existed) are candidates for simplification, since
the side branch in its total effect didn't contribute to changing the
path.

If you don't want that simplification, use --full-history (though you
probably also want --simplify-merges in this case).

So why does your second command produce output? It's because it matches
pagemap.txt, too. And along that side branch that created and removed
pagemap.rst, there are changes to pagemap.txt (since, after all, it was
converted into pagemap.rst). If you get rid of the "-n2", you'll see
those commits.

-Peff
