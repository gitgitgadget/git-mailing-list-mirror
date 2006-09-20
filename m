From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 12:49:12 -0400
Message-ID: <20060920164912.GD23260@spearce.org>
References: <20060919232851.GA12195@spearce.org> <7vac4ujzf0.fsf@assigned-by-dhcp.cox.net> <20060920161407.GQ8259@pasky.or.cz> <20060920162145.GA23260@spearce.org> <7v1wq6jy3q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 20 18:52:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5I2-0003XU-St
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbWITQtc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWITQtc
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:49:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45211 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751943AbWITQtT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:49:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ5G0-00052r-0H; Wed, 20 Sep 2006 12:49:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9A29320E48E; Wed, 20 Sep 2006 12:49:12 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wq6jy3q.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27376>

Junio C Hamano <junkio@cox.net> wrote:
> I realize I am going around in circles, but Pasky's "remotes/"
> argument made me realize that this mirroring is not much more
> than "fetch --force --all".  I initially had an impression that
> this was for only strict mirroring where you do not even want
> your own "origin", but if you arrange the .git/remotes/origin
> file the right way, "fetch --force --all" (if you remembered to
> put '+' in front of the refspecs, even without --force) would
> what --mirror-all would do wouldn't it?

I started this change with '--all' and realized that ideally you
want '--all' to copy all available refs/heads/* from the remote to
refs/remotes/<name>/* here.  You want to create any new branches
which the remote has introduced since your last fetch.

You probably don't want to force a non-fast forward unless there's a
'+' in the corresponding Pull line of remotes/<name> or if --force is
used.  However you probably also want to delete any removed branches.

Which I think is quite different from a mirror.  A mirror wants to
replace the entire ref namespace with what's on the remote as it
has no need for a local namespace of its own.


Originally I gave Pasky a one-liner on #git:

  git fetch --force origin $(git ls-remote origin \
      | awk '{if(!/\^{}$/){print $2":"$2}}')

but he expressed interest in it being a native feature of the
core-Git fetch Porcelain.  To be honest I disagreed with him but
submitted the patch anyway.

I think --all copying into .git/refs/remotes/<name>/* makes perfect
sense.

And I think this mirror thing may make more sense as a small wrapper
around git-fetch.  A wrapper that checks for:

	- its running in a bare repository;
	- it has a single remote named origin;
	- HEAD isn't a symlink or a symref (its a normal ref in its
	  own right);
	- git-mirror.permitted is true in the config file.
 
-- 
Shawn.
