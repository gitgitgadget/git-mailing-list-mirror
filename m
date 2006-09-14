From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (take 4)] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 22:18:59 +0200
Message-ID: <200609142218.59428.jnareb@gmail.com>
References: <200609140839.56181.jnareb@gmail.com> <200609142134.33725.jnareb@gmail.com> <7vejue2omq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 14 22:18:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNxfV-0000Xb-Pu
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 22:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWINUSj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 16:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWINUSj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 16:18:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:16809 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751125AbWINUSi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 16:18:38 -0400
Received: by wr-out-0506.google.com with SMTP id i7so1076098wra
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 13:18:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uS/BbRjR6JZi//helMMld5q1Uq9/uiy6+IU5BojzL5W++neq9jP1yaxSTwrq+0DkVwNThEoZzwZTDlS9f2/QEdXjNVl7+r1aX39u5N/dNxQgtYTf9mOiN/bddhMOk6g8afTvYZEiSqZTFAeXKVk4baYvvby6b4c2nPBrHwAZS5A=
Received: by 10.67.119.5 with SMTP id w5mr5039736ugm;
        Thu, 14 Sep 2006 13:18:37 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id y7sm834569ugc.2006.09.14.13.18.36;
        Thu, 14 Sep 2006 13:18:36 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <7vejue2omq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27038>

Earlier code to get list of projects when $projects_list is a
directory (e.g. when it is equal to $projectroot) had a hardcoded flat
(one level) list of directories.  Allow for projects to be in
subdirectories also for $projects_list being a directory by using
File::Find.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c3544dd..25383bc 100755
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
+				return if (m!^[/.]$!);
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
