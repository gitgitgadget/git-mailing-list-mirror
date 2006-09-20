From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] cvsimport move over to using git for each ref to read refs
Date: Wed, 20 Sep 2006 09:52:00 +0100
Message-ID: <20060920085200.GA21865@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 20 10:52:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPxor-0008KO-NW
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 10:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWITIwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 04:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWITIwY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 04:52:24 -0400
Received: from 85-210-218-110.dsl.pipex.com ([85.210.218.110]:17568 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750742AbWITIwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 04:52:23 -0400
Received: from apw by localhost.localdomain with local (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1GPxoG-0005gw-G3; Wed, 20 Sep 2006 09:52:00 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27333>

cvsimport: move over to using git-for-each-ref to read refs

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
for-each-ref iterator to get this information.  Use the format
specifier to ensure we are neutral to changes in default.

[Junio: although although for-each-ref offers a --perl quoting mode
this patch does not use it as it seems only to make parsing the
output harder in perl.  If there is a neat trick for handling this
'perl' form please educate me.  Here, rely on sha1's to contain
no spaces.]

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e5a00a1..1a62afa 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -495,13 +495,14 @@ unless(-d $git_dir) {
 	$tip_at_start = `git-rev-parse --verify HEAD`;
 
 	# Get the last import timestamps
-	opendir(D,"$git_dir/refs/heads");
-	while(defined(my $head = readdir(D))) {
-		next if $head =~ /^\./;
-		open(F,"$git_dir/refs/heads/$head")
-			or die "Bad head branch: $head: $!\n";
-		chomp(my $ftag = <F>);
-		close(F);
+	open(H, "git-for-each-ref --format='%(objectname) %(refname)'|") or
+		die "Cannot run git-for-each-ref: $!\n";
+	while(defined(my $entry = <H>)) {
+		chomp($entry);
+		my ($ftag, $name) = split(' ', $entry, 2);
+		next if ($name !~ m@^refs/heads/(.*)$@);
+		my ($head) = ($1);
+
 		open(F,"git-cat-file commit $ftag |");
 		while(<F>) {
 			next unless /^author\s.*\s(\d+)\s[-+]\d{4}$/;
@@ -510,7 +511,7 @@ unless(-d $git_dir) {
 		}
 		close(F);
 	}
-	closedir(D);
+	close(H);
 }
 
 -d $git_dir
