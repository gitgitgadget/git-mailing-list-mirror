From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Mon, 4 Jan 2010 23:29:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 23:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRvLA-0001Gj-GY
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 23:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940Ab0ADWXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 17:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936Ab0ADWXv
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 17:23:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:54207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753930Ab0ADWXu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 17:23:50 -0500
Received: (qmail invoked by alias); 04 Jan 2010 22:23:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 04 Jan 2010 23:23:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IulgzmFhIHkCFyHIBH0Vj43Gfzy9wooJ9vBhD55
	mAxczK58DyBOR9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B421F90.4090402@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136144>

Hi,

On Mon, 4 Jan 2010, Jens Lehmann wrote:

> Am 04.01.2010 10:44, schrieb Johannes Schindelin:
> > The real problem is that submodules in the current form are not very 
> > well designed.
> 
> IMVHO using the tree sha1 for a submodule seems to be the 'natural' way 
> to include another git repo. And it gives the reproducibility i expect 
> from a scm. Or am i missing something?

You do remember the discussion at the Alles wird Git about the need for 
Subversion external-like behavior, right?

> It looks to me as most shortcomings come from the fact that most git 
> commands tend to ignore submodules (and if they don't, like git gui and 
> gitk do now, they e.g. only show certain aspects of their state).

It is not only ignoring.  It is not being able to cope with the state only 
submodules can be in (see below).

> Submodules are in heavy use in our company since last year. Virtually 
> every patch i submitted for submodules came from that experience and 
> scratched an itch i or one of my colleagues had (and the situation did 
> already improve noticeably by the few things we changed). We are still 
> convinced that using submodules was the right decision. But some work 
> has still to be done to be able to use them easily and to get rid of 
> some pitfalls.

Submodules may be the best way you have in Git for your workflow ATM.  
But that does not mean that the submodule design is in any way 
thought-through.

Just a few shortcomings that do show up in my main project (and to a 
small extent in msysGit, as you are probably aware):

- submodules were designed with a strong emphasis on not being forced to 
  check them out.  But Git makes it very unconvenient to actually check 
  submodules out, let alone check them out at clone-time.  And it is 
  outright impossible to _enforce_ a submodule to be checked out.

- among other use cases, submodules are recommended for sharing content 
  between two different repositories. But it is part of the design that it 
  is _very_ easy to forget to commit, or push the changes in the submodule 
  that are required for the integrity of the superproject.

- that use case -- sharing content between different repositories -- is 
  not really supported by submodules, but rather an afterthought.  This is 
  all too obvious when you look at the restriction that the shared content 
  must be in a single subdirectory.

- submodules would be a perfect way to provide a fast-forward-only media 
  subdirectory that is written to by different people (artists) than to 
  the superproject (developers).  But there is no mechanism to enforce 
  shallow fetches, which means that this use case cannot be handled 
  efficiently using Git.

- related are the use cases where it is desired not to have a fixed 
  submodule tip committed to the superproject, but always to update to the 
  current, say, master (like Subversion's externals).  This use case has 
  been wished away by the people who implemented submodules in Git.  But 
  reality has this nasty habit of ignoring your wishes, does it not?

- there have been patches supporting rebasing submodules, i.e.  
  submodules where a "git submodule update" rebases the current branch to 
  the revision committed to the superproject rather than detaching the 
  HEAD, which everybody who ever contributed to a project with submodules 
  should agree is a useful thing. But the patches only have been discussed 
  to death, to the point where the discussion's information content was 
  converging to zero, yet the patches did not make it into Git.  (FWIW 
  this is one reason why I refuse to write patches to git-submodule.sh: I 
  refuse to let my time to be wasted like that.)

- working directories with GIT_DIRs are a very different beast from single 
  files.  That alone leads to a _lot_ of problems.  The original design of 
  Git had only a couple of states for named content (AKA files): clean, 
  added, removed, modified.  The states that are possible with submodules 
  are for the most part not handled _at all_ by most Git commands (and it 
  is sometimes very hard to decide what would be the best way to handle 
  those states, either).  Just think of a submodule at a different 
  revision than committed in the superproject, with uncommitted changes, 
  ignored and unignored files, a few custom hooks, a bit of additional 
  metadata in the .git/config, and just for fun, a few temporary files in 
  .git/ which are used by the hooks.

- while it might be called clever that the submodules' metadata are stored 
  in .gitmodules in the superproject (and are therefore naturally tracked 
  with Git), the synchronization with .git/config is performed exactly 
  once -- when you initialize the submodule.  You are likely to miss out 
  on _every_ change you pulled into the superproject.

All in all, submodules are very clumsy to work with, and you are literally 
forced to provide scripts in the superproject to actually work with the 
submodules.

> > In ths short run, we can paper over the shortcomings of the submodules 
> > by introducing a command line option "--include-submodules" to 
> > update-refresh, diff-files and diff-index, though.
> 
> Maybe this is the way to go for now (and hopefully we can turn this 
> option on by default later because we did the right thing ;-).

I do not think that --include-submodules is a good default.  It is just 
too expensive in terms of I/O even to check the status in a superproject 
with a lot of submodules.

Besides, as long as there is enough reason to have out-of-Git alternative 
solutions such as repo, submodules deserve to be 2nd-class citizens.

Ciao,
Dscho
