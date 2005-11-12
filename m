From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] archimport improvements
Date: Sat, 12 Nov 2005 01:23:37 -0800
Message-ID: <20051112092336.GA16218@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 10:24:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Earbs-0004nG-Mv
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 10:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVKLJXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 04:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKLJXk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 04:23:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:31117 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932250AbVKLJXk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 04:23:40 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 56CA92DC03B;
	Sat, 12 Nov 2005 01:23:38 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sat, 12 Nov 2005 01:23:37 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11662>

Hello,

I'm another Arch-user trying out git.  Unfortunately, I encountered
several problems with git-archimport that I needed fixed before my
development trees could be imported into git.

Here's a summary of the changes:

Bug Fixes:

* Support for '--branch'-less Arch version names.
  Encoding '/' to '--' (as was previously done) is not 100% reversable
  because the "--branch" portion of an fully-qualified Arch version name
  is optional (though not many people or Arch-related tools know this).

* I'm encoding the '/' in the fully-qualified name as ',' to not confuse
  other porcelains, but leaving '/' in branch names may be alright
  provided porcelains can support them.

* Identify git branches as an Arch "archive,category<--branch>--version"
  Anything less than that is ambiguous as far as history and patch
  relationships go.

* Renamed directories containing renamed/moved files inside didn't get
  tracked properly.  The original code was inadequate for this, and
  making it support all rename cases that Arch supports is too much
  work.  Instead, I maintain full-blown Arch trees in the temp dir and
  replay patches + rsync based on that.  Performance is slightly slower
  than before, but accuracy is more important to me.

* Permission (execute bit only because of git) tracking as a side effect
  of the above.

* Tracking changes from branches that are only cherry-picked now works

* Pika-escaped filenames unhandled.  This seems fixed in the latest
  git, but I fixed it more generally and removed the ShellQuote module
  dependency along the way.

* Don't die() when a merge-base can't be found.  Arch supports
  merging between unrelated trees.


Usability enhancements:

* Optionally detect merged branches and attempt to import their history,
  too.  Use the -D <depth> option for this.  Specifying a <depth>
  greater than 1 is usually not needed unless the tree you're tracking
  has had history pruned.
  
* Optionally attempt to auto-register unknown Arch archives from
  mirrors.sourcecontrol.net to pull their history with the -a (boolean)
  switch.  Not sure how useful users will find this.

* Removed -A <archive> usage (unnecessary in all cases) and made all
  Arch calls and output parsing to be compatible with both tla (tested
  1.3.3) and baz (1.4.2).  Default is still tla, but the ARCH_CLIENT
  environment variable may be changed to baz.


Current weaknesses:

* (Present in the original code as well).
  The code still assumes that dates in commit logs can be trusted, which is
  fine in most cases, but a wayward branch can screw up git-archimport and
  cause parents to be missed.

-- 
Eric Wong
