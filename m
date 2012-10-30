From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v5 00/14] New remote-hg helper
Date: Tue, 30 Oct 2012 10:25:27 +0000
Message-ID: <20121030102526.GN4891@arachsys.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 11:25:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT914-0001OJ-US
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 11:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758247Ab2J3KZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 06:25:38 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:58237 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757604Ab2J3KZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 06:25:37 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.80)
	(envelope-from <chris@arachsys.com>)
	id 1TT90n-0008Rd-Fx; Tue, 30 Oct 2012 10:25:34 +0000
Content-Disposition: inline
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208691>

Hi. I routinely work with projects in both hg and git, so I'm really
interested in this. Thanks for working on it! I grabbed the latest version
from

  https://github.com/felipec/git/blob/fc-remote-hg/contrib/remote-hg/git-remote-hg

and have been trying it out. For the most part, it seems to work very nicely
for the hg repos I have access to and can test against. I've spotted a couple
of issues along the way that I thought would be worth reporting.

The first is really a symptom of a general difference between hg and git: an hg
repository can have multiple heads, whereas a git repo has exactly one head. To
demonstrate:

  $ hg init hgtest && cd hgtest
  $ echo zero >foo && hg add foo && hg commit -m zero
  $ echo one >foo && hg commit -m one
  $ hg checkout -r 0
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  $ echo two >foo && hg commit -m two
  created new head
  $ hg log --graph
  @  changeset:   2:ca09651009cb
  |  tag:         tip
  |  parent:      0:9f552c53d116
  |  user:        Chris Webb <chris@arachsys.com>
  |  date:        Tue Oct 30 09:33:38 2012 +0000
  |  summary:     two
  |
  | o  changeset:   1:58fad8998339
  |/   user:        Chris Webb <chris@arachsys.com>
  |    date:        Tue Oct 30 09:33:25 2012 +0000
  |    summary:     one
  |
  o  changeset:   0:9f552c53d116
     user:        Chris Webb <chris@arachsys.com>
     date:        Tue Oct 30 09:33:08 2012 +0000
     summary:     zero

  $ cd ..

Now if I try to convert this:

  $ git clone hg::$PWD/hgtest gittest
  Cloning into 'gittest'...
  WARNING: Branch 'default' has more than one head, consider merging
  Traceback (most recent call last):
    File "/home/chris/bin/git-remote-hg", line 773, in <module>
      sys.exit(main(sys.argv))
    File "/home/chris/bin/git-remote-hg", line 759, in main
      do_list(parser)
    File "/home/chris/bin/git-remote-hg", line 463, in do_list
      list_branch_head(repo, cur)
    File "/home/chris/bin/git-remote-hg", line 425, in list_branch_head
      tip = get_branch_tip(repo, cur)
    File "/home/chris/bin/git-remote-hg", line 418, in get_branch_tip
      return repo.branchtip(branch)
  AttributeError: 'mqrepo' object has no attribute 'branchtip'

Strip the second head and it's fine:

  $ hg -R hgtest strip 2
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  saved backup bundle to /tmp/hgtest/hgtest/.hg/strip-backup/ca09651009cb-backup.hg
  $ git clone hg::$PWD/hgtest gittest
  Cloning into 'gittest'...
  $

Not sure what the most friendly thing to do here is. Perhaps refuse to
clone/pull from a repo with multiple heads unless you name the specific head
you want?


The second thing I spotted is the behaviour of bookmarks on push:

  $ hg init hgtest && cd hgtest
  $ echo zero >foo && hg add foo && hg commit -m zero
  $ hg bookmark development
  $ cd ..
  $ git clone hg::$PWD/hgtest gittest && cd gittest
  Cloning into 'gittest'...
  $ git checkout development
  Branch development set up to track remote branch development from origin.
  Switched to a new branch 'development'
  $ echo one >foo && git add foo && git commit -m one
  [development 9f67dc4] one
   1 file changed, 1 insertion(+), 1 deletion(-)
  $ git status
  # On branch development
  # Your branch is ahead of 'origin/development' by 1 commit.
  #
  nothing to commit
  $ git push
  warning: helper reported unexpected status of refs/hg/origin/bookmarks/development
  To hg::/tmp/hgtest/hgtest
   * [new branch]      branches/default -> branches/default
   * [new branch]      development -> development
  $ hg log -R ../hgtest
  changeset:   1:1c0714d93864
  tag:         tip
  user:        Chris Webb <chris@arachsys.com>
  date:        Tue Oct 30 09:51:51 2012 +0000
  summary:     one

  changeset:   0:f56c463398ea
  bookmark:    development
  user:        Chris Webb <chris@arachsys.com>
  date:        Tue Oct 30 09:50:53 2012 +0000
  summary:     zero

i.e. the development bookmark hasn't been updated by the push. This might be
connected to the warning message

  warning: helper reported unexpected status of refs/hg/origin/bookmarks/development

I'm testing with hg 2.2.2 and current git master, so I expect this could be a
python api change in the more recent versions of hg if you don't see the same
behaviour.

Best wishes,

Chris.
