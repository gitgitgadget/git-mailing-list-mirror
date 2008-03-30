From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH/RFC] git-cvsimport: When fetching a file and an error occurs, disconnect and retry
Date: Sun, 30 Mar 2008 03:50:07 +0200
Message-ID: <1206841808-24605-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 04:30:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfnJ4-000213-Ty
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 04:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbYC3C3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 22:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbYC3C3H
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 22:29:07 -0400
Received: from smtp.nextra.cz ([195.70.130.2]:3764 "EHLO smtp.nextra.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbYC3C3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 22:29:06 -0400
X-Greylist: delayed 2328 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Mar 2008 22:29:06 EDT
Received: from resox (unknown [213.29.198.144])
	by smtp.nextra.cz (Postfix) with ESMTP id 59F3E5DA1;
	Sun, 30 Mar 2008 03:50:08 +0200 (CEST)
Received: from wsh by resox with local (Exim 4.69)
	(envelope-from <wsh@resox.local>)
	id 1JfmgS-0006PC-13; Sun, 30 Mar 2008 03:50:08 +0200
X-Mailer: git-send-email 1.5.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78496>

I imported my repositories from CVSNT server 1.11.1.3 and on some of
them import died with error like this:

Fetching libvideo\libvideo/libvideo.dsp   v 1.1.1.1
Unknown: error

After some searching I have found that the reason is probably wrong
naming of my directories (i.e. directories with the same name at
different locations). I'm not CVS guru but guess that CVS server tracks
what we are downloading and assumes that we are downloading all
subdirectories (at all levels) to one common directory. If more
subdirectories have the same name, it refuses to send the latter ones to
avoid overwriting the first one.

The dump of TCP communication was like this:

C: Argument -N
C: Argument -P
C: Argument -r
C: Argument 1.1
C: Argument --
C: Argument video/libvideo\libvideo/libvideo.dsp
C: Directory .
C: /d//cvs
C: co
S: E cvs server: existing repository d:/cvs/video/libvideo does not match d:/cvs/video/libvideo\libvideo
S: E cvs server: ignoring module video/libvideo\libvideo/libvideo.dsp
S: error

This patch solved the problem for me. When the error is received,
instead of dying immediately, the connection is closed, then opened again
and the second fetch attempt is executed.
---
 git-cvsimport.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 95c5eec..b33ed53 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -438,7 +438,10 @@ sub _line {
 				die "Unknown: $line" if $line ne "ok";
 				return -1;
 			} else {
-				die "Unknown: $line\n";
+				STDOUT->flush(); # To see which file cannot be fetched
+				print STDERR "Unexpected response: $line\nDisconnecting and retrying...\n";
+				$self->{"socketo"}->close();
+				return -2;
 			}
 		}
 	}
@@ -453,13 +456,13 @@ sub file {
 
 	$self->_file($fn,$rev) and $res = $self->_line($fh);
 
-	if (!defined $res) {
-	    print STDERR "Server has gone away while fetching $fn $rev, retrying...\n";
+	if (!defined $res || $res == -2) {
+	    print STDERR "Server has gone away while fetching $fn $rev, retrying...\n" if !defined $res;
 	    truncate $fh, 0;
 	    $self->conn();
 	    $self->_file($fn,$rev) or die "No file command send";
 	    $res = $self->_line($fh);
-	    die "Retry failed" unless defined $res;
+	    die "Retry failed" unless (defined $res && $res != -2);
 	}
 	close ($fh);
 
-- 
1.5.4.5
