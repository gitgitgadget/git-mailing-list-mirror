From: Jeff King <peff@peff.net>
Subject: Re: Okay to invoke merge-recursive with an empty workdir?
Date: Mon, 12 Sep 2011 23:29:00 -0400
Message-ID: <20110913032900.GA3296@sigill.intra.peff.net>
References: <CAG+J_Dyz-aeLYn43ARTG4GJz0+zRw_RyDr80bmPCayd9BjzCwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 05:29:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3JgN-00018w-05
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 05:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab1IMD3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 23:29:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43660
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801Ab1IMD3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 23:29:03 -0400
Received: (qmail 22124 invoked by uid 107); 13 Sep 2011 03:29:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Sep 2011 23:29:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 23:29:00 -0400
Content-Disposition: inline
In-Reply-To: <CAG+J_Dyz-aeLYn43ARTG4GJz0+zRw_RyDr80bmPCayd9BjzCwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181264>

On Mon, Sep 12, 2011 at 11:13:37PM -0400, Jay Soffian wrote:

> So my approach is to create a temporary, empty, workdir, using
> symlinks to point to the parent repo per git new-workdir.
> 
> I then invoke merge-recursive directly inside the temporary workdir.
> 
> The question is whether this is safe to do, or whether merge-recursive
> expects a fully populated working tree that matches the index. My easy
> test cases seem to work correctly, but I'm concerned that I sometimes
> get:

I'm not sure if we were ever using merge-recursive like that. Especially
with Elijah's latest patches to handle worktree dirtiness better, I
wouldn't be surprised if it has issues.

What we do now at GitHub is something like:

  export GIT_WORK_TREE=/some/tmpdir
  export GIT_INDEX_FILE=/some/tmpfile
  git read-tree -i -m --aggressive $merge_base $us $them
  git merge-index git-merge-one-file -a

I also have a patch to do the content-level merge in read-tree without
touching the filesystem at all. But we're not using it yet, and I should
probably write more tests for it. You can see it at:

  git://github.com/peff/git.git jk/read-tree-content-merge

It should produce the same results as the snippet above, but faster.
Both of those will obviously not handle renames or do recursive merges
like merge-recursive, of course.

-Peff
