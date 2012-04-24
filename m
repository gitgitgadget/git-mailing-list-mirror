From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH 2/2] gitweb: Option to not display information about owner
Date: Tue, 24 Apr 2012 19:41:14 +0200
Message-ID: <20120424174114.GC15600@camk.edu.pl>
References: <20120403132735.GA12389@camk.edu.pl>
 <20120416213938.GB22574@camk.edu.pl>
 <201204180136.08570.jnareb@gmail.com>
 <201204191807.32410.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:41:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMjk9-0004dU-Ns
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 19:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960Ab2DXRlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 13:41:31 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:50372 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756795Ab2DXRla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 13:41:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 2EE125F004F;
	Tue, 24 Apr 2012 19:42:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Ib1IqVjqNlQq; Tue, 24 Apr 2012 19:42:10 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id A8D335F0053;
	Tue, 24 Apr 2012 19:42:08 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id E0DD64671B; Tue, 24 Apr 2012 19:41:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201204191807.32410.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196231>

In some setups the repository owner is not a well defined concept
and administrator can prefer it to be not shown. This commit add
and an option that enable to reach this effect.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 Documentation/gitweb.conf.txt |    3 +++
 gitweb/gitweb.perl            |   20 ++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index d240a2f..4b8d1b1 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -503,6 +503,9 @@ $omit_age_column::
 	If true, omit the column with date of the most current commit on the
 	projects list page. It can save a bit of I/O and a fork per repository.
 
+$omit_owner::
+	If true prevents displaying information about repository owner.
+
 $per_request_config::
 	If this is set to code reference, it will be run once for each request.
 	You can	set parts of configuration that change per session this way.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6bddbff..7558def 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -136,6 +136,9 @@ our $export_ok = "++GITWEB_EXPORT_OK++";
 # don't generate age column on the projects list page
 our $omit_age_column = 0;
 
+# don't generate information about owners of repositories
+our $omit_owner=0;
+
 # show repository only if this subroutine returns true
 # when given the path to the project, for example:
 #    sub { return -e "$_[0]/git-daemon-export-ok"; }
@@ -5495,8 +5498,10 @@ sub git_project_list_rows {
 		                        ? esc_html_match_hl_chopped($pr->{'descr_long'},
 		                                                    $pr->{'descr'}, $search_regexp)
 		                        : esc_html($pr->{'descr'})) .
-		      "</td>\n" .
-		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
+		      "</td>\n";
+		unless ($omit_owner) {
+		        print "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
+		}
 		unless ($omit_age_column) {
 		        print "<td class=\"". age_class($pr->{'age'}) . "\">" .
 		            (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n";
@@ -5532,7 +5537,8 @@ sub git_project_list_body {
 	                                 'tagfilter'  => $tagfilter)
 		if ($tagfilter || $search_regexp);
 	# fill the rest
-	my @all_fields = $omit_age_column ? ('descr', 'descr_long', 'owner', 'ctags', 'category') : ();
+	my @all_fields = $omit_age_column ? ('descr', 'descr_long', 'ctags', 'category') : ();
+	push @all_fields, 'owner' unless($omit_owner);
 	@projects = fill_project_list_info(\@projects, @all_fields);
 
 	$order ||= $default_projects_order;
@@ -5564,7 +5570,7 @@ sub git_project_list_body {
 		}
 		print_sort_th('project', $order, 'Project');
 		print_sort_th('descr', $order, 'Description');
-		print_sort_th('owner', $order, 'Owner');
+		print_sort_th('owner', $order, 'Owner') unless $omit_owner;
 		print_sort_th('age', $order, 'Last Change') unless $omit_age_column;
 		print "<th></th>\n" . # for links
 		      "</tr>\n";
@@ -6318,8 +6324,10 @@ sub git_summary {
 
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table class=\"projects_list\">\n" .
-	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
-	      "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
+	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n";
+        unless ($omit_owner) {
+	        print  "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
+        }
 	if (defined $cd{'rfc2822'}) {
 		print "<tr id=\"metadata_lchange\"><td>last change</td>" .
 		      "<td>".format_timestamp_html(\%cd)."</td></tr>\n";
-- 
1.7.10

-- 
  Kacper Kornet
