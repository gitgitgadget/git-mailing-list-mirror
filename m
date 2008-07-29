From: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
Subject: [PATCH 2/2] gitweb: add section support to gitweb project listing.
Date: Mon, 28 Jul 2008 23:34:28 -0300
Message-ID: <1217298868-16513-3-git-send-email-barbieri@profusion.mobi>
References: <1217298868-16513-1-git-send-email-barbieri@profusion.mobi>
 <1217298868-16513-2-git-send-email-barbieri@profusion.mobi>
Cc: gitster@pobox.com,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 04:36:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNf4B-0004gq-Kq
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 04:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbYG2Ces (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 22:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbYG2Ces
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 22:34:48 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:52360 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbYG2Cer (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 22:34:47 -0400
Received: by qw-out-2122.google.com with SMTP id 3so394563qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 19:34:47 -0700 (PDT)
Received: by 10.214.183.3 with SMTP id g3mr1060661qaf.94.1217298887093;
        Mon, 28 Jul 2008 19:34:47 -0700 (PDT)
Received: from solid.profusion.mobi ( [201.82.39.16])
        by mx.google.com with ESMTPS id 5sm877493ywd.8.2008.07.28.19.34.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jul 2008 19:34:46 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.2
In-Reply-To: <1217298868-16513-2-git-send-email-barbieri@profusion.mobi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90554>

Section headers will be optionally displayed when projects dirnames or
owner names changes (depending on sort order), making it easier to
find projects in large setups.

Signed-off-by: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
---
 gitweb/gitweb.css  |    7 +++++
 gitweb/gitweb.perl |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index aa0eeca..44abc4c 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -235,6 +235,13 @@ tr.dark:hover {
 	background-color: #edece6;
 }
 
+tr.section td {
+	background-color: #d9d8d1;
+	border-top: 1px solid #000000;
+	border-left: 1px solid #000000;
+	font-weight: bold;
+}
+
 td {
 	padding: 2px 5px;
 	font-size: 100%;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c5675cf..c99cea3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -15,7 +15,7 @@ use CGI::Carp qw(fatalsToBrowser);
 use Encode;
 use Fcntl ':mode';
 use File::Find qw();
-use File::Basename qw(basename);
+use File::Basename qw(basename dirname);
 binmode STDOUT, ':utf8';
 
 BEGIN {
@@ -82,6 +82,9 @@ our $projects_list_description_width = 25;
 # valid values are none, project, descr, owner, and age
 our $default_projects_order = "project";
 
+# use sections to separate projects by dirname, helps usability
+our $use_sections = 1;
+
 # show repository only if this file exists
 # (only effective if this variable evaluates to true)
 our $export_ok = "++GITWEB_EXPORT_OK++";
@@ -3631,6 +3634,66 @@ sub print_sort_th_num {
 	print_sort_th(0, @_);
 }
 
+sub print_section_tr {
+	my ($n_cols, $section) = @_;
+	print "<tr class=\"section\"><td colspan=\"$n_cols\">$section</td></tr>\n";
+}
+
+sub print_section_internal {
+	my ($order, $n_cols, $current, $getter) = @_;
+	my $current_value = $getter->($current);
+
+	if (!$current_value) {
+		return 0;
+	}
+
+	my $last_value = '';
+	if ($current > 0) {
+		$last_value = $getter->($current - 1);
+	}
+
+	if ($current_value ne $last_value) {
+		print_section_tr($n_cols, $current_value);
+		return 1;
+	}
+
+	return 0;
+}
+
+sub print_section_project {
+	my ($order, $n_cols, $current, $projects) = @_;
+
+	sub get_section_project {
+		my ($index) = @_;
+		return dirname(@$projects[$index]->{'path'});
+	}
+
+	return print_section_internal($order, $n_cols, $current, \&get_section_project);
+}
+
+sub print_section_owner {
+	my ($order, $n_cols, $current, $projects) = @_;
+
+	sub get_section_owner {
+		my ($index) = @_;
+		return @$projects[$index]->{'owner'};
+	}
+
+	return print_section_internal($order, $n_cols, $current, \&get_section_owner);
+}
+
+sub print_section {
+	my ($order, $n_cols, $current, $projects) = @_;
+
+	if ($order eq 'project') {
+		return print_section_project($order, $n_cols, $current, $projects);
+	} elsif ($order eq 'owner') {
+		return print_section_owner($order, $n_cols, $current, $projects);
+	}
+
+	return 0;
+}
+
 sub git_project_list_body {
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
@@ -3658,9 +3721,17 @@ sub git_project_list_body {
 		print "<th></th>\n" . # for links
 		      "</tr>\n";
 	}
+	my $n_cols = $check_forks ? 6 : 5;
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $pr = $projects[$i];
+
+                if ($use_sections) {
+			if (print_section($order, $n_cols, $i, \@projects)) {
+				$alternate = 1;
+			}
+                }
+
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
-- 
1.5.5.2
