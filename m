From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Delete ref $frotz by moving ref file to "deleted-$frotz~ref".
Date: Tue, 17 Oct 2006 01:07:14 -0400
Message-ID: <20061017050714.GA21210@spearce.org>
References: <20061014153949.2994a114.chriscool@tuxfamily.org> <7vr6xa91kj.fsf@assigned-by-dhcp.cox.net> <200610170626.25654.chriscool@tuxfamily.org> <7v4pu3tuye.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 07:07:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZhB7-0005hZ-QX
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 07:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423091AbWJQFH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 01:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423092AbWJQFH1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 01:07:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:5100 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1423091AbWJQFHY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 01:07:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GZhAc-0005xc-UQ; Tue, 17 Oct 2006 01:07:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CD12620E42A; Tue, 17 Oct 2006 01:07:14 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pu3tuye.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29020>

Junio C Hamano <junkio@cox.net> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
> > For example, when git becomes a major SCM, there may be people working on 
> > big projects that want to create a new branch for each new bug and then 
> > delete the branch when the code on the bug branch has been integrated into 
> > a new release and the bug is closed.
> 
> I would say that is a very valid way to work with git,
> regardless of the size of project.  Now, how often would you
> create such a per-bug branch and delete one, compared to the
> number of operations that would require ref lookups?  Your
> example actually supports what I've said -- optimizing for
> deletion at the cost of more expensive lookups is wrong.

I agree completely with Junio.  I make a lot of temporary "throw
away" branches in Git; often they live on disk for 5/10 minutes at
most before getting deleted again.  I also make a smaller number
(but still significant) of longer lived branches that hang around
for days or weeks before getting deleted.

In the former case (throw away) I wouldn't want those refs added
to the packed refs file.  They just don't live around long enough
to make it worth it.  And when I delete them I want them gone.
So moving them off to a 'deleted-refs' directory to indicate they
are gone is just delaying the removal.  Not something I want.

In the latter case (longer lived) I don't mind if I have to sit
though an extra 500 ms to rewrite the entire packed refs file
during a ref delete operation.  I lived with the branch for weeks;
I can probably spare a second to finally get rid of it once its
gone upstream.  Heck, the push to move that branch upstream might
actually take longer to unpack the loose objects contained on that
branch than the packed ref delete, even on 1000s of refs.
 
> If the goal is to optimize for deletion path, then that is
> true.  My point is that we do not want to optimize for deletion
> path at the expense of more costly lookup path.

Absolutely.  I figure I do ref lookups at least 3x the number of ref
deletes I perform.  And that's just thinking about the sequence of
commands I commonly perform against my "throw away" branches which
live for at most 10 minutes, let alone my longer lived branches
that hang around for weeks.

-- 
Shawn.
