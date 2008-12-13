From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH 2/2] gitweb: support hiding projects from user-visible lists
Date: Sat, 13 Dec 2008 16:16:47 -0500
Message-ID: <1229203007.31181.6.camel@mattlaptop2.local>
References: <4ba6b6c3fc183002407f322663d7ab53c1c28a91.1229202740.git.matt@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 22:18:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBbsF-0005bM-Rz
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 22:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbYLMVQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 16:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbYLMVQu
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 16:16:50 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:44882 "EHLO
	jankymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751644AbYLMVQu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 16:16:50 -0500
Received: from [129.2.130.102] (129-2-130-102.wireless.umd.edu [129.2.130.102])
	by jankymail-a2.g.dreamhost.com (Postfix) with ESMTP id 2958CB6AAC;
	Sat, 13 Dec 2008 13:16:49 -0800 (PST)
In-Reply-To: <4ba6b6c3fc183002407f322663d7ab53c1c28a91.1229202740.git.matt@mattmccutchen.net>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103020>

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---

My Web site has a single gitweb installation in which some of the
repositories are protected by a basic authentication login.  By virtue
of my aforementioned setup with gitweb and pulling at the same URL, the
login applies uniformly to both.  I had to include these repositories in
the projects_list because I use strict_export, but I want to hide them
when the user views the project list.  This patch implements that
feature, and the previous one fixes a bug I noticed along the way.

Matt

 gitweb/gitweb.perl |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5357bcc..085cc60 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1144,7 +1144,7 @@ sub untabify {
 
 sub project_in_list {
 	my $project = shift;
-	# Tell git_get_projects_list to include forks.
+	# Tell git_get_projects_list to include forks and hidden repositories.
 	my @list = git_get_projects_list(undef, 1);
 	return @list && scalar(grep { $_->{'path'} eq $project } @list);
 }
@@ -2174,15 +2174,18 @@ sub git_get_projects_list {
 		# 'git%2Fgit.git Linus+Torvalds'
 		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
 		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
+		#
+		# 1 in the third field hides the project from user-visible lists, e.g.:
+		# 'linux%2Fembargoed-security-fixes.git John+Doe 1'
 		my %paths;
 		open my ($fd), $projects_list or return;
 	PROJECT:
 		while (my $line = <$fd>) {
 			chomp $line;
-			my ($path, $owner) = split ' ', $line;
+			my ($path, $owner, $hidden) = split ' ', $line;
 			$path = unescape($path);
 			$owner = unescape($owner);
-			if (!defined $path) {
+			if (!defined $path || ($hidden && !$for_strict_export)) {
 				next;
 			}
 			if ($filter ne '') {
@@ -2227,6 +2230,8 @@ sub git_get_projects_list {
 	return @list;
 }
 
+# This is used to look up the owner of a project the user is already allowed to
+# see, so we shouldn't omit hidden repositories.
 our $gitweb_project_owner = undef;
 sub git_get_project_list_from_file {
 
@@ -2241,7 +2246,7 @@ sub git_get_project_list_from_file {
 		open (my $fd , $projects_list);
 		while (my $line = <$fd>) {
 			chomp $line;
-			my ($pr, $ow) = split ' ', $line;
+			my ($pr, $ow, $hidden) = split ' ', $line;
 			$pr = unescape($pr);
 			$ow = unescape($ow);
 			$gitweb_project_owner->{$pr} = to_utf8($ow);
-- 
1.6.1.rc2.27.gc7114
