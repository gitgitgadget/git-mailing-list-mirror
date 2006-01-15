From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] cvsimport: ease migration from CVSROOT/users format
Date: Sun, 15 Jan 2006 03:30:30 -0800
Message-ID: <7vbqyd684p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 12:30:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ey65l-0000er-Ik
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 12:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbWAOLae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 06:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWAOLae
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 06:30:34 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:16884 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751904AbWAOLae (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 06:30:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115112929.MATK20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 Jan 2006 06:29:29 -0500
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14697>

This fixes a minor bug, which caused the author email to be
doubly enclosed in a <> pair (the code gave enclosing <> to
GIT_AUTHOR_EMAIL and GIT_COMMITTER_EMAIL environment variable).

The read_author_info() subroutine is taught to also understand
the user list in CVSROOT/users format.  This is primarily done
to ease migration for CVS users, who can use the -A option
to read from existing CVSROOT/users file.  write_author_info()
always writes in the git-cvsimport's native format ('='
delimited and value without quotes).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Andreas, I also tweaked the regexp to parse the native format
   from /^([^ \t=]*)[ \t=]*([^<]*)(<.*$)\s*/
   to /^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*$/.  I think this tweak is
   correct, but I would appreciate if you can proofread and ACK
   on it.  The differences are:

   - We did not require '=' anywhere, but accepted "= = =".
   - We had funny '$' in the middle; probably a typo. 
   - We first slurped author name with trailing whitespaces, only 
     to strip that separately in later steps.
   - We grabbed <> pairs and stored in author_email (this is a
     bugfix).

 git-cvsimport.perl |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

1b23ed3d1f9f3d83ea8b94ebc37c99e0ca32a09b
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8d493c2..3ddbdfa 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -48,16 +48,28 @@ sub read_author_info($) {
 	open my $f, '<', "$file" or die("Failed to open $file: $!\n");
 
 	while (<$f>) {
-		chomp;
-		# Expected format is this;
+		# Expected format is this:
 		#   exon=Andreas Ericsson <ae@op5.se>
-		if (m/^([^ \t=]*)[ \t=]*([^<]*)(<.*$)\s*/) {
+		if (m/^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*$/) {
 			$user = $1;
-			$conv_author_name{$1} = $2;
-			$conv_author_email{$1} = $3;
-			# strip trailing whitespace from author name
-			$conv_author_name{$1} =~ s/\s*$//;
+			$conv_author_name{$user} = $2;
+			$conv_author_email{$user} = $3;
 		}
+		# However, we also read from CVSROOT/users format
+		# to ease migration.
+		elsif (/^(\w+):(['"]?)(.+?)\2\s*$/) {
+			my $mapped;
+			($user, $mapped) = ($1, $3);
+			if ($mapped =~ /^\s*(.*?)\s*<(.*)>\s*$/) {
+				$conv_author_name{$user} = $1;
+				$conv_author_email{$user} = $2;
+			}
+			elsif ($mapped =~ /^<?(.*)>?$/) {
+				$conv_author_name{$user} = $user;
+				$conv_author_email{$user} = $1;
+			}
+		}
+		# NEEDSWORK: Maybe warn on unrecognized lines?
 	}
 	close ($f);
 }
@@ -68,8 +80,7 @@ sub write_author_info($) {
 	  die("Failed to open $file for writing: $!");
 
 	foreach (keys %conv_author_name) {
-		print $f "$_=" . $conv_author_name{$_} .
-		  " " . $conv_author_email{$_} . "\n";
+		print $f "$_=$conv_author_name{$_} <$conv_author_email{$_}>\n";
 	}
 	close ($f);
 }
-- 
1.1.2-gd425
