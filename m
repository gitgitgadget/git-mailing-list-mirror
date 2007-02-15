From: Junio C Hamano <junkio@cox.net>
Subject: Re: MinGW port updated to GIT 1.5.0
Date: Thu, 15 Feb 2007 10:59:20 -0800
Message-ID: <7v7iujckmv.fsf@assigned-by-dhcp.cox.net>
References: <45D44FD5.72299A3A@eudaptics.com>
	<7vire3co5s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 19:59:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHlpI-0001Sd-RQ
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 19:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030623AbXBOS7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 13:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030619AbXBOS7X
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 13:59:23 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62653 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030623AbXBOS7W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 13:59:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215185921.GGUV21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 15 Feb 2007 13:59:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PuzL1W00g1kojtg0000000; Thu, 15 Feb 2007 13:59:21 -0500
In-Reply-To: <7vire3co5s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 15 Feb 2007 09:43:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39841>

Junio C Hamano <junkio@cox.net> writes:

> Johannes Sixt <J.Sixt@eudaptics.com> writes:
>
>> .... The general idea is to extend the meaning of
>> `core.filemode = false` to check out symbolic links as plain files. Any
>> hints about where the source code needs changes are welcome.

I might have misread the above but I do not think linking
core.filemode and the symlink munging is the right way.  Another
per-repository core.symlink = yes/no (which defaults to yes for
others and no on filesystems without symlinks) would be more
appropriate, as it allows Cygwin to continue using symlinks
where it can, and UNIX folks to try it out.

I take by "checking out as plain files" you mean instead of
calling symlink(2) you would write(2) it out.

I think that would be Ok from git's side.  Just like we use
executable bit from the index to "fix" what we read from the
filesystem (e.g. look for trust_executable_bit in diff-lib.c)
when core.filemode is set, you would munge st.st_mode and
pretend as if your lstat() said "RelNotes", which should be a
symlink but you checked out as a regular file, said it is a
symlink, using what is in the index.

However, I am not so sure if we can do better to help Windows
people.  They have what they call "ShortCut", which to me feels
like what they use for what symlinks are used for.  I do not
know if it is possible (I do not even know doing so would make
life easier for Windows people) but perhaps a symlink can be
"checked out" as a ShortCut?

I suspect reading side would become too complex and slow if the
shortcut needs to be named differently from the real name
(e.g. "RelNotes" needs to be checked out as "RelNotes.lnk" or
something silly like that), so if that is the case, please
forget about this useless suggestion.
