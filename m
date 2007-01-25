From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] gitweb: Allow users to have their own project directories.
Date: Thu, 25 Jan 2007 20:10:11 +0000
Message-ID: <11697558112701-git-send-email-mdw@distorted.org.uk>
Cc: Mark Wooding <mdw@distorted.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 21:15:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAB0m-00050V-D8
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 21:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbXAYUPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 15:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030552AbXAYUPc
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 15:15:32 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:20278 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1030538AbXAYUPb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jan 2007 15:15:31 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jan 2007 15:15:30 EST
Received: (qmail 13953 invoked by uid 1000); 25 Jan 2007 20:10:11 -0000
X-Mailer: git-send-email 1.5.0.rc2.gc9a89
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37756>

The git-daemon understands `~USER/...' as referring to a project within
USER's home directory.  This change makes gitweb able to serve each
user's personal projects without them all having to be linked into one
place.

If the gitweb_config.perl file defines $user_path then a username given
in the `u' argument, or as a leading `/~USER/' string in the PATH_INFO,
causes gitweb to look for projects in $homedir/$user_path (where
$homedir is USER's home directory).

Rather than expose all their projects, or the ones with an export file
in them, a user can write a file listing the projects to be exported by
gitweb.  (Maybe this ought to force strict_export on, but it doesn't at
the moment.)

This patch leaves it as someone else's problem to actually work out
which users have exported GIT repositories, and maybe compile them into
a list.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---
 gitweb/gitweb.perl |   56 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 88af2e6..14c344d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -35,6 +35,12 @@ our $GIT = "++GIT_BINDIR++/git";
 #our $projectroot = "/pub/scm";
 our $projectroot = "++GITWEB_PROJECTROOT++";
 
+# subdirectory of user home to look for projects, or empty to not do that
+our $user_path = "";
+
+# file naming user's projects
+our $user_projects = "projects";
+
 # target of the home link on top of all pages
 our $home_link = $my_uri || "/";
 
@@ -285,6 +291,8 @@ $projects_list ||= $projectroot;
 
 # ======================================================================
 # input validation and dispatch
+our $path_info = $ENV{"PATH_INFO"};
+
 our $action = $cgi->param('a');
 if (defined $action) {
 	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
@@ -292,6 +300,37 @@ if (defined $action) {
 	}
 }
 
+our $user = $cgi->param('u');
+if (!defined($user && $path_info)) {
+	$path_info =~ s:^/+::;
+	if ($path_info =~ m:\~([^/]+)(/.*$|):) {
+		$user = $1;
+		$path_info = $2;
+	}
+}
+if (defined $user) {
+	if (!$user_path || $user =~ m/[^0-9a-zA-Z\.\-_]/) {
+		die_error(undef, "Invalid user parameter");
+	}
+	my @pw = getpwnam($user);
+	my $ok = 0;
+	if (@pw) {
+		$projectroot = $pw[7] . "/" . $user_path;
+		if (-d $projectroot) {
+			$ok = 1;
+		}
+		if ($user_projects && -f "$projectroot/$user_projects") {
+			$projects_list = "$projectroot/$user_projects";
+		} else {
+			$projects_list = $projectroot;
+		}
+		$home_text = "$projectroot/$home_text";
+	}
+	if (!$ok) {
+		die_error("No such user as $user");
+	}
+}
+
 # parameters which are pathnames
 our $project = $cgi->param('p');
 if (defined $project) {
@@ -377,7 +416,7 @@ if (defined $searchtype) {
 # now read PATH_INFO and use it as alternative to parameters
 sub evaluate_path_info {
 	return if defined $project;
-	my $path_info = $ENV{"PATH_INFO"};
+	my $path_info = $::path_info;
 	return if !$path_info;
 	$path_info =~ s,^/+,,;
 	return if !$path_info;
@@ -482,6 +521,7 @@ sub href(%) {
 
 	my @mapping = (
 		project => "p",
+		user => "u",
 		action => "a",
 		file_name => "f",
 		file_parent => "fp",
@@ -497,12 +537,15 @@ sub href(%) {
 	my %mapping = @mapping;
 
 	$params{'project'} = $project unless exists $params{'project'};
+	$params{'user'} = $user unless exists $params{'user'};
 
 	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
 	if ($use_pathinfo) {
 		# use PATH_INFO for project name
+		$href .= "/~$user" if defined $params{'user'};
 		$href .= "/$params{'project'}" if defined $params{'project'};
 		delete $params{'project'};
+		delete $params{'user'};
 
 		# Summary just uses the project path URL
 		if (defined $params{'action'} && $params{'action'} eq 'summary') {
@@ -1771,6 +1814,9 @@ EOF
 	               -title => $logo_label},
 	              qq(<img src="$logo" width="72" height="27" alt="git" class="logo"/>));
 	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
+	if (defined $user) {
+		print $cgi->a({-href => href(action=>"summary", project=>undef)}, esc_html("~" . $user)) . " / ";
+	}
 	if (defined $project) {
 		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
 		if (defined $action) {
@@ -1794,9 +1840,11 @@ EOF
 		$cgi->param("a", "search");
 		$cgi->param("h", $search_hash);
 		$cgi->param("p", $project);
+		if (defined $user) { $cgi->param("u", $user); }
 		print $cgi->startform(-method => "get", -action => $my_uri) .
 		      "<div class=\"search\">\n" .
 		      $cgi->hidden(-name => "p") . "\n" .
+		      (defined $user ? $cgi->hidden(-name => "u") . "\n" : "") .
 		      $cgi->hidden(-name => "a") . "\n" .
 		      $cgi->hidden(-name => "h") . "\n" .
 		      $cgi->popup_menu(-name => 'st', -default => 'commit',
@@ -4715,8 +4763,10 @@ XML
 		}
 
 		my $path = esc_html(chop_str($proj{'path'}, 25, 5));
-		my $rss  = "$my_url?p=$proj{'path'};a=rss";
-		my $html = "$my_url?p=$proj{'path'};a=summary";
+		my $base  = "$my_url?p=$proj{'path'}";
+		if (defined $user) { $base .= ";u=$user"; }
+		my $rss  = "$base;a=rss";
+		my $html = "$base;a=summary";
 		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
 	}
 	print <<XML;
-- 
1.5.0.rc2.gc9a89
