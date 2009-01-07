From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] gitweb: support the rel=vcs microformat
Date: Tue, 6 Jan 2009 23:25:18 -0500
Message-ID: <20090107042518.GB24735@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 05:26:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKQ0K-0003z5-18
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 05:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbZAGEZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 23:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754939AbZAGEZ3
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 23:25:29 -0500
Received: from wren.kitenet.net ([80.68.85.49]:60620 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649AbZAGEZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 23:25:28 -0500
Received: from gnu.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id CC2503142F4
	for <git@vger.kernel.org>; Tue,  6 Jan 2009 23:25:25 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id CA038A8AA5; Tue,  6 Jan 2009 23:25:18 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8840/Tue Jan  6 15:03:01 2009 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104754>

The rel=vcs microformat allows a web page to indicate the locations of
repositories related to it in a machine-parseable manner.
(See http://kitenet.net/~joey/rfc/rel-vcs/)

Make gitweb use the microformat in the header of pages it generates,
if it has been configured with project url information in any of the usual
ways.

Since getting the urls can require hitting disk, I avoided putting the
microformat on *every* page gitweb generates. Just put it on the project
summary page, the project list page, and the forks list page.
The first of these already looks up the urls, so adding the microformat was
free. There is a small overhead in including the microformat on the
latter two pages, but getting the project descriptions for those pages
already incurs a similar overhead, and the ability to get every repo url
in one place seems worthwhile.

This changes git_get_project_description() to not check wantarray, and only
return in list context -- the only way it is used AFAICS.

Signed-off-by: Joey Hess <joey@gnu.kitenet.net>
---
 gitweb/gitweb.perl |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 99f71b4..3f8a228 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -789,6 +789,9 @@ $git_dir = "$projectroot/$project" if $project;
 our @snapshot_fmts = gitweb_get_feature('snapshot');
 @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
+# populated later with git urls for the project
+our @git_url_list;
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -2100,17 +2103,22 @@ sub git_show_project_tagcloud {
 }
 
 sub git_get_project_url_list {
+	# use per project git URL list in $projectroot/$path/cloneurl
+	# or make project git URL from git base URL and project name
 	my $path = shift;
 
+	my @ret;
+
 	$git_dir = "$projectroot/$path";
-	open my $fd, "$git_dir/cloneurl"
-		or return wantarray ?
-		@{ config_to_multi(git_get_project_config('url')) } :
-		   config_to_multi(git_get_project_config('url'));
-	my @git_project_url_list = map { chomp; $_ } <$fd>;
-	close $fd;
+	if (open my $fd, "$git_dir/cloneurl") {
+		@ret = map { chomp; $_ } <$fd>;
+		close $fd;
+	}
+	else {
+	       @ret = @{ config_to_multi(git_get_project_config('url')) };
+	}
 
-	return wantarray ? @git_project_url_list : \@git_project_url_list;
+	return @ret ? @ret : map { "$_/$project" } @git_base_url_list;
 }
 
 sub git_get_projects_list {
@@ -2953,6 +2961,10 @@ EOF
 		print qq(<link rel="shortcut icon" href="$favicon" type="image/png" />\n);
 	}
 
+	foreach my $url (@git_url_list) {
+		print qq{<link rel="vcs" type="git" href="$url" />\n};
+	}
+
 	print "</head>\n" .
 	      "<body>\n";
 
@@ -4380,6 +4392,8 @@ sub git_project_list {
 		die_error(404, "No projects found");
 	}
 
+	@git_url_list = map { git_get_project_url_list($_->{path}) } @list;
+
 	git_header_html();
 	if (-f $home_text) {
 		print "<div class=\"index_include\">\n";
@@ -4400,6 +4414,8 @@ sub git_forks {
 	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
 		die_error(400, "Unknown order parameter");
 	}
+	
+	@git_url_list = map { git_get_project_url_list($_->{path}) } @list;
 
 	my @list = git_get_projects_list($project);
 	if (!@list) {
@@ -4457,6 +4473,8 @@ sub git_summary {
 		@forklist = git_get_projects_list($project);
 	}
 
+	@git_url_list = git_get_project_url_list($project);
+
 	git_header_html();
 	git_print_page_nav('summary','', $head);
 
@@ -4468,12 +4486,8 @@ sub git_summary {
 		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
 	}
 
-	# use per project git URL list in $projectroot/$project/cloneurl
-	# or make project git URL from git base URL and project name
 	my $url_tag = "URL";
-	my @url_list = git_get_project_url_list($project);
-	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
-	foreach my $git_url (@url_list) {
+	foreach my $git_url (@git_url_list) {
 		next unless $git_url;
 		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
 		$url_tag = "";
-- 
1.5.6.5
