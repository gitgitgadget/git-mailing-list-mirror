From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] gitweb: Support multiple clone urls
Date: Tue, 15 Aug 2006 22:53:37 +0530
Message-ID: <ebsvuq$de5$1@sea.gmane.org>
References: <ebrpfs$grn$1@sea.gmane.org> <1155659063.10054.65.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090209030404040200040909"
X-From: git-owner@vger.kernel.org Tue Aug 15 19:24:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD2e7-0001kA-7L
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 19:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWHORYD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 13:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWHORYC
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 13:24:02 -0400
Received: from main.gmane.org ([80.91.229.2]:43430 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030427AbWHORYA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 13:24:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GD2dv-0001hE-Tz
	for git@vger.kernel.org; Tue, 15 Aug 2006 19:23:56 +0200
Received: from 59.92.163.89 ([59.92.163.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 19:23:55 +0200
Received: from aneesh.kumar by 59.92.163.89 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 19:23:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.163.89
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <1155659063.10054.65.camel@cashmere.sps.mot.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25469>

This is a multi-part message in MIME format.
--------------090209030404040200040909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This one is on top of the last one 


--------------090209030404040200040909
Content-Type: text/plain;
 name="0002-gitweb-Support-multiple-clone-urls.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-gitweb-Support-multiple-clone-urls.txt"

>From 135f502d7f47f58be5035f2cdb4896dd24adb852 Mon Sep 17 00:00:00 2001
gitweb: Support multiple clone urls

This shows multiple urls if available for git clone

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 gitweb/gitweb.perl |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 869c53e..501537f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -505,12 +505,13 @@ sub git_get_project_description {
 
 sub git_get_project_cloneurl {
 	my $path = shift;
+	my @cloneurls;
 
 	open my $fd, "$projectroot/$path/cloneurl" or return undef;
-	my $descr = <$fd>;
+	@cloneurls = <$fd>;
 	close $fd;
-	chomp $descr;
-	return $descr;
+
+	return \@cloneurls;
 }
 
 sub git_get_projects_list {
@@ -1665,7 +1666,7 @@ sub git_project_list {
 sub git_summary {
 	my $descr = git_get_project_description($project) || "none";
 	my $head = git_get_head_hash($project);
-	my $cloneurl = git_get_project_cloneurl($project) || "none";
+	my $cloneurls = git_get_project_cloneurl($project);
 	my %co = parse_commit($head);
 	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
@@ -1679,9 +1680,14 @@ sub git_summary {
 	print "<table cellspacing=\"0\">\n" .
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
-	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
-	      "<tr><td>URL</td><td>$cloneurl</td></tr>\n" .
-	      "</table>\n";
+	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+
+	my $url;
+	foreach $url (@$cloneurls) {
+		chomp $url;
+		print "<tr><td>URL</td><td>$url</td></tr>\n";
+	}
+	print "</table>\n";
 
 	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_get_head_hash($project)
 		or die_error(undef, "Open git-rev-list failed");
-- 
1.4.2.rc1.g83e1-dirty


--------------090209030404040200040909--
