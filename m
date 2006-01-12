From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Show non-naked git repositories in subdirectories as well.
Date: Thu, 12 Jan 2006 00:55:12 -0800
Message-ID: <7v8xtlrfkf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 09:55:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwyF0-0007ab-Br
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 09:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWALIzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 03:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWALIzS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 03:55:18 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:7648 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030330AbWALIzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 03:55:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112085423.ZZGP3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 03:54:23 -0500
To: Kay Sievers <kay.sievers@suse.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14553>

This allows $projects_list to name a directory under which a
non-naked git project trees can hang.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * The development of this patch was done using the experimental
   "git checkout" I posted in thread:

     http://thread.gmane.org/gmane.comp.version-control.git/14375

   With the same workflow as I described there, I added this
   feature by working in the test branch, and then did this:

     $ git checkout -b projects master

   which automerged the changes in the test branch over to a new
   branch, based on Kay's upstream (thereby removing the effect
   of my other changes I had in the test branch).  All I had to
   do after that was to make a commit, and I am reasonably happy
   to see the checkout change is working nicely.

 gitweb.cgi |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

c302bfde91563778155084d13453b1c2bdc771d8
diff --git a/gitweb.cgi b/gitweb.cgi
index 986d7da..ed52ed0 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -14,6 +14,7 @@ use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser);
 use Encode;
 use Fcntl ':mode';
+use File::Find qw(find);
 binmode STDOUT, ':utf8';
 
 my $cgi = new CGI;
@@ -794,17 +795,18 @@ sub git_read_projects {
 
 	if (-d $projects_list) {
 		# search in directory
-		my $dir = $projects_list;
-		opendir my $dh, $dir or return undef;
-		while (my $dir = readdir($dh)) {
-			if (-e "$projectroot/$dir/HEAD") {
-				my $pr = {
-					path => $dir,
+		my $pl = quotemeta($projects_list);
+		find(sub {
+			if (/\.git$/ && -d _ &&
+			    (-l "$File::Find::name/HEAD" || -f _) &&
+			    $File::Find::name =~ /^$pl\/(.*)/) {
+				push @list, {
+					path => "$1"
 				};
-				push @list, $pr
+				$File::Find::prune = 1;
 			}
-		}
-		closedir($dh);
+		}, $projects_list);
+
 	} elsif (-f $projects_list) {
 		# read from file(url-encoded):
 		# 'git%2Fgit.git Linus+Torvalds'
-- 
1.1.1-g8a769
