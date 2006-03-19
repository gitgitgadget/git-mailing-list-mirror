From: Shawn Pearce <spearce@spearce.org>
Subject: Re: efficient cloning
Date: Sun, 19 Mar 2006 17:31:12 -0500
Message-ID: <20060319223111.GA20464@spearce.org>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 19 23:31:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL6Ql-0001Oq-Sc
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 23:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWCSWbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 17:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWCSWbU
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 17:31:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:17635 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751122AbWCSWbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 17:31:20 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FL6QT-0002T3-NR; Sun, 19 Mar 2006 17:31:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2024A20FBA0; Sun, 19 Mar 2006 17:31:12 -0500 (EST)
To: James Cloos <cloos@jhcloos.com>
Content-Disposition: inline
In-Reply-To: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17732>

James Cloos <cloos@jhcloos.com> wrote:
> Is there a way to accomplish the effect of this script w/o having to
> download any unnecessary objects?
> 
> ==================================================
> #!/bin/bash
> 
> lt="/gits/linux-2.6/.git"
> 
> if [ $# -ne 2 ]; then
>     echo >&2 "Usage: $0 <repo> <target-dir>"
>     exit 1
> fi
> 
> git-clone $1 $2
> mkdir -p $2/objects/info
> {
>  test -f "$lt/objects/info/alternates" &&
>  cat "$lt/objects/info/alternates";
>  echo "$lt/objects"
> } >"$2/objects/info/alternates"
> 
> cd $2
> git-repack -a -d -s
> git-prune-packed
> ==================================================
> 
> I tried to modify git-clone to add an alternates file before calling
> fetch, but that file just gets deleted.
> 
> I presume I need to clone -s -l the local alternate, re-parent it to
> the new URL and grab anything missing, but how can I assure that it
> results in exactly the same repo as this script?

Exactly right.  There was some discussion about this perhaps just
two weeks back and it become clear that the easiest way to clone
through a thin straw is to use `git clone -s -l' from a locally
available repository which is ``close''[*1*] to the remote you are going
to actually trying to clone from, edit .git/remotes/origin to have
the correct URL: and Pull: lines, then `git-pull origin' to bring
down whatever you don't have yet.  This won't miss any objects so
it will result in the same repository as a clone would have[*2*].

Footnotes:

  [*1*] Here ``close'' means probably related to the same project.
  Meaning if you are cloning the Linux kernel at least start with
  another kernel repository and not say the GIT repository.  :-)
  The more your original repository has in common with the remote you
  are trying to pull from the less that will need to be downloaded.

  [*2*] This isn't entirely true.  During a normal clone everything
  is pulled down into a single pack. Using this strategy the missing
  objects that are downloaded will be loose; a git-repack after
  the pull might be a good idea to pull them into a pack.

-- 
Shawn.
