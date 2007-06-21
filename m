From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set correct date for tags.
Date: Wed, 20 Jun 2007 19:52:32 -0700
Message-ID: <7vzm2u3tov.fsf@assigned-by-dhcp.pobox.com>
References: <11823921031931-git-send-email-dmo@roaringpenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dave O'Neill" <dmo@roaringpenguin.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 04:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Cml-00045k-3I
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 04:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbXFUCwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 22:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbXFUCwe
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 22:52:34 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:37626 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbXFUCwe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 22:52:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621025233.PIHW1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Jun 2007 22:52:33 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E2sY1X00S1kojtg0000000; Wed, 20 Jun 2007 22:52:33 -0400
In-Reply-To: <11823921031931-git-send-email-dmo@roaringpenguin.com> (Dave
	O'Neill's message of "Wed, 20 Jun 2007 22:15:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50584>

I suspect (I haven't looked at the evolution history of these
import scripts) this was copied from git-cvsimport.perl.  I
would prefer to fix it the same way as 5c08931, which looks like
this:

commit 5c08931dfc9fa0acbf8667581e4c98d643e66dbe
Author: Elvis Pranskevichus <el@prans.net>

    Use git-tag in git-cvsimport
---
 git-cvsimport.perl |   26 ++------------------------
 1 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 4e6c9c6..524c9bb 100755
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
+		system('git-tag', $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
-		print C "$tagobj\n"
-			or die "Cannot write tag $xtag: $!\n";
-		close(C)
-			or die "Cannot write tag $xtag: $!\n";
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
 	}
