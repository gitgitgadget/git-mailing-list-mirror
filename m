From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC 5/5] Support 'master@2 hours ago' syntax
Date: Wed, 17 May 2006 18:32:46 -0400
Message-ID: <20060517223246.GD30313@spearce.org>
References: <20060517095609.GF28529@spearce.org> <7vbqtwhpum.fsf@assigned-by-dhcp.cox.net> <20060517220613.GC30313@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 00:32:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgUZZ-0008KD-Rv
	for gcvg-git@gmane.org; Thu, 18 May 2006 00:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWEQWcv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 18:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWEQWcv
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 18:32:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:21219 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750782AbWEQWcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 18:32:50 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgUZK-0007qg-O8; Wed, 17 May 2006 18:32:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C23CB212667; Wed, 17 May 2006 18:32:46 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060517220613.GC30313@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20247>

Shawn Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> >
> > Also I wonder how much complexity would we suffer and how much
> > efficiency would we gain if we binary search the logdata (the
> > committer info is variable length, so you would need to resync
> > in each step).
> 
> I thought about doing this but did not think it would be worth the
> effort (either developer to code or CPU to execute) at this point
> in time.  I don't think users will be pulling refs from the log very
> often and if they are they will probably be pulling from recent time,
> not very far back.  Thus starting at the end and walking back is
> probably "good enough".
> 
> But if it proves to be too slow in practice I'm sure I can come up
> with a faster way to walk through the log.  :-)

I just ran a test on my PowerBook: walking a 10,000 line log file and
extracting the very oldest commit along.  Each hit on git-rev-parse
seems to took about 100 ms.  Hardly worth worrying about for casual
use.  Further git-rev-parse is taking 73 ms just to run '--verify
HEAD' so an extra 30 ms to read the 10k log is pretty much nothing.

  [spearce@pb15 trash]$ wc -l .git/logs/refs/heads/master 
     10000 .git/logs/refs/heads/master
  [spearce@pb15 trash]$ head -n 1 .git/logs/refs/heads/master 
  b943559a305bdd6bdee2cef6e5df2413c3d30a00 0000000000000000000000000000000000000000 A U Thor <example@example.com> 1136091600 -0500
  [spearce@pb15 trash]$ perl -e 'print scalar(localtime shift),"\n"' 1136091600
  Sun Jan  1 00:00:00 2006
  [spearce@pb15 trash]$ time ../../git-rev-parse --verify HEAD@'300 days'
  warning: Log .git/logs/refs/heads/master only goes back to Thu, 1 Jan 1970 00:00:00 +0000.
  b943559a305bdd6bdee2cef6e5df2413c3d30a00
  
  real    0m0.112s
  user    0m0.029s
  sys     0m0.023s
  [spearce@pb15 trash]$ time ../../git-rev-parse --verify HEAD@'300 days'
  warning: Log .git/logs/refs/heads/master only goes back to Thu, 1 Jan 1970 00:00:00 +0000.
  b943559a305bdd6bdee2cef6e5df2413c3d30a00
  
  real    0m0.105s
  user    0m0.029s
  sys     0m0.023s

-- 
Shawn.
