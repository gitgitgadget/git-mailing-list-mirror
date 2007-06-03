From: Matthias Lederhofer <matled@gmx.net>
Subject: [RFC] GIT_WORK_TREE
Date: Sun, 3 Jun 2007 16:44:01 +0200
Message-ID: <20070603144401.GA9518@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 16:45:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HurL1-0007gJ-Om
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 16:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbXFCOoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 10:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758025AbXFCOoH
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 10:44:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:33770 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755443AbXFCOoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 10:44:05 -0400
Received: (qmail invoked by alias); 03 Jun 2007 14:44:03 -0000
Received: from pD9EB8AF4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.244]
  by mail.gmx.net (mp051) with SMTP; 03 Jun 2007 16:44:03 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/CEGxAbknC3CypDMMP2kkC5RtP68dPej2iQwVISg
	t6OhHd3JOJBy1Y
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48998>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I think it's a valid use case. Anyone remember why Matthias' patchset
> was dropped?
> It was last mentioned in
> http://article.gmane.org/gmane.comp.version-control.git/43041
> 
> Junio, Matthias? May I help?

Thanks for reminding me, I just did not finish the patch and then
there was an exam which took all my time.  But I took another look at
it and made a new series, including the missing test cases.
If you want to help please test it, check the source for errors, make
comments etc.

This series introduces the GIT_WORK_TREE environment variable (and
core.worktree config option) to specify the working tree that should
be used with the repository (not for repositories found as .git
directory).  This allows to separate the repository and working tree.

Example use cases:
- you don't want to put the repository in the checkout (e.g. the
  checkout is publicly available but the history shouldn't)
- you want to track a read-only directory with git (e.g. track
  configuration files as normal user that are modified by other people
  or by yourself as superuser)
- there is a directory many people are working in and you can track
  the changes made by yourself and others without placing the .git
  directory in the directory
- checkout multiple repositories into the same directory
- see the mail form nguyen (Message-ID:
  <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>)

The patches are also available from git://igit.ath.cx/~matled/git in
branch worktree (I might change this branch later) or as tag
worktree1.

[PATCH] rev-parse: document --is-inside-git-dir
[PATCH] rev-parse: introduce --is-bare-repository
[PATCH] test git rev-parse
[PATCH] introduce GIT_WORK_TREE to specify the work tree
[PATCH] use new semantics of is_bare/inside_git_dir/inside_work_tree
[PATCH] extend rev-parse test for --is-inside-work-tree
[PATCH] test GIT_WORK_TREE

There are also a few things which are not addressed in this series:
- The documentation needs updates on what bare means.
- is_bare_repository should ignore trailing slashes when guessing if
  the repository is bare (/path/to/.git is not bare, /path/to/.git/ is
  bare if core.bare is unspecified).  Perhaps we can also set GIT_DIR
  to the path returned by getcwd which would solve this too.
- Aliases using --git-dir and/or --work-tree cause problems (also
  before this patch).  git should probably exec itself if an alias
  uses --git-dir or --work-tree.
- Calls to git_config(git_default_config) can be removed in many
  places because setup_git_directory_gently always reads the
  configuration.
- git init could set core.worktree if GIT_WORK_TREE is set.
