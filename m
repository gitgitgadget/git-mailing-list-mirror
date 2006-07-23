From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Random Git Issues/Wishlist
Date: Sun, 23 Jul 2006 00:27:25 -0400
Message-ID: <20060723042725.GA12306@spearce.org>
References: <20060722195502.GS13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 23 06:27:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4VZD-0005Xw-Jq
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 06:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWGWE1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 00:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWGWE1g
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 00:27:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:24725 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751093AbWGWE1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 00:27:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G4VYt-0006Kv-Px; Sun, 23 Jul 2006 00:27:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EA5D220FB77; Sun, 23 Jul 2006 00:27:25 -0400 (EDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060722195502.GS13776@pasky.or.cz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24084>

Petr Baudis <pasky@suse.cz> wrote:
>   (iii) Lazy clone, shallow clone, whatever you call it. This has
> several possible degrees of implementation:

I'd love to work on this, but I just don't have time.  :-(
 
>   (vi) Renames - should we follow them in logs? Will we? When? How
> exactly in the interesting cases?

I thought this has been settled as ``we will not record renames
directly, but instead rely on after-the-fact comparsions to identify
renames and copies based on content similarity''.

The rename identification code in diffcore isn't the fastest, but
I think someone suggested caching the results of rename comparsions
under .git as a way of speeding that up.  Unfortunately nobody has
stepped forward with a reasonable caching implementation, and I
think it was also debated that caching is probably not worthwhile
due to the high number of permutations people would typically be
asking for from diffcore.
 
>   (viii) Patches versioning in StGit - many people I've told about StGit
> complained that it doesn't version patches (and possibly moved to mq?).
> We should have some scheme for doing meta-history (especially
> interesting when/if we aim to make altering history easy).

Doesn't StGit now have a single ref for every patch commit?
What about turning on reflog support on those refs and reading the
reflog for the ``history'' of that patch?  Granted the reflog isn't
prune proof but it is a history of that ref's values over time.

You can already go back in that history with the @{yesterday}
syntax (e.g. "HEAD@{yesterday}") anywhere a sha1 expression is
valid (e.g. git-log) but StGit doesn't take advantage of it.
 
>   (xii) Special merging - I now maintian the SuSE glibc package in git
> and I'd like to use something more sensible than diff3 merger for
> merging the changelogs from various branches; it's trivially solvable
> conflicts all the time

I've been waiting for the C based recursive merger to get stable
before I take a crack at parameterizing the `merge` invocation.
I much prefer using patch reject files for conflict resolution,
but that's just me.  (Besides opening a single patch process and
shoving a stream of all diffs at it is faster on Cygwin than forking
30+ merge processes for 30 files with conflicts.)

I take it you are really asking for a way to parameterize the 3 way
merge tool on a file-by-file basis, e.g. adding to the config file:

	[mergetool "default"]
		program = merge %real %stage1 %stage3
		real = stage2

	[mergetool "ChangeLog"]
		program = change-log-merger %stage1 %stage2 %stage3 %real

	[mergetool "some/bad/binary-file"]
		program = cp %stage2 %real

An issue with storing this data in the config file is what happens
if the stuff stored at the path "some/bad/binary-file" changes such
that simply using `cp` (as above) is horribly wrong.  Another is how
do you pass these "reasonable defaults" off to other team members
on a repository-by-repository basis, assuming you all have access
to the same tools (e.g. the change-log-merger mentioned above).

-- 
Shawn.
