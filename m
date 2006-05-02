From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Tue, 02 May 2006 12:07:04 -0700
Message-ID: <7v1wvcmejr.fsf@assigned-by-dhcp.cox.net>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
	<e34bdf$ho4$1@sea.gmane.org> <7vhd4as00i.fsf@assigned-by-dhcp.cox.net>
	<e34cb4$is1$1@sea.gmane.org> <44571967.7080807@op5.se>
	<7vy7xkn6kd.fsf@assigned-by-dhcp.cox.net> <e378fs$lpc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 21:07:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb0DI-0000Gu-1s
	for gcvg-git@gmane.org; Tue, 02 May 2006 21:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWEBTHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 15:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWEBTHH
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 15:07:07 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:23192 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750712AbWEBTHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 15:07:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060502190705.YAOF27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 15:07:05 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e378fs$lpc$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	02 May 2006 11:25:10 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19425>

Jakub Narebski <jnareb@gmail.com> writes:

>> I renamed "git grip" to "git grep" and "git diffn" to "git diff"
>> both in "next" branch to avoid confusion.  Thanks Andreas,
>> Jakub, and others for input.
>
> So, is there a way to use old, script version of those commands?

I'd say that is probably not the real question you wanted to
ask, but let's pretend it is for a moment.

The "master" branch has not been updated to remove the script
one, so you can keep running "master" one (or 1.3.X series).  Or
you can fork your own private edition by tweaking git.c (prevent
it from running the builtin one) and Makefile (resurrect the
script based one and prevent it from installing git-grep
hardlinked with git itself).  One thing that I will not do in
the long run, however, is to keep the script based one and have
builtin one.  It is like carrying all the earlier slightly
incompatible versions as git-grep-1.1.sh, git-grep-1.2.sh, and
git-grep-1.3.sh in the source for fear of backward compatibility
problems -- it is crazy.

So the real question, is what are still missing in the built-in
implementation.  What will we lose if we remove the script based
one and replace it with today's built-in one, if we are ready to
do it today, and if not what we are going to do about them.  My
answer to the latter questions are "not yet" (obviously, that is
why "master" does not have it yet), and "will support what are
reasonable".

Here are main differences that I am aware of:

 - The shell-script one, if you use GNU grep, accepts more
   options to grep than what the current built-in one supports.
   Notable ones that are missing: fixed strings (-F), patterns
   from file (-f), count matches (-c), omit filenames (-h),
   skipping binary files (-I, -U), files without match (-L),
   pcre (-P), silent (-q), word expression (-w), NUL (-z).  They
   should be easy to add if somebody cares enough, and I plan to
   do a few myself before pushing it out to "master".

 - The shell-script one can be coaxed to use different "grep"
   implementation from the standard one with an appropriate PATH
   settings.

At the lowest level, buitlin-grep.c::grep_buffer() function is
called with the set of parsed options, the "filename" used for
reporting, and the text to grepped in-core.  The shell-script
one always worked on working tree files, but the built-in one
can work on working tree files and also alternatively on files
from other versions.  Regardless of where the file comes from,
this function is called to look for the pattern the user is
looking for.

You can do two things.

One is to add support for commonly used but still missing
features to built-in one.  For this, you would need to extend
"struct grep_opt" to hold new option parameters (e.g. if you
want to do "-f", you would need to hold all patterns you obtain
from the named file so grep_buffer() can use them -- currently
it supports only one pattern), and teach grep_buffer() how to do
the new feature.

Another thing you can do is to detect GIT_EXTERNAL_GREP (in the
same spirit as GIT_EXTERNAL_DIFF) environment variable at the
front of grep_buffer(), and when it is set, spawn the named
external program with the original parameters the user supplied,
probably stashed away in "struct grep_opt" when cmd_grep() does
its parameter parsing, and feed it the contents of the buffer.
