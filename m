From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Add git_project_index for generating index.aux
Date: Fri, 15 Sep 2006 04:56:03 +0200
Message-ID: <200609150456.03972.jnareb@gmail.com>
References: <200609150453.42231.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 04:59:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO3vi-0007mF-T5
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 04:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWIOC7P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 22:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWIOC7P
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 22:59:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:28540 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751467AbWIOC7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 22:59:14 -0400
Received: by ug-out-1314.google.com with SMTP id o38so121425ugd
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 19:59:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nfSaiAMb6k/gQIpcLUyRvauwKEva1kHRChqh4+V0tblhEWCNKUyBzg9RasBdzvYRvbau14Ag2IavlZPLn5kvQZ183yFS+8TLPaIQqzLDKygJ+HU8BfUrwlgImNY7KreTroTpMnDkGnk+JzOTXwu4JksyQYMXF1mBHrRvL5pOTX0=
Received: by 10.67.103.7 with SMTP id f7mr5196564ugm;
        Thu, 14 Sep 2006 19:59:13 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id b23sm1017606ugd.2006.09.14.19.59.12;
        Thu, 14 Sep 2006 19:59:13 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609150453.42231.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27056>

Add git_project_index, which generates index.aux file that can be used
as a source of projects list, instead of generating projects list from
a directory.  Using file as a source of projects list allows for some
projects to be not present in gitweb main (project_list) page, and/or
correct project owner info. And is probably faster.

Additionally it can be used to get the list of all available repositories
for scripts (in easily parseable form).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b4a890b..7dbcb88 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -296,6 +296,7 @@ my %actions = (
 	# those below don't need $project
 	"opml" => \&git_opml,
 	"project_list" => \&git_project_list,
+	"project_index" => \&git_project_index,
 );
 
 if (defined $project) {
@@ -2210,6 +2211,30 @@ sub git_project_list {
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
+		$owner =~ s/ /\+/g;
+
+		print "$path $owner\n";
+	}
+}
+
 sub git_summary {
 	my $descr = git_get_project_description($project) || "none";
 	my $head = git_get_head_hash($project);
-- 
1.4.2
