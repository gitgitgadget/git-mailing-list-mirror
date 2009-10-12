From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 0/5] Pretty formats for reflog data
Date: Mon, 12 Oct 2009 23:06:02 +0200
Message-ID: <cover.1255380039.git.trast@student.ethz.ch>
References: <20091012175201.GA10263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	<git@vger.kernel.org>
To: Jef Driesen <jefdriesen@hotmail.com>,
	Jef Driesen <jefdriesen@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDg-0002of-Ob
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933055AbZJLVHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933007AbZJLVHb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:07:31 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:56482 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932695AbZJLVHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:07:30 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 23:06:42 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 23:06:44 +0200
X-Mailer: git-send-email 1.6.5.64.g01287
In-Reply-To: <20091012175201.GA10263@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130067>

[I forgot to address the list on the first batch, sorry for the spam.]

Jeff King wrote:
> On Mon, Oct 12, 2009 at 05:47:34PM +0200, Jef Driesen wrote:
> 
> > Is it possible to make "git stash list" show more than 10 items?
> 
> Try "git stash list -30".
> 
> Stash listing is internally just "git log -g refs/stash", so you can
> pass any formatting or limiting arguments you want there (see the git
> log documentation for ideas). If no arguments are given, we pass "-10".

This seems fairly arbitrary, doesn't it?  My own working theory is
that Nanako put it in because the git-log|sed construct inherently
bars any way to a pager, so it needs to be cut short.

So suppose we could somehow get rid of the |sed... like if we had
--pretty specifiers for the reflog information.

Sadly

  git log -g --format="%h %g: %G"

still fails to exactly replicate the reflog format: if the reflog was
cut off during garbage collection, the last entry refers to a no
longer existing commit causing a stray ':' on that line.  Oh, well.

It's also still RFC because:

* I don't like the massive code churn in 2/5, maybe someone sees a
  better option.

* 5/5 has a pretty lame excuse.  I could also just change it in 'git
  stash list' to limit the backwards-incompatibility damage, but
  that's also a maintenance headache.


Thomas Rast (5):
  reflog-walk: refactor the branch@{num} formatting
  Introduce new pretty formats %g and %G for reflog information
  stash: Use new %g/%G formats instead of sed
  stash list: drop the default limit of 10 stashes
  stash: change built-in ref to 'stash' instead of 'refs/stash'

 archive.c             |    2 +-
 builtin-branch.c      |    3 +-
 builtin-checkout.c    |    2 +-
 builtin-commit.c      |    4 +-
 builtin-log.c         |    2 +-
 builtin-merge.c       |    2 +-
 builtin-rev-list.c    |    2 +-
 builtin-shortlog.c    |    2 +-
 builtin-show-branch.c |    2 +-
 commit.h              |    7 +++-
 git-stash.sh          |   10 +-----
 log-tree.c            |    4 +-
 pretty.c              |   20 +++++++++++--
 reflog-walk.c         |   72 ++++++++++++++++++++++++++++++++++---------------
 reflog-walk.h         |    7 +++++
 15 files changed, 94 insertions(+), 47 deletions(-)
