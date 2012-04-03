From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH] gitweb: Option to omit column with time of the last change
Date: Tue, 3 Apr 2012 15:27:36 +0200
Message-ID: <20120403132735.GA12389@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
To: git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 03 15:51:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF48v-0003jH-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 15:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab2DCNvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 09:51:25 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:45594 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508Ab2DCNvY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 09:51:24 -0400
X-Greylist: delayed 1416 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Apr 2012 09:51:24 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id A1AF45F0049;
	Tue,  3 Apr 2012 15:28:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id taPFkQHgJ4bM; Tue,  3 Apr 2012 15:28:23 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id EB61C5F0046;
	Tue,  3 Apr 2012 15:28:22 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 314134669F; Tue,  3 Apr 2012 15:27:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194623>

Generating information about last change for a large number of git
repositories can be time consuming. This commit adds an option to
omit 'Last Change' column when presenting the list of repositories.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 Documentation/gitweb.conf.txt |    3 +++
 gitweb/gitweb.perl            |   16 +++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 7aba497..bfeef21 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -403,6 +403,9 @@ $default_projects_order::
 	i.e. path to repository relative to `$projectroot`), "descr"
 	(project description), "owner", and "age" (by date of most current
 	commit).
+
+$no_list_age::
+	Omit column with date of the most curren commit
 +
 Default value is "project".  Unknown value means unsorted.
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad..f42468c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -133,6 +133,9 @@ our $default_projects_order = "project";
 # (only effective if this variable evaluates to true)
 our $export_ok = "++GITWEB_EXPORT_OK++";
 
+# don't generate age column
+our $no_list_age = 0;
+
 # show repository only if this subroutine returns true
 # when given the path to the project, for example:
 #    sub { return -e "$_[0]/git-daemon-export-ok"; }
@@ -5462,9 +5465,11 @@ sub git_project_list_rows {
 		                        : esc_html($pr->{'descr'})) .
 		      "</td>\n" .
 		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
-		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
-		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
-		      "<td class=\"link\">" .
+		unless ($no_list_age) {
+		        print "<td class=\"". age_class($pr->{'age'}) . "\">" .
+		            (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n";
+		}
+		print"<td class=\"link\">" .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
@@ -5495,7 +5500,8 @@ sub git_project_list_body {
 	                                 'tagfilter'  => $tagfilter)
 		if ($tagfilter || $search_regexp);
 	# fill the rest
-	@projects = fill_project_list_info(\@projects);
+	my @all_fields = $no_list_age ? ('descr', 'descr_long', 'owner', 'ctags', 'category') : ();
+	@projects = fill_project_list_info(\@projects, @all_fields);
 
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
@@ -5527,7 +5533,7 @@ sub git_project_list_body {
 		print_sort_th('project', $order, 'Project');
 		print_sort_th('descr', $order, 'Description');
 		print_sort_th('owner', $order, 'Owner');
-		print_sort_th('age', $order, 'Last Change');
+		print_sort_th('age', $order, 'Last Change') unless $no_list_age;
 		print "<th></th>\n" . # for links
 		      "</tr>\n";
 	}
-- 
1.7.10.rc3
