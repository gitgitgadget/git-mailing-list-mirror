From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 4/4] gitweb.cgi: Centralize printing of the page path
Date: Sun, 23 Jul 2006 13:31:15 -0700 (PDT)
Message-ID: <20060723203115.40374.qmail@web31810.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-121438022-1153686675=:40367"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 23 22:31:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4kbf-0000d1-HD
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 22:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWGWUbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 16:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWGWUbR
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 16:31:17 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:25262 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751302AbWGWUbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 16:31:16 -0400
Received: (qmail 40376 invoked by uid 60001); 23 Jul 2006 20:31:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=x2pUiVuGUiWWxmxPaUYUgouwDGZiMZQ5swffURzSyfyIbdSveL06nohNFucqHudR+zn2InDHErJgaC2wmpGxcAvVtBKNMLuZ7C/NNE0usb9vzwzCuJcbqfEZQZyHXWSj+XQtFEmrrkDs1CqJKWahKN0HwgANtfA3w+kNz7y0NZY=  ;
Received: from [71.80.232.189] by web31810.mail.mud.yahoo.com via HTTP; Sun, 23 Jul 2006 13:31:15 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24103>

--0-121438022-1153686675=:40367
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Centralize printing of the page path so that
if the entity is a blob, we can set the page path
to be the link to the HEAD revision of the
"raw" blob.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |   41 +++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 20 deletions(-)
--0-121438022-1153686675=:40367
Content-Type: text/inline; name="p4.patch"
Content-Description: 2013183029-p4.patch
Content-Disposition: name="p4.patch"; filename="p4.patch"

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index c04283b..4106cb8 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1199,6 +1199,20 @@ sub git_summary {
 	git_footer_html();
 }
 
+sub git_print_page_path {
+	my $name = shift;
+	my $type = shift;
+
+	if (!defined $name) {
+		print "<div class=\"page_path\"><b>/</b></div>\n";
+	} elsif ($type =~ "blob") {
+		print "<div class=\"page_path\"><b>" .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;f=$file_name")}, esc_html($name)) . "</b><br/></div>\n";
+	} else {
+		print "<div class=\"page_path\"><b>" . esc_html($name) . "</b><br/></div>\n";
+	}
+}
+
 sub git_tag {
 	my $head = git_read_head($project);
 	git_header_html();
@@ -1266,7 +1280,7 @@ sub git_blame {
 		"<div>" .
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
 		"</div>\n";
-	print "<div class=\"page_path\"><b>" . esc_html($file_name) . "</b></div>\n";
+	git_print_page_path($file_name);
 	print "<div class=\"page_body\">\n";
 	print <<HTML;
 <table class="blame">
@@ -1604,9 +1618,7 @@ sub git_blob {
 		      "<br/><br/></div>\n" .
 		      "<div class=\"title\">$hash</div>\n";
 	}
-	if (defined $file_name) {
-		print "<div class=\"page_path\"><b>" . esc_html($file_name) . "</b></div>\n";
-	}
+	git_print_page_path($file_name, "blob");
 	print "<div class=\"page_body\">\n";
 	my $nr;
 	while (my $line = <$fd>) {
@@ -1671,10 +1683,8 @@ sub git_tree {
 	}
 	if (defined $file_name) {
 		$base = esc_html("$file_name/");
-		print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b></div>\n";
-	} else {
-		print "<div class=\"page_path\"><b>/</b></div>\n";
 	}
+	git_print_page_path($file_name);
 	print "<div class=\"page_body\">\n";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
@@ -2132,9 +2142,7 @@ sub git_blobdiff {
 		      "<br/><br/></div>\n" .
 		      "<div class=\"title\">$hash vs $hash_parent</div>\n";
 	}
-	if (defined $file_name) {
-		print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b></div>\n";
-	}
+	git_print_page_path($file_name, "blob");
 	print "<div class=\"page_body\">\n" .
 	      "<div class=\"diff_info\">blob:" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash_parent;hb=$hash_base;f=$file_name")}, $hash_parent) .
@@ -2308,6 +2316,7 @@ sub git_history {
 	if (!defined $hash_base) {
 		$hash_base = git_read_head($project);
 	}
+	my $ftype;
 	my %co = git_read_commit($hash_base);
 	if (!%co) {
 		die_error(undef, "Unknown commit object.");
@@ -2330,18 +2339,9 @@ sub git_history {
 		$hash = git_get_hash_by_path($hash_base, $file_name);
 	}
 	if (defined $hash) {
-		my $ftype = git_get_type($hash);
-
-		if ($ftype =~ "blob") {
-		    print "<div class=\"page_path\"><b>/" .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;f=$file_name")}, esc_html($file_name)) . "</b><br/></div>\n";
-		} else {
-		    print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
-		}
-	} else {
-		print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
+		$ftype = git_get_type($hash);
 	}
+	git_print_page_path($file_name, $ftype);
 
 	open my $fd, "-|",
 		"$GIT rev-list --full-history $hash_base -- \'$file_name\'";
-- 
1.4.2.rc1.g9b54


--0-121438022-1153686675=:40367--
