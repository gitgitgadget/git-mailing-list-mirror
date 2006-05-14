From: Linus Torvalds <torvalds@osdl.org>
Subject: Simplify "git reset --hard"
Date: Sun, 14 May 2006 11:20:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605141110150.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605141040210.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun May 14 20:21:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfLD4-00058M-Pd
	for gcvg-git@gmane.org; Sun, 14 May 2006 20:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWENSUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 14:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWENSUm
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 14:20:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751533AbWENSUl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 14:20:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4EIKctH000720
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 May 2006 11:20:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4EIKbgp012303;
	Sun, 14 May 2006 11:20:37 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605141040210.3866@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19977>


Now that the one-way merge strategy does the right thing wrt files that do 
not exist in the result, just remove all the random crud we did in "git 
reset" to do this all by hand.

Instead, just pass in "-u" to git-read-tree when we do a hard reset, and 
depend on git-read-tree to update the working tree appropriately.

This basically means that git reset turns into

	# Always update the HEAD ref
	git update-ref HEAD "$rev"

	case "--soft"
		# do nothing to index/working tree
	case "--hard"
		# read index _and_ update working tree
		git-read-tree --reset -u "$rev"
	case "--mixed"
		# update just index, report on working tree differences
		git-read-tree --reset "$rev"
		git-update-index --refresh

which is what it was always semantically doing, it just did it in a
rather strange way because it was written to not expect git-read-tree to 
do anything to the working tree.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

NOTE! The switch to use "git-read-tree -u" does actually result in a real 
change: we will now remove files that were in the index but not in HEAD 
before (ie files added with "git add"). I'd argue that this is a bug-fix.

 git-reset.sh |   50 ++++----------------------------------------------
 1 files changed, 4 insertions(+), 46 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index 6cb073c..0ee3e3e 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -6,6 +6,7 @@ USAGE='[--mixed | --soft | --hard]  [<co
 tmp=${GIT_DIR}/reset.$$
 trap 'rm -f $tmp-*' 0 1 2 3 15
 
+update=
 reset_type=--mixed
 case "$1" in
 --mixed | --soft | --hard)
@@ -23,24 +24,7 @@ # We need to remember the set of paths t
 # behind before a hard reset, so that we can remove them.
 if test "$reset_type" = "--hard"
 then
-	{
-		git-ls-files --stage -z
-		git-rev-parse --verify HEAD 2>/dev/null &&
-		git-ls-tree -r -z HEAD
-	} | perl -e '
-	    use strict;
-	    my %seen;
-	    $/ = "\0";
-	    while (<>) {
-		chomp;
-		my ($info, $path) = split(/\t/, $_);
-		next if ($info =~ / tree /);
-		if (!$seen{$path}) {
-			$seen{$path} = 1;
-			print "$path\0";
-		}
-	    }
-	' >$tmp-exists
+	update=-u
 fi
 
 # Soft reset does not touch the index file nor the working tree
@@ -54,7 +38,7 @@ then
 		die "Cannot do a soft reset in the middle of a merge."
 	fi
 else
-	git-read-tree --reset "$rev" || exit
+	git-read-tree --reset $update "$rev" || exit
 fi
 
 # Any resets update HEAD to the head being switched to.
@@ -68,33 +52,7 @@ git-update-ref HEAD "$rev"
 
 case "$reset_type" in
 --hard )
-	# Hard reset matches the working tree to that of the tree
-	# being switched to.
-	git-checkout-index -f -u -q -a
-	git-ls-files --cached -z |
-	perl -e '
-		use strict;
-		my (%keep, $fh);
-		$/ = "\0";
-		while (<STDIN>) {
-			chomp;
-			$keep{$_} = 1;
-		}
-		open $fh, "<", $ARGV[0]
-			or die "cannot open $ARGV[0]";
-		while (<$fh>) {
-			chomp;
-			if (! exists $keep{$_}) {
-				# it is ok if this fails -- it may already
-				# have been culled by checkout-index.
-				unlink $_;
-				while (s|/[^/]*$||) {
-					rmdir($_) or last;
-				}
-			}
-		}
-	' $tmp-exists
-	;;
+	;; # Nothing else to do
 --soft )
 	;; # Nothing else to do
 --mixed )
