From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH v4] import-tars: Allow per-tar author and commit message.
Date: Wed, 26 Aug 2009 20:26:55 +0100
Message-ID: <20090828185652.448AD189B7B@perkele>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 21:00:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6g9-00081P-8I
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbZH1S52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 14:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbZH1S51
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 14:57:27 -0400
Received: from smtp.getmail.no ([84.208.15.66]:51697 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752476AbZH1S4x (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 14:56:53 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP300CJEOMUWA30@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 28 Aug 2009 20:56:54 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP300L93OMT4D20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 28 Aug 2009 20:56:54 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.28.181820
Received: by perkele (Postfix, from userid 501)	id 448AD189B7B; Fri,
 28 Aug 2009 20:56:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127329>

If the "--metainfo=<ext>" option is given on the command line, a file
called "<filename.tar>.<ext>" will be used to create the commit message
for "<filename.tar>", instead of using "Imported from filename.tar".

The author and committer of the tar ball can also be overridden by
embedding an "Author:" or "Committer:" header in the metainfo file.

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
This version stops parsing the meta file for headers as soon as a
non-header line is seen, as requested by Junio.

 contrib/fast-import/import-tars.perl |   56 +++++++++++++++++++++++++++++++--
 1 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 78e40d2..081694f 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -8,9 +8,20 @@
 ##  perl import-tars.perl *.tar.bz2
 ##  git whatchanged import-tars
 ##
+## Use --metainfo to specify the extension for a meta data file, where
+## import-tars can read the commit message and optionally author and
+## committer information.
+##
+##  echo 'This is the commit message' > myfile.tar.bz2.msg
+##  perl import-tars.perl --metainfo=msg myfile.tar.bz2
 
 use strict;
-die "usage: import-tars *.tar.{gz,bz2,Z}\n" unless @ARGV;
+use Getopt::Long;
+
+my $metaext = '';
+
+die "usage: import-tars [--metainfo=extension] *.tar.{gz,bz2,Z}\n"
+	unless GetOptions('metainfo=s' => \$metaext) && @ARGV;
 
 my $branch_name = 'import-tars';
 my $branch_ref = "refs/heads/$branch_name";
@@ -109,12 +120,49 @@ foreach my $tar_file (@ARGV)
 		$have_top_dir = 0 if $top_dir ne $1;
 	}
 
+	my $commit_msg = "Imported from $tar_file.";
+	my $this_committer_name = $committer_name;
+	my $this_committer_email = $committer_email;
+	my $this_author_name = $author_name;
+	my $this_author_email = $author_email;
+	if ($metaext ne '')
+	{
+		# Optionally read a commit message from <filename.tar>.msg
+		# Add a line on the form "Committer: name <e-mail>" to override
+		# the committer and "Author: name <e-mail>" to override the
+		# author for this tar ball.
+		if (open MSG, '<', "${tar_file}.${metaext}")
+		{
+			my $header_done = 0;
+			$commit_msg = '';
+			while (<MSG>)
+			{
+				if (!$header_done && /^Committer:\s+([^<>]*)\s+<(.*)>\s*$/i)
+				{
+					$this_committer_name = $1;
+					$this_committer_email = $2;
+				}
+				elsif (!$header_done && /^Author:\s+([^<>]*)\s+<(.*)>\s*$/i)
+				{
+					$this_author_name = $1;
+					$this_author_email = $2;
+				}
+				else
+				{
+					$commit_msg .= $_;
+					$header_done = 1;
+				}
+			}
+			close MSG;
+		}
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
