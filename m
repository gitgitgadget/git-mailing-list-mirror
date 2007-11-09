From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/11] Updated 'quickfetch' series
Date: Fri, 9 Nov 2007 06:06:00 -0500
Message-ID: <20071109110600.GR14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqRgr-0007Mx-S5
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbXKILGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbXKILGF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:06:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34072 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbXKILGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:06:04 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqRgV-0003BT-Dz; Fri, 09 Nov 2007 06:05:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B6C4C20FBAE; Fri,  9 Nov 2007 06:06:00 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64154>

So what started out as a 1 patch hack has now grown into an 11
patch series.  *sigh*

  1)  Fix memory leak in traverse_commit_list

This one seems obvious to me.  No real harm to not having it but
later on we'd see the downside to the leak in git-fetch.

  2)  Reorganize the object memory pools so we can release them
  3)  Define free_all_objects to deallocate object pools
  4)  Allow pooled nodes to be recycled back onto a free list
  5)  Bulk allocate struct commit_list, as we do for struct commit

This part of the series is only lightly tested thus far.  It rewrites
the object allocators in alloc.c to allow complete destruction of
the object hash and its contents in a single call.  This way we
can rerun the revision machinary a second time in the same process
without the mess of clear_commit_flags() or worring about parents
having been rewritten.

We also decrease memory usage by moving struct commit_list into the
pool of things managed by alloc.c.  Given how many of these suckers
we are allocating (3x as many as commits in a --topo-order!) the
malloc overhead saved per parent pointer is probably worth the pain
of reviewing this series.

  6)  git-fetch: Release objects used by a prior transport

Makes use of the above to ensure transports that are called directly
in-process (e.g. fetch-pack) don't get confused by a prior invocation
of that same transport.  I don't think fetch-pack was meant to be
run twice in the same process...

  7)  git-fetch: Limit automated tag following to only fetched objects

Rewrites the rules behind automated tag following.  The new rule is
simpler to understand, has some measure of safety attached to it, and
actually works when we turn on quickfetch behavior in a transport.

  8)  run-command: Support sending stderr to /dev/null
  9)  rev-list: Introduce --quiet to avoid /dev/null redirects
 10)  git-fetch: avoid local fetching from alternate (again)
 11)  git-fetch: test avoiding unnecessary copying from alternates

Turn on quickfetch for the native git transport.  As I'm sitting
here writing this I'm wondering if the quickfetch thing shouldn't
be higher up, like in git-fetch itself, so that we can also use
it in the HTTP transport.  But it should work now with the earlier
stuff out of the way.

-- 
Shawn.
