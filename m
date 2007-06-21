From: "Dave O'Neill" <dmo@roaringpenguin.com>
Subject: [PATCH] Let git-svnimport clean up SVK commit messages.
Date: Wed, 20 Jun 2007 22:14:55 -0400
Message-ID: <1182392095394-git-send-email-dmo@roaringpenguin.com>
Cc: "Dave O'Neill" <dmo@roaringpenguin.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 04:31:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1CSG-0001WH-5V
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 04:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbXFUCbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 22:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbXFUCbJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 22:31:09 -0400
Received: from www.roaringpenguin.com ([206.191.13.82]:3969 "EHLO
	www.roaringpenguin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbXFUCbG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 22:31:06 -0400
X-Greylist: delayed 968 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2007 22:31:05 EDT
Received: from magnesium.roaringpenguin.com (ottawa-hs-64-26-171-99.s-ip.magma.ca [64.26.171.99])
	by www.roaringpenguin.com (8.14.1/8.14.0) with ESMTP id l5L2EtQf001812
	for <git@vger.kernel.org>; Wed, 20 Jun 2007 22:14:55 -0400
Received: from localhost.localdomain (oxygen.roaringpenguin.com [192.168.10.8])
	by magnesium.roaringpenguin.com (8.12.10/8.12.10) with ESMTP id l5L2EtWo005701;
	Wed, 20 Jun 2007 22:14:55 -0400
X-Mailer: git-send-email 1.5.2.2.239.g89630
X-Scanned-By: CanIt (www . roaringpenguin . com) on 206.191.13.82
X-Scanned-By: MIMEDefang 2.57 on 192.168.10.12
X-Spam-Score: undef - spam scanning disabled
X-CanItPRO-Stream: outgoing (inherits from default)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50583>

SVK likes to begin all commit messages with a line of the format:
   r12345@hostname: user | YYYY-MM-DD HH:MM:SS -ZZZZ
which makes the import desperately ugly in git.  This adds a -k option to move
this extra SVK commit line to the end of the commit message, rather than
keeping it at the beginning.
---
 Documentation/git-svnimport.txt |    6 +++++-
 git-svnimport.perl              |   18 +++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index e97d15e..23a54b0 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 --------
 [verse]
 'git-svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
-		[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
+		[ -C <GIT_repository> ] [ -i ] [ -k ] [ -u ] [-l limit_rev]
 		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
 		[ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
 		[ -I <ignorefile_name> ] [ -A <author_file> ]
@@ -68,6 +68,10 @@ When importing incrementally, you might need to edit the .git/svn2git file.
 	Prepend 'rX: ' to commit messages, where X is the imported
 	subversion revision.
 
+-k::
+	Remove SVK-style revision/commiter info from the top of commit
+	messages and move it to the bottom.
+
 -I <ignorefile_name>::
 	Import the svn:ignore directory property to files with this
 	name in each directory. (The Subversion and GIT ignore
diff --git a/git-svnimport.perl b/git-svnimport.perl
index f459762..7076f41 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -32,20 +32,20 @@ $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
     $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F,
-    $opt_P,$opt_R);
+    $opt_P,$opt_R,$opt_k);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from SVN
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev] [-R repack_each_revs]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
-       [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
+       [-d|-D] [-i] [-k] [-u] [-r] [-I ignorefilename] [-s start_chg]
        [-m] [-M regex] [-A author_file] [-S] [-F] [-P project_name] [SVN_URL]
 END
 	exit(1);
 }
 
-getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:R:uv") or usage();
+getopts("A:b:C:dDFhiI:kl:mM:o:rs:t:T:SP:R:uv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
@@ -835,7 +835,19 @@ sub commit {
 		$pw->writer();
 		$pr->reader();
 
+
+		if ( $opt_k ) {
+			# Remove SVK cruft in commit message
+			my ($svk_info) = $message =~ s{(r\d+\@[^:]+:\s+\S+\s+\|\s+\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\s[\+-]\d{4})\s*}{};
+			if( $svk_info ) {
+				# and stick it on the end so we don't lose it
+				$message .= "\n$svk_info"
+			}
+		}
+
+
 		$message =~ s/[\s\n]+\z//;
+
 		$message = "r$revision: $message" if $opt_r;
 
 		print $pw "$message\n"
-- 
1.5.2.2.239.g89630
