From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Fix several places where diff.renames in config can be problematic
Date: Fri, 7 Jul 2006 18:58:46 -0700
Message-ID: <20060708015844.GA13769@soma>
References: <11522670452824-git-send-email-normalperson@yhbt.net> <11522670473116-git-send-email-normalperson@yhbt.net> <7v7j2p3eac.fsf@assigned-by-dhcp.cox.net> <20060707110123.GA23400@soma> <7vpsghzmr1.fsf@assigned-by-dhcp.cox.net> <7v64i9zk0j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 08 03:59:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz25z-0005vC-SC
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 03:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWGHB6t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 21:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWGHB6t
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 21:58:49 -0400
Received: from hand.yhbt.net ([66.150.188.102]:1727 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751296AbWGHB6s (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 21:58:48 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CA8C27DC021;
	Fri,  7 Jul 2006 18:58:46 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  7 Jul 2006 18:58:46 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64i9zk0j.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23471>

git-cvsexportcommit.perl:
git-cvsserver.perl:
	CVS can't handle renames, so we best not show them to
	users.

templates/hooks--update:
	replace diffstat calls with git diff --stat

There may be other places where users having diff.renames can be
problematic, too.  diff.renames is opt-in, but maybe some users
have enabled it in their configs previously because it's been
in examples for a long time...

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Junio C Hamano <junkio@cox.net> wrote:
 > Junio C Hamano <junkio@cox.net> writes:
 > 
 > > I am more worried about somebody who opts-in finds breakage of
 > > commands that happen to internally use low-level diff machinery
 > > and expect the diff machinery does not automagically do funny
 > > rename detection without being told.
 > > ...
 > > That is why I said I do not want this at _that_ low level.  I do
 > > not have objections to have the configuration at a layer closer
 > > to the UI, e.g. things in builtin-log.c and builtin-diff.c.
 > 
 > Upon closer look I think the revision pruning code is OK.  So
 > let's cook this as is in "next" and see what happens.

 Cool.  I've found these that could be potential issues.  There could be
 more, and possibly many in 3rd-party scripts outside our control, too.

 git-cvsexportcommit.perl |    8 +++++---
 git-cvsserver.perl       |    2 +-
 templates/hooks--update  |    4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d1051d0..09ff2cc 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -91,7 +91,8 @@ close MSG;
 $? && die "Error extracting the commit message";
 
 my (@afiles, @dfiles, @mfiles, @dirs);
-my @files = safe_pipe_capture('git-diff-tree', '-r', $parent, $commit);
+my @files = safe_pipe_capture('git-diff-tree','--no-renames','-r',
+				$parent, $commit);
 #print @files;
 $? && die "Error in git-diff-tree";
 foreach my $f (@files) {
@@ -175,7 +176,8 @@ foreach my $d (@dirs) {
 
 print "'Patching' binary files\n";
 
-my @bfiles = grep(m/^Binary/, safe_pipe_capture('git-diff-tree', '-p', $parent, $commit));
+my @bfiles = grep(m/^Binary/, safe_pipe_capture('git-diff-tree','--no-renames',
+						'-p', $parent, $commit));
 @bfiles = map { chomp } @bfiles;
 foreach my $f (@bfiles) {
     # check that the file in cvs matches the "old" file
@@ -206,7 +208,7 @@ ## apply non-binary changes
 my $fuzz = $opt_p ? 0 : 2;
 
 print "Patching non-binary files\n";
-print `(git-diff-tree -p $parent -p $commit | patch -p1 -F $fuzz ) 2>&1`;
+print `(git-diff-tree --no-renames -p $parent -p $commit | patch -p1 -F $fuzz ) 2>&1`;
 
 my $dirtypatch = 0;
 if (($? >> 8) == 2) {
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 5ccca4f..ae878ea 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2295,7 +2295,7 @@ sub update
 
         if ( defined ( $lastpicked ) )
         {
-            my $filepipe = open(FILELIST, '-|', 'git-diff-tree', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git-diff-tree', '--no-merges', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree : $!");
             while ( <FILELIST> )
             {
                 unless ( /^:\d{6}\s+\d{3}(\d)\d{2}\s+[a-zA-Z0-9]{40}\s+([a-zA-Z0-9]{40})\s+(\w)\s+(.*)$/o )
diff --git a/templates/hooks--update b/templates/hooks--update
index d7a8f0a..76d5ac2 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -60,7 +60,7 @@ then
 			echo "Changes since $prev:"
 			git rev-list --pretty $prev..$3 | $short
 			echo ---
-			git diff $prev..$3 | diffstat -p1
+			git diff --stat $prev..$3
 			echo ---
 		fi
 		;;
@@ -75,7 +75,7 @@ else
 	base=$(git-merge-base "$2" "$3")
 	case "$base" in
 	"$2")
-		git diff "$3" "^$base" | diffstat -p1
+		git diff --stat "$3" "^$base"
 		echo
 		echo "New commits:"
 		;;
-- 
1.4.1.gc57e
