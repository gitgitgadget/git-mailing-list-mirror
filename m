From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and time
Date: Sat, 30 Sep 2006 00:50:37 -0400
Message-ID: <20060930045037.GB18479@spearce.org>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com> <Pine.LNX.4.64.0609272232040.9349@xanadu.home> <7vfyec63jx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0609281029300.9349@xanadu.home> <7vd59ejokp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 30 06:51:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTWp4-0001AU-U8
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 06:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWI3EvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 00:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWI3EvT
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 00:51:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49588 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750845AbWI3EvS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 00:51:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GTWoG-0008G9-Uv; Sat, 30 Sep 2006 00:50:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D7E3A20FB28; Sat, 30 Sep 2006 00:50:37 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd59ejokp.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28138>

Junio C Hamano <junkio@cox.net> wrote:
> The more I think about this, if we were to add yet another
> command, I think it should be a command that lets us inspect
> ref-log.  We do not have an UI other than @{time} syntax to
> interact with it right now.

Agreed.  I've been missing such a command and have wanted to add
one but it wasn't important enough to me to actually code it.  :)
 
> What are the things we would want?  Here is a strawman.
> 
>  - List when and how a branch was changed.
> 
>    git ref-log --list --type=merge next (when did I merge into my 'next'?)
>    git ref-log --list --type=merge (ditto but any branches)
>    git ref-log --list next (any changes not just 'merge')
> 
>    I expect the output would give timestamp and reason comment;
>    in addition the branch name when no branch is specified.
>    Type does not have to be a concrete thing -- it could just be
>    a substring match in the reason comment string.

What about --grep=pat instead of --type?

You are talking about essentially the same behavior as
`git log --grep=pat` except applying it to the message
in the reflog rather than to message in the commits.

Also I think that this should be the default behavior
and thus --list shouldn't be an option.  This matches
git-log's default behavior to just show whatever is
in the named branches.

>    Also we would limit output with -n <limit>.

I'd limit with "--max-count=<n>" like we do with git-log.

>    The output
>    should be sorted by the timestamp of ref-log entry -- we are
>    talking about a particular repository's ref-log, so its
>    timestamp has more sane meaning than in distributed case.

Agreed, sorting newest -> oldest so newest displays first, much as
git-log does.  This way its order of operation, much as git-log is
order of operation.

If multiple branches are specified we really should interleave the
various reflogs according to timestamps, to show the "global picture"
of what happened in this repository.

>  - Find which branches currently contains a commit, and find the
>    earliest time that the commit became part of each of them.
> 
>    git ref-log $commit next master (when did it enter 'next' and
>                                     when did it graduate to 'master'?)
>    git ref-log $commit (ditto but any branches)

Since I'm suggesting above that this behavior not be the default
what about:

    git ref-log --arrive=$commit next master
    git ref-log --arrive=$commit
?

>    I expect the output to be the timestamp and reason comment;
>    in addition the branch name when no branch is specified.

Agreed.

> Also for a shared repository, the person who made the change
> would be a reasonable thing to report.

I think that should be shown no matter what; even if
core.sharedRepository is false.

> So for consistency, in all cases we could make the output
> format like this:
> 
>     branch SP time-and-zone SP name SP email SP reason-comment LF

That's too long of a line with most reason-comments in the ref-log.
Especially ones that come from git-commit, and especially if they
were human written commit messages.

I'd like to see the output be more like git-log.  Allow a --pretty
option with a few useful formats:

  --pretty=full:
     branch branchname LF
     from old
     to new
     Modifier: name SP email
     Date: time-and-zone

         reason-comment

  --pretty=oneline:
     branchname SP time-and-zone SP name SP email SP reason-comment LF

  --pretty=raw is obviously the exact line in the reflog but with
  the branch name preceeding it if more than one branch was specified
  or none were specified.

And --pretty=full should be the default, much as --pretty=medium
is with git-log.

-- 
Shawn.
