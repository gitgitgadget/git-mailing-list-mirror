From: Florian Forster <octo@verplant.org>
Subject: [PATCH] gitweb: Make the availability of the `blame' interface in gitweb configurable.
Date: Mon, 12 Jun 2006 10:31:57 +0200
Message-ID: <11501011173804-git-send-email-octo@verplant.org>
References: <20060612082448.GA11857@verplant.org>
Reply-To: Florian Forster <octo@verplant.org>
Cc: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 10:32:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FphqT-0003rW-Ns
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 10:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWFLIcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 04:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWFLIcK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 04:32:10 -0400
Received: from verplant.org ([213.95.21.52]:38346 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1750932AbWFLIcA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 04:32:00 -0400
Received: from leeloo.lan.home.verplant.org ([2001:780:104:1:2e0:18ff:fead:37e4] ident=Debian-exim)
	by huhu.verplant.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Fphq3-0000Im-F9; Mon, 12 Jun 2006 10:31:59 +0200
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=octo)
	by leeloo.lan.home.verplant.org with esmtp (Exim 4.62)
	(envelope-from <octo@verplant.org>)
	id 1Fphq1-0000yr-Sx; Mon, 12 Jun 2006 10:31:57 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3
In-Reply-To: <20060612082448.GA11857@verplant.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21695>

Since `git-annotate' is an expensive operation to run it may be desirable to
deactivate this functionality. This patch introduces the `gitweb.blame' option
to git-repo-config and disables the blame support by default.

Signed-off-by: Florian Forster <octo@verplant.org>


---

 gitweb/gitweb.cgi |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

3eea23e8d8a13579455cdf8d5088794d33bdcba2
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 91c075d..5eabe06 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -837,6 +837,25 @@ sub git_read_projects {
 	return @list;
 }
 
+sub git_get_project_config {
+	my $key = shift;
+
+	return unless ($key);
+	$key =~ s/^gitweb\.//;
+	return if ($key =~ m/\W/);
+
+	my $val = qx(git-repo-config --get gitweb.$key);
+	return ($val);
+}
+
+sub git_get_project_config_bool {
+	my $val = git_get_project_config (@_);
+	if ($val and $val =~ m/true|yes|on/) {
+		return (1);
+	}
+	return; # implicit false
+}
+
 sub git_project_list {
 	my @list = git_read_projects();
 	my @projects;
@@ -1233,6 +1252,7 @@ sub git_tag {
 
 sub git_blame {
 	my $fd;
+	die_error('403 Permission denied', "Permission denied.") if (!git_get_project_config_bool ('blame'));
 	die_error('404 Not Found', "What file will it be, master?") if (!$file_name);
 	$hash_base ||= git_read_head($project);
 	die_error(undef, "Reading commit failed.") unless ($hash_base);
@@ -1468,6 +1488,7 @@ sub git_blob {
 		my $base = $hash_base || git_read_head($project);
 		$hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
 	}
+	my $have_blame = git_get_project_config_bool ('blame');
 	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or die_error(undef, "Open failed.");
 	git_header_html();
 	if (defined $hash_base && (my %co = git_read_commit($hash_base))) {
@@ -1479,8 +1500,10 @@ sub git_blob {
 		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
 		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") . "<br/>\n";
 		if (defined $file_name) {
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$hash;hb=$hash_base;f=$file_name")}, "blame") .
-			" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash;f=$file_name")}, "plain") .
+			if ($have_blame) {
+				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$hash;hb=$hash_base;f=$file_name")}, "blame") .  " | ";
+			}
+			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash;f=$file_name")}, "plain") .
 			" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;hb=HEAD;f=$file_name")}, "head") . "<br/>\n";
 		} else {
 			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash")}, "plain") . "<br/>\n";
-- 
1.3.3
