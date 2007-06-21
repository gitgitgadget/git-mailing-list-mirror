From: "Dave O'Neill" <dmo@roaringpenguin.com>
Subject: [PATCH] Generate tags with correct timestamp (git-svnimport)
Date: Thu, 21 Jun 2007 17:48:56 -0400
Message-ID: <11824625361092-git-send-email-dmo@roaringpenguin.com>
References: <7vzm2u3tov.fsf@assigned-by-dhcp.pobox.com>
Cc: "Dave O'Neill" <dmo@roaringpenguin.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 23:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1UWb-0001Hp-Jf
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 23:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbXFUVs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 17:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbXFUVs6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 17:48:58 -0400
Received: from www.roaringpenguin.com ([206.191.13.82]:4377 "EHLO
	www.roaringpenguin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbXFUVs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 17:48:57 -0400
Received: from magnesium.roaringpenguin.com (ottawa-hs-64-26-171-99.s-ip.magma.ca [64.26.171.99])
	by www.roaringpenguin.com (8.14.1/8.14.0) with ESMTP id l5LLmuE1010205
	for <git@vger.kernel.org>; Thu, 21 Jun 2007 17:48:56 -0400
Received: from localhost.localdomain (oxygen.roaringpenguin.com [192.168.10.8])
	by magnesium.roaringpenguin.com (8.12.10/8.12.10) with ESMTP id l5LLmuWo006259;
	Thu, 21 Jun 2007 17:48:56 -0400
X-Mailer: git-send-email 1.5.2.2.239.g89630
In-Reply-To: <7vzm2u3tov.fsf@assigned-by-dhcp.pobox.com>
X-Scanned-By: CanIt (www . roaringpenguin . com) on 206.191.13.82
X-Scanned-By: MIMEDefang 2.57 on 192.168.10.12
X-Spam-Score: undef - spam scanning disabled
X-CanItPRO-Stream: outgoing (inherits from default)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50656>

Now uses git-tag instead of manually constructing the tag.  This gives us a
correct timestamp, removes some crufty code, and makes it work the same as
git-cvsimport.

The generated tags are now lightweight tags instead of tag objects, which may
or may not be the behaviour we want.

Also, remove two unused variables from git-cvsimport.
---
 git-cvsimport.perl |    1 -
 git-svnimport.perl |   24 ++----------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 433b7fd..69ccb88 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -774,7 +774,6 @@ sub commit {
 		or die "Cannot write branch $branch for update: $!\n";
 
 	if ($tag) {
-		my ($in, $out) = ('','');
 	        my ($xtag) = $tag;
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
diff --git a/git-svnimport.perl b/git-svnimport.perl
index f459762..32832ad 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -868,33 +868,13 @@ sub commit {
 	}
 
 	if($tag) {
-		my($in, $out) = ('','');
 		$last_rev = "-" if %$changed_paths;
 		# the tag was 'complex', i.e. did not refer to a "real" revision
 
 		$dest =~ tr/_/\./ if $opt_u;
-		$branch = $dest;
-
-		my $pid = open2($in, $out, 'git-mktag');
-		print $out ("object $cid\n".
-		    "type commit\n".
-		    "tag $dest\n".
-		    "tagger $committer_name <$committer_email> 0 +0000\n") and
-		close($out)
-		    or die "Cannot create tag object $dest: $!\n";
-
-		my $tagobj = <$in>;
-		chomp $tagobj;
-
-		if ( !close($in) or waitpid($pid, 0) != $pid or
-				$? != 0 or $tagobj !~ /^[0123456789abcdef]{40}$/ ) {
-			die "Cannot create tag object $dest: $!\n";
-		}
 
-		open(C,">$git_dir/refs/tags/$dest") and
-		print C ("$tagobj\n") and
-		close(C)
-			or die "Cannot create tag $branch: $!\n";
+		system('git-tag', $dest, $cid) == 0
+			or die "Cannot create tag $dest: $!\n";
 
 		print "Created tag '$dest' on '$branch'\n" if $opt_v;
 	}
-- 
1.5.2.2.239.g89630
