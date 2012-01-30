From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v5 1/5] gitweb: prepare git_get_projects_list for use outside
 'forks'.
Date: Mon, 30 Jan 2012 12:44:47 +0100
Message-ID: <20120130114447.GA9267@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <m3wr8bcuon.fsf@localhost.localdomain>
 <20120129012234.GD16079@server.brlink.eu>
 <201201291354.50241.jnareb@gmail.com>
 <20120129160615.GA13937@server.brlink.eu>
 <7v7h0afcc2.fsf@alter.siamese.dyndns.org>
 <20120130095252.GA6183@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 12:44:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrpfB-0007bD-8P
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab2A3Loc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 06:44:32 -0500
Received: from server.brlink.eu ([78.46.187.186]:54084 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248Ab2A3Lob (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 06:44:31 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rrpeu-0005dL-HG; Mon, 30 Jan 2012 12:44:28 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrpfD-0002Ph-T4; Mon, 30 Jan 2012 12:44:47 +0100
Content-Disposition: inline
In-Reply-To: <20120130095252.GA6183@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189348>

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

Changes to v4:
	- split patch in smaller parts
	- move ".git" suffix removal from filters to forks specific code
          (if you want this as patch on top of the previous series, let me know)
	- improve the descriptions of all patches
---
 gitweb/gitweb.perl |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9cf7e71..acf1bae 100755
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
+	my @list = git_get_projects_list($project =~ s/\.git$//r);
 	if (!@list) {
 		die_error(404, "No forks found");
 	}
@@ -6066,7 +6069,7 @@ sub git_summary {
 
 	if ($check_forks) {
 		# find forks of a project
-		@forklist = git_get_projects_list($project);
+		@forklist = git_get_projects_list($project =~ s/\.git$//r);
 		# filter out forks of forks
 		@forklist = filter_forks_from_projects_list(\@forklist)
 			if (@forklist);
-- 
1.7.8.3
