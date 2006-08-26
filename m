From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/7] gitweb: blobs defined by non-textual hash ids can be cached
Date: Sat, 26 Aug 2006 19:14:25 +0200
Message-ID: <11566124672100-git-send-email-jnareb@gmail.com>
References: <1156612392716-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 26 19:14:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH1k9-00041P-36
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 19:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422899AbWHZROh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 13:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422879AbWHZROg
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 13:14:36 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:34182 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030261AbWHZROe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 13:14:34 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7QHDGpW004454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Aug 2006 19:13:16 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7QHERXd032753;
	Sat, 26 Aug 2006 19:14:27 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7QHER0N032752;
	Sat, 26 Aug 2006 19:14:27 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1156612392716-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26059>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index eae83e6..f6175bb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2371,6 +2371,12 @@ sub git_heads {
 }
 
 sub git_blob_plain {
+	# blobs defined by non-textual hash id's can be cached
+	my $expires;
+	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = "+1d";
+	}
+
 	if (!defined $hash) {
 		if (defined $file_name) {
 			my $base = $hash_base || git_get_head_hash($project);
@@ -2394,8 +2400,10 @@ sub git_blob_plain {
 		$save_as .= '.txt';
 	}
 
-	print $cgi->header(-type => "$type",
-	                   -content_disposition => "inline; filename=\"$save_as\"");
+	print $cgi->header(
+		-type => "$type",
+		-expires=>$expires,
+		-content_disposition => "inline; filename=\"$save_as\"");
 	binmode STDOUT, ':raw';
 	local $/ = undef;
 	print <$fd>;
@@ -2404,6 +2412,12 @@ sub git_blob_plain {
 }
 
 sub git_blob {
+	# blobs defined by non-textual hash id's can be cached
+	my $expires;
+	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = "+1d";
+	}
+
 	if (!defined $hash) {
 		if (defined $file_name) {
 			my $base = $hash_base || git_get_head_hash($project);
@@ -2421,7 +2435,7 @@ sub git_blob {
 		close $fd;
 		return git_blob_plain($mimetype);
 	}
-	git_header_html();
+	git_header_html(undef, $expires);
 	my $formats_nav = '';
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		if (defined $file_name) {
-- 
1.4.1.1
