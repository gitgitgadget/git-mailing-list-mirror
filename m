From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Pushing a git repository to a new server
Date: Mon, 11 Feb 2013 11:50:40 +0400
Message-ID: <20130211075040.GJ5210@localhost.localdomain>
References: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:51:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4oAX-00071c-BX
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab3BKHuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:50:46 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:40596 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab3BKHup (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:50:45 -0500
Received: from proxysrv.domain007.com (localhost [10.8.0.42] (may be forged))
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r1B7ogvX018110;
	Mon, 11 Feb 2013 11:50:43 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id B2E20B232CC; Mon, 11 Feb 2013 11:50:41 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216019>

On Sun, Feb 10, 2013 at 04:00:56PM -0500, Ethan Reesor wrote:

> I'm looking to make a command to push a git repo to a new server. The
> way I just did it is as follows:
> 
> localhost> git clone --bare /path/to/MyRepo /path/to/tmpdir/MyRepo.git
> localhost> tar xz /path/to/tmpdir/MyRepo.git | ssh myuser@remotehost
> tar cz \~/      # If I don't escape '~', my local machine expands it
> localhost> ssh myuser@remotehost
> remotehost> sudo chown -R git:git MyRepo.git

What's wrong with
$ ssh myuser@remotehost 'mkdir /path/to/MyRepo.git; cd $_; git init --bare'
$ git push --all git@remotehost:MyOtherRepo.git
?

> The reason I had to use my user is the git user's shell is git-prompt

There's no such thing as git-prompt.  The restricted login shell for
SSH-only access typically used for such a "virtual" Git user is
git-shell.

> and ~git/git-shell-commands is empty. I have repos set up using
> 'git@remotehost:MyOtherRepo.git' as the remote and everything works.
> 
> How do I make a git command that can talk to the server using
> git-prompt like the other commands do?

It's not really clear what do you want to achieve.
The reason the git-shell shell is *restricted* (read its manual page)
is to shrink the surface of possible attacks in the case the shell
account used for accessing Git repos over SSH is compromized (the key or
password stolen, for instance).  This is achieved by only allowing
commands like git-upload-pack etc in the shell (no general file
manipulation commands etc).  So what creating "git command that can
talk to the server using git-prompt ..." would really buy you?

I think the way to go is to start using gitolite [1] or implement by
hand a subset of what it does (a custom login shell which is allowed to
do certain things in a special area of the filesystem designated to keep
Git repositories) or just set up a special account on the server
("git-admin", for instance) which would have a regular login shell set
for it and would be in the same group as the user "git" (or even have
the same UID) so that they could share the files they create (subject to
active umasks of processes run as both users though).

1. https://github.com/sitaramc/gitolite
