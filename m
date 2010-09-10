From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/2] gitweb: Make it possible to paginate projects
Date: Fri, 10 Sep 2010 18:17:21 +0200
Message-ID: <1284135442-10971-2-git-send-email-lkundrak@v3.sk>
References: <1284135442-10971-1-git-send-email-lkundrak@v3.sk>
Cc: Lubomir Rintel <lkundrak@v3.sk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 18:17:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6IJ-000460-Tf
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab0IJQRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 12:17:38 -0400
Received: from norkia.v3.sk ([91.210.183.14]:49172 "EHLO norkia.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409Ab0IJQRh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 12:17:37 -0400
Received: from localhost.localdomain.com (unknown [195.39.106.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lkundrak@v3.sk)
	by norkia.v3.sk (Postfix) with ESMTP id 13D52A0004;
	Fri, 10 Sep 2010 18:17:36 +0200 (CEST)
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1284135442-10971-1-git-send-email-lkundrak@v3.sk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155939>

This adds simple pagination (next and prev links), to project lists,
analogous to what is done for commit history lists.
---
 gitweb/gitweb.perl |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a85e2f6..8dc7f29 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -255,6 +255,9 @@ our %highlight_ext = (
 	map { $_ => 'xml' } qw(xhtml html htm),
 );
 
+# Set this to non-zero to enable project list pagination
+our $projects_per_page = 0;
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -4613,9 +4616,19 @@ sub git_project_list_body {
 	my @projects = fill_project_list_info($projlist, $check_forks);
 
 	$order ||= $default_projects_order;
+	$page ||= 0;
+	if ($projects_per_page) {
+		$from = $page * $projects_per_page unless defined $from;
+		$to = $from + $projects_per_page - 1 unless defined $to;
+	}
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
 
+	my $prev_link = $cgi->a({-href => href(-replay=>1, page=>$page-1),
+		 -accesskey => "p", -title => "Alt-p"}, "prev") if ($page > 0);
+	my $next_link = $cgi->a({-href => href(-replay=>1, page=>$page+1),
+		 -accesskey => "n", -title => "Alt-n"}, "next") if ($#$projlist > $to);
+
 	my %order_info = (
 		project => { key => 'path', type => 'str' },
 		descr => { key => 'descr_long', type => 'str' },
@@ -4709,6 +4722,19 @@ sub git_project_list_body {
 		print "<td colspan=\"5\">$extra</td>\n" .
 		      "</tr>\n";
 	}
+
+	if ($prev_link or $next_link) {
+		print "<tr>\n";
+		if ($check_forks) {
+			print "<td></td>\n";
+		}
+		print "<td colspan=\"5\">";
+		print $prev_link if $prev_link;
+		print " &sdot; " if $prev_link and $next_link;
+		print $next_link if $next_link;
+		print "</td>\n</tr>\n";
+	}
+
 	print "</table>\n";
 }
 
-- 
1.7.2.1
