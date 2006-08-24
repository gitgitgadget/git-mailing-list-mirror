From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 1/x] gitweb: Use git-diff-tree patch output for commitdiff
Date: Wed, 23 Aug 2006 19:15:49 -0700
Message-ID: <7v3bbmhoa2.fsf@assigned-by-dhcp.cox.net>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 04:15:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG4l8-0006oA-8e
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 04:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWHXCPv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 22:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWHXCPv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 22:15:51 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61913 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030197AbWHXCPu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 22:15:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060824021550.VMNE18458.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 Aug 2006 22:15:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id DeFp1V00F4Noztg0000000
	Wed, 23 Aug 2006 22:15:49 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608240015.15071.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 24 Aug 2006 00:15:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25939>

Jakub Narebski <jnareb@gmail.com> writes:

> Converting "blobdiff" and "blobdiff_plain" format would be much easier
> if git-diff-tree and friends had -L <label>/--label=<label> option,
> like GNU diff has.

I am not sure how that would be useful, given that you would
disect the header line-by-line to colorize anyway.

> Current patch preserves much of current output; the question is if for
> example generate if 'plain' format should generate patch which could
> be appplied by ordinary patch which do not understand git diff
> extensions (including renaming and copying), as it is done in current
> version, and if 'html' version should detect renames and copying.

I would say html is definitely for human consumption; does
anybody cut&paste html patch and expect to apply that?  Plain
format I am easy but probably enabling rename is fine.  You can
edit the header or tell patch to apply to which file anyway, and
I think the value of being able to view the real changes outweigh
that inconvenience.

>  * "commitdiff" now products patches with renaming and copying
>    detection (git-diff-tree is invoked with -M and -C options).

You do not have to give -M and -C; a single -C is enough.
I wonder if -B is also useful as a default (i.e. -B -C).

For a merge, I often would want to see --cc just like gitk does,
but it is probably just me.

I do not know we would want to slurp the entier diff in an
array before processing.  Is this easy to streamify by passing
an pipe fd to the formatting sub?

>    Empty patches (mode changes and pure renames and copying)
>    are not written currently.

That's quite bad.

>  * "commitdiff" output is now divided into several div elements
>    of class "log", "patchset" and "patch".
>
>  * "commitdiff_plain" now only generates X-Git-Tag: line only if there
>    is tag pointing to the current commit.

Hmph...

>    ...; besides we are
>    interested rather in tags _preceding_ the commit, and _heads_
>    following the commit.

Interesting observation.  When somebody says "feature X was
introduced in such and such commit", people would want to know (1) the
point release they are using has the feature -- which means you
would want to know the earliest tag that comes after the commit,
or (2) if the branch they are working on already has that
feature -- which again means if the head follows the commit.  So
I am not sure when preceding tag is interesting...
