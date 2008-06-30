From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 21:54:11 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806292047100.19665@iabervon.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.LNX.1.00.0806271149580.19665@iabervon.org> <7vvdzuo61b.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
 <alpine.DEB.1.00.0806292248160.9925@racer> <alpine.LNX.1.00.0806291821520.19665@iabervon.org> <alpine.DEB.1.00.0806300134200.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 03:55:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD8cM-00062S-Cf
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 03:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbYF3By1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 21:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYF3By0
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 21:54:26 -0400
Received: from iabervon.org ([66.92.72.58]:42690 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbYF3ByN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 21:54:13 -0400
Received: (qmail 27001 invoked by uid 1000); 30 Jun 2008 01:54:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jun 2008 01:54:11 -0000
In-Reply-To: <alpine.DEB.1.00.0806300134200.9925@racer>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86861>

On Mon, 30 Jun 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 29 Jun 2008, Daniel Barkalow wrote:
> 
> > On Sun, 29 Jun 2008, Johannes Schindelin wrote:
> > 
> > > On Sun, 29 Jun 2008, Daniel Barkalow wrote:
> > > 
> > > > Did we even make a commitment on whether:
> > > > 
> > > > GIT_CONFIG=foo git clone bar
> > > > 
> > > > must ignore the environment variable, or simply doesn't necessarily 
> > > > obey it?
> > > 
> > > I'd rather strongly argue that no matter what is the answer to this 
> > > question, we _HAVE TO_ unsetenv() GIT_CONFIG at some stage, otherwise 
> > > no .git/config will be written.
> > 
> > Why should .git/config get written?
> 
> Because the user asked for a clone, where she reasonably expects a git 
> repository with all the [core] and the initial [remote "origin"] settings 
> to be written as it should be, _even if_ setting the config to somewhere 
> else?  Hmm?

But those should be written to the location of the config file, where 
subsequent commands will find them, which is $GIT_CONFIG if it's set and 
git commands in general use it. I mean:

$ export GIT_CONFIG=/home/barkalow/something
$ git clone git://git.kernel.org/pub/scm/git/git.git
$ cd git
$ git fetch
fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly

(because "git clone" currently ignores GIT_CONFIG, but "git fetch" 
doesn't, so it can't find the initial [remote "origin"] settings).

> IMITCNVHO it would be a serious mistake to write the config somewhere else 
> with "clone".
> 
> If that still does not convince you, "git init" also writes to 
> ".git/config" regardless of the user's (possibly bogus) GIT_CONFIG.

No, "git init" has always written to GIT_CONFIG. In fact, git-clone.sh 
used to depend on it writing to GIT_CONFIG, which is how it caused the 
config file to be written into the new clone.

> It is just such a basic thing that you must _not_ use GIT_CONFIG for 
> writing with git clone or git init.

Surely, then, you must not use GIT_CONFIG when reading the options that 
git clone writes? But I think this reduces to "you must not use GIT_CONFIG 
when using a repository", which pretty much leaves "git config". And I 
think it's only ever *useful* for "git config" anyway.

It doesn't make much sense to ensure that "git clone" works if you have 
GIT_CONFIG set when nothing else works in that situation. I still don't 
know what setting it is good for (and the commit that introduced it 
explained what it did, but not why), but I think we should be consistant 
about whether or not it affects where git expects configuration to be.

	-Daniel
*This .sig left intentionally blank*
