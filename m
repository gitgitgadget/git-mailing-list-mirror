From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: finding the right remote branch for a commit
Date: Mon, 16 Jul 2007 00:33:41 +0200
Message-ID: <20070715223341.GA3797@moooo.ath.cx>
References: <20070710144907.GA324@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707112226170.4516@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 00:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IACey-0008KN-Ot
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 00:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbXGOWdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 18:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbXGOWdp
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 18:33:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:60850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753742AbXGOWdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 18:33:44 -0400
Received: (qmail invoked by alias); 15 Jul 2007 22:33:43 -0000
Received: from pD9EB8A0A.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.10]
  by mail.gmx.net (mp032) with SMTP; 16 Jul 2007 00:33:43 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+UtddbkviUIcdoUb1x4+Mqqd0F6ENlxVBg52Q2Pb
	KPa1bfL12KANZz
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707112226170.4516@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52594>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> In practice, and I consider these all bugs, it does not work:
> 
> - you have to say
> 
>   $ git --work-tree=$HOME --bare init
> 
>   which is a bit counterintuitive.  After all, it is _not_ a bare 
>   repository.  The whole purpose of worktree, as far as I understand, is 
>   to have a _detached_ repository, which would otherwise be called bare.

Use

    $ git --work-tree "$HOME" --git-dir . init

instead.

IMHO the --bare flag did not make much sense before the introduction
of GIT_WORK_TREE and doesn't after, at least not with the meaning it
has: why should 'git --bare' mean to use the repository from cwd?
Ok, git --bare implies that you cannot use a working tree because
you're at the top of the git repository directory which may not be
used as working tree.

Now bare only means that some protection mechanisms are disabled and
some default values change (i.e. overwrite HEAD, enable/disable
reflogs by default).  So maybe the name bare itself is a bit
counterintuitive now.

> - $ git status
> 
>   does not do what you would expect: it fails, telling you that it needs a 
>   work tree, of all things. You can say (tongue-in-cheek)
> 
>   $ (export GIT_DIR="$(pwd)" && cd "$(git config core.worktree)" &&
>      git status)
> 
>   So, git knows about the location of the working tree, but just ignores 
>   that.
> 
> - In the case that you forget to set GIT_DIR, you better not have any 
>   .git/ repository in $HOME/ or $HOME/gits/, because it will pick up that 
>   instead!  Even if you are _inside_ a detached git directory!
> 
>   So you better not try some games like this in a subdirectory of your 
>   local git.git repository.  It is a fine way to get completely confused.  
>   And certainly do _not_ do something like "git reset --hard <branch>" 
>   there.
>
> - Of course, it would be nice if something like that worked:
> 
>   $ cd $HOME/gits/vim.git
>   $ git add $HOME/.vimrc
> 
>   But it does not work, because it wants to _be_ in the work tree.  Of 
>   course, you have to specify the GIT_DIR again, because the working tree 
>   does not know about the location of the repository, but vice versa.

Up to now you are supposed to be in the working tree all the time when
using it.  Therefore I'd call these feature requests rather than bugs :)

For git status it should be quite easy to add a special case to change
to the top of the working tree as long as no paths are used as
parameters.

When paths are used (either with git status or git add) you'd have to
translate the specified path to a path relative to the working tree.
This should be possible with chdir, getcwd and prefixcmp.  If this
gets implemented for git status/git add it should probably get
implemented for all commands for which it makes sense.  I think this
would be nice to have but I'm not sure how complicated this is to
implement.
