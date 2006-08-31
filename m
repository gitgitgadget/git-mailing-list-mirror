From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add git_project_index for generating index.aux
Date: Thu, 31 Aug 2006 15:17:11 +0200
Message-ID: <200608311517.11987.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 31 15:17:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GImQ4-0004Iq-AN
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 15:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWHaNRQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 09:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHaNRQ
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 09:17:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:49116 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932199AbWHaNRP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 09:17:15 -0400
Received: by ug-out-1314.google.com with SMTP id m3so545202ugc
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 06:17:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hgaq/+n8g1YVESF5Wov9JHd5BvHB7MN9DSsVjnV2V3+zUOE8ObD30Lhyp0c1n2aqyb1TWHeV9dRWA0QIViGVIFKJJTF665NSp1+Ndt+XTMhQj40INSQtGtAdzie3MDwxOCIRlPUjvTTu7UUMb9Hcz5c/FmCs+ZcV1geG4lfV4ew=
Received: by 10.66.216.6 with SMTP id o6mr513159ugg;
        Thu, 31 Aug 2006 06:17:14 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id m1sm1009974ugc.2006.08.31.06.17.13;
        Thu, 31 Aug 2006 06:17:13 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26260>

Add git_project_index, which generates index.aux file that can be used
as a source of projects list, instead of generating projects list from
a directory.  Using file as a source of projects list allows for some
projects to be not present in gitweb main (project_list) page, and/or
correct project owner info.

This also allows for easy getting list of all available (well, gitweb
available) projects. OPML output offers something similar.

This action is not linked from anywhere, one must put p=project_index
into query string by hand.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fa7f62a..98193be 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -268,6 +268,7 @@ my %actions = (
 	# those below don't need $project
 	"opml" => \&git_opml,
 	"project_list" => \&git_project_list,
+	"project_index" => \&git_project_index,
 );
 
 if (defined $project) {
@@ -2069,6 +2070,30 @@ sub git_project_list {
 	git_footer_html();
 }
 
+sub git_project_index {
+	my @projects = git_get_projects_list();
+
+	print $cgi->header(
+		-type => 'text/plain',
+		-charset => 'utf-8',
+		-content_disposition => qq(inline; filename="index.aux"));
+
+	foreach my $pr (@projects) {
+		if (!exists $pr->{'owner'}) {
+			$pr->{'owner'} = get_file_owner("$projectroot/$project");
+		}
+
+		my ($path, $owner) = ($pr->{'path'}, $pr->{'owner'});
+		# quote as in CGI::Util::encode, but keep the slash, and use '+' for ' '
+		$path  =~ s/([^a-zA-Z0-9_.\-\/ ])/sprintf("%%%02X", ord($1))/eg;
+		$owner =~ s/([^a-zA-Z0-9_.\-\/ ])/sprintf("%%%02X", ord($1))/eg;
+		$path  =~ s/ /\+/g;
+		$owner  =~ s/ /\+/g;
+
+		print "$path $owner\n";
+	}
+}
+
 sub git_summary {
 	my $descr = git_get_project_description($project) || "none";
 	my $head = git_get_head_hash($project);
-- 
1.4.1.1
