From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH 1/2] git-svn: don't append extra newlines at the end of commit messages.
Date: Thu, 12 Jun 2008 19:10:50 -0400
Message-ID: <1213312251-8081-1-git-send-email-apenwarr@gmail.com>
Cc: gitster@pobox.com, Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 01:19:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6w4L-0003oQ-MP
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 01:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756850AbYFLXSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 19:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756252AbYFLXSG
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 19:18:06 -0400
Received: from host.239.160.mtl.cablemodem.vdn.ca ([206.223.239.160]:52906
	"EHLO insight.mtl.versabanq.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755988AbYFLXSG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 19:18:06 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jun 2008 19:18:05 EDT
Received: by insight.mtl.versabanq.com (Postfix, from userid 1000)
	id 857CEE7C532; Thu, 12 Jun 2008 19:10:51 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.rc2.26.g8c37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84812>

In git, all commits end in exactly one newline character.  In svn, commits
end in zero or more newlines.  Thus, when importing commits from svn into
git, git-svn always appends two extra newlines to ensure that the
git-svn-id: line is separated from the main commit message by at least one
blank line.

Combined with the terminating newline that's always present in svn commits
produced by git, you usually end up with two blank lines instead of one
between the commit message and git-svn-id: line, which is undesirable.

Instead, let's remove all trailing whitespace from the git commit on the way
through to svn.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 git-svn.perl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 47b0c37..a54979d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1023,6 +1023,7 @@ sub get_commit_entry {
 		my $in_msg = 0;
 		my $author;
 		my $saw_from = 0;
+		my $msgbuf = "";
 		while (<$msg_fh>) {
 			if (!$in_msg) {
 				$in_msg = 1 if (/^\s*$/);
@@ -1035,14 +1036,15 @@ sub get_commit_entry {
 				if (/^From:/ || /^Signed-off-by:/) {
 					$saw_from = 1;
 				}
-				print $log_fh $_ or croak $!;
+				$msgbuf .= $_;
 			}
 		}
+		$msgbuf =~ s/\s+$//s;
 		if ($Git::SVN::_add_author_from && defined($author)
 		    && !$saw_from) {
-			print $log_fh "\nFrom: $author\n"
-			      or croak $!;
+			$msgbuf .= "\n\nFrom: $author";
 		}
+		print $log_fh $msgbuf or croak $!;
 		command_close_pipe($msg_fh, $ctx);
 	}
 	close $log_fh or croak $!;
-- 
1.5.4.3
