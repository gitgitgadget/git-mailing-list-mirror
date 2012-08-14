From: Michal Novotny <minovotn@redhat.com>
Subject: [PATCH] gitweb: Add option to limit repositories to be shown by ServerName
Date: Tue, 14 Aug 2012 10:47:48 +0200
Message-ID: <d4f61bb06c9a125113442ae63be15ccea9464afd.1344932897.git.minovotn@redhat.com>
Cc: Michal Novotny <minovotn@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 10:48:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1CnE-0004OA-TG
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 10:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab2HNIry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 04:47:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754725Ab2HNIrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 04:47:52 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7E8lqOl020939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Tue, 14 Aug 2012 04:47:52 -0400
Received: from miglaptop.brq.redhat.com.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q7E8loHR002054;
	Tue, 14 Aug 2012 04:47:51 -0400
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203393>

Hi,
this is the patch to limit repositories to be shown
by the ServerName in the gitweb.cgi script. This is
useful for cases you're hosting multiple websites on
a single machine and you don't want all the repos to
be shown in all of them.

Functionality: Simply create file called 'server' in
               the git repository (the same location
               like for 'description' file) and put
               the server name to show this repo for.

Testing: It's been tested on a test server and everything
         was working fine/as expected. If there's no
         'server' file in the git repository it falls back
         to the default option to show the repository as
         it was working before this patch applied not to
         introduce any regressive behaviour.

Use case scenario: Imagine you have one server running HTTPd
                   for 3 domains, let's call them domain1,
                   domain2 and domain3, and you want all of
                   them to have a git server accessible via
                   gitweb at these URLs:
                   1) http://domain1/git
                   2) http://domain2/git
                   3) http://domain3/git

                   Before this patch, all the URLs would be
                   showing the same repos however we would
                   like to limit repo1 to be shown only on
                   domain1, repo2 to be shown only on domain2
                   and repo3 to be shown only on domain3. Here
                   my patch comes handy because you simply edit
                   the 'repo1/server' file and put 'domain1' in
                   here and it won't get shown on any other URL.
                   The same for repo2 and repo3 and it will be
                   shown only for the domain it belongs to.
                   Also, if no 'server' file exists in the repo
                   the repository is being shown so upgrading
                   gitweb with no creation of 'server' files
                   will preserve the old behaviour.

Hope this will help, at least it did help me on my test server.

Any feedback appreciated!

Thanks,
Michal

Signed-off-by: Michal Novotny <minovotn@redhat.com>
---
 gitweb/gitweb.perl | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d6a705..1b74239 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2804,6 +2804,11 @@ sub git_get_project_description {
 	return git_get_file_or_project_config($path, 'description');
 }
 
+sub git_get_project_server {
+	my $path = shift;
+	return git_get_file_or_project_config($path, 'server');
+}
+
 sub git_get_project_category {
 	my $path = shift;
 	return git_get_file_or_project_config($path, 'category');
@@ -2947,6 +2952,19 @@ sub git_get_project_url_list {
 	return wantarray ? @git_project_url_list : \@git_project_url_list;
 }
 
+sub get_project_can_export {
+	my ($path) = @_;
+
+	if (defined $ENV{'SERVER_NAME'}) {
+		my $server = git_get_project_server($path) || "";
+
+		return (($server eq $ENV{'SERVER_NAME'}) or ($server eq ''));
+	}
+	else {
+		return 1;
+	}
+}
+
 sub git_get_projects_list {
 	my $filter = shift || '';
 	my $paranoid = shift;
@@ -2990,7 +3008,8 @@ sub git_get_projects_list {
 					next;
 				}
 				# we check related file in $projectroot
-				if (check_export_ok("$projectroot/$path")) {
+				if (check_export_ok("$projectroot/$path") and
+					get_project_can_export($path)) {
 					push @list, { path => $path };
 					$File::Find::prune = 1;
 				}
@@ -3016,7 +3035,8 @@ sub git_get_projects_list {
 			if ($filter && $path !~ m!^\Q$filter\E/!) {
 				next;
 			}
-			if (check_export_ok("$projectroot/$path")) {
+			if (check_export_ok("$projectroot/$path") and
+				get_project_can_export($path)) {
 				my $pr = {
 					path => $path
 				};
-- 
1.7.11.2
