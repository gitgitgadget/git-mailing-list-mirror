From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Support for no project list on gitweb front page
Date: Fri,  6 Nov 2009 16:11:05 +0100
Message-ID: <1257520265-16699-1-git-send-email-pasky@suse.cz>
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 16:19:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6QbO-0006Td-1j
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 16:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759355AbZKFPTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 10:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759358AbZKFPTC
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 10:19:02 -0500
Received: from rover.dkm.cz ([62.24.64.27]:54572 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759354AbZKFPS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 10:18:59 -0500
Received: by rover.dkm.cz (Postfix, from userid 1001)
	id 775A6165F0D; Fri,  6 Nov 2009 16:11:05 +0100 (CET)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132305>

On very large sites like repo.or.cz (but maybe also git.debian.org,
git.kernel.org, etc.), it is desirable not to have the project list
on the front page since generating it is significant overhead and it
takes significant data transfer and load time for the user, who might
prefer to instead use the search form and possibly content tags to
navigate to the target project. A link to the full list of projects is
still available on the front page for users who wish to browse it. The
whole feature is turned off by default.

The patch introduces a new config variable $frontpage_no_project_list,
by default 0 keeping the current behavior; if set to 1, no project list
will be shown, but all projects will be still scanned if ctags are
enabled; if set to 2, no project will be shown and no projects will
be scanned while showing the front page. The compromise value of 1 is
useful for sites where project scan time is not an issue or which
use additional project list caching patches.

The patch furthermore modifies project_list action not to show the
index text, and introduces new default action frontpage which is by
default identical to old project_list action, but can be further
controlled by the $frontpage_no_project_list variable.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 gitweb/README      |    8 ++++++++
 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |   32 +++++++++++++++++++++++++++++---
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 66c6a93..c5fd1b8 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -223,6 +223,14 @@ not include variables usually directly set during build):
    repositories from launching cross-site scripting (XSS) attacks.  Set this
    to true if you don't trust the content of your repositories. The default
    is false.
+ * $frontpage_no_project_list
+   If 0, the gitweb frontpage will contain the project list; if 1 instead,
+   it will contain just the index text, search form, tag cloud (if enabled)
+   and a link to the actual project list. The page is reduced, but all
+   projects still need to be scanned for the tag cloud construction. If the
+   option is set to 2, not even the tag cloud will be shown; this is fastest.
+   This option is useful for sites with large amount of projects. The default
+   is 0.
 
 
 Projects list file format
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index cb3f0ba..9fee3f0 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -97,6 +97,11 @@ div.readme {
 	padding: 8px;
 }
 
+p.projectlist_link {
+	text-align: center;
+	font-weight: bold;
+}
+
 a.title:hover {
 	background-color: #d9d8d1;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 97e88b4..48326a4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -152,6 +152,11 @@ our @diff_opts = ('-M'); # taken from git_commit
 # the gitweb domain.
 our $prevent_xss = 0;
 
+# Whether to include project list on the gitweb front page; 0 means yes,
+# 1 means no list but show tag cloud if enabled (all projects still need
+# to be scanned), 2 means no list and no tag cloud (very fast)
+our $frontpage_no_project_list = 0;
+
 # information about snapshot formats that gitweb is capable of serving
 our %known_snapshot_formats = (
 	# name => {
@@ -601,6 +606,7 @@ our %actions = (
 	"object" => \&git_object,
 	# those below don't need $project
 	"opml" => \&git_opml,
+	"frontpage" => \&git_frontpage,
 	"project_list" => \&git_project_list,
 	"project_index" => \&git_project_index,
 );
@@ -901,13 +907,13 @@ if (!defined $action) {
 	} elsif (defined $project) {
 		$action = 'summary';
 	} else {
-		$action = 'project_list';
+		$action = 'frontpage';
 	}
 }
 if (!defined($actions{$action})) {
 	die_error(400, "Unknown action");
 }
-if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
+if ($action !~ m/^(?:opml|frontpage|project_list|project_index)$/ &&
     !$project) {
 	die_error(400, "Project needed");
 }
@@ -4377,6 +4383,7 @@ sub git_project_list_body {
 
 sub git_project_search_form {
 	print $cgi->startform(-method => "get") .
+	      $cgi->hidden({-name=>"a", -value=>"project_list"}) . "\n" .
 	      "<p class=\"projsearch\">Search:\n" .
 	      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
 	      "</p>" .
@@ -4665,7 +4672,7 @@ sub git_search_grep_body {
 ## ======================================================================
 ## actions
 
-sub git_project_list {
+sub git_frontpage {
 	git_header_html();
 	if (-f $home_text) {
 		print "<div class=\"index_include\">\n";
@@ -4673,6 +4680,25 @@ sub git_project_list {
 		print "</div>\n";
 	}
 	git_project_search_form();
+	if (not $frontpage_no_project_list) {
+		git_project_list_all();
+	} else {
+		my $show_ctags = gitweb_check_feature('ctags');
+		if ($frontpage_no_project_list == 1 and $show_ctags) {
+			my @list = git_get_projects_list();
+			my @projects = fill_project_list_info(\@list, gitweb_check_feature('forks'), $show_ctags);
+			git_project_list_ctags(\@projects);
+		}
+		print "<p class=\"projectlist_link\">" .
+			$cgi->a({-href => href(action=>'project_list')}, "Browse all projects") .
+			"</p>\n";
+	}
+	git_footer_html();
+}
+
+sub git_project_list {
+	git_header_html();
+	git_project_search_form();
 	git_project_list_all();
 	git_footer_html();
 }
-- 
tg: (e731dcd..) t/frontpage/separate (depends on: t/frontpage/ctags)
