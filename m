From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Anomaly with the new code - Re: git-svn performance
Date: Fri, 24 Oct 2014 23:34:11 +0000
Message-ID: <20141024233411.GA18655@dcvr.yhbt.net>
References: <1413999510.36832.YahooMailBasic@web172305.mail.ir2.yahoo.com>
 <1414134386.28852.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 01:34:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhoN7-0000bQ-OQ
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 01:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932884AbaJXXeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 19:34:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36409 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932836AbaJXXeM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 19:34:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E4D1FB0B;
	Fri, 24 Oct 2014 23:34:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414134386.28852.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> I keep tabs of a particular svn repository over many years
> and run "git svn fetch --all" every few days. So that's the old clone.
> Since this discussion started, I made a new one with git 2.1.0 patched
> with the first two patches below, a couple of weeks ago. And I ran
> 'git svn fetch --all' on both every few days since.
> 
> I have added a few more patches, so the whole list is the 6
> below against 2.1.0. The latest fetch is really strange - the fetch against
> the new clone took almost twice as long and uses almost twice
> as much memory, vs against the old. 17 min, 800 MB vs 10 min 400MB.
> Details below. Maybe this is a performance issue about how the clones
> were made?

Memory usage seems to grow with the amount of revisions fetched,
see below.  And higher memory means slower fork() on Linux systems.

> 0001-git-svn-only-look-at-the-new-parts-of-svn-mergeinfo.patch    
> 0002-git-svn-only-look-at-the-root-path-for-svn-mergeinfo.patch   
> 0003-git-svn-reduce-check_cherry_pick-cache-overhead.patch        
> 0004-git-svn-cache-only-mergeinfo-revisions.patch                 

> 0006-git-svn-clear-global-SVN-pool-between-get_log-invoca.patch   

0006 is insufficient and incompatible with older SVN.
I pushed "git-svn: reload RA every log-window-size"
(commit dfa72fdb96befbd790f623bb2909a347176753c2) instead
which saves much more memory:

http://mid.gmane.org/20141024225352.GB31716@dcvr.yhbt.net

But there still seems to be some slow growth with many revisions
which is not mergeinfo-related.

> 0007-git-svn-remove-mergeinfo-rev-caching.patch 

I think it is also safe to remove the _rev_list memoization since
it uses a lot of memory.  The remaining caches should be tiny
(but useful, I think).
