From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn set-tree bug
Date: Tue, 12 Jun 2007 01:39:10 -0700
Message-ID: <20070612083910.GA28369@muzzle>
References: <466C8B35.3020207@midwinter.com> <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle> <7vir9vox5l.fsf@assigned-by-dhcp.cox.net> <20070612072035.GA29385@muzzle> <7v1wghlj7j.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 10:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy1uN-0003jJ-7l
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 10:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbXFLIjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 04:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbXFLIjN
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 04:39:13 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38262 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992AbXFLIjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 04:39:12 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 672CF7DC09D;
	Tue, 12 Jun 2007 01:39:10 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 12 Jun 2007 01:39:10 -0700
Content-Disposition: inline
In-Reply-To: <7v1wghlj7j.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49936>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > If dcommit detects a merge commit when doing rev-list When looking at
> > commit objects, is it safe to assume that the first parent is always the
> > "mainline" and that parents after it are the ones to merge from?
> >
> > So if I saw:
> >
> > commit $X
> > parent $A
> > parent $B
> >
> > I'd basically do:
> >   reset --hard $A
> >   merge --squash $B
> >
> > And resulting in $C which would have the same tree as $X,
> > then, when dcommit-ting, $D would be created with two parents:
> >   $D~1 (svn), $B (git), but not $A
> 
> I am not sure what you mean by "mainline", but I assume that you
> mean "SVN is the main and we are tracking it while taking
> advantage of more efficient and merge-capable git in guerrilla
> fashion".  Because the tip of the current branch is what the
> user is pushing back to SVN via dcommit, I would say it is safe
> to assume that the first parent of such a merge is the line that
> corresponds to the SVN branch you are keeping track.

Yes, "mainline" meaning the history that would be committed to SVN if
history were linear.

I've gotten the following patch working for Joakim's second test script
(with dcommit before merge).  However, without the dcommit before merge
in the first test script, git-svn has trouble figuring out which history
to follow.  It'll take more work to figure out what to do in this
situation, and how to deal with more complex history...

Subject: git-svn: Allow dcommit to handle certain single-parent merge commits

This only works if a merge is the first commit to be committed
in a chain of commits.
---
 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0ae8d70..6b3e021 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -403,6 +403,9 @@ sub cmd_dcommit {
 			                svn_path => '');
 			if (!SVN::Git::Editor->new(\%ed_opts)->apply_diff) {
 				print "No changes\n$d~1 == $d\n";
+			} elsif (my $merge_parent = verify_ref("$d^2")) {
+				$gs->{inject_parents}->{$last_rev} =
+				                                 $merge_parent;
 			}
 		}
 	}
-- 
Eric Wong
