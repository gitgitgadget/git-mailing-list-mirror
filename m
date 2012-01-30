From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v5.5 1/5] gitweb: prepare git_get_projects_list for use
 outside 'forks'.
Date: Mon, 30 Jan 2012 15:55:38 +0100
Message-ID: <20120130145538.GA2162@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114447.GA9267@server.brlink.eu>
 <201201301442.06707.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 15:55:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrsdj-0000lh-Em
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 15:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab2A3OzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 09:55:22 -0500
Received: from server.brlink.eu ([78.46.187.186]:54100 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab2A3OzW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 09:55:22 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rrsdb-0005lA-DJ; Mon, 30 Jan 2012 15:55:19 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rrsdu-0000g5-Ih; Mon, 30 Jan 2012 15:55:38 +0100
Content-Disposition: inline
In-Reply-To: <201201301442.06707.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189364>

Use of the filter option of git_get_projects_list is currently
limited to forks. It hard codes removal of ".git" suffixes from
the filter and assumes the project belonging to the filter directory
was already validated to be visible in the project list.

To make it more generic move the .git suffix removal to the callers
and add an optional argument to denote visibility verification is
still needed.

If there is a projects list file (GITWEB_LIST) only projects from
this list are returned anyway, so no more checks needed.

If there is no projects list file and the caller requests strict
checking (GITWEB_STRICT_EXPORT), do not jump directly to the
given directory but instead do a normal search and filter the
results instead.

The only (hopefully non-existing) effect of GITWEB_STRICT_EXPORT
without GITWEB_LIST is to make sure no project can be viewed without
also be found starting from project root. git_get_projects_list without
this patch does not enforce this but all callers only call it with
a filter already checked this way. With this parameter a caller
can request this check if the filter cannot be checked this way.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---

Changes since v5:
	- don't you use s/.../.../r

 gitweb/gitweb.perl |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9cf7e71..19daabc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2829,10 +2829,9 @@ sub git_get_project_url_list {
 
 sub git_get_projects_list {
 	my $filter = shift || '';
+	my $paranoid = shift;
 	my @list;
 
-	$filter =~ s/\.git$//;
-
 	if (-d $projects_list) {
 		# search in directory
 		my $dir = $projects_list;
@@ -2841,7 +2840,7 @@ sub git_get_projects_list {
 		my $pfxlen = length("$dir");
 		my $pfxdepth = ($dir =~ tr!/!!);
 		# when filtering, search only given subdirectory
-		if ($filter) {
+		if ($filter and not $paranoid) {
 			$dir .= "/$filter";
 			$dir =~ s!/+$!!;
 		}
@@ -2866,6 +2865,10 @@ sub git_get_projects_list {
 				}
 
 				my $path = substr($File::Find::name, $pfxlen + 1);
+				# paranoidly only filter here
+				if ($paranoid && $filter && $path !~ m!^\Q$filter\E/!) {
+					next;
+				}
 				# we check related file in $projectroot
 				if (check_export_ok("$projectroot/$path")) {
 					push @list, { path => $path };
@@ -6007,7 +6010,7 @@ sub git_forks {
 		die_error(400, "Unknown order parameter");
 	}
 
-	my @list = git_get_projects_list($project);
+	my @list = git_get_projects_list((my $filter = $project) =~ s/\.git$//);
 	if (!@list) {
 		die_error(404, "No forks found");
 	}
@@ -6066,7 +6069,7 @@ sub git_summary {
 
 	if ($check_forks) {
 		# find forks of a project
-		@forklist = git_get_projects_list($project);
+		@forklist = git_get_projects_list((my $filter = $project) =~ s/\.git$//);
 		# filter out forks of forks
 		@forklist = filter_forks_from_projects_list(\@forklist)
 			if (@forklist);
-- 
1.7.8.3
