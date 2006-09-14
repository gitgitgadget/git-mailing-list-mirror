From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (take 3)] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 21:34:33 +0200
Message-ID: <200609142134.33725.jnareb@gmail.com>
References: <200609140839.56181.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 14 21:34:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNwye-0007xP-7j
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 21:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWINTeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 15:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWINTeN
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 15:34:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:37300 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751070AbWINTeM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 15:34:12 -0400
Received: by ug-out-1314.google.com with SMTP id o38so91765ugd
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 12:34:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=skWUosmrPhDUEk7ogrt2/lX2o1DZ5PyhBYIc5QjQxoNSs7P7KPcomj0wOHoEsRQvagGwds7aCNW1xqlbOmWOWhpHeF2ACxT1SePXYR+4785KbIAZ3pB0dt7nPb/qKC+YGSHEdN2GecspOKmtBSrOVA1hROJp4/t9tnXO3yGW+aM=
Received: by 10.67.103.7 with SMTP id f7mr5010316ugm;
        Thu, 14 Sep 2006 12:34:11 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id y7sm813374ugc.2006.09.14.12.34.10;
        Thu, 14 Sep 2006 12:34:10 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609140839.56181.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27030>

Earlier code to get list of projects when $projects_list is a
directory (e.g. when it is equal to $projectroot) had a hardcoded flat
(one level) list of directories.  Allow for projects to be in
subdirectories also for $projects_list being a directory by using
File::Find.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Use anonymous subroutine to avoid 
  Variable "@list" will not stay shared at gitweb.perl line 727.
warning. Check for the current directory to avoid substr outside 
string warning.

 gitweb/gitweb.perl |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c3544dd..bea75d3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -715,16 +715,26 @@ sub git_get_projects_list {
 	if (-d $projects_list) {
 		# search in directory
 		my $dir = $projects_list;
-		opendir my ($dh), $dir or return undef;
-		while (my $dir = readdir($dh)) {
-			if (-e "$projectroot/$dir/HEAD") {
-				my $pr = {
-					path => $dir,
-				};
-				push @list, $pr
-			}
-		}
-		closedir($dh);
+		my $pfxlen = length("$dir");
+
+		File::Find::find({
+			follow_fast => 1, # follow symbolic links
+			dangling_symlinks => 0, # ignore dangling symlinks, silently
+			wanted => sub {
+				# skip current directory
+				return if (m!^/|.|..$!);
+				# only directories can be git repositories
+				return unless (-d $_);
+
+				my $subdir = substr($File::Find::name, $pfxlen + 1);
+				# we check related file in $projectroot
+				if (-e "$projectroot/$subdir/HEAD") {
+					push @list, { path => $subdir };
+					$File::Find::prune = 1;
+				}
+			},
+		}, "$dir");
+
 	} elsif (-f $projects_list) {
 		# read from file(url-encoded):
 		# 'git%2Fgit.git Linus+Torvalds'
-- 
1.4.2
