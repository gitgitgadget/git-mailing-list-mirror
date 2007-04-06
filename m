From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH(resend)] gitweb: Allow forks with project list file
Date: Fri,  6 Apr 2007 23:58:11 +0200
Message-ID: <11758966911292-git-send-email-frank@lichtenheld.de>
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 01:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwSA-0007Q7-1p
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 23:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbXDFV6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 17:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbXDFV6j
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 17:58:39 -0400
Received: from mail.lenk.info ([217.160.134.107]:59444 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbXDFV6i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 17:58:38 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwSL-0006Qc-KV; Fri, 06 Apr 2007 23:58:53 +0200
Received: from p54b0f96b.dip.t-dialin.net ([84.176.249.107] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwS2-0001ld-SG; Fri, 06 Apr 2007 23:58:35 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HZwRf-0003Aw-Qm; Fri, 06 Apr 2007 23:58:11 +0200
X-Mailer: git-send-email 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43931>

Make it possible to use the forks feature even when
reading the list of projects from a file, by creating
a list of known prefixes as we go. Forks have to be
listed after the main project in order to be recognised
as such.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 gitweb/gitweb.perl |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

Probably got lost in the noise since I never received a comment on it.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ea49156..379c89c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -176,8 +176,8 @@ our %feature = (
 	# projects matching $projname/*.git will not be shown in the main
 	# projects list, instead a '+' mark will be added to $projname
 	# there and a 'forks' view will be enabled for the project, listing
-	# all the forks. This feature is supported only if project list
-	# is taken from a directory, not file.
+	# all the forks. If project list is taken from a file, forks have
+	# to be listed after the main project.
 
 	# To enable system wide have in $GITWEB_CONFIG
 	# $feature{'forks'}{'default'} = [1];
@@ -1047,6 +1047,8 @@ sub git_get_projects_list {
 	$filter ||= '';
 	$filter =~ s/\.git$//;
 
+	my ($check_forks) = gitweb_check_feature('forks');
+
 	if (-d $projects_list) {
 		# search in directory
 		my $dir = $projects_list . ($filter ? "/$filter" : '');
@@ -1054,8 +1056,6 @@ sub git_get_projects_list {
 		$dir =~ s!/+$!!;
 		my $pfxlen = length("$dir");
 
-		my ($check_forks) = gitweb_check_feature('forks');
-
 		File::Find::find({
 			follow_fast => 1, # follow symbolic links
 			dangling_symlinks => 0, # ignore dangling symlinks, silently
@@ -1081,7 +1081,9 @@ sub git_get_projects_list {
 		# 'git%2Fgit.git Linus+Torvalds'
 		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
 		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
+		my %paths;
 		open my ($fd), $projects_list or return;
+	PROJECT:
 		while (my $line = <$fd>) {
 			chomp $line;
 			my ($path, $owner) = split ' ', $line;
@@ -1094,11 +1096,27 @@ sub git_get_projects_list {
 				# looking for forks;
 				my $pfx = substr($path, 0, length($filter));
 				if ($pfx ne $filter) {
-					next;
+					next PROJECT;
 				}
 				my $sfx = substr($path, length($filter));
 				if ($sfx !~ /^\/.*\.git$/) {
-					next;
+					next PROJECT;
+				}
+			} elsif ($check_forks) {
+			PATH:
+				foreach my $filter (keys %paths) {
+					# looking for forks;
+					my $pfx = substr($path, 0, length($filter));
+					if ($pfx ne $filter) {
+						next PATH;
+					}
+					my $sfx = substr($path, length($filter));
+					if ($sfx !~ /^\/.*\.git$/) {
+						next PATH;
+					}
+					# is a fork, don't include it in
+					# the list
+					next PROJECT;
 				}
 			}
 			if (check_export_ok("$projectroot/$path")) {
@@ -1106,7 +1124,9 @@ sub git_get_projects_list {
 					path => $path,
 					owner => to_utf8($owner),
 				};
-				push @list, $pr
+				push @list, $pr;
+				(my $forks_path = $path) =~ s/\.git$//;
+				$paths{$forks_path}++;
 			}
 		}
 		close $fd;
-- 
1.5.1
