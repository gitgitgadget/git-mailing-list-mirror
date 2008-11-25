From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Avoid breaking the walk prematurely
Date: Mon, 24 Nov 2008 16:12:01 -0800
Message-ID: <20081125001201.GH2932@spearce.org>
References: <1227570348-20092-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 01:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4lYU-0003s7-Nq
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 01:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbYKYAME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 19:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbYKYAME
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 19:12:04 -0500
Received: from george.spearce.org ([209.20.77.23]:33271 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbYKYAMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 19:12:03 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 671FE38200; Tue, 25 Nov 2008 00:12:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1227570348-20092-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101636>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> The optimization broke the walk when all changes we adds, assuming
> the parent was an empty tree. This assumption was wrong. The tree does
> not have to bee empty, it can contain other trees and blobs.
> 
> http://code.google.com/p/egit/issues/detail?id=46
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  .../spearce/jgit/revwalk/RewriteTreeFilter.java    |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> We could introduce a fixed version later on if we supply an option to select
> whether to optimize the walk this way. The problem with doing it without an
> option is that imports from legacy SCMs do not necessarily record file moves
> as add/removes in direct sucession, but other events may happen in beteens
> for various reasons.

This is a fairly useful optimization in git.  Most people use it,
because most people don't pass "--full-history" when they run
"git log -- path".  So I think we really want to do it by default
in jgit.

Enabling this optimization again probably requires adding a new
method to TreeFilter which allows the filter graph to return only
nodes which select paths by name, and then do something like:

  else if (chgs == adds && isPathSetEmpty(c.getTree())) {
    c.parents = RevCommit.NO_PARENTS;
    return true;
  }

where isPathSetEmpty runs a second TreeWalk iteration but uses the
new (smaller) filter graph that only matches on paths.

I'm not going to write that out today.  But I thought I'd at least
write an email while the idea was fresh in my head.
 
-- 
Shawn.
