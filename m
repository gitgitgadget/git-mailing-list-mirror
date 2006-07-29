From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4] gitweb: More explicit error messages for open "-|"
Date: Sat, 29 Jul 2006 23:01:00 +0200
Message-ID: <200607292301.01236.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 29 23:00:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6vvZ-0000J6-Np
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 23:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWG2VAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 17:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWG2VAu
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 17:00:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:30881 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932245AbWG2VAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 17:00:49 -0400
Received: by ug-out-1314.google.com with SMTP id m3so208819ugc
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 14:00:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ta53zZ1+O9D45QOyp3qlnEBEtLJqkLo8qoVUzvajBYVWSDLuPtq5N8RRTZoyppN/QwWxSxoiQ34yk1fpseNdzPooncaFm2dfL6jXb98grV7SN4rilp9eJQdwZeonvlV5kqdHGEwbjHNdtFpXz2vJqL8xurllmoxcr2Wi/P1oI7M=
Received: by 10.67.29.12 with SMTP id g12mr998665ugj;
        Sat, 29 Jul 2006 14:00:48 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k30sm3478988ugc.2006.07.29.14.00.47;
        Sat, 29 Jul 2006 14:00:48 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24436>

Use more explicit error messages when failing magical "-|" open,
stating at least the name of the git command that failed.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Should not affect web security.

 gitweb/gitweb.cgi |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index e1a817b..2c67df0 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1063,7 +1063,7 @@ sub git_summary {
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
 	      "</table>\n";
 	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_read_head($project) 
-		or die_error(undef, "Open failed.");
+		or die_error(undef, "Open git-rev-list failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 	print "<div>\n" .
@@ -1271,7 +1271,7 @@ sub git_blame2 {
 		die_error("400 Bad Request", "object is not a blob");
 	}
 	open ($fd, "-|", $GIT, "blame", '-l', $file_name, $hash_base)
-		or die_error(undef, "Open failed");
+		or die_error(undef, "Open git-blame failed.");
 	git_header_html();
 	print "<div class=\"page_nav\">\n" .
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
@@ -1333,7 +1333,7 @@ sub git_blame {
 			or die_error(undef, "Error lookup file.");
 	}
 	open ($fd, "-|", $GIT, "annotate", '-l', '-t', '-r', $file_name, $hash_base)
-		or die_error(undef, "Open failed.");
+		or die_error(undef, "Open git-annotate failed.");
 	git_header_html();
 	print "<div class=\"page_nav\">\n" .
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
@@ -1609,7 +1609,8 @@ sub git_blob_plain {
 		}
 	}
 	my $type = shift;
-	open my $fd, "-|", $GIT, "cat-file", "blob", $hash or die_error("Couldn't cat $file_name, $hash");
+	open my $fd, "-|", $GIT, "cat-file", "blob", $hash 
+		or die_error("Couldn't cat $file_name, $hash");
 
 	$type ||= git_blob_plain_mimetype($fd, $file_name);
 
@@ -1641,7 +1642,8 @@ sub git_blob {
 		}
 	}
 	my $have_blame = git_get_project_config_bool ('blame');
-	open my $fd, "-|", $GIT, "cat-file", "blob", $hash or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "cat-file", "blob", $hash 
+		or die_error(undef, "Couldn't cat $file_name, $hash.");
 	my $mimetype = git_blob_plain_mimetype($fd, $file_name);
 	if ($mimetype !~ m/^text\//) {
 		close $fd;
@@ -1705,7 +1707,8 @@ sub git_tree {
 		}
 	}
 	$/ = "\0";
-	open my $fd, "-|", $GIT, "ls-tree", '-z', $hash or die_error(undef, "Open git-ls-tree failed.");
+	open my $fd, "-|", $GIT, "ls-tree", '-z', $hash 
+		or die_error(undef, "Open git-ls-tree failed.");
 	chomp (my (@entries) = <$fd>);
 	close $fd or die_error(undef, "Reading tree failed.");
 	$/ = "\n";
@@ -1787,7 +1790,7 @@ #			      " | " . $cgi->a({-href => "$my
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
 	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project) 
-		or die_error(undef, "Open failed.");
+		or die_error(undef, "Open git-rev-list failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading rev-list failed.");
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
@@ -1895,7 +1898,8 @@ sub git_log {
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", $GIT, "rev-list", $limit, $hash or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "rev-list", $limit, $hash 
+		or die_error(undef, "Open git-rev-list failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
@@ -1987,7 +1991,7 @@ sub git_commit {
 		$parent = "";
 	}
 	open my $fd, "-|", $GIT, "diff-tree", '-r', '-M', $root, $parent, $hash 
-		or die_error(undef, "Open failed.");
+		or die_error(undef, "Open git-diff-tree failed.");
 	@difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2234,7 +2238,7 @@ sub git_commitdiff {
 		$hash_parent = $co{'parent'};
 	}
 	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
-		or die_error(undef, "Open failed.");
+		or die_error(undef, "Open git-diff-tree failed.");
 	my (@difftree) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2325,7 +2329,7 @@ sub git_commitdiff {
 sub git_commitdiff_plain {
 	mkdir($git_temp, 0700);
 	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash 
-		or die_error(undef, "Open failed.");
+		or die_error(undef, "Open git-diff-tree failed.");
 	my (@difftree) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
@@ -2618,7 +2622,8 @@ sub git_shortlog {
 	      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$hash;hb=$hash")}, "tree") . "<br/>\n";
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", $GIT, "rev-list", $limit, $hash or die_error(undef, "Open failed.");
+	open my $fd, "-|", $GIT, "rev-list", $limit, $hash 
+		or die_error(undef, "Open git-rev-list failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 
-- 
1.4.0
