From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Paginate project list
Date: Sat, 10 May 2008 11:28:56 +0200
Message-ID: <200805101128.59313.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com> <200805031103.14960.jnareb@gmail.com> <200805091523.24591.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, "J.H." <warthog19@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 11:30:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JulPR-0001b1-Fd
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 11:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbYEJJ3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 05:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbYEJJ3O
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 05:29:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:58006 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYEJJ3N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 05:29:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1111211fgg.17
        for <git@vger.kernel.org>; Sat, 10 May 2008 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=QSraghsWBs2WfdZ+r7gvPDDVI3y6BzLR796lCq/RliU=;
        b=YlcnpIilHsDo6DcU9sNKOYZ8QulWSFsTbubWgu2xzdiR6VN+5hiECQ4neoWKUqvOZEM5y9OIGQy/XfW1qkeHO+3/T8y+sEIDYDtEXVpukhxXuZxh8phYIusFjNe/OxvHNUN//98iHVaMXpesPhmeVI42wbFTu9/DgwFqnBPs8M8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aN+1+GcW+Na+WEiwYyocr73qSNewARGcI5Iizjj20TycmgzViYV+Wbe6kZY/EQzn8sTQrmnYlBeu1X9vaMCKvHJjBwK3nCh7QOnOfoLrYl+fJy/0T0CTWO1An316Ya8MnIGCIgjcPRycp83bGWWD/yjXazn0GzfS3+sgKx0ppio=
Received: by 10.86.57.9 with SMTP id f9mr10114233fga.8.1210411751567;
        Sat, 10 May 2008 02:29:11 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.192.226])
        by mx.google.com with ESMTPS id e8sm23174526muf.0.2008.05.10.02.29.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 May 2008 02:29:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200805091523.24591.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81660>

Divide projects list and project search results into pages of
$page_size (currently 100) elements.  Pagination links look
like shown below:

  first prev 1 2 3 *4* 5 6 next last

where *4* denotes current page, is in bold, and isn't a link.
This would need to be improved for extremely large number of projects
(repositories), where number of projects divided by page size is very
large.

Currently pagination interacts with sorting in a bit strange way.
When clicking on "sort by" link when on some later page the result is
not this page sorted, by given page of sorted output.  Perhaps "sort
by" links should always show first page...

git_project_list_body() subroutine takes care to fill field (key) we
sort by for all projects, sort by given ordering, and fill the rest of
project info only for projects shown.

NOTE: currently code is not optimal, as it contains a few unnecessary
array copying, or array fragment copying.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch depends on earlier "gitweb: Project search", but conceptually
they are independent; probably fill_project_list_info() improvement to
do partial filling should be in seaparet commit...

 gitweb/gitweb.perl |   57 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7e1a9b4..716f7ad 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3709,10 +3709,10 @@ sub print_sort_th_num {
 sub git_project_list_body {
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
+	$order ||= $default_projects_order;
 	my ($check_forks) = gitweb_check_feature('forks');
-	my @projects = fill_project_list_info($projlist, $check_forks);
+	my @projects = fill_project_list_info($projlist, $check_forks, $order);
 
-	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
 
@@ -3733,9 +3733,10 @@ sub git_project_list_body {
 		print "<th></th>\n" . # for links
 		      "</tr>\n";
 	}
+	@projects = @projects[$from..$to];
+	@projects = fill_project_list_info(\@projects, $check_forks);
 	my $alternate = 1;
-	for (my $i = $from; $i <= $to; $i++) {
-		my $pr = $projects[$i];
+	foreach my $pr (@projects) {
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -4066,6 +4067,46 @@ sub git_project_list {
 		die_error(undef, "No projects found");
 	}
 
+	my $page_size = 100;
+	# +1 for incomplete page (not having $page_size items)
+	my $npages = int(@list / $page_size)+((@list % $page_size) > 0);
+	# pages are numbered 0..$npages-1
+	$page = 0 if (!defined $page || $page < 0);
+	$page = $npages-1 if ($page >= $npages);
+	my $paging_nav;
+
+	if ($npages > 1) {
+		my @paging = ();
+		push @paging, $cgi->a({-href => href(-replay=>1, page=>0)},
+		                      "first");
+		if ($page > 0) {
+			push @paging, $cgi->a({-href => href(-replay=>1, page=>$page-1),
+			                       -accesskey => "p", -title => "Alt-p"},
+			                      "prev");
+		} else {
+			push @paging, "prev";
+		}
+		for (my $pg = 0; $pg < $npages; $pg++) {
+			# links to individual pages are numbered 1..$npages
+			if ($page == $pg) {
+				push @paging, '<b>'.($pg+1).'</b>';
+			} else {
+				push @paging, $cgi->a({-href => href(-replay=>1, page=>$pg)},
+				                      $pg+1);
+			}
+		}
+		if ($page < $npages-1) {
+			push @paging, $cgi->a({-href => href(-replay=>1, page=>$page+1),
+			                       -accesskey => "n", -title => "Alt-n"},
+			                      "next");
+		} else {
+			push @paging, "next";
+		}
+		push @paging, $cgi->a({-href => href(-replay=>1, page=>$npages-1)},
+		                      "last");
+		$paging_nav = join(' &sdot; ', @paging);
+	}
+
 	git_header_html();
 	if (-f $home_text) {
 		print "<div class=\"index_include\">\n";
@@ -4081,10 +4122,14 @@ sub git_project_list {
 		if (defined $searchtype) {
 			filter_project_list(\@list, $searchtype, $search_regexp)
 				unless ($searchtype eq 'list_all');
-			git_project_list_body(\@list, $order);
+			git_project_list_body(\@list, $order,
+			                      $page*$page_size, ($page+1)*$page_size - 1,
+			                      $paging_nav);
 		}
 	} else {
-		git_project_list_body(\@list, $order);
+		git_project_list_body(\@list, $order,
+		                      $page*$page_size, ($page+1)*$page_size - 1,
+		                      $paging_nav);
 	}
 	git_footer_html();
 }
-- 
1.5.5
