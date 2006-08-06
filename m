From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/6] gitweb: Simplify git_diff_print
Date: Sun, 06 Aug 2006 02:26:20 -0700
Message-ID: <7v8xm2b4g3.fsf@assigned-by-dhcp.cox.net>
References: <200608060206.49086.jnareb@gmail.com>
	<200608060211.38604.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 11:26:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9etx-0002Oj-M1
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 11:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWHFJ0X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 05:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWHFJ0X
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 05:26:23 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:30937 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750726AbWHFJ0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 05:26:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060806092622.QUCH12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Aug 2006 05:26:22 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608060211.38604.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 6 Aug 2006 02:11:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24969>

Jakub Narebski <jnareb@gmail.com> writes:

> Copy to temporaty file more directly, not using temporary variable @file.
> Use list form of open for diff invocation (we cannot use git-diff because
> first it doesn't support -L/--label option, and we cannot generate diff
> between /dev/null and blob given by it's sha1 identifier). 
>
> Use "local $/ = undef;" for (temporary) slurp mode.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

I think this part of the gitweb code predates the git-diff
support by the core level.  If I recall correctly, back then we
did not even have "git-diff-{tree,files,index}" when this part
was written.

I think you could use "git-diff $from $to" instead of using
temporary files and running /usr/bin/diff on it with today's
git.  Which is a big win from both security and ease of
administration point of view.  Not having to write anything into
temporary file from gitweb.cgi means you do not have to worry
about stray gitweb process leaving temporary files dangling
behind, for example.

You obviously would need to emulate the -L$from_name -L$to_name
part by hand in the loop that reads from the diff output.

One worrysome pathological case is what happens if files being
tracked happen to have names that consist of 40-byte hexdigits.
I think "git-diff $from $to --" should do the right thing for
gitweb use ($from and $to should not mistaken taken as pathnames
with the explicit -- disambiguator) and "git-diff -- $from $to"
also should do the right thing to take $from and $to as pathnames
even if there are revisions with the same object names, but
somebody may want to verify that (and send patches to fix if it
is not the case).
