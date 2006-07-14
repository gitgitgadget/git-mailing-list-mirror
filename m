From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 19:21:20 +0100
Message-ID: <1152901280.3191.82.camel@pmac.infradead.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
	 <1152840456.31372.75.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0607132251310.5623@g5.osdl.org>
	 <1152869915.3191.12.camel@pmac.infradead.org>
	 <7v64i0qd4d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 20:21:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1SII-0005Jv-HZ
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 20:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbWGNSVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 14:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWGNSVj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 14:21:39 -0400
Received: from canuck.infradead.org ([205.233.218.70]:26602 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1422696AbWGNSVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 14:21:39 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1G1SIC-0003MR-1I; Fri, 14 Jul 2006 14:21:36 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64i0qd4d.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23905>

On Fri, 2006-07-14 at 11:01 -0700, Junio C Hamano wrote:
> David Woodhouse <dwmw2@infradead.org> writes:
> 
> > Yet what I actually want in the final result is "those commits which
> > change the result of the _exported_ headers". It's slightly less
> > realistic to want rev-list to find that for me directly from the
> > original kernel tree without having done the export step in stage1 --
> > what I need to do is create the exported header tree for each commit
> > which _might_ change it, then filter out the commits which don't
> > _actually_ change it.
> >
> > The extra commits in the stage1 branch are cheap enough -- by definition
> > they don't lead to any extra tree or blob objects. I think the two-stage
> > export is probably the best approach, unless I'm missing something.
> 
> Since you are not building an exact parallel history with the
> same topology (you are trying to cull the commits in the new
> tree that do not change the resulting header files), I do not
> see much point in the parent conversion loop in the first script
> to compute CONVERTEDPARENTS.
> 
> How about making it simpler?
> 
> 	* Keep the current HEAD of the "headers" branch at in
>           refs/heads/kernel-headers
> 
> 	* Whenever you see $UPSTREAM_GITDIR/refs/heads/master
>           changes, you do your converttree to come up with the
>           new header tree
> 
> 	* See if the resulting tree changed by doing something
>           like this:
> 
>                 TREE=`converttree $INCDIR $KBUILDASMSHA`
>                 case "`git diff-tree --name-only kernel-headers $TREE`" in
>                 '')
>                         # No changes in the result
>                         exit
>                 esac
> 
> 	  Stop processing here if there is no change.
> 
> 	* Make a new commit, with its parent set to the current
>           value of refs/heads/kernel-headers, perhaps with the
>           same message as $UPSTREAM_GITDIR/refs/heads/master
>           has as you do already.
> 
> 	* Advance refs/heads/kernel-headers only when you
>           actually make a new commit.

Unless I'm misunderstanding, I then don't get a tree with a topology
which matches Linus' tree -- I just get a series of snapshots, and it's
dependent on the timing of my cron jobs.

That means that there isn't a 1:1 relationship between any commit in the
slave tree and a corresponding commit in the upstream tree, and that the
slave tree can't (sensibly) be reproduced.

I'd much rather keep it the way it is -- but I'm certainly interested in
ways that I could simplify the process of generating what I have at the
moment.

> I would further suggest to record the value of the upstream
> commit object name, $UPSTREAM_GITDIR/refs/heads/master,
> somewhere in the commit message, by using "git describe".  This
> will help people who use your converted headers to know which
> released version of the Linus kernel the headers correspond to,
> and also help you notice when the upstream is updated during the
> next run.

Yeah, that was already suggested. I'll do that.

-- 
dwmw2
