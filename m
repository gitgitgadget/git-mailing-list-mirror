From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-mail in sh
Date: Sun, 27 Nov 2005 14:01:18 -0800
Message-ID: <7v4q5xbvip.fsf@assigned-by-dhcp.cox.net>
References: <4386DD45.6030308@op5.se>
	<7v7jaxou5b.fsf@assigned-by-dhcp.cox.net> <43874935.2080804@op5.se>
	<7vwtiwmvfp.fsf@assigned-by-dhcp.cox.net> <4388E33A.8000004@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 23:03:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgUaL-0000EG-28
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 23:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVK0WBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 17:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVK0WBU
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 17:01:20 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52117 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751124AbVK0WBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 17:01:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051127220047.SQUT15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 17:00:47 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4388E33A.8000004@op5.se> (Andreas Ericsson's message of "Sat, 26
	Nov 2005 23:35:38 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12829>

Andreas Ericsson <ae@op5.se> writes:

> Here's what I have on disk right now. The ${var##*^} syntax was decided 
> to be portable in some earlier discussion, so I'm sticking with it 
> (mostly because I don't know how to do it with expr and Junio pokes me 
> when I do it with sed. Enlightenment welcome).

The ${parameter##word} syntax is in IEEE 1003.1-2001, and bash,
ksh, and dash seem to work with it.  That does not necessarily
mean it is "portable" but I won't be so worried about shells
that do not grok this.  Input from people on non-Linux platforms
are appreciated.

> if [ "$com2" ]; then
>     range="$com1..$com2"
> else
>     case "$com1" in
>...
>         ?*^)
>             # single commit
>             com1="${com1##*^}"
>             range="$com1^1..$com1"
>             ;;

I wonder if you meant "${com1%^}" here, to remove the trailing '^'.

>         ?*^[0-9]|?*^[0-9][0-9])
>             # series of commits, ranging back from <commit-ish>
>             range="$com1..${com1%%^*}"
>             ;;
>         ^[0-9]|^[0-9][0-9])
>             # series of commits, ranging back from HEAD
>             range="HEAD$com1..HEAD"
>             ;;

N generation back in extended SHA1 notation uses a tilde '~',
e.g. "HEAD~5" is five commits back from the current HEAD, so I'd
prefer being consistent with that (HEAD^5 means the fifth parent
of an octopus merge commit).  Also limiting to between 0 and 99
generations misinterprets "HEAD~123".

Although checking only the letter that follows the tilde is a
digit mistakenly accepts something like "master~1-bad-one", that
is already malformed and whatever comes downstream would barf,
so that may be fine.  How about something like:

	?*'~'[1-9]*)
        	range="$com1..${com1%~*}" ;;
	'~'[1-9]*)
        	range="HEAD$com1..HEAD" ;;

I do not have aversion against echo piped to sed in general, by
the way.  I *would* redicule people who write something like
this, though:

	case "$git" in
        */.git)	printname=`echo "$git" | sed -e 's/\/\.git$//'` ;;
        *)	printname=$git ;;
	esac

It should be spelled `expr "$git" : '\(.*\)/\.git$'` (or
"${git%/.git}" if we know the shell is POSIX), for this
particular one, since we already know it ends with "/.git".  But
if all you want to do is to drop an *optional* trailing "/.git"
(i.e. your input may or may not end with "/.git"), a single:

	printname=`echo "$git" | sed -e 's/\/\.git$//'`

without surrounding case may be adequate; it forks sed when it
does not have the optional /.git part, though.  And if you are
dropping optional /.git or .git (think of prettyprinting
uemacs/.git and git.git), then echo-to-sed without surrounding
"case" is probably easier to read:

	printname=`echo "$git" | sed -e 's/\/*\.git$//'`

unless you want to avoid fork, in which case it would be:

	case "$git" in
        */.git) printname=${git%/.git} ;;
        *.git) printname=${git%.git} ;;
        *) printname=$git ;;
	esac
