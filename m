From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix "Use of unitialized value" warnings in empty repository
Date: Sun, 13 May 2007 12:39:22 +0200
Message-ID: <200705131239.23353.jnareb@gmail.com>
References: <200705120135.30150.jnareb@gmail.com> <7vzm4a7sv3.fsf@assigned-by-dhcp.cox.net> <200705122116.34486.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 01:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNZ0-0002hy-J4
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758388AbXEMXch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758459AbXEMXcg
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:32:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:39498 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758362AbXEMXcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:32:35 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1226383uga
        for <git@vger.kernel.org>; Sun, 13 May 2007 16:32:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LaMEXQTvOT98yMrp0NHm85y3R7RJfZRj2inrB8IOpb5f8Tcatwns7E4szzccyqwSafcaUvCUGYo0+chuvIj14glGM9Mvp/jRD5j+j9vhlOGgEK0UXQNBMWoZXsLRyx4ba3P1SOY3nJ8Us8+CUsuYcL5fnUq32SDuyCxBuGynVRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZBjQZGCrjxBhI4HGF0m0j2i0bDEsGIsnkDkMf1efrwNYGjh8siB8FJPVpN08oFpin51zNh0kn/FFZ3/BF/vtSve5xrVth1nhILfK5SASQ2ZWgoCQFRZpwrYtPjaHZRNIubL9JN1BPJxTTSm7LjmQlJ3AMc57p4HCz1CeJQnP7M0=
Received: by 10.67.96.14 with SMTP id y14mr3781418ugl.1179099154692;
        Sun, 13 May 2007 16:32:34 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e33sm12678053ugd.2007.05.13.16.32.33;
        Sun, 13 May 2007 16:32:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200705122116.34486.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47191>

Fix it so gitweb doesn't write "Use of unitialized value..." warnings
(which gets written in web server logs) for empty (no commits)
repository.

In empty repository "last change" (last activity) doesn't make sense;
also there is no sense in parsing commits which aren't there.

In projects list for empty repositories gitweb now writes "No commits"
using "noage" class, instead of leaving cell empty, in the last change
column.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski wrote:
> One thing that is left is to fix "Use of initialized value..." warnings
> for empty repositories (initialized, but without any commits). But I
> don't think that this corner case is terribly important.

This patch fixes this issue.

 gitweb/gitweb.perl |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d467bf3..c2eeca9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -728,7 +728,9 @@ sub chop_str {
 sub age_class {
 	my $age = shift;
 
-	if ($age < 60*60*2) {
+	if (!defined $age) {
+		return "noage";
+	} elsif ($age < 60*60*2) {
 		return "age0";
 	} elsif ($age < 60*60*24*2) {
 		return "age1";
@@ -1258,7 +1260,8 @@ sub git_get_last_activity {
 	     'refs/heads') or return;
 	my $most_recent = <$fd>;
 	close $fd or return;
-	if ($most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
+	if (defined $most_recent &&
+	    $most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
 		my $timestamp = $1;
 		my $age = time - $timestamp;
 		return ($age, age_string($age));
@@ -2983,7 +2986,7 @@ sub git_project_list_body {
 		                        esc_html($pr->{'descr'})) . "</td>\n" .
 		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
 		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
-		      $pr->{'age_string'} . "</td>\n" .
+		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
@@ -3335,7 +3338,7 @@ sub git_project_index {
 sub git_summary {
 	my $descr = git_get_project_description($project) || "none";
 	my %co = parse_commit("HEAD");
-	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
+	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
 	my $head = $co{'id'};
 
 	my $owner = git_get_project_owner($project);
@@ -3358,8 +3361,11 @@ sub git_summary {
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table cellspacing=\"0\">\n" .
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
-	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
-	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+	      "<tr><td>owner</td><td>$owner</td></tr>\n";
+	if (defined $cd{'rfc2822'}) {
+		print "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+	}
+
 	# use per project git URL list in $projectroot/$project/cloneurl
 	# or make project git URL from git base URL and project name
 	my $url_tag = "URL";
@@ -3382,11 +3388,13 @@ sub git_summary {
 
 	# we need to request one more than 16 (0..15) to check if
 	# those 16 are all
-	my @commitlist = parse_commits($head, 17);
-	git_print_header_div('shortlog');
-	git_shortlog_body(\@commitlist, 0, 15, $refs,
-	                  $#commitlist <=  15 ? undef :
-	                  $cgi->a({-href => href(action=>"shortlog")}, "..."));
+	my @commitlist = $head ? parse_commits($head, 17) : ();
+	if (@commitlist) {
+		git_print_header_div('shortlog');
+		git_shortlog_body(\@commitlist, 0, 15, $refs,
+		                  $#commitlist <=  15 ? undef :
+		                  $cgi->a({-href => href(action=>"shortlog")}, "..."));
+	}
 
 	if (@taglist) {
 		git_print_header_div('tags');
-- 
1.5.1.4
