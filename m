From: Junio C Hamano <junkio@cox.net>
Subject: Re: Initial support for cloning submodules
Date: Sat, 05 May 2007 01:46:42 -0700
Message-ID: <7vmz0jk68d.fsf@assigned-by-dhcp.cox.net>
References: <11782762032207-git-send-email-skimo@liacs.nl>
	<7vfy6cqk0w.fsf@assigned-by-dhcp.cox.net>
	<20070505081404.GR955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 05 10:47:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkFvd-0004w3-Se
	for gcvg-git@gmane.org; Sat, 05 May 2007 10:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbXEEIqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 04:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbXEEIqp
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 04:46:45 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42262 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466AbXEEIqo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 04:46:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070505084643.RGDM1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 5 May 2007 04:46:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vLmj1W0081kojtg0000000; Sat, 05 May 2007 04:46:43 -0400
In-Reply-To: <20070505081404.GR955MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Sat, 05 May 2007 10:14:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46253>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Fri, May 04, 2007 at 03:52:15PM -0700, Junio C Hamano wrote:
>> I do not like the Porcelain part very much, though.  I do not
>> think we would want to add anything new to git-clone.  We should
>> lose as much code from git-clone that is common with git-fetch
>> as we can first, and add new features to git-fetch, with
>> possibly passthru options added to git-clone as needed (e.g. a
>> new --submodule option).
>
> So what would you want to keep in git-clone ?

 - Figuring out the name of the new directory we create (think
   "git clone git://repo.or.cz/git.git" -- it does "mkdir git &&
   cd git" for you before doing the other things).

 - Run "git init" there, obviously.

 - Probably run "git ls-remote" to figure out which branch HEAD
   should point at; you would definitely want to add a mechanism
   to pass the ls-remote result to the "git fetch" you are going
   to call next, as it is the first thing "git fetch" usually
   does -- we would want to reuse it.

 - Recently suggested good addition is to have "--track $branch"
   option to "git clone" to point remotes/origin/HEAD to
   something other than what the remote's HEAD actually points
   at (the discussion was primarily between Carl Worth and
   Linus; see archive).

 - Run "git remote add origin" with the given URL to set up the
   standard "separate remotes" tracking structure.

 - Run "git fetch" for initial fetch ("git remote add -f" could
   do that as well).  You would probably need to pass --tags to
   this "git fetch" to mimick what "git clone" does today.

 - Run initial checkout if asked.

>>  (3) "git-fetch --submodules", after finishing what it would do
>>      without "--submodules" option, would inspect the fetched
>>      tree (or the index derived from it), find the tree entries
>>      with mode 160000 (i.e. submodule graft points), and _then_
>>      uses the pathnames of these tree entries to consult the
>>      config mechanism to see which URL(s) can be used to
>>      retrieve them, probably only for new submodules.
>
> Would git-fetch then call git-clone for these new submodules?

Most likely yes but that is just my gut feeling -- I readily
admit I haven't thought it through.
