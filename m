Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987D61F461
	for <e@80x24.org>; Fri, 23 Aug 2019 05:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391902AbfHWF7e (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 01:59:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:53404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390268AbfHWF7e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 01:59:34 -0400
Received: (qmail 12966 invoked by uid 109); 23 Aug 2019 05:59:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Aug 2019 05:59:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29842 invoked by uid 111); 23 Aug 2019 06:00:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Aug 2019 02:00:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Aug 2019 01:59:33 -0400
From:   Jeff King <peff@peff.net>
To:     Christopher Sean Morrison <brlcad@mac.com>
Cc:     git@vger.kernel.org, Cliff Yapp <cliffyapp@gmail.com>
Subject: Re: Bug Report: notes disassociated after history edits
Message-ID: <20190823055932.GA10806@sigill.intra.peff.net>
References: <01F35983-BC98-4518-8ED3-C0E1AFC7507A@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01F35983-BC98-4518-8ED3-C0E1AFC7507A@mac.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 04:44:37PM -0400, Christopher Sean Morrison wrote:

> We’re migrating a very large old repository to Git (the oldest in
> continuous development!) and using the notes feature to preserve Svn
> data like revision IDs and branch information.  We’ve run into what
> seems like an incomplete feature or bug in that notes get
> orphaned/disassociated if an old commit is changed (e.g., edit a
> committer's e-mail or the commit message).
> 
> The changed commit and all children commits get sha updates, but the
> notes remain associated with the original sha.  This can be
> particularly catastrophic, for example, if an early commit is changed
> as all notes become orphaned.
> 
> I presume this is a bug but perhaps we may be doing something wrong?
> Is there a better way to preserve old Svn information that will work
> with filter-branch?

Whether the old notes apply to the rewritten commit depends on what is
in the notes. Commands like rebase and "commit --amend" that rewrite
history have some options to carry notes across rewrites. See
"notes.rewrite*" in "git help config".

I don't think that filter-branch ever learned about rewriting notes.
Here's an old thread asking the same thing:

  https://public-inbox.org/git/hbf.20110317iwua@bombur.uio.no/

And it even mentions an even more ancient patch:

  https://public-inbox.org/git/0ad4b8c1a5377d697513cd8e49f64419cd8deef4.1266164150.git.trast@student.ethz.ch/

The consensus seems to be that filter-branch should actually have a
notes filter, but nobody ever implemented it.

In the meantime, I think you could accomplish the same thing with a
--commit-filter. This seems to work for me:

  # fake repo with some notes
  git init repo
  cd repo
  for i in 1 2 3; do
	echo $i >orig-$i
	git add orig-$i
	git commit -m $i
	git notes add -m "note $i"
  done

  # introduce a silly tree change that will modify the commit ids,
  # and map the notes, too
  git filter-branch \
	  --tree-filter 'rename s/orig-/new-/ *' \
	  --commit-filter '
		commit=$(git commit-tree "$@")
		git notes copy $GIT_COMMIT $commit
		echo $commit
	  '

  # this should have the new-* files, but still have notes
  git log --raw

I think you could also use "--state-branch", and then pass its mapping
into a single "notes copy" invocation, which would be much more
efficient. E.g.:

  git filter-branch \
    --tree-filter 'rename s/orig-/new-/ *' \
    --state-branch refs/mapped-state
  git cat-file blob refs/mapped-state:filter.map |
    tr ':' ' ' |
    git notes copy --stdin

Hope that helps.

-Peff
