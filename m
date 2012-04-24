From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH 1/2] gitweb: Option to omit column with time of the last
 change
Date: Tue, 24 Apr 2012 19:39:15 +0200
Message-ID: <20120424173914.GB15600@camk.edu.pl>
References: <20120403132735.GA12389@camk.edu.pl>
 <20120416213938.GB22574@camk.edu.pl>
 <201204180136.08570.jnareb@gmail.com>
 <201204191807.32410.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:39:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMji9-0002zr-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 19:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963Ab2DXRj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 13:39:28 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:50247 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756812Ab2DXRj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 13:39:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 6557D5F0052;
	Tue, 24 Apr 2012 19:40:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 13A8sKiGfkdI; Tue, 24 Apr 2012 19:40:09 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id ED9B05F004F;
	Tue, 24 Apr 2012 19:40:08 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 30CD34671B; Tue, 24 Apr 2012 19:39:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201204191807.32410.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196230>

Generating information about last change for a large number of git
repositories can be very time consuming. This commit add an option to
omit 'Last Change' column when presenting the list of repositories.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 Documentation/gitweb.conf.txt |    4 ++++
 gitweb/gitweb.perl            |   16 +++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 7aba497..d240a2f 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -499,6 +499,10 @@ $maxload::
 Set `$maxload` to undefined value (`undef`) to turn this feature off.
 The default value is 300.
 
+$omit_age_column::
+	If true, omit the column with date of the most current commit on the
+	projects list page. It can save a bit of I/O and a fork per repository.
+
 $per_request_config::
 	If this is set to code reference, it will be run once for each request.
 	You can	set parts of configuration that change per session this way.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 350b59c..6bddbff 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -133,6 +133,9 @@ our $default_projects_order = "project";
 # (only effective if this variable evaluates to true)
 our $export_ok = "++GITWEB_EXPORT_OK++";
 
+# don't generate age column on the projects list page
+our $omit_age_column = 0;
+
 # show repository only if this subroutine returns true
 # when given the path to the project, for example:
 #    sub { return -e "$_[0]/git-daemon-export-ok"; }
@@ -5494,9 +5497,11 @@ sub git_project_list_rows {
 		                        : esc_html($pr->{'descr'})) .
 		      "</td>\n" .
 		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
-		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
-		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
-		      "<td class=\"link\">" .
+		unless ($omit_age_column) {
+		        print "<td class=\"". age_class($pr->{'age'}) . "\">" .
+		            (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n";
+		}
+		print"<td class=\"link\">" .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
@@ -5527,7 +5532,8 @@ sub git_project_list_body {
 	                                 'tagfilter'  => $tagfilter)
 		if ($tagfilter || $search_regexp);
 	# fill the rest
-	@projects = fill_project_list_info(\@projects);
+	my @all_fields = $omit_age_column ? ('descr', 'descr_long', 'owner', 'ctags', 'category') : ();
+	@projects = fill_project_list_info(\@projects, @all_fields);
 
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
@@ -5559,7 +5565,7 @@ sub git_project_list_body {
 		print_sort_th('project', $order, 'Project');
 		print_sort_th('descr', $order, 'Description');
 		print_sort_th('owner', $order, 'Owner');
-		print_sort_th('age', $order, 'Last Change');
+		print_sort_th('age', $order, 'Last Change') unless $omit_age_column;
 		print "<th></th>\n" . # for links
 		      "</tr>\n";
 	}
-- 
1.7.10



-- 
  Kacper Kornet
