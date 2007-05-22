From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [RFC] git-float
Date: Tue, 22 May 2007 15:58:51 +0300
Message-ID: <20070522125851.GC27385@mellanox.co.il>
References: <20070517211805.GA29259@mellanox.co.il> <7v3b1v7z19.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 14:58:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqTwz-0003Fj-QQ
	for gcvg-git@gmane.org; Tue, 22 May 2007 14:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757749AbXEVM6t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 08:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757726AbXEVM6t
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 08:58:49 -0400
Received: from p02c11o142.mxlogic.net ([208.65.144.75]:54085 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481AbXEVM6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 08:58:48 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-5.0.0-2)
	with ESMTP id 709e2564.2204953520.115266.00-014.p02c11o142.mxlogic.net (envelope-from <mst@dev.mellanox.co.il>);
	Tue, 22 May 2007 06:58:47 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.50]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 22 May 2007 15:59:19 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Tue, 22 May 2007 15:57:55 +0300
Content-Disposition: inline
In-Reply-To: <7v3b1v7z19.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 22 May 2007 12:59:19.0376 (UTC) FILETIME=[02B14D00:01C79C71]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-15190.003
X-TM-AS-Result: No--5.881500-4.000000-2
X-Spam: [F=0.0100000000; S=0.010(2007050201); SS=0.500]
X-MAIL-FROM: <mst@dev.mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48104>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [RFC] git-float
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> > Here's a simple script I use to float a commit up the history -
> > similiar to what stg float does if I understand it correctly.
> >
> > Is this a good way to implement it?
> 
> > git-rebase --onto $ref~1 $ref && git-cherry-pick $ref
> 
> Because git-rebase or git-cherry-pick can be interrupted with a
> conflict, this is not a good _implementation_.  The whole script
> needs to have the sequencing and continue logic similar to the
> one git-rebase has.
> 
> > Would it make sense to have something like this in git tree?
> 
> Incidentally, this is closely related to something that people
> have wanted to have for a long time, which is to cherry-pick
> series of commits.
> 
> One step of rebase and cherry-pick can be thought of as a
> "rotate a commit" operation.  When you cherry-pick a commit C on
> top of where you are, the resulting tree is computed by applying
> the commit C's effect to the current tree via 3-way merge.
> 
> 	git-merge-recursive C^ HEAD C
> 
> git-rebase without -m does the equivalent of the above "rotate a
> commit" operation using patch + apply (and fall back to merge if
> the patch does not cleanly apply) for performance reasons, but
> the principle is the same.  And the commit message for the
> result is taken from C itself.
> 
> git-rebase can be decomposed into three stages:
> 
>  (1) find the sequence of commits to reapply;
> 
>  (2) find the commit to start rebuilding onto and reset to it;
> 
>  (3) one by one, rotate the commits you found in (1), with
>      the sequencing support (--abort, --skip and --continue).
> 
> There is no reason, other than the fact that there is no other
> commit rotator in git suite that needs sequencing, that these
> three needs to be in a single program git-rebase.
> 
> The only difference with the above outline and your float is
> that after you finish step (1), you record "this commit also
> needs to be replayed at the end" information to the sequence.
> 
> The implementation of cherry-pick that takes commit range is
> also obvious; instead of the computation git-rebase does for
> step (1) above, we would allow arbitrary series of commits to be
> specified from the command line (most likely using the revision
> list notation A..B) to be replayed with the sequencing
> machinery.

So to summarize: you suggest creating a new low-level command
that gets a list of commits and applies them, with
the sequencing support (--abort, --skip and --continue).
Then rewrite both cherry-pick and rebase on top of these,
implement git float (and maybe git kill which does just
git-rebase --onto $1~1 $1 I posted at some point) on top
of this as well.

-- 
MST
