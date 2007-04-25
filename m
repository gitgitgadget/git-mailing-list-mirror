From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch and unannotated tags
Date: Wed, 25 Apr 2007 14:00:53 -0700
Message-ID: <7vfy6ow4my.fsf@assigned-by-dhcp.cox.net>
References: <200704252004.45112.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
	<200704252142.33756.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:01:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgoc7-0001Pp-Pj
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 23:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbXDYVAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 17:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbXDYVAz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 17:00:55 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62056 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbXDYVAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 17:00:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425210054.IBAK1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 17:00:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rZ0s1W00h1kojtg0000000; Wed, 25 Apr 2007 17:00:53 -0400
In-Reply-To: <200704252142.33756.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 25 Apr 2007 21:42:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45576>

Andy Parkins <andyparkins@gmail.com> writes:

>> You could even modify git-tag to create them for you with some
>> appropriate switch ...
>
> Well yes, but that's the answer to everything isn't it?

The answer to everything you want to change the current
behaviour is to code something that implement that change.  What
else is new?

I suspect that if you look at what git-fetch.sh does in the
paragraph that follows /^# automated tag following/, it probably
is not that much change.  At that point,

 (1) $ls_remote_result contains the output from "git ls-remote $URL"
     we ran earlier, LF and everything intact.

 (2) show-ref --exclude-existing=refs/tags/ discards, out of
     $ls_remote_result, everything that does not begin with refs/tags/,
     and at the same time, discards the ones you already have.
     This is done after stripping away ^{} markers.

 (3) The remainder is fed to the while loop, which says "if we
     already have the object pointed at by a surviving ref under
     refs/tags/ in the remote, follow that tag".

So I think you could filter out the ones that do not have
corresponding ^{} in $ls_remote_result from the while loop.  As
the use of "show-ref --exclude-existing" is to speed things up
by reducing the work done in the while loop written in shell, I
would suggest giving another option to show-ref that can be used
together with --exclude-existing.

Take a look at exclude_existing() function in builtin-show-ref.c;
your additional option to the command would say something like:

  - ignore everything that do not begin with match (as we do now
    already);

  - if we do not have the ref we read from the stdin (determined
    with the call to path_list_has_path() there), instead of
    running printf() unconditionally as we do now, make sure we
    have both refs/tags/foo and refs/tags/foo^{} in the input.
    And show only those.
