From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 08:39:55 +0200
Message-ID: <200609140839.56181.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 14 08:39:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNksw-0001fj-65
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 08:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWINGjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 02:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWINGjj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 02:39:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:37765 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751368AbWINGji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 02:39:38 -0400
Received: by ug-out-1314.google.com with SMTP id o38so35236ugd
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 23:39:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PkY1eeHjr282Emx/GGevQTrN6rEHw2WNLjnI2Sops3ylMFahR2VU4usqH5v5128XijVWz/LDSzOkKLHloY6kXgid8xYozxkNP6hFiAlrGI9OdQRFhYgBvf7pVVYxSG1WSdqXOZhr8QOu9y1AbhGxIzGlmcpduvGOZDuGCQo/UQ0=
Received: by 10.67.101.8 with SMTP id d8mr976887ugm;
        Wed, 13 Sep 2006 23:39:36 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id u1sm370707uge.2006.09.13.23.39.36;
        Wed, 13 Sep 2006 23:39:36 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26988>

Earlier code to get list of projects when $projects_list is a
directory (e.g. when it is equal to $projectroot) had a hardcoded flat
(one level) list of directories.  Allow for projects to be in
subdirectories also for $projects_list being a directory by using
File::Find.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This doesn't add much overhead to "project_list" view,
compared to previous version; times are the same within margin
of error.

 gitweb/gitweb.perl |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c3544dd..470bff2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -715,16 +715,29 @@ sub git_get_projects_list {
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
+		my $pfxlen = length("$dir");
+
+		sub wanted {
+			# skip dot files (hidden files), check only directories
+			#return if (/^\./);
+			return unless (-d $_);
+
+			my $subdir = substr($File::Find::name, $pfxlen + 1);
+			# we check related file in $projectroot
+			if (-e "$projectroot/$subdir/HEAD") {
+				push @list, { path => $subdir };
+				$File::Find::prune = 1;
 			}
 		}
-		closedir($dh);
+
+		File::Find::find({
+			no_chdir => 1, # do not change directory
+			follow_fast => 1, # follow symbolic links
+			#follow_skip => 2, # ignore duplicated files and directories
+			dangling_symlinks => 0, # ignore dangling symlinks, silently
+			wanted => \&wanted,
+		}, "$dir");
+
 	} elsif (-f $projects_list) {
 		# read from file(url-encoded):
 		# 'git%2Fgit.git Linus+Torvalds'
-- 
1.4.2
