From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Make 'history' view (re)use git_log_generic()
Date: Fri, 13 Nov 2009 02:02:14 +0100
Message-ID: <1258074134-27011-4-git-send-email-jnareb@gmail.com>
References: <1258074134-27011-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 02:02:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8kYH-0008Cr-KF
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 02:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbZKMBBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 20:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbZKMBBw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 20:01:52 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:32820 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696AbZKMBBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 20:01:47 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so2929461fxm.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 17:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xNgg37nNx2dEKYmTBb2mcFrFSOSc1EhI7qB8RRGdGFU=;
        b=NHGcYZifGFj2dezY0OxmjwwBMzSIRCc4fWm07J771stncPcL/jjGqyvDf4hMLCC/3Q
         TNs7uvbnCTIjm+FOkOeWay/6fclCItU3hI/+XjKuuxYRxGE7qooMR3un+y7UR0XjPkw0
         ebEfHWQ7ne8Rsraj8hrVyWFivhaV8e23MZZlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kN8y4b6Ye2NjjjBdThHTorvixnm9flej2ueUzMN6qzMPJA/R2oh4+FSE2fZYlmj0A/
         5XBd1pzzoxdhbnnUFeH6A1T3RnyJSHKCE/V2ZM16lsfdwLyuR2YN+MnLLi9QRpsV/0Vb
         rZ3HOYT083mJEuAOEFRDmLxU6qEG6y5/Eh+dc=
Received: by 10.204.34.78 with SMTP id k14mr656598bkd.106.1258074112754;
        Thu, 12 Nov 2009 17:01:52 -0800 (PST)
Received: from localhost.localdomain (abvv30.neoplus.adsl.tpnet.pl [83.8.219.30])
        by mx.google.com with ESMTPS id 15sm1112492fxm.10.2009.11.12.17.01.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 17:01:52 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAD12QaI027055;
	Fri, 13 Nov 2009 02:02:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAD12LFg027054;
	Fri, 13 Nov 2009 02:02:21 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1258074134-27011-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132811>

Make git_history use git_log_generic, passing git_history_body as one
of its paramaters.  This required changes to git_log_generic, in
particular passing more things as parameters.

While refactoring common code of 'log', 'shortlog' and 'history' view,
we did unify pagination, using always the form used by 'history' view,
namely
  first * prev * next
in place of
  HEAD * prev * next
used by 'log' and 'shortlog' views.

The 'history' view now supports commit limiting via 'hpb' parameter,
similarly to 'shortlog' (and 'log') view.  Performance of 'history'
view got improved a bit, as it doesn't run git_get_hash_by_path for
"current" version in a loop.  Error detection and reporting for
'history' view changed a bit.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |  146 ++++++++++++++++++++-------------------------------
 1 files changed, 57 insertions(+), 89 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 14661cc..5cfa507 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3363,22 +3363,18 @@ sub git_print_page_nav {
 }
 
 sub format_paging_nav {
-	my ($action, $hash, $head, $page, $has_next_link) = @_;
+	my ($action, $page, $has_next_link) = @_;
 	my $paging_nav;
 
 
-	if ($hash ne $head || $page) {
-		$paging_nav .= $cgi->a({-href => href(action=>$action)}, "HEAD");
-	} else {
-		$paging_nav .= "HEAD";
-	}
-
 	if ($page > 0) {
-		$paging_nav .= " &sdot; " .
+		$paging_nav .=
+			$cgi->a({-href => href(-replay=>1, page=>undef)}, "first") .
+			" &sdot; " .
 			$cgi->a({-href => href(-replay=>1, page=>$page-1),
 			         -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
-		$paging_nav .= " &sdot; prev";
+		$paging_nav .= "first &sdot; prev";
 	}
 
 	if ($has_next_link) {
@@ -4447,7 +4443,8 @@ sub git_shortlog_body {
 
 sub git_history_body {
 	# Warning: assumes constant type (blob or tree) during history
-	my ($commitlist, $from, $to, $refs, $hash_base, $ftype, $extra) = @_;
+	my ($commitlist, $from, $to, $refs, $extra,
+	    $file_name, $file_hash, $ftype) = @_;
 
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} unless (defined $to && $to <= $#{$commitlist});
@@ -4481,7 +4478,7 @@ sub git_history_body {
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
 
 		if ($ftype eq 'blob') {
-			my $blob_current = git_get_hash_by_path($hash_base, $file_name);
+			my $blob_current = $file_hash;
 			my $blob_parent  = git_get_hash_by_path($commit, $file_name);
 			if (defined $blob_current && defined $blob_parent &&
 					$blob_current ne $blob_parent) {
@@ -5337,25 +5334,48 @@ sub git_snapshot {
 }
 
 sub git_log_generic {
-	my ($fmt_name, $body_subr) = @_;
+	my ($fmt_name, $body_subr, $base, $parent, $file_name, $file_hash) = @_;
 
 	my $head = git_get_head_hash($project);
-	if (!defined $hash) {
-		$hash = $head;
+	if (!defined $base) {
+		$base = $head;
 	}
 	if (!defined $page) {
 		$page = 0;
 	}
 	my $refs = git_get_references();
 
-	my $commit_hash = $hash;
-	if (defined $hash_parent) {
-		$commit_hash = "$hash_parent..$hash";
+	my $commit_hash = $base;
+	if (defined $parent) {
+		$commit_hash = "$parent..$base";
+	}
+	my @commitlist =
+		parse_commits($commit_hash, 101, (100 * $page),
+		              defined $file_name ? ($file_name, "--full-history") : ());
+
+	my $ftype;
+	if (!defined $file_hash && defined $file_name) {
+		# some commits could have deleted file in question,
+		# and not have it in tree, but one of them has to have it
+		for (my $i = 0; $i < @commitlist; $i++) {
+			$file_hash = git_get_hash_by_path($commitlist[$i]{'id'}, $file_name);
+			last if defined $file_hash;
+		}
+	}
+	if (defined $file_hash) {
+		$ftype = git_get_type($file_hash);
+	}
+	if (defined $file_name && !defined $ftype) {
+		die_error(500, "Unknown type of object");
+	}
+	my %co;
+	if (defined $file_name) {
+		%co = parse_commit($base)
+			or die_error(404, "Unknown commit object");
 	}
-	my @commitlist = parse_commits($commit_hash, 101, (100 * $page));
 
-	my $paging_nav = format_paging_nav($fmt_name, $hash, $head,
-	                                   $page, $#commitlist >= 100);
+
+	my $paging_nav = format_paging_nav($fmt_name, $page, $#commitlist >= 100);
 	my $next_link = '';
 	if ($#commitlist >= 100) {
 		$next_link =
@@ -5363,7 +5383,7 @@ sub git_log_generic {
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
 	my $patch_max = gitweb_get_feature('patches');
-	if ($patch_max) {
+	if ($patch_max && !defined $file_name) {
 		if ($patch_max < 0 || @commitlist <= $patch_max) {
 			$paging_nav .= " &sdot; " .
 				$cgi->a({-href => href(action=>"patches", -replay=>1)},
@@ -5373,15 +5393,23 @@ sub git_log_generic {
 
 	git_header_html();
 	git_print_page_nav($fmt_name,'', $hash,$hash,$hash, $paging_nav);
-	git_print_header_div('summary', $project);
+	if (defined $file_name) {
+		git_print_header_div('commit', esc_html($co{'title'}), $base);
+	} else {
+		git_print_header_div('summary', $project)
+	}
+	git_print_page_path($file_name, $ftype, $hash_base)
+		if (defined $file_name);
 
-	$body_subr->(\@commitlist, 0, 99, $refs, $next_link);
+	$body_subr->(\@commitlist, 0, 99, $refs, $next_link,
+	             $file_name, $file_hash, $ftype);
 
 	git_footer_html();
 }
 
 sub git_log {
-	git_log_generic('log', \&git_log_body);
+	git_log_generic('log', \&git_log_body,
+	                $hash, $hash_parent);
 }
 
 sub git_commit {
@@ -5920,70 +5948,9 @@ sub git_patches {
 }
 
 sub git_history {
-	if (!defined $hash_base) {
-		$hash_base = git_get_head_hash($project);
-	}
-	if (!defined $page) {
-		$page = 0;
-	}
-	my $ftype;
-	my %co = parse_commit($hash_base)
-	    or die_error(404, "Unknown commit object");
-
-	my $refs = git_get_references();
-	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-
-	my @commitlist = parse_commits($hash_base, 101, (100 * $page),
-	                               $file_name, "--full-history")
-	    or die_error(404, "No such file or directory on given branch");
-
-	if (!defined $hash && defined $file_name) {
-		# some commits could have deleted file in question,
-		# and not have it in tree, but one of them has to have it
-		for (my $i = 0; $i <= @commitlist; $i++) {
-			$hash = git_get_hash_by_path($commitlist[$i]{'id'}, $file_name);
-			last if defined $hash;
-		}
-	}
-	if (defined $hash) {
-		$ftype = git_get_type($hash);
-	}
-	if (!defined $ftype) {
-		die_error(500, "Unknown type of object");
-	}
-
-	my $paging_nav = '';
-	if ($page > 0) {
-		$paging_nav .=
-			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
-			                       file_name=>$file_name)},
-			        "first");
-		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => href(-replay=>1, page=>$page-1),
-			         -accesskey => "p", -title => "Alt-p"}, "prev");
-	} else {
-		$paging_nav .= "first";
-		$paging_nav .= " &sdot; prev";
-	}
-	my $next_link = '';
-	if ($#commitlist >= 100) {
-		$next_link =
-			$cgi->a({-href => href(-replay=>1, page=>$page+1),
-			         -accesskey => "n", -title => "Alt-n"}, "next");
-		$paging_nav .= " &sdot; $next_link";
-	} else {
-		$paging_nav .= " &sdot; next";
-	}
-
-	git_header_html();
-	git_print_page_nav('history','', $hash_base,$co{'tree'},$hash_base, $paging_nav);
-	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
-	git_print_page_path($file_name, $ftype, $hash_base);
-
-	git_history_body(\@commitlist, 0, 99,
-	                 $refs, $hash_base, $ftype, $next_link);
-
-	git_footer_html();
+	git_log_generic('history', \&git_history_body,
+	                $hash_base, $hash_parent_base,
+	                $file_name, $hash);
 }
 
 sub git_search {
@@ -6247,7 +6214,8 @@ EOT
 }
 
 sub git_shortlog {
-	git_log_generic('shortlog', \&git_shortlog_body);
+	git_log_generic('shortlog', \&git_shortlog_body,
+	                $hash, $hash_parent);
 }
 
 ## ......................................................................
-- 
1.6.5
