From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] C implementation of the 'git' program.
Date: Fri, 11 Nov 2005 00:37:51 +0100
Message-ID: <20051110233751.GD30496@pasky.or.cz>
References: <20051110182631.3C5615BF90@nox.op5.se> <Pine.LNX.4.64.0511101133550.4627@g5.osdl.org> <4373CEA8.1020900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 00:39:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaLzY-0002wu-Q7
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 00:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVKJXiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 18:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVKJXiA
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 18:38:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:10416 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751235AbVKJXh7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 18:37:59 -0500
Received: (qmail 23406 invoked by uid 2001); 11 Nov 2005 00:37:51 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <4373CEA8.1020900@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11536>

Dear diary, on Thu, Nov 10, 2005 at 11:50:16PM CET, I got a letter
where Andreas Ericsson <ae@op5.se> said that...
> Linus Torvalds wrote:
> >
> >And the performance difference does seem to be quite noticeable too..
> >
> 
> Yes. I was quite astonished when I noticed first, thinking the shell 
> kept the parsed script in cache or some such. Apparently it doesn't.

The bulk of the time is likely not spent parsing, but executing
subprocesses, that's hideously expensive. Just for fun, you can try to
measure the improvement when you remove the $(dirname "$0"). Here, for
1000 tries it's roughly 9s normal, 7s without dirname and 3s direct
invocation, which seems to give you _very roughly_ 2s per subprocess,
and 2s other shell overhead, which is unusually right.

Actually, I can bring the git.sh runtime from 7s to 4.7s:

-       case "$cmd" in
-       -v|--v|--ve|--ver|--vers|--versi|--versio|--version)
+       if [[ "$cmd" = "-v" ||
+             "$cmd" = "--v" ||
+             "$cmd" = "--ve" ||
+             "$cmd" = "--ver" ||
+             "$cmd" = "--vers" ||
+             "$cmd" = "--versi" ||
+             "$cmd" = "--versio" ||
+             "$cmd" = "--version" ]]; then
                echo "git version @@GIT_VERSION@@"
                exit 0 ;;
-       esac
+       fi
				(whitespace-mangled)

Well, subconsciously I never really trusted this case thing. ;-)

This leaves ~ 1.7s to other shell overhead and execve() (the main
command call is without the fork(), while $(dirname) fork()s).

> >>The location of the GIT_LIB can be obtained by running
> >>
> >>	git --lib
> >
> >
> >I think this might be a bit ambiguous. When I see "GIT_LIB", to me it 
> >implies traditional libraries (ie a "libgit.a" kind of thing), not the 
> >kind of "git executable plugin" directory.
> >
> >So I'd suggest renaming "--lib" and "GIT_LIB" to be more of a "--libexec" 
> >kind of flavor, if only to avoid that confusion.
> 
> 
> Someone said libexec was moving out (of Linux, at least), so I thought 
> I'd better avoid that. Perhaps GIT_LIBDIR?

This may not necessarily have anything in common with the actual
directory name. I prefer libexec too (but personally don't care too
much).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
