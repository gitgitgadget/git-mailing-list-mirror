From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-p4import.py robustness changes
Date: Mon, 4 Jun 2007 01:54:33 -0400
Message-ID: <20070604055433.GD4507@spearce.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org> <7vzm3inisa.fsf@assigned-by-dhcp.cox.net> <200706031511.31157.simon@lst.de> <839AEF71-ED29-4A79-BE97-C79EAFEDC466@slamb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Hausmann <simon@lst.de>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 07:54:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv5Wi-0007tx-GA
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 07:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbXFDFyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 01:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbXFDFyl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 01:54:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44679 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbXFDFyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 01:54:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hv5WV-0003Yc-1T; Mon, 04 Jun 2007 01:54:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B5D5A20FBAE; Mon,  4 Jun 2007 01:54:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <839AEF71-ED29-4A79-BE97-C79EAFEDC466@slamb.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49062>

Scott Lamb <slamb@slamb.org> wrote:
> On Jun 3, 2007, at 6:11 AM, Simon Hausmann wrote:
> >On the topic of git integration with perforce, what are the chances  
> >of getting
> >git-p4 ( http://repo.or.cz/w/fast-export.git ) into git's contrib/ 
> >fast-export
> >area? :)
> 
> I missed that one...I just saw Tailor and the Perl script someone  
> else had written.

Perhaps why it should be in contrib/fast-import?  ;-)
 
> As for performance...hmm. Looks like git-p4import.py runs these  
> commands for each Perforce revision:
> 
>     realtime  operation
>         3.4%  p4 describe -s N
>        66.6%  p4 sync ...@N
>    [*] 10.2%  git ls-files -m -d -o -z | git update-index --add -- 
> remove -z --stdin
>         2.6%  git rev-parse --verify HEAD
>         4.2%  git write-tree
>         2.8%  git commit-tree xxxxxx
>         7.5%  git tag -f p4/N xxxxxx
>         2.7%  git update-ref HEAD xxxxxx
...
> git-p4 seems to use "git fast-import". I guess the big performance  
> improvement there is removing the ls-files operation? So we're  
> talking about a 0-10% speedup, right? Plus some fork()/exec() overhead.

fast-import folds all of the git commands you list above behind
a single engine that is *fast*.  So its actually a 0-30% gain
that is available by using the fast-import backend, with a single
fork()/exec() for the *entire import*.  The local object IO performed
by Git is also minimized, so large imports have much better IO
behavior from the Git perspective.  Its not something to sneeze at.

fast-import also can run in parallel with the frontend process,
allowing you to use a dual-core system, to the extent that your
disk(s) and network can keep up.  Generally p4 is going to be
the bottleneck.

I think writing data to fast-import is much easier than running
the raw Git commands, especially when you are talking about an
import engine where you need to set all of the special environment
variables for git-commit-tree or git-tag to do its job properly.
Its a good tool that simply doesn't get enough use, partly because
nobody is using it...

-- 
Shawn.
