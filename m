From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Simplify git_project_list_body
Date: Thu, 1 May 2008 12:20:57 +0200
Message-ID: <200805011220.58871.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 12:22:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrVvK-0008Ch-OJ
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 12:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbYEAKVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 06:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbYEAKVI
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 06:21:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:29219 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYEAKVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 06:21:07 -0400
Received: by nf-out-0910.google.com with SMTP id d3so433218nfc.21
        for <git@vger.kernel.org>; Thu, 01 May 2008 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=UQ90q3TFKHct2xnMGZE1hszdJcGbXbIN0x+mKRIy+ww=;
        b=vp5MO9Fc7OmirWuRPNjo2kCFNTSI96rS8wKt52twh1X4BoVqRV6ETKl0DhDRUUdCtMY/xNLREToC8kQWlgADJzY8FGBSaO3RyaOXY0VSonFCsNuCsS7H/ppHLdLLPYry+0AQo8yz9VIQ7lCv2Q65RW6IlhmtftCZawrErQmg94Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KxAHvJchTjYsEypuR/8AuuAhLDKNK5NxAzvTbMboatbEFvnjn7twCKdaeJiYNFvAP7Tvz//3JO+fQ2e4L30XgTzFL8MQrUAX8xJhWAzof2kMTT1uZikl3Zrk6OdWgx9RZDyUHBA0S8Fbq6hRwXhnnNKkhGv7h9/sJRuJFAykN8I=
Received: by 10.210.112.4 with SMTP id k4mr1707395ebc.115.1209637264206;
        Thu, 01 May 2008 03:21:04 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.219.4])
        by mx.google.com with ESMTPS id i6sm2067321gve.4.2008.05.01.03.21.01
        (version=SSLv3 cipher=OTHER);
        Thu, 01 May 2008 03:21:02 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80896>

Extract filling project list info, i.e. adding age, description, owner
and forks information, to fill_project_list_info() subroutine.  This
is preparation for smart pagination and smart searching (if possible,
only calculate info for those projects which are shown).

Extract generating table header cell one can sort by into
print_sort_th_str() and print_sort_th_num() subroutines, and
print_sort_th() driver subroutine.  This avoids repetition, and should
make further improvements (like JavaScript client-side sorting) easier.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is an RFC patch, first patch of series meant to improve generating
list of projects, trying to reduce both amount of work server has to do
to generate the page, and the size of the page to reduce amount of data
send and amount of rendering web browser (client) has to do.

An RFC because:
 * I don't quote like naming of print_sort_th*() subroutines, but
   I could not think of a better name
 * I wonder if there is a better way to pass arguments, and better way
   to deal with numeric sorting (age) and lexical soering (the rest).

I'd like for someone with better Perl knowledge than me examine this
patch.


What is planned:
 * Adding description to project_list format, so everything except age
   (last changed) can be read by parsing single file, making gitweb
   performance better
 * Paginate projects list in such way so the information such as age
   is gathered and filled only for projects which are shown, if possible
   (it is not possible for example if worting by age)
 * Add searching for projects, by project name (project path),
   description, and owner.  Make gitweb use search page if number of
   projects is greater than some configurable number, as a front page

What is planned in the future
 * Add project's categories support.

 gitweb/gitweb.perl |  108 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2facf2d..6a28dca 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3548,21 +3548,23 @@ sub git_patchset_body {
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
-sub git_project_list_body {
-	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
-
-	my ($check_forks) = gitweb_check_feature('forks');
-
+# fills project list info (age, description, owner, forks) for each
+# project in the list, removing invalid projects from returned list
+sub fill_project_list_info {
+	my ($projlist, $check_forks) = @_;
 	my @projects;
+
+ PROJECT:
 	foreach my $pr (@$projlist) {
-		my (@aa) = git_get_last_activity($pr->{'path'});
-		unless (@aa) {
-			next;
+		my (@activity) = git_get_last_activity($pr->{'path'});
+		unless (@activity) {
+			next PROJECT;
 		}
-		($pr->{'age'}, $pr->{'age_string'}) = @aa;
+		($pr->{'age'}, $pr->{'age_string'}) = @activity;
 		if (!defined $pr->{'descr'}) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
-			$pr->{'descr_long'} = to_utf8($descr);
+			$descr = to_utf8($descr);
+			$pr->{'descr_long'} = $descr;
 			$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
 		}
 		if (!defined $pr->{'owner'}) {
@@ -3574,14 +3576,50 @@ sub git_project_list_body {
 			    ($pname !~ /\/$/) &&
 			    (-d "$projectroot/$pname")) {
 				$pr->{'forks'} = "-d $projectroot/$pname";
-			}
-			else {
+			}	else {
 				$pr->{'forks'} = 0;
 			}
 		}
 		push @projects, $pr;
 	}
 
+	return @projects;
+}
+
+sub print_sort_th {
+	my ($str_sort, $name, $order, $key, $header, $projlist) = @_;
+	$key    ||= $name;
+	$header ||= ucfirst($name);
+
+	if ($order eq $name) {
+		if ($str_sort) {
+			@$projlist = sort {$a->{$key} cmp $b->{$key}} @$projlist;
+		} else {
+			@$projlist = sort {$a->{$key} <=> $b->{$key}} @$projlist;
+		}
+		print "<th>$header</th>\n";
+	} else {
+		print "<th>" .
+		      $cgi->a({-href => href(project=>undef, order=>$name),
+		               -class => "header"}, $header) .
+		      "</th>\n";
+	}
+}
+
+sub print_sort_th_str {
+	print_sort_th(1, @_);
+}
+
+sub print_sort_th_num {
+	print_sort_th(0, @_);
+}
+
+sub git_project_list_body {
+	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
+
+	my ($check_forks) = gitweb_check_feature('forks');
+	my @projects = fill_project_list_info($projlist, $check_forks);
+
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
@@ -3592,43 +3630,15 @@ sub git_project_list_body {
 		if ($check_forks) {
 			print "<th></th>\n";
 		}
-		if ($order eq "project") {
-			@projects = sort {$a->{'path'} cmp $b->{'path'}} @projects;
-			print "<th>Project</th>\n";
-		} else {
-			print "<th>" .
-			      $cgi->a({-href => href(project=>undef, order=>'project'),
-			               -class => "header"}, "Project") .
-			      "</th>\n";
-		}
-		if ($order eq "descr") {
-			@projects = sort {$a->{'descr'} cmp $b->{'descr'}} @projects;
-			print "<th>Description</th>\n";
-		} else {
-			print "<th>" .
-			      $cgi->a({-href => href(project=>undef, order=>'descr'),
-			               -class => "header"}, "Description") .
-			      "</th>\n";
-		}
-		if ($order eq "owner") {
-			@projects = sort {$a->{'owner'} cmp $b->{'owner'}} @projects;
-			print "<th>Owner</th>\n";
-		} else {
-			print "<th>" .
-			      $cgi->a({-href => href(project=>undef, order=>'owner'),
-			               -class => "header"}, "Owner") .
-			      "</th>\n";
-		}
-		if ($order eq "age") {
-			@projects = sort {$a->{'age'} <=> $b->{'age'}} @projects;
-			print "<th>Last Change</th>\n";
-		} else {
-			print "<th>" .
-			      $cgi->a({-href => href(project=>undef, order=>'age'),
-			               -class => "header"}, "Last Change") .
-			      "</th>\n";
-		}
-		print "<th></th>\n" .
+		print_sort_th_str('project', $order, 'path',
+		                  'Project', \@projects);
+		print_sort_th_str('descr', $order, 'descr_long',
+		                  'Description', \@projects);
+		print_sort_th_str('owner', $order, 'owner',
+		                  'Owner', \@projects);
+		print_sort_th_num('age', $order, 'age',
+		                  'Last Change', \@projects);
+		print "<th></th>\n" . # for links
 		      "</tr>\n";
 	}
 	my $alternate = 1;
-- 
1.5.5
