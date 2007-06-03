From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [RFC] GIT_WORK_TREE
Date: Sun, 3 Jun 2007 21:32:03 +0200
Message-ID: <20070603193203.GA24781@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx> <loom.20070603T175743-376@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 21:32:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuvoE-0004xP-Nd
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbXFCTcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 15:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXFCTcJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 15:32:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:40029 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750807AbXFCTcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 15:32:08 -0400
Received: (qmail invoked by alias); 03 Jun 2007 19:32:04 -0000
Received: from pD9EB8AF4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.244]
  by mail.gmx.net (mp037) with SMTP; 03 Jun 2007 21:32:04 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+BdKV3o7+BhHf35Csaj+ccFfnFgG4u2ULfv9MkNx
	OW+wHwNQBzzvBV
Content-Disposition: inline
In-Reply-To: <loom.20070603T175743-376@post.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49025>

Sergio <sergio.callegari@gmail.com> wrote:
> Matthias Lederhofer <matled <at> gmx.net> writes:
> If I am not wrong, with this we detach the WT from the REPO by letting git know
> our working tree if the working tree does not include a repo (.git) directory.
> And this is done either:
> - by setting the GIT_WORK_TREE environment variable whenever needed
> - by passing the --work-tree parameter to git when needed
> - by setting the core.worktree config option in the git repo, so that the
> repository knows where its default work tree is...
> 
> Is this correct? or am I missing some other ways?

That's right, you'd set GIT_DIR and core.worktree/GIT_WORK_TREE.

> Would it make sense to make the _WT_ know where its repo is?
>
> I.e. having something like a .git-repo file a the top dir of a WT, so that when
> git is invoked within the WT it can scan up the WT until it finds the .git-repo
> file and automatically decide that GIT_WORK_TREE is at the dir containing that
> .git-repo file and that GIT_DIR is at the file pointed by that .git-repo?

Symlinking the .git directory is quite similar to this and works
already without this patch series.  Anyway I spontaneously can think
of the following use cases, so it might be interesting to add this
feature:
- The use case Nguyen mentioned, e.g. the filesystem does not support
  symlinks and for some reason it is not possible to use the git
  repository next to the working tree.
- When executing potentially 'dangerous' programs in the working tree
  it is safer to have a file pointing to the repository than placing
  the repository or a symlink to the repository in the working tree
  (breaking the .git-repo file might be confusing but is not as bad as
  breaking the repository).
- In case of a publicly available working tree it might be ok to
  publish the path to the repository accidentially (which might happen
  if the permissions for the .git-repo file are too loose) but there
  would be no risk that wrong permissions could disclose the
  repository itself.

What I haven't thought through is if it could make sense to honor the
GIT_WORK_TREE/core.worktree setting when such a .git-repo file is used
or just use the directory containing the file as work tree.
