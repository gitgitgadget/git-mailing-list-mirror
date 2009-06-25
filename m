From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: Support multiple branch and tag paths in the
	svn repository.
Date: Thu, 25 Jun 2009 02:36:02 -0700
Message-ID: <20090625093602.GA3997@dcvr.yhbt.net>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 11:37:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJlNL-0004nO-Gn
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 11:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948AbZFYJgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 05:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755941AbZFYJgA
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 05:36:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46115 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755894AbZFYJf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 05:35:59 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1DF1F44D;
	Thu, 25 Jun 2009 09:36:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A410A90.1090101@xiplink.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122188>

Marc Branchaud <marcnarc@xiplink.com> wrote:
> This enables git-svn.perl to read multiple 'branches' and 'tags' entries in
> svn-remote config sections.  The init and clone subcommands also support
> multiple --branches and --tags arguments.
> 
> The branch (and tag) subcommand gets a new argument: --destination (or -d).
> This argument is required if there are multiple branches (or tags) entries
> configured for the remote Subversion repository.  The argument's value
> specifies which branch (or tag) path to use to create the branch (or tag).
> The specified value must match the left side (without wildcards) of one of
> the branches (or tags) refspecs in the svn-remote's config.
> 
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
> 
> I got carried away making unit tests and went and implemented most of this...
> 
> I'm fairly happy with this, except for the way the branch subcommand matches
> refspecs.  The patch does a simple string comparison, but it'd be better to do
> an actual glob.  I just couldn't track down the right function for that, so I
> left it as a strcmp and hope that a gitizen can tell me how to glob here.
> 
> (ps. I'm trying a new way to send patches -- apologies if it's mangled!)

Thanks Marc!  Everything looks fine here; I don't think I'll have time
to test it myself any time soon but your test case looks good and
doesn't break any of the other tests :)  Sorry for the delay, I haven't
had access to my computer or email much in the past few weeks.

Acked and and pushed out to git://git.bogomips.org/git-svn along with a
followup patch to convert the glob to a regexp for branching:

>From f7050599310c18bd67b35b8d59486116b30ff1f6 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Thu, 25 Jun 2009 02:28:15 -0700
Subject: [PATCH] git-svn: convert globs to regexps for branch destinations

Marc Branchaud wrote:
> I'm fairly happy with this, except for the way the branch
> subcommand matches refspecs.  The patch does a simple string
> comparison, but it'd be better to do an actual glob.  I just
> couldn't track down the right function for that, so I left it as
> a strcmp and hope that a gitizen can tell me how to glob here.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 I haven't actually tested it, and yes, it should probably be
 moved to Git.pm even though it's not necessarily git-only...

 git-svn.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 48e8aad..6c42e2a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -646,7 +646,9 @@ sub cmd_branch {
 		            " with the --destination argument.\n";
 		}
 		foreach my $g (@{$allglobs}) {
-			if ($_branch_dest eq $g->{path}->{left}) {
+			# SVN::Git::Editor could probably be moved to Git.pm..
+			my $re = SVN::Git::Editor::glob2pat($g->{path}->{left});
+			if ($_branch_dest =~ /$re/) {
 				$glob = $g;
 				last;
 			}
-- 
Eric Wong
