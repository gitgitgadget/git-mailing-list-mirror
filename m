From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: new plan for cleaning up the worktree mess, was Re: [PATCH] rehabilitate
 'git index-pack' inside the object store
Date: Tue, 21 Oct 2008 19:59:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810211955250.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.LFD.2.00.0810202110380.26244@xanadu.home> <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com> <alpine.DEB.1.00.0810211856090.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081021174303.GA25827@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 19:53:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsLQ9-000315-QF
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 19:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbYJURwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 13:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbYJURwR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 13:52:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:34328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751587AbYJURwR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 13:52:17 -0400
Received: (qmail invoked by alias); 21 Oct 2008 17:52:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 21 Oct 2008 19:52:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//nWAHhY///Vbgb5JtSOmGTgx6SmgcZzLHQygRJ7
	e8iO1/E8OMd6Cg
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081021174303.GA25827@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98800>

Hi,

On Tue, 21 Oct 2008, Jeff King wrote:

> On Tue, Oct 21, 2008 at 07:02:48PM +0200, Johannes Schindelin wrote:
> 
> > So I propose this change in semantics:
> > 
> > - setup_git_directory_gently(): rename to discover_git_directory(), 
> >   and avoid any chdir() at all.
> > - setup_git_directory(): keep the semantics that it chdir()s to the
> >   worktree, or to the git directory for bare repositories.
> > 
> > Using _gently() even for RUN_SETUP builtins should solve the long 
> > standing pager problem, too.
> 
> I'm not sure there aren't hidden problems lurking in that strategy 
> (every time I look at this area of code, something unexpected prevents 
> what I think should Just Work from Just Working), but I think that is a 
> promising direction to go for clearing up some of the long-standing 
> issues.

Same here.  I grew a pretty strong opinion about the whole worktree thing, 
but maybe that is only because it was done trying to change as little as 
possible.

> I think you will need to do something for a few commands which use 
> _gently() but then, if we _are_ in a git repo, assume we are chdir'd 
> properly.

Right.

> We may also be able to just call setup_git_directory_gently() as the 
> first thing in the wrapper, which should help us more consistently find 
> config before the 'exec' stage (see 4e10738a for a discussion of some of 
> the issues).

Yep, that's what I referred to as "pager" problems.  Thanks for the 
pointer!  For other people's convenience I quote it here :-)

-- snip --
    Allow per-command pager config

    There is great debate over whether some commands should set
    up a pager automatically. This patch allows individuals to
    set their own pager preferences for each command, overriding
    the default. For example, to disable the pager for git
    status:

      git config pager.status false

    If "--pager" or "--no-pager" is specified on the command
    line, it takes precedence over the config option.

    There are two caveats:

      - you can turn on the pager for plumbing commands.
        Combined with "core.pager = always", this will probably
        break a lot of things. Don't do it.

      - This only works for builtin commands. The reason is
        somewhat complex:

        Calling git_config before we do setup_git_directory
        has bad side effects, because it wants to know where
        the git_dir is to find ".git/config". Unfortunately,
        we cannot call setup_git_directory indiscriminately,
        because some builtins (like "init") break if we do.

        For builtins, this is OK, since we can just wait until
        after we call setup_git_directory. But for aliases, we
        don't know until we expand (recursively) which command
        we're doing. This should not be a huge problem for
        aliases, which can simply use "--pager" or "--no-pager"
        in the alias as appropriate.

        For external commands, however, we don't know we even
        have an external command until we exec it, and by then
        it is too late to check the config.

        An alternative approach would be to have a config mode
        where we don't bother looking at .git/config, but only
        at the user and system config files. This would make the
        behavior consistent across builtins, aliases, and
        external commands, at the cost of not allowing per-repo
        pager config for at all.
-- snap --

Ciao,
Dscho
