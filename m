From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 28 Jun 2007 22:23:21 +0200
Message-ID: <20070628202321.GA13263@moooo.ath.cx>
References: <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net> <7vodkb1adr.fsf@assigned-by-dhcp.cox.net> <7virac547s.fsf@assigned-by-dhcp.cox.net> <7v6466oygl.fsf@assigned-by-dhcp.cox.net> <7vfy54tt3l.fsf@assigned-by-dhcp.cox.net> <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com> <7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com> <7v645cz7vm.fsf@assigned-by-dhcp.pobox.com> <20070626133548.GB11504@moooo.ath.cx> <7vtzsurvo1.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 22:23:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I40WW-0002op-IN
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 22:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761868AbXF1UX1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 16:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761058AbXF1UX0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 16:23:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:45218 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757619AbXF1UX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 16:23:26 -0400
Received: (qmail invoked by alias); 28 Jun 2007 20:23:24 -0000
Received: from pD9EBB5BD.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.189]
  by mail.gmx.net (mp018) with SMTP; 28 Jun 2007 22:23:24 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19fjAczy7RfmFbeVGpIOlcKyexTcoMcf0Jo7sYLi3
	fIJ4ZzYoZfnPsB
Content-Disposition: inline
In-Reply-To: <7vtzsurvo1.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51127>

Junio C Hamano <gitster@pobox.com> wrote:
> I think the behaviour for receive-pack and the environment the
> hooks run in have been pretty well defined.  You start in the
> repository (the directory $GIT_DIR), GIT_DIR is set and points
> at it.
> 
> The issue is that the introduction of WORK_TREE enviornment and
> core.worktree mechanism might want to update the semantics.  For
> example, some people seem to run checkout (or perhaps "merge")
> to update the associated working tree.  Can they find out where
> the root of the working tree is (because they would want to
> chdir to it before saying "git checkout"), given the current
> environment receive-pack sets up for them?
>
> Earlier we said that people who use only GIT_DIR without
> GIT_WORK_TREE nor core.worktree should get exactly the same
> semantics with or without the WORK_TREE topic, so the above may
> not be an issue.

When GIT_WORK_TREE/core.worktree are not set the only difference with
the patch series should be that cwd may be used as working tree in more
cases than before.

I think these are the ways git-receive-pack is executed (in normal
setups):
 * local pushes: git_connect() unsets GIT_WORK_TREE.
 * ssh: the user might set GIT_WORK_TREE in his shell
   configuration, .ssh/environments, .ssh/authorized_keys etc.
   git-receive-pack is then executed with GIT_WORK_TREE set.
 * git-daemon: git-daemon with --enable=receive-pack allows pushing
   and does not unset GIT_WORK_TREE, so a git-daemon started with
   GIT_WORK_TREE exported will also have it exported when receive-pack
   is executed.

I think it makes sense to unset GIT_WORK_TREE when receive-pack is
started.  In the first case GIT_WORK_TREE is unset already and in the
latter two cases I don't think we really need to support that
GIT_WORK_TREE stays exported in the hooks, it could rather happen
accidentally.

When doing more stuff in receive-pack old hooks might stop working
break.

For example receive-pack could set up GIT_WORK_TREE with a sane
default value if a working tree can be found, i.e.
    $ export GIT_WORK_TREE=$(dirname $(pwd))
if the working tree is in the parent directory
    $ export GIT_WORK_TREE=$(git config core.worktree)
if core.worktree is set and otherwise GIT_WORK_TREE is not exported.
This way hooks can just use GIT_WORK_TREE for the working tree if
they don't need anything special.
