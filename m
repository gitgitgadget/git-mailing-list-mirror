From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] cvsimport move over to using git for each ref to read refs V3
Date: Wed, 20 Sep 2006 17:37:04 +0100
Message-ID: <20060920163704.GA27407@shadowen.org>
References: <45116888.4050806@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 20 18:38:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ54k-0008Lv-Pr
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWITQh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWITQh1
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:37:27 -0400
Received: from 85-210-218-110.dsl.pipex.com ([85.210.218.110]:40923 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751816AbWITQh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:37:27 -0400
Received: from apw by localhost.localdomain with local (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1GQ54K-000788-BV; Wed, 20 Sep 2006 17:37:04 +0100
To: git@vger.kernel.org
Content-Disposition: inline
InReply-To: <45116888.4050806@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27372>

cvsimport: move over to using git-for-each-ref to read refs V3

cvsimport opens all of the files in $GIT_DIR/refs/heads and reads
out the sha1's in order to work out what time the last commit on
that branch was made (in CVS) thus allowing incremental updates.
However, this takes no account of hierachical refs naming producing
the following error for each directory in $GIT_DIR/refs:

  Use of uninitialized value in chomp at /usr/bin/git-cvsimport line 503.
  Use of uninitialized value in concatenation (.) or string at
					/usr/bin/git-cvsimport line 505.
  usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>

Take advantage of the new packed refs work to use the new
for-each-ref iterator to get this information.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e5a00a1..92d14c3 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -495,22 +495,19 @@ unless(-d $git_dir) {
 	$tip_at_start = `git-rev-parse --verify HEAD`;
 
 	# Get the last import timestamps
-	opendir(D,"$git_dir/refs/heads");
-	while(defined(my $head = readdir(D))) {
-		next if $head =~ /^\./;
-		open(F,"$git_dir/refs/heads/$head")
-			or die "Bad head branch: $head: $!\n";
-		chomp(my $ftag = <F>);
-		close(F);
-		open(F,"git-cat-file commit $ftag |");
-		while(<F>) {
-			next unless /^author\s.*\s(\d+)\s[-+]\d{4}$/;
-			$branch_date{$head} = $1;
-			last;
-		}
-		close(F);
+	my $fmt = '($ref, $author) = (%(refname), %(author));';
+	open(H, "git-for-each-ref --perl --format='$fmt'|") or
+		die "Cannot run git-for-each-ref: $!\n";
+	while(defined(my $entry = <H>)) {
+		my ($ref, $author);
+		eval($entry) || die "cannot eval refs list: $@";
+
+		next if ($ref !~ m@^refs/heads/(.*)$@);
+		my ($head) = ($1);
+		$author =~ /^.*\s(\d+)\s[-+]\d{4}$/;
+		$branch_date{$head} = $1;
 	}
-	closedir(D);
+	close(H);
 }
 
 -d $git_dir
