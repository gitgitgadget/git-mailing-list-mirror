From: Nicolas Pitre <nico@cam.org>
Subject: Re: Reverting an uncommitted revert
Date: Tue, 19 May 2009 23:35:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
References: <4A136C40.6020808@workspacewhiz.com>
 <alpine.LFD.2.00.0905192300070.3906@xanadu.home>
 <20090520032139.GB10212@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 05:36:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6cbZ-0008C9-GZ
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 05:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbZETDfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 23:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbZETDfu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 23:35:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23048 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbZETDft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 23:35:49 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KJX00819BBL70X0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 19 May 2009 23:35:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090520032139.GB10212@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119581>

On Tue, 19 May 2009, Jeff King wrote:

> On Tue, May 19, 2009 at 11:10:14PM -0400, Nicolas Pitre wrote:
> 
> > > So here's the idea: What if Git, upon a revert change (or git reset --hard
> > > HEAD), "committed" the changes to be reverted and then did the revert with a
> > > 'git reset --hard HEAD^'?  The reverted files would be disconnected from a
> > > branch, but they would be available in the reflog to retrieve.
> > 
> > I think there is indeed some value in having a commit of the work 
> > directory dirty state automatically made before this state is discarded, 
> 
> Related to this, I have wondered if it might be useful to have an "index
> reflog". If I do something like this:
> 
>   $ git add foo
>   $ hack hack hack
>   $ git add foo
> 
> Then the first added state of "foo" is available in the object database,
> but it is not connected to the name "foo" in any way, which makes it
> much harder to find. If we had a reflog pointing to trees representing
> the index state after each change, then it would be simple (you could
> look at "INDEX@{1}:foo" or similar).
> 
> I don't know if the performance is an issue. We are writing an extra
> tree every time we touch the index, but in many cases you are already
> writing a blob.

Well... Actually I think having a reflog dedicated to discarded state 
would probably be a better idea. And...

> > and stuff a reference to that commit in the HEAD reflog.  I think such a 
> > feature would need to be made configurable and active by default.
> 
> I'm not sure if putting it in the HEAD reflog is a good idea. The
> reflogs and what goes in them are very user-visible. Do users make the
> assumption that HEAD@{1} will be where they expect (e.g., because they
> just did a reset, they expect HEAD@{1} to be the prevoius commit, but
> with this patch it would actually be HEAD@{2}, with HEAD@{1} as the
> worktree pseudo-commit)?

Having a "trash" reflog would solve this unambiguously.  That could also 
include your index example above.  However, in the index case, I'd 
record a reflog entry only if you're about to discard a previously non 
committed entry.  If you do:

	$ git add foo
	$ git add bar
	$ git commit
	$ hack hack hack
	$ git add foo

then in this case there is nothing to be lost hence no additional entry 
in the "trash" reflog.


Nicolas
