From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (take 2)] gitweb: Do not parse refs by hand, use git-peek-remote instead
Date: Thu, 14 Sep 2006 23:15:31 -0700
Message-ID: <7v4pv91wqk.fsf@assigned-by-dhcp.cox.net>
References: <200609142327.23059.jnareb@gmail.com>
	<7v8xkm2gfs.fsf@assigned-by-dhcp.cox.net>
	<200609150343.28334.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 08:15:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO6zI-0007dF-3I
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 08:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWIOGPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 02:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWIOGPd
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 02:15:33 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:20456 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750805AbWIOGPc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 02:15:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060915061531.CJBN21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 Sep 2006 02:15:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NWFY1V00i1kojtg0000000
	Fri, 15 Sep 2006 02:15:33 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609150343.28334.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 15 Sep 2006 03:43:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27061>

Jakub Narebski <jnareb@gmail.com> writes:

> This is in response to Linus work on packed refs. Additionally it
> makes gitweb work with symrefs, too.
>
> Do not parse refs by hand, using File::Find and reading individual
> heads to get hash of reference, but use git-peek-remote output
> instead.

Looks nicer.  Will apply.

Now, once we start doing this, it may make sense to rethink how
this function and git_get_references functions are used.  I
think

	git grep -n -e '^sub ' \
        	-e git_get_references \
                -e git_get_refs_list gitweb/gitweb.perl

would be instructive how wasteful the current code is.

get_refs_list is called _TWICE_ in git_summary and worse yet
very late in the function, after calling git_get_references that
could already have done what the function does (by the way,
git_get_references already knows how to use peek-remote output
but for some reason it uses ls-remote -- I think you can safely
rewrite it to use peek-remote).  So you end up doing peek-remote
three times to draw the summary page.

git_get_references are called from almost everywhere that shows
the list of commits, which is understandable because we would
want to see those markers in the list.

I very much suspect that you can use git_get_refs_list to return
a hash and a sorted list at the same time from the same input
and make git_summary to do with just a single call to it, and
get rid of git_get_references with a little bit of restructuring
of the caller.

Hmm?
