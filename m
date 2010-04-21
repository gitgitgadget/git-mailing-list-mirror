From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess,iffy,mismatch] Re: [PATCH/RFC 2/2] git-svn: Don't
 allow missing commit parent to  stop git-svn
Date: Thu, 22 Apr 2010 11:45:11 +1200
Message-ID: <4BCF8E07.9080507@vilain.net>
References: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com>  <1271880470.20208.47.camel@denix> <m2sc8b3bef91004211417n1f3368a7ica94a1c2a7656622@mail.gmail.com>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Thu Apr 22 02:03:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4jtX-0000w8-2M
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 02:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588Ab0DVADq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 20:03:46 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:39326 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381Ab0DVADp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 20:03:45 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2010 20:03:45 EDT
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id A324FFCD1A; Thu, 22 Apr 2010 11:54:30 +1200 (NZST)
In-Reply-To: <m2sc8b3bef91004211417n1f3368a7ica94a1c2a7656622@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145480>

Michael Olson wrote:
> Interestingly, I see people reporting the same problem in the thread
> "git svn clone of subversion's own code failing".  So it's not just
> related to patch 1/2 of this series.  At least that thread has a
> public-facing repo so the problem should be easier to reproduce for
> a real fix.

Oh, right ... I remember that issue now. I'm currently testing the
below change to see if it breaks the test suite; any issues and I'll
post an update.

Subject: [PATCH] git-svn: deal with svn cherry-picks with non-linear history

The expression 'BASE^..TIP' is only defined when BASE has parents.  It
actually does what it intends only when it has one parent.

Allow for more complicated revision list arguments than a range by
splitting any space-containing arguments on the way into _rev_list,
and check the parents of the bottom commit so that we may use the
correct revision list specifier.
---
 git-svn.perl |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2c86ea2..a82ca1a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3063,8 +3063,24 @@ sub lookup_svn_merge {
 			next;
 		}
 
-		push @merged_commit_ranges,
-			"$bottom_commit^..$top_commit";
+		# how many parents does $bottom_commit have?
+		my @parents = split / /, command_oneline(
+			qw(rev-list --parents -1 -m),
+			$bottom_commit,
+		       );
+		shift @parents;
+
+		if ( @parents == 1 ) {
+			push @merged_commit_ranges,
+				"$bottom_commit^..$top_commit";
+		}
+		elsif ( @parents ) {
+			push @merged_commit_ranges,
+				"$top_commit --not @parents";
+		}
+		else {
+			push @merged_commit_ranges, $top_commit;
+		}
 
 		if ( !defined $tip or $top > $tip ) {
 			$tip = $top;
@@ -3094,7 +3110,7 @@ sub check_cherry_pick {
 	my %commits = map { $_ => 1 }
 		_rev_list("--no-merges", $tip, "--not", $base);
 	for my $range ( @ranges ) {
-		delete @commits{_rev_list($range)};
+		delete @commits{_rev_list(split " ", $range)};
 	}
 	for my $commit (keys %commits) {
 		if (has_no_changes($commit)) {
-- 
1.7.0.2
