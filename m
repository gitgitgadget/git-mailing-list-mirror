From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/6] gitweb: Optional grouping of projects by category
Date: Fri, 29 Apr 2011 19:52:01 +0200
Message-ID: <1304099521-27617-7-git-send-email-jnareb@gmail.com>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:52:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFrs5-0001Q3-Fr
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 19:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760771Ab1D2Rwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 13:52:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38549 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894Ab1D2Rwf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 13:52:35 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2635577fxm.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=HYXeq/edgsbZTHnK/4qaUbnYe4ZIcF6t76LLZEmT950=;
        b=BbYV8PPpV3BuMOzOIOWuvUeim224wCy+KyUATNZdY5ZbowZdEKh+HSyrOi8vnkPC/t
         4SEuSM26kOAeDtI6LywLa+oQYqhAWikuNksB/zzWcbbVcUq0wgrFS6+ehowr7cS85iWd
         aUL0b2RYET9VpUeMky2Sk/D4k+mkQojnMqNxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Vn4QJ+dYrTDNF5hm2VGAo1icGDo2biLMB/qqE02+u73U296B0tTSkb6pYCwAPaVxQv
         orgN9FZ4u87AnUOAK7jDD6HhUJJY/xy4+IiJbch2o992E7bHB8esw9XVp550Gvr+ubcj
         z9r90KiuwIBJsbkoP3FnnqJCZGhiUDKoRVpbQ=
Received: by 10.223.27.18 with SMTP id g18mr1988336fac.52.1304099554919;
        Fri, 29 Apr 2011 10:52:34 -0700 (PDT)
Received: from localhost.localdomain (abvr62.neoplus.adsl.tpnet.pl [83.8.215.62])
        by mx.google.com with ESMTPS id n26sm962346fam.37.2011.04.29.10.52.32
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 10:52:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172480>

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
 gitweb/gitweb.perl                     |   62 ++++++++++++++++++++++++++++++--
 gitweb/static/gitweb.css               |    7 ++++
 t/t9500-gitweb-standalone-no-errors.sh |    8 ++++
 4 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index a92bde7..a3a697b 100644
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
index e8685ac..f78fdd7 100755
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
@@ -2584,6 +2592,12 @@ sub git_get_project_description {
 	return git_get_file_or_project_config($path, 'description');
 }
 
+sub git_get_project_category {
+	my $path = shift;
+	return git_get_file_or_project_config($path, 'category');
+}
+
+
 # supported formats:
 # * $GIT_DIR/ctags/<tagname> file (in 'ctags' subdirectory)
 #   - if its contents is a number, use it as tag weight,
@@ -4877,8 +4891,9 @@ sub git_patchset_body {
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
-# fills project list info (age, description, owner, forks) for each
-# project in the list, removing invalid projects from returned list
+# fills project list info (age, description, owner, category, forks)
+# for each project in the list, removing invalid projects from
+# returned list
 # NOTE: modifies $projlist, but does not remove entries from it
 sub fill_project_list_info {
 	my $projlist = shift;
@@ -4904,6 +4919,12 @@ sub fill_project_list_info {
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
 
@@ -4931,6 +4952,23 @@ sub sort_projects_list {
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
@@ -5059,7 +5097,25 @@ sub git_project_list_body {
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
