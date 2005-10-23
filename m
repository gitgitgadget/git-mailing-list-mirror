From: Junio C Hamano <junkio@cox.net>
Subject: Re: Server side programs
Date: Sat, 22 Oct 2005 17:30:36 -0700
Message-ID: <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net>
References: <435ABB99.5020908@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 02:31:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETTl3-0001Fa-9v
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 02:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVJWAai (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 20:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVJWAai
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 20:30:38 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:16061 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751321AbVJWAah (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 20:30:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051023003020.CGYU9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Oct 2005 20:30:20 -0400
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <435ABB99.5020908@op5.se> (Andreas Ericsson's message of "Sun, 23
	Oct 2005 00:22:17 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10479>

Andreas Ericsson <ae@op5.se> writes:

> Are git-receive-pack and git-upload-pack the only two binaries that get 
> called directly over a SSH-tunnel?

There are git-ssh-fetch and git-ssh-upload which call each other
(and the older name pairs git-ssh-push and git-sh-pull do so as
well).  However, you do not have to use these commit walkers
over ssh; fetch-pack/upload-pack pair work quite well.

I think your question is "what is the absolute minimum set of
binaries you need to allow", so I think the two listed are
enough.  If you want to let your users coming over SSH *create*
a new repository on your machine, you would need a bit more,
though (namely, shell access to run mkdir and git-init-db).

> The reason I'm asking is that I'm adding support for userrelative paths 
> (git pull ssh://host:~user/somedir) and removing the possibilities to 
> use a compromised but limited account for finding out what other 
> useraccounts are available.

Sorry, it is not clear to me what you are adding.  I do this
regularly:

	$ git push kernel.org:git/
	$ git fetch kernel.org:git/

to push into and fetch from $HOME/git/ repository on the other
end.

Also I can do this already (assuming the other end hangs all
users under the same directory, presumably /home/$user):

	$ git fetch kernel.org:../torvalds/git/

Are you in addition trying to let me do this:

	$ git fetch kernel.org:~torvalds/git/

which would work even when ~torvalds == /home/torvalds and
~junio == /home2/junio, without having to tell people where
the user home directories are?

At one point, Linus posted an outline of "restricted login shell
for use with git over ssh".  I think you could start from there,
perhaps extend it so that it checks the binaries *and* pathnames
the user can specify (e.g. only under your own $HOME is allowed,
and no /../ in them, or something silly like that).
