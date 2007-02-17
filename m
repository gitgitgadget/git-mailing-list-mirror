From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for disconnected transfer
Date: Fri, 16 Feb 2007 22:57:55 -0800
Message-ID: <7vfy95w9sc.fsf@assigned-by-dhcp.cox.net>
References: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
	<7vhctl50zc.fsf@assigned-by-dhcp.cox.net>
	<45D63C7A.4050300@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 07:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIJWB-0005nk-Ms
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 07:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbXBQG55 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 01:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946429AbXBQG55
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 01:57:57 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61631 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965051AbXBQG54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 01:57:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217065757.BPPN1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 17 Feb 2007 01:57:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QWxv1W00L1kojtg0000000; Sat, 17 Feb 2007 01:57:56 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39970>

Mark Levedahl <mdl123@verizon.net> writes:

>> Wouldn't it be nice if you can treat a bundle as just a
>> different kind of git URL that you can "git fetch"?
>>
>> 	$ git fetch file.bdl 'refs/heads/*:refs/heads/*'
>>
> yes
>...
>
> As long as I can still do a "git fetch file.bdl" and without having to
> do the config stuff. I'm happy.

I do not think your patch (original or respun) checks if it is
overwriting the current branch.  Even if it is a fast forward,
it should check this condition and prevent the end user from
getting confused.  The above sample command line you quoted from
my message can potentially have the same problem, but "git
fetch" checks and refuses.

Even when the "remote" is not a bundle file, it sometimes is
useful to store the refs as they are without mapping them to
remotes hierarchy as the separate-remote layout does.  An
obvious use case is to mirror another repository as is.  So it
may make sense to teach --mirror to "git-fetch" so that you can
say:

	$ git fetch --mirror file.bdl

which would be a short-hand to say:

	$ git fetch file.bdl 'refs/*:refs/*'

A final note.  A real 'mirror' mode should also remove stale
refs that do not exist on the remote side anymore, which is a
different use case as your bundle, which presumably is primarily
meant to carry not all but only selected set of refs, and most
likely not the 'master' branch head (and I am guessing that that
is why you forgot to make sure you are not overwriting the
current branch in the unbundle script).  A real 'mirror' mode
would use a separate option to remove a ref that does not exist
on the remote end anymore, like:

	$ git fetch --mirror-all git://git.kernel.org/pub/scm/git/git.git/
