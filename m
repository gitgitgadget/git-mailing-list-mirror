From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Refactor common parts of 'log' and 'shortlog' views
Date: Fri, 13 Nov 2009 02:02:13 +0100
Message-ID: <1258074134-27011-3-git-send-email-jnareb@gmail.com>
References: <1258074134-27011-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 02:02:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8kYG-0008Cr-1U
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 02:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbZKMBBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 20:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754642AbZKMBBq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 20:01:46 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44118 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbZKMBBn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 20:01:43 -0500
Received: by fxm21 with SMTP id 21so2929475fxm.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 17:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rXadAr7a2kZxC3besuPVSObwRMaQPifNaoiSrOuHbpo=;
        b=dpvatsmawCXX16kROC3t1VDSNUBWG6B68RDxIlK/jbDLxzsCRqFLtqwsBHntPaEePU
         7zO/3jfQubJLDZVNViRlibpId25AjSNw7ARo4CnOgl32QLulKrOFOCHoKF/AQnRZMgKl
         NoRbFgyQjLIXEokD6MCt5LbGtIG/rcUmOn3Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AujVSAmMPgzHJiDjdLloqcL/hLarOxBFODlkAOWC948XM6OmQNF+Tvlu9juT2Ewv2R
         JsHwETtWxgvYREn9MzgBD26rRkCOKuEG8+jERjpg2uoAJvdejcxjZp3rJHXhtv92dj1J
         apX+4jtinhvjpM5bKBQa8/jd1hSTYyZaCztlw=
Received: by 10.204.20.82 with SMTP id e18mr4123619bkb.168.1258074108217;
        Thu, 12 Nov 2009 17:01:48 -0800 (PST)
Received: from localhost.localdomain (abvv30.neoplus.adsl.tpnet.pl [83.8.219.30])
        by mx.google.com with ESMTPS id 16sm1117738fxm.4.2009.11.12.17.01.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 17:01:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAD12Ldn027051;
	Fri, 13 Nov 2009 02:02:21 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAD12KND027050;
	Fri, 13 Nov 2009 02:02:20 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1258074134-27011-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132810>

Put the common parts of git_log and git_shortlog into git_log_generic
subroutine: git_log and git_shortlog are now thin wrappers calling
git_log_generic with appropriate arguments.

The unification of code responsible for 'log' and 'shorlog' actions
lead to the following changes in gitweb output
 * 'tree' link in page_nav now uses $hash parameter, as was the case
   for 'shortlog' but not for 'log'
 * 'log' view now respect $hash_parent limiting, like 'shortlog' did
 * 'log' view doesn't have special case for empty list anymore, and it
   always uses page_header linking to summary view, like 'shortlog'
   did.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   72 ++++++++++++++-------------------------------------
 1 files changed, 20 insertions(+), 52 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 68dbd9e..14661cc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5336,7 +5336,9 @@ sub git_snapshot {
 	close $fd;
 }
 
-sub git_log {
+sub git_log_generic {
+	my ($fmt_name, $body_subr) = @_;
+
 	my $head = git_get_head_hash($project);
 	if (!defined $hash) {
 		$hash = $head;
@@ -5346,16 +5348,21 @@ sub git_log {
 	}
 	my $refs = git_get_references();
 
-	my @commitlist = parse_commits($hash, 101, (100 * $page));
+	my $commit_hash = $hash;
+	if (defined $hash_parent) {
+		$commit_hash = "$hash_parent..$hash";
+	}
+	my @commitlist = parse_commits($commit_hash, 101, (100 * $page));
 
-	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
-	my $next_link;
+	my $paging_nav = format_paging_nav($fmt_name, $hash, $head,
+	                                   $page, $#commitlist >= 100);
+	my $next_link = '';
 	if ($#commitlist >= 100) {
 		$next_link =
 			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
-	my ($patch_max) = gitweb_get_feature('patches');
+	my $patch_max = gitweb_get_feature('patches');
 	if ($patch_max) {
 		if ($patch_max < 0 || @commitlist <= $patch_max) {
 			$paging_nav .= " &sdot; " .
@@ -5365,20 +5372,18 @@ sub git_log {
 	}
 
 	git_header_html();
-	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
-
-	if (!@commitlist) {
-		my %co = parse_commit($hash);
-
-		git_print_header_div('summary', $project);
-		print "<div class=\"page_body\"> Last change $co{'age_string'}.<br/><br/></div>\n";
-	}
+	git_print_page_nav($fmt_name,'', $hash,$hash,$hash, $paging_nav);
+	git_print_header_div('summary', $project);
 
-	git_log_body(\@commitlist, 0, 99, $refs, $next_link);
+	$body_subr->(\@commitlist, 0, 99, $refs, $next_link);
 
 	git_footer_html();
 }
 
+sub git_log {
+	git_log_generic('log', \&git_log_body);
+}
+
 sub git_commit {
 	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash)
@@ -6242,44 +6247,7 @@ EOT
 }
 
 sub git_shortlog {
-	my $head = git_get_head_hash($project);
-	if (!defined $hash) {
-		$hash = $head;
-	}
-	if (!defined $page) {
-		$page = 0;
-	}
-	my $refs = git_get_references();
-
-	my $commit_hash = $hash;
-	if (defined $hash_parent) {
-		$commit_hash = "$hash_parent..$hash";
-	}
-	my @commitlist = parse_commits($commit_hash, 101, (100 * $page));
-
-	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#commitlist >= 100);
-	my $next_link = '';
-	if ($#commitlist >= 100) {
-		$next_link =
-			$cgi->a({-href => href(-replay=>1, page=>$page+1),
-			         -accesskey => "n", -title => "Alt-n"}, "next");
-	}
-	my $patch_max = gitweb_check_feature('patches');
-	if ($patch_max) {
-		if ($patch_max < 0 || @commitlist <= $patch_max) {
-			$paging_nav .= " &sdot; " .
-				$cgi->a({-href => href(action=>"patches", -replay=>1)},
-					"patches");
-		}
-	}
-
-	git_header_html();
-	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-	git_print_header_div('summary', $project);
-
-	git_shortlog_body(\@commitlist, 0, 99, $refs, $next_link);
-
-	git_footer_html();
+	git_log_generic('shortlog', \&git_shortlog_body);
 }
 
 ## ......................................................................
-- 
1.6.5
