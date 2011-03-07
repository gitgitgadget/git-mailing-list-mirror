From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Optional grouping of projects by category
Date: Tue,  8 Mar 2011 00:13:35 +0100
Message-ID: <1299539616-19991-4-git-send-email-jnareb@gmail.com>
References: <1299539616-19991-1-git-send-email-jnareb@gmail.com>
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, "J.H." <warthog9@kernel.org>,
	Sebastien Cevey <seb@cine7.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 00:14:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwjdD-0004uH-VW
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 00:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684Ab1CGXOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 18:14:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65266 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab1CGXOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 18:14:08 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so4166894bwz.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 15:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OsNc+rcT+kR+Jy4O50l8+ApX4DAYkW1Yh1cFWDhvEJQ=;
        b=hzKjehflvwlDByQydr1h6wnzhBIwWM3aHyZs9PnSNewuPEvUG9nzdJGXOJSh7vTTzT
         QIfy5rRPwDhQKlPe+pG5+n0alJ3HMwnog9hcBronUdJiqwD3hrWI+6t+EkbRHdZ5X9Dy
         ZqlqV6E1P+QWDiv8y09GbYlw2O0sQQmf7BM3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ngwoeExDf4EZlFEaSs1HdxSKqfD5yHa+dTtoxXw285iYjqKzNo6L3AgeMzT1PQ3fC+
         c6DIUjwx6H+lZx+UEP7htdHgsb0mi0RZIlTvMc6GAmCmR1bGSWfvemx55lE4A3HIjQJk
         O8oUeuOJ0X26TLAttCSTKYezypCs9u7iMZr14=
Received: by 10.204.20.139 with SMTP id f11mr253045bkb.177.1299539647685;
        Mon, 07 Mar 2011 15:14:07 -0800 (PST)
Received: from localhost.localdomain (abvd192.neoplus.adsl.tpnet.pl [83.8.201.192])
        by mx.google.com with ESMTPS id l1sm75621bkl.1.2011.03.07.15.14.05
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 15:14:06 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1299539616-19991-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168618>

From: Sebastien Cevey <seb@cine7.net>

This adds the $projects_list_group_categories option which, if enabled,
will result in grouping projects by category on the project list page.
The category is specified for each project by the $GIT_DIR/category file
or the 'gitweb.category' variable in its configuration file. By default,
projects are put in the $project_list_default_category category.

Note:
- Categories are always sorted alphabetically, with projects in
  each category sorted according to the globally selected $order.
- When displaying a subset of all the projects (page limiting), the
  category headers are only displayed for projects present on the page.

The feature is inspired from Sham Chukoury's patch for the XMMS2
gitweb, but has been rewritten for the current gitweb code. The CSS
for categories is inspired from Gustavo Sverzut Barbieri's patch to
group projects by path.

Thanks to Florian Ragwitz for Perl tips.

[jn: Updated to post restructuring projects list generation, fixed bugs,
 added very basic test in t9500 that there are no warnings from Perl.]

Signed-off-by: Sebastien Cevey <seb@cine7.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/README                          |   16 ++++++++
 gitweb/gitweb.perl                     |   61 ++++++++++++++++++++++++++++++--
 gitweb/static/gitweb.css               |    7 ++++
 t/t9500-gitweb-standalone-no-errors.sh |    8 ++++
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 4a67393..6cdf51b 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -207,6 +207,15 @@ not include variables usually directly set during build):
    full description is available as 'title' attribute (usually shown on
    mouseover).  By default set to 25, which might be too small if you
    use long project descriptions.
+ * $projects_list_group_categories
+   Enables the grouping of projects by category on the project list page.
+   The category of a project is determined by the $GIT_DIR/category
+   file or the 'gitweb.category' variable in its repository configuration.
+   Disabled by default.
+ * $project_list_default_category
+   Default category for projects for which none is specified.  If set
+   to the empty string, such projects will remain uncategorized and
+   listed at the top, above categorized projects.
  * @git_base_url_list
    List of git base URLs used for URL to where fetch project from, shown
    in project summary page.  Full URL is "$git_base_url/$project".
@@ -314,6 +323,13 @@ You can use the following files in repository:
    from the template during repository creation. You can use the
    gitweb.description repo configuration variable, but the file takes
    precedence.
+ * category (or gitweb.category)
+   Singe line category of a project, used to group projects if
+   $projects_list_group_categories is enabled. By default (file and
+   configuration variable absent), uncategorized projects are put in
+   the $project_list_default_category category. You can use the
+   gitweb.category repo configuration variable, but the file takes
+   precedence.
  * cloneurl (or multiple-valued gitweb.url)
    File with repository URL (used for clone and fetch), one per line.
    Displayed in the project summary page. You can use multiple-valued
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c032cd4..1b71934 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -115,6 +115,14 @@ our $projects_list = "++GITWEB_LIST++";
 # the width (in characters) of the projects list "Description" column
 our $projects_list_description_width = 25;
 
+# group projects by category on the projects list
+# (enabled if this variable evaluates to true)
+our $projects_list_group_categories = 0;
+
+# default category if none specified
+# (leave the empty string for no category)
+our $project_list_default_category = "";
+
 # default order of projects list
 # valid values are none, project, descr, owner, and age
 our $default_projects_order = "project";
@@ -2572,6 +2580,11 @@ sub git_get_project_description {
 	return git_get_file_or_project_config($path, 'description');
 }
 
+sub git_get_project_category {
+	my $path = shift;
+	return git_get_file_or_project_config($path, 'category');
+}
+
 sub git_get_project_ctags {
 	my $path = shift;
 	my $ctags = {};
@@ -4799,8 +4812,9 @@ sub git_patchset_body {
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
-# fills project list info (age, description, owner, forks) for each
-# project in the list, removing invalid projects from returned list
+# fills project list info (age, description, owner, category, forks)
+# for each project in the list, removing invalid projects from
+# returned list
 # NOTE: modifies $projlist, but does not remove entries from it
 sub fill_project_list_info {
 	my $projlist = shift;
@@ -4826,6 +4840,12 @@ sub fill_project_list_info {
 		if ($show_ctags) {
 			$pr->{'ctags'} = git_get_project_ctags($pr->{'path'});
 		}
+		if ($projects_list_group_categories && !defined $pr->{'category'}) {
+			my $cat = git_get_project_category($pr->{'path'}) ||
+			                                   $project_list_default_category;
+			$pr->{'category'} = to_utf8($cat);
+		}
+
 		push @projects, $pr;
 	}
 
@@ -4853,6 +4873,23 @@ sub sort_projects_list {
 	return @projects;
 }
 
+# returns a hash of categories, containing the list of project
+# belonging to each category
+sub build_projlist_by_category {
+	my ($projlist, $from, $to) = @_;
+	my %categories;
+
+	$from = 0 unless defined $from;
+	$to = $#$projlist if (!defined $to || $#$projlist < $to);
+
+	for (my $i = $from; $i <= $to; $i++) {
+		my $pr = $projlist->[$i];
+		push @{$categories{ $pr->{'category'} }}, $pr;
+	}
+
+	return wantarray ? %categories : \%categories;
+}
+
 # print 'sort by' <th> element, generating 'sort by $name' replay link
 # if that order is not selected
 sub print_sort_th {
@@ -4986,7 +5023,25 @@ sub git_project_list_body {
 		      "</tr>\n";
 	}
 
-	git_project_list_rows(\@projects, $from, $to, $check_forks);
+	if ($projects_list_group_categories) {
+		# only display categories with projects in the $from-$to window
+		@projects = sort {$a->{'category'} cmp $b->{'category'}} @projects[$from..$to];
+		my %categories = build_projlist_by_category(\@projects, $from, $to);
+		foreach my $cat (sort keys %categories) {
+			unless ($cat eq "") {
+				print "<tr>\n";
+				if ($check_forks) {
+					print "<td></td>\n";
+				}
+				print "<td class=\"category\" colspan=\"5\">".esc_html($cat)."</td>\n";
+				print "</tr>\n";
+			}
+
+			git_project_list_rows($categories{$cat}, undef, undef, $check_forks);
+		}
+	} else {
+		git_project_list_rows(\@projects, $from, $to, $check_forks);
+	}
 
 	if (defined $extra) {
 		print "<tr>\n";
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 79d7eeb..4df2d16 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -295,6 +295,13 @@ td.current_head {
 	text-decoration: underline;
 }
 
+td.category {
+	background-color: #d9d8d1;
+	border-top: 1px solid #000000;
+	border-left: 1px solid #000000;
+	font-weight: bold;
+}
+
 table.diff_tree span.file_status.new {
 	color: #008000;
 }
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 71ef0ac..f5648a6 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -644,4 +644,12 @@ test_expect_success \
 	'ctags: search projects by non existent tag' \
 	'gitweb_run "by_tag=non-existent"'
 
+# ----------------------------------------------------------------------
+# categories
+
+test_expect_success \
+	'categories: projects list, only default category' \
+	'echo "\$projects_list_group_categories = 1;" >>gitweb_config.perl &&
+	 gitweb_run'
+
 test_done
-- 
1.7.3
