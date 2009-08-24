From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH v2] import-tars: Allow per-tar author and commit message.
Date: Mon, 24 Aug 2009 18:55:32 +0100
Message-ID: <20090824175740.71AE22FC20@perkele>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 19:57:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfdnn-0000f3-Bi
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 19:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbZHXR5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 13:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753067AbZHXR5l
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 13:57:41 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40180 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752944AbZHXR5k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 13:57:40 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOW00KGI7852J30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 24 Aug 2009 19:57:41 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOW001SV7841U30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 24 Aug 2009 19:57:41 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.24.174217
Received: by perkele (Postfix, from userid 501)	id 71AE22FC20; Mon,
 24 Aug 2009 19:57:40 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126949>

Instead of having each imported tar ball's commit message be "Imported
from filename.tar", optionally take a commit message from a file
called "filename.tar.msg". The author and committer of the tar ball
can also be overridden by embedding an "Author:" or "Committer:" header
in the .msg file.

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
Instead of having a .author and .committer file to override the author
and committer, allow embedding this information in the .msg file, as
suggested by Sam Vilain <sam@vilain.net>.

 contrib/fast-import/import-tars.perl |   38 +++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 78e40d2..0d59434 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -109,12 +109,44 @@ foreach my $tar_file (@ARGV)
 		$have_top_dir = 0 if $top_dir ne $1;
 	}
 
+	# Optionally read a commit message from <filename.tar>.msg
+	# Add a line on the form "Committer: name <e-mail>" to override
+	# the committer and "Author: name <e-mail>" to override the
+	# author for this tar ball.
+	my $commit_msg = "Imported from $tar_file.";
+	my $this_committer_name = $committer_name;
+	my $this_committer_email = $committer_email;
+	my $this_author_name = $author_name;
+	my $this_author_email = $author_email;
+	if (open MSG, '<', "${tar_file}.msg")
+	{
+		$commit_msg = '';
+		while (<MSG>)
+		{
+			if (/^Committer:\s+([^<>]*)\s+<(.*)>\s*$/i)
+			{
+				$this_committer_name = $1;
+				$this_committer_email = $2;
+			}
+			elsif (/^Author:\s+([^<>]*)\s+<(.*)>\s*$/i)
+			{
+				$this_author_name = $1;
+				$this_author_email = $2;
+			}
+			else
+			{
+				$commit_msg .= $_;
+			}
+		}
+		close MSG;
+	}
+
 	print FI <<EOF;
 commit $branch_ref
-author $author_name <$author_email> $author_time +0000
-committer $committer_name <$committer_email> $commit_time +0000
+author $this_author_name <$this_author_email> $author_time +0000
+committer $this_committer_name <$this_committer_email> $commit_time +0000
 data <<END_OF_COMMIT_MESSAGE
-Imported from $tar_file.
+$commit_msg
 END_OF_COMMIT_MESSAGE
 
 deleteall
-- 
1.6.3.3
