From: Elvis Pranskevichus <el@prans.net>
Subject: [PATCH] Use git-tag in git-cvsimport
Date: Sun,  3 Jun 2007 02:56:36 -0400
Message-ID: <11808537962798-git-send-email-el@prans.net>
Cc: Elvis Pranskevichus <el@prans.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 09:31:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HukYd-00057W-Lc
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 09:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbXFCHbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 03:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbXFCHbQ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 03:31:16 -0400
Received: from prans.org ([209.59.209.223]:58532 "EHLO prans.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173AbXFCHbP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 03:31:15 -0400
X-Greylist: delayed 1998 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jun 2007 03:31:15 EDT
Received: from cpe0015f287cf0c-cm0011e6ecad14.cpe.net.cable.rogers.com ([74.102.18.24] helo=asgard.prans.org)
	by prans.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <el@prans.net>)
	id 1Huk2G-0008KO-DJ; Sat, 02 Jun 2007 23:57:56 -0700
Received: from el by asgard.prans.org with local (Exim 4.67)
	(envelope-from <el@asgard.prans.org>)
	id 1Huk0y-0005uR-5q; Sun, 03 Jun 2007 02:56:36 -0400
X-Mailer: git-send-email 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48977>

Currently git-cvsimport tries to create tag objects directly via git-mktag
in a very broken way, e.g the stuff it writes into the tagger field of
the tag object doesn't really resemble the GIT_COMMITTER_IDENT. This makes
gitweb and possibly other tools that try to interpret tag objects to be
confused about tag date and authorship.

Fix this by calling git-tag instead. This also has a nice side effect of
not creating the tag object but only the lightweight tag as that's the only
thing CVS has anyways.

Signed-off-by: Elvis Pranskevichus <el@prans.net>
---
 git-cvsimport.perl |   26 ++------------------------
 1 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index f68afe7..d5ca66b 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -771,31 +771,9 @@ sub commit {
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
-		
-		my $pid = open2($in, $out, 'git-mktag');
-		print $out "object $cid\n".
-		    "type commit\n".
-		    "tag $xtag\n".
-		    "tagger $author_name <$author_email>\n"
-		    or die "Cannot create tag object $xtag: $!\n";
-		close($out)
-		    or die "Cannot create tag object $xtag: $!\n";
-
-		my $tagobj = <$in>;
-		chomp $tagobj;
-
-		if ( !close($in) or waitpid($pid, 0) != $pid or
-		     $? != 0 or $tagobj !~ /^[0123456789abcdef]{40}$/ ) {
-		    die "Cannot create tag object $xtag: $!\n";
-	        }
-		
-
-		open(C,">$git_dir/refs/tags/$xtag")
+
+		system("git-tag $xtag $cid") == 0
 			or die "Cannot create tag $xtag: $!\n";
-		print C "$tagobj\n"
-			or die "Cannot write tag $xtag: $!\n";
-		close(C)
-			or die "Cannot write tag $xtag: $!\n";
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
 	}
-- 
1.5.2
