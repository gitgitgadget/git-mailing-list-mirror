From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH] import-tars: Allow per-tar author and commit message.
Date: Sun, 23 Aug 2009 21:34:33 +0100
Message-ID: <20090823203640.B195D189B12@perkele>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 22:36:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfJo2-0005HW-JQ
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 22:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934132AbZHWUgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 16:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934129AbZHWUgm
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 16:36:42 -0400
Received: from smtp.getmail.no ([84.208.15.66]:36291 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934118AbZHWUgl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 16:36:41 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOU00E2FJX6NG10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 23 Aug 2009 22:36:42 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOU004TIJX53W70@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 23 Aug 2009 22:36:42 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.23.202116
Received: by perkele (Postfix, from userid 501)	id B195D189B12; Sun,
 23 Aug 2009 22:36:40 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126875>

Instead of having each imported tar ball's commit message be "Imported
from filename.tar", optionally take a commit message from a file
called "filename.tar.msg".

Instead of having each commit have the same author and committer
information, optionally read the committer information from a file
called "filename.tar.committer" and author from a file called
"filename.tar.author".

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
I used this (albeit based on a slightly earlier verison of the script)
to generate a better-looking history when importing
http://git.debian.org/?p=crashmail/jamnntpd.git and
http://git.debian.org/?p=crashmail/crashmail.git into Git, using
excerpts from the embedded change history as commit messages.

 contrib/fast-import/import-tars.perl |   42 +++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 78e40d2..7aad16f 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -109,12 +109,48 @@ foreach my $tar_file (@ARGV)
 		$have_top_dir = 0 if $top_dir ne $1;
 	}
 
+	# Optionally read a commit message from <filename.tar>.msg
+	my $commit_msg = "Imported from $tar_file.";
+	if (open MSG, '<', "${tar_file}.msg")
+	{
+		$commit_msg = '';
+		while (<MSG>)
+		{
+			$commit_msg .= $_;
+		}
+		close MSG;
+	}
+
+	# Optionally read a committer from <filename.tar>.committer
+	# (first line is name, second line is e-mail address).
+	my $this_committer_name = $committer_name;
+	my $this_committer_email = $committer_email;
+	if (open COMMITTER, '<', "${tar_file}.committer")
+	{
+		($this_committer_name, $this_committer_email) = <COMMITTER>;
+		chomp $this_committer_name;
+		chomp $this_committer_email;
+		close COMMITTER;
+	}
+
+	# Optionally read an author from <filename.tar>.author
+	# (first line is name, second line is e-mail address).
+	my $this_author_name = $author_name;
+	my $this_author_email = $author_email;
+	if (open AUTHOR, '<', "${tar_file}.author")
+	{
+		($this_author_name, $this_author_email) = <AUTHOR>;
+		chomp $this_author_name;
+		chomp $this_author_email;
+		close AUTHOR;
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
