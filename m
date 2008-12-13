From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH 1/2] gitweb: allow access to forks with strict_export
Date: Sat, 13 Dec 2008 16:16:54 -0500
Message-ID: <1229203014.31181.7.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 22:18:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBbsi-0005hy-5v
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 22:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbYLMVRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 16:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYLMVRS
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 16:17:18 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:33159 "EHLO
	jankymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751644AbYLMVRS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 16:17:18 -0500
Received: from [129.2.130.102] (129-2-130-102.wireless.umd.edu [129.2.130.102])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id AD68613F0C;
	Sat, 13 Dec 2008 13:17:17 -0800 (PST)
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103021>

git_get_projects_list excludes forks in order to unclutter the main
project list, but this caused the strict_export check, which also relies
on git_get_project_list, to incorrectly fail for forks.  This patch adds
an argument so git_get_projects_list knows when it is being called for a
strict_export check (as opposed to a user-visible project list) and
doesn't exclude the forks.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 gitweb/gitweb.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 86511cf..5357bcc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1144,7 +1144,8 @@ sub untabify {
 
 sub project_in_list {
 	my $project = shift;
-	my @list = git_get_projects_list();
+	# Tell git_get_projects_list to include forks.
+	my @list = git_get_projects_list(undef, 1);
 	return @list && scalar(grep { $_->{'path'} eq $project } @list);
 }
 
@@ -2128,13 +2129,13 @@ sub git_get_project_url_list {
 }
 
 sub git_get_projects_list {
-	my ($filter) = @_;
+	my ($filter, $for_strict_export) = @_;
 	my @list;
 
 	$filter ||= '';
 	$filter =~ s/\.git$//;
 
-	my $check_forks = gitweb_check_feature('forks');
+	my $check_forks = !$for_strict_export && gitweb_check_feature('forks');
 
 	if (-d $projects_list) {
 		# search in directory
-- 
1.6.1.rc2.27.gc7114
