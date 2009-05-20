From: Jeff King <peff@peff.net>
Subject: Re: Reverting an uncommitted revert
Date: Tue, 19 May 2009 23:21:39 -0400
Message-ID: <20090520032139.GB10212@coredump.intra.peff.net>
References: <4A136C40.6020808@workspacewhiz.com> <alpine.LFD.2.00.0905192300070.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 20 05:24:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6cQ0-0005Li-Qb
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 05:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbZETDVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 23:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbZETDVj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 23:21:39 -0400
Received: from peff.net ([208.65.91.99]:35687 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbZETDVj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 23:21:39 -0400
Received: (qmail 6482 invoked by uid 107); 20 May 2009 03:21:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 19 May 2009 23:21:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2009 23:21:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905192300070.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119580>

On Tue, May 19, 2009 at 11:10:14PM -0400, Nicolas Pitre wrote:

> > So here's the idea: What if Git, upon a revert change (or git reset --hard
> > HEAD), "committed" the changes to be reverted and then did the revert with a
> > 'git reset --hard HEAD^'?  The reverted files would be disconnected from a
> > branch, but they would be available in the reflog to retrieve.
> 
> I think there is indeed some value in having a commit of the work 
> directory dirty state automatically made before this state is discarded, 

Related to this, I have wondered if it might be useful to have an "index
reflog". If I do something like this:

  $ git add foo
  $ hack hack hack
  $ git add foo

Then the first added state of "foo" is available in the object database,
but it is not connected to the name "foo" in any way, which makes it
much harder to find. If we had a reflog pointing to trees representing
the index state after each change, then it would be simple (you could
look at "INDEX@{1}:foo" or similar).

I don't know if the performance is an issue. We are writing an extra
tree every time we touch the index, but in many cases you are already
writing a blob.

> and stuff a reference to that commit in the HEAD reflog.  I think such a 
> feature would need to be made configurable and active by default.

I'm not sure if putting it in the HEAD reflog is a good idea. The
reflogs and what goes in them are very user-visible. Do users make the
assumption that HEAD@{1} will be where they expect (e.g., because they
just did a reset, they expect HEAD@{1} to be the prevoius commit, but
with this patch it would actually be HEAD@{2}, with HEAD@{1} as the
worktree pseudo-commit)?

-Peff
