From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: finding the right remote branch for a commit
Date: Wed, 11 Jul 2007 22:26:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707112226170.4516@racer.site>
References: <20070710144907.GA324@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git discussion list <git@vger.kernel.org>,
	Matthias Lederhofer <matled@gmx.net>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jiP-0007v9-LW
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758456AbXGKV1P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758594AbXGKV1N
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:27:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:49872 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758535AbXGKV1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:27:12 -0400
Received: (qmail invoked by alias); 11 Jul 2007 21:26:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 11 Jul 2007 23:26:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+m1LBG3y6m0MmlvVNCFFAKvw0PfOjUyP7oyTeolJ
	vHWRw5WMNXnmX5
X-X-Sender: gene099@racer.site
In-Reply-To: <20070710144907.GA324@piper.oerlikon.madduck.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52211>

Hi,

On Tue, 10 Jul 2007, martin f krafft wrote:

> I am trying to figure out a way to store ~/.etc in git. With SVN,
> I would have a .etc repository for each machine, which would use
> svn:externals to reference locations of the various subdirectories,
> which SVN would then pull and assemble. Thus, my ~/.etc might be
> 
>   ~/.etc
>   ~/.etc/ssh [svn+ssh://svn.madduck.net/priv/etc/ssh]
>   ~/.etc/vim [svn+ssh://svn.madduck.net/pub/etc/vim]
>   ...
>
> [...] 
> 
> Thus, the vim repository might look like this:
> 
>   .etc/
>   |-- vim/
>   |   `-- rc.vim
>   `-- .vimrc -> .etc/vim/rc.vim
> 
> and the ssh configuration might be
> 
>   .etc/
>   |-- ssh/
>   |   |-- config
>   |   `-- authorized_keys
>   `-- .ssh -> .etc/ssh/

Okay, after discussing this for a bit on IRC, here is what I would do (I 
already said this on IRC, but the mailing list is really the better medium 
for this):

I would actually rename .etc/ into gits/, because it is not a directory 
containing settings, but a directory containing repositories.

Then I would create bare repositories gits/vim.git/, gits/ssh.git/, 
gits/mutt.git/, etc. but as soon as I created them, I would make them 
"unbare", i.e. "git config core.bare false".

Everytime I would work on, say, .vimrc, I would say 
"--git-dir=$HOME/gits/vim.git", or maybe even make an alias in 
$HOME/.gitconfig, which spares me that:

$ git config --global vim '!git --git-dir=$HOME/gits/vim.git'

Then I could see the status with

$ git vim status

Come to think of it, this is maybe what I would have done, but it appears 
to me that this is the _ideal_ use case for worktree:

In $HOME/gits:

$ mkdir vim.git && cd vim.git
$ git --work-tree=$HOME init
$ cat >> info/exclude < EOF
*
!/.vimrc
EOF

Then you could do all Git operations like push, fetch, pull, log in 
$HOME/gits/vim.git, and all editing in $HOME.

At least that is the theory.

In practice, and I consider these all bugs, it does not work:

- you have to say

  $ git --work-tree=$HOME --bare init

  which is a bit counterintuitive.  After all, it is _not_ a bare 
  repository.  The whole purpose of worktree, as far as I understand, is 
  to have a _detached_ repository, which would otherwise be called bare.

- $ git status

  does not do what you would expect: it fails, telling you that it needs a 
  work tree, of all things. You can say (tongue-in-cheek)

  $ (export GIT_DIR="$(pwd)" && cd "$(git config core.worktree)" &&
     git status)

  So, git knows about the location of the working tree, but just ignores 
  that.

- In the case that you forget to set GIT_DIR, you better not have any 
  .git/ repository in $HOME/ or $HOME/gits/, because it will pick up that 
  instead!  Even if you are _inside_ a detached git directory!

  So you better not try some games like this in a subdirectory of your 
  local git.git repository.  It is a fine way to get completely confused.  
  And certainly do _not_ do something like "git reset --hard <branch>" 
  there.

- Of course, it would be nice if something like that worked:

  $ cd $HOME/gits/vim.git
  $ git add $HOME/.vimrc

  But it does not work, because it wants to _be_ in the work tree.  Of 
  course, you have to specify the GIT_DIR again, because the working tree 
  does not know about the location of the repository, but vice versa.

Those are serious bugs.  Matthias, any idea how to fix them?

Ciao,
Dscho
