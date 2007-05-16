From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] import-tars: Use the "Link indicator" to identify directories
Date: Wed, 16 May 2007 17:22:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705161659530.6410@racer.site>
References: <6efbd9b70705111308v47a76b04n9328ebf393a209e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org
To: Chris Riddoch <riddochc@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 18:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoMGi-0005bv-Ue
	for gcvg-git@gmane.org; Wed, 16 May 2007 18:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbXEPQWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 12:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbXEPQWX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 12:22:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:43622 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756223AbXEPQWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 12:22:22 -0400
Received: (qmail invoked by alias); 16 May 2007 16:22:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 16 May 2007 18:22:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GhGFfy/cG4JFtUNJVWA2jXihkm2ScTedgegI26f
	VKyncyClzQyoiE
X-X-Sender: gene099@racer.site
In-Reply-To: <6efbd9b70705111308v47a76b04n9328ebf393a209e6@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47442>


Earlier, we used the mode to determine if a name was associated with
a directory. This fails, since some tar programs do not set the mode
correctly. However, the link indicator _has_ to be set correctly.

Noticed by Chris Riddoch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 11 May 2007, Chris Riddoch wrote:

	> I believe I've uncovered an issue in fast-import, but I don't 
	> know the code well enough yet to debug it.  So, I'll produce my 
	> evidence and let others work on finding the solution.  It should 
	> be pretty easy to reproduce.

	It was easy. Thanks.

	The problem is -- again -- that a directory is overwritten, since 
	it is not recognized as a directory. Earlier, I tried to use the 
	trailing "/" for that. Which fails with your example.

	I actually took the time to research in Wikipedia what should be 
	the correct way to find out if the current item is a directory...

 contrib/fast-import/import-tars.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 1e6fa5a..23aeb25 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -75,7 +75,7 @@ foreach my $tar_file (@ARGV)
 		$mode = oct $mode;
 		$size = oct $size;
 		$mtime = oct $mtime;
-		next if $mode & 0040000;
+		next if $typeflag == 5; # directory
 
 		print FI "blob\n", "mark :$next_mark\n", "data $size\n";
 		while ($size > 0 && read(I, $_, 512) == 512) {
-- 
1.5.2.rc3.2506.ge455
