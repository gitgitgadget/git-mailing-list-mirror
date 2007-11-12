From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] setup_git_directory: Setup cwd properly if worktree is
 found
Date: Mon, 12 Nov 2007 12:31:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121224430.4362@racer.site>
References: <20071112112408.GA5420@laptop>  <Pine.LNX.4.64.0711121139010.4362@racer.site>
 <fcaeb9bf0711120413w180c07e1qbf1b186753593d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 13:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrYSI-0005Sd-2J
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 13:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162AbXKLMbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 07:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757864AbXKLMbi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 07:31:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:58850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757255AbXKLMbh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 07:31:37 -0500
Received: (qmail invoked by alias); 12 Nov 2007 12:31:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 12 Nov 2007 13:31:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/45lov8nT40mXuPFr/0bOo/D53HDt687sXKWj9El
	tW8r+tpi4o9WUq
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0711120413w180c07e1qbf1b186753593d7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64612>

Hi,

On Mon, 12 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> On Nov 12, 2007 6:57 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > But what about setup_git_directory_gently()?  If the working tree is 
> > overridden by the config, this function is still bogus, right?
> 
> Hmm.. thinking a little bit more. I guess you're right because 
> GIT_WORK_TREE takes precedence over core.worktree. Maybe some more bits 
> for check_repository_format_version(). Tough decision because, from the 
> value of inside_work_tree, we don't know if we can safely skip 
> overriding inside_work_tree.

I was thinking about adding check_repository_format_version() and a check 
for inside_work_tree < 0 with obvious handling in two places, probably as 
a function:  first, when we have a gitdirenv but no work_tree_env, and 
second, at the end of _gently() when we found a git dir but only if 
work_tree_env was not set.

> > As far as I see, setup_git_directory_gently() only works correctly 
> > when core.worktree is _not_ set, unless GIT_WORK_TREE is set (which is 
> > supposed to override the config setting).  Note: I treat GIT_WORK_TREE 
> > the same as --work-tree, since at that time they are identical.
> >
> > Maybe the config stuff has to move into _gently()?
> 
> Well, it could be a bit more complicated because you need to know
> GIT_DIR first before reading config. I'd rather not move as _gently()
> is complicated already.

AFAICT it is not a question of complexity, but of correctness.  Wouldn't 
you agree that the prefix _gently() returns is wrong if we don't fix it?

Besides, it might be needed anyway if we are serious about the version 
check.  This check, however, would have to be done _whenever_ we found a 
git directory, not only when work_tree_env is NULL.

But we could break down _gently() quite nicely.  ATM it both handles the 
cases when gitdirenv was set, and when it was unset.  Even if those are 
really two pretty different situations.

Ciao,
Dscho
