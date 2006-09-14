From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 19:39:39 +0200
Message-ID: <200609141939.39406.jnareb@gmail.com>
References: <200609140839.56181.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 14 19:39:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNvBL-0003Py-6H
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 19:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWINRjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 13:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWINRjU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 13:39:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:28059 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750811AbWINRjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 13:39:19 -0400
Received: by ug-out-1314.google.com with SMTP id o38so82613ugd
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 10:39:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QaKzS9C9lEnZ2ldMSjvAnDUUwNTGyWHAArFstnpPeQWzUTWPOkfQvaGgTZ5FSYIFmZjfum258mF2zgkwjxQAm0Se1wKDwMFOpX9QFHOpkqyBHtlIy/Oixqd7Ll25/Q0XhUDDoXz38s/q2vivDb0UjDsRvd8NeOjz12v/loo4LG4=
Received: by 10.66.224.19 with SMTP id w19mr4948071ugg;
        Thu, 14 Sep 2006 10:39:17 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id 27sm753698ugp.2006.09.14.10.39.16;
        Thu, 14 Sep 2006 10:39:17 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609140839.56181.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27020>

Earlier code to get list of projects when $projects_list is a
directory (e.g. when it is equal to $projectroot) had a hardcoded flat
(one level) list of directories.  Allow for projects to be in
subdirectories also for $projects_list being a directory by using
File::Find.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c3544dd..27641a6 100755
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
+		my $pfxlen = length("$dir");
+
+		sub wanted {
+			# only directories can be git repositories
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
+			follow_fast => 1, # follow symbolic links
+			dangling_symlinks => 0, # ignore dangling symlinks, silently
+			wanted => \&wanted,
+		}, "$dir");
+
 	} elsif (-f $projects_list) {
 		# read from file(url-encoded):
 		# 'git%2Fgit.git Linus+Torvalds'
-- 
1.4.2
