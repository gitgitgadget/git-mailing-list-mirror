X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git reflog expire
Date: Tue, 19 Dec 2006 02:15:39 -0800
Message-ID: <7vhcvsry2c.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
	<7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
	<20061218140813.GA32446@spearce.org>
	<7vy7p4u1au.fsf@assigned-by-dhcp.cox.net>
	<7v64c8thr4.fsf@assigned-by-dhcp.cox.net>
	<20061219090851.GH2511@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 10:15:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061219090851.GH2511@spearce.org> (Shawn Pearce's message of
	"Tue, 19 Dec 2006 04:08:51 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34810>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gwc0e-0005tU-0S for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932757AbWLSKPl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbWLSKPl
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:15:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51217 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932757AbWLSKPk (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 05:15:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219101540.THFC16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 05:15:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0aFs1W0011kojtg0000000; Tue, 19 Dec 2006
 05:15:52 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Of course that's not what the code does, because if either the
> old or the new object is no longer in the ODB you are pruning away
> the log entry.  I cannot however come up with a better name than
> --expire-lost.  :-(

How about --expire-unreachable?

> I'm thinking that we may want the 'expire' subcommand to simply be
> implied by '--expire' instead.

After coding this, my conclusion is the same as yours, but
reasoning behind it is slightly different.

To have 'expire' action as a subcommand to 'git-reflog' is from
implementor's point of view, and is a horrible organization from
the UI standpoint.  To the end users, it may be easier to have a
single 'git-gc' command that runs these commands with reasonable
set of defaults:

	- rerere gc
        - reflog expire --all
	- (possibly) repack -a -d
        - prune

If we go that route, it probably is not even necessary to
advertise that 'expire' is a subcommand of reflog.  The users
would not run it from the command line; it is an implementation
detail of 'git-gc' command.

> Needing a subcommand like 'git reflog show HEAD' is just a lot
> of typing[*1*].

I am very interested in seeing how 'git reflog show HEAD' would
show the reflog entries.  I've tried showing it just like log
family shows (it is reasonably easy; you build the list of revs
out of reflog entries and feed them to 'git-show' machinery),
and while it works, it is unusable for the purpose of seeing
which ones are the lost ones (amended commits and rebased branch
remnants).

The best I came up with is still my "show-branch --reflog" so
far.  You really need to show not just the commit title but how
they topologically relate to the commits on the surviving
branch, and I think having something graphical or semi-graphical
is a must.

> I would also say maybe we want to make --dry-run the default, with
> a final message which tells the user that if they really want to
> make it possible to throw away the commits printed above then
> restart the expire operation.

I am moderately negative on that.  Nobody does it like that;
prune, branch -d, tag -d,...

> I'd like to take a stab at the log display code for the reflog
> command, but I'd also really like to port forward (aka rewrite)
> that mmap window code I keep saying I'll work on, but never quite
> seem to do...

After today's pread() thing, I was also wondering about that too
;-).
