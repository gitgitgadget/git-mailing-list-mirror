From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Wed, 11 Jan 2012 18:31:01 +0100
Message-ID: <20120111173101.GQ30469@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Christian Couder <chriscool@tuxfamily.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 18:40:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl29k-0004QQ-O8
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 18:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899Ab2AKRgl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 12:36:41 -0500
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:29322 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757847Ab2AKRgl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 12:36:41 -0500
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jan 2012 12:36:41 EST
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Jan
 2012 18:30:59 +0100
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Jan
 2012 18:31:01 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188378>

Hi,

I did some multi-commit cherry-picks lately, and noticed that
sometimes cherry-pick applied the commits in different order than I
specified on the command line.  After some debugging, today I could
finally come up with a receipe to reproduce:

  git init
  echo 1 >a && git add a
  git commit -m a
  echo 2 >b && git add b
  git commit -m b
  sleep 2 && echo 3 >c && git add c
  git commit -m c
  git checkout -b branch HEAD^^
  git cherry-pick master master^    # the later commit first

where the 'git cherry-pick' command produces the following output:

[branch ef5b86e0] b
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 b
[branch 6a74f934] c
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 c

Notice that master^, i.e. the commit adding the file 'b', is picked
before master, i.e. the commit adding 'c', although the order on the
command line was the reverse.

This is because

  cmd_cherry_pick()
    pick_revisions()
      walk_revs_populate_todo()
        prepare_revs()

calls prepare_revision_walk(), which parses the commits from the
command line in the order they were specified, but inserts them into a
list ordered by date, and commits will be picked in the order they
appear in this list.  So if you specify commits in a different order
than their committer date or commits with the same commiter date
(which are often produced by am, rebase, and multi-commit
cherry-pick), then they will be picked in wrong order.

As far as I can tell, this buggy behavior is as old as multi-commit
cherry-pick itself, i.e. 7e2bfd3f (revert: allow cherry-picking more
than one commit, 2010-06-02).


Best,
G=E1bor
