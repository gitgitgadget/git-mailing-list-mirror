From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/3] gitweb: Use here-doc
Date: Tue, 22 Aug 2006 23:42:53 +0200
Message-ID: <200608222342.53861.jnareb@gmail.com>
References: <200608221651.19629.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 22 23:43:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFe1l-0002eO-SZ
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 23:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWHVVnK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 17:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWHVVnK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 17:43:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:62066 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751307AbWHVVnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 17:43:08 -0400
Received: by nf-out-0910.google.com with SMTP id x30so173600nfb
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 14:42:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ERXMrM0qpDOyABM+6VNy9wu66maqpUmJamfw29dM+LeIp/8AwhxdxfgH+7cD6Vt5Epi4CPAXEa1uvXrpYPE8TQn5wbkMYl+gNQgcWCQxLVz0rT86+pbLgRzOEvQO43go0S/j8kJyT8fV+XhkkUZxaJ5pSz2FUqImLDaW/rI1ax8=
Received: by 10.49.75.2 with SMTP id c2mr1043003nfl;
        Tue, 22 Aug 2006 14:42:53 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id k9sm1170924nfc.2006.08.22.14.42.52;
        Tue, 22 Aug 2006 14:42:52 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608221651.19629.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25874>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch uses undocumented, at least in perlop(1), trick in
interpolation that allows calling function from interpolated string,
using ${\subroutine_name(parameters...)}, found in git_blame,
and used in git_rss here-doc in this patch.

This patch is part of "[PATCH 0/3] gitweb: Yet another cleanup series"
series.

 gitweb/gitweb.perl |   75 
+++++++++++++++++++++++++++++++---------------------
 1 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e09204d..5301213 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1185,11 +1185,13 @@ sub die_error {
 	my $error = shift || "Malformed query, file missing or permission 
denied";
 
 	git_header_html($status);
-	print "<div class=\"page_body\">\n" .
-	      "<br/><br/>\n" .
-	      "$status - $error\n" .
-	      "<br/>\n" .
-	      "</div>\n";
+	print <<EOF;
+<div class="page_body">
+<br /><br />
+$status - $error
+<br />
+</div>
+EOF
 	git_footer_html();
 	exit;
 }
@@ -2026,9 +2028,11 @@ sub git_blame2 {
 	my $num_colors = scalar(@rev_color);
 	my $current_color = 0;
 	my $last_rev;
-	print "<div class=\"page_body\">\n";
-	print "<table class=\"blame\">\n";
-	print "<tr><th>Commit</th><th>Line</th><th>Data</th></tr>\n";
+	print <<HTML;
+<div class="page_body">
+<table class="blame">
+<tr><th>Commit</th><th>Line</th><th>Data</th></tr>
+HTML
 	while (<$fd>) {
 		/^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
 		my $full_rev = $1;
@@ -2570,9 +2574,10 @@ sub git_blobdiff {
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, 
$formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
-		print "<div class=\"page_nav\">\n" .
-		      "<br/><br/></div>\n" .
-		      "<div class=\"title\">$hash vs $hash_parent</div>\n";
+		print <<HTML;
+<div class="page_nav"><br/><br/></div>
+<div class="title">$hash vs $hash_parent</div>
+HTML
 	}
 	git_print_page_path($file_name, "blob", $hash_base);
 	print "<div class=\"page_body\">\n" .
@@ -2708,9 +2713,11 @@ sub git_commitdiff_plain {
 	                   -content_disposition => "inline; 
filename=\"git-$hash.patch\"");
 	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 	my $comment = $co{'comment'};
-	print "From: $co{'author'}\n" .
-	      "Date: $ad{'rfc2822'} ($ad{'tz_local'})\n".
-	      "Subject: $co{'title'}\n";
+	print <<TEXT;
+From: $co{'author'}
+Date: $ad{'rfc2822'} ($ad{'tz_local'})
+Subject: $co{'title'}
+TEXT
 	if (defined $tagname) {
 		print "X-Git-Tag: $tagname\n";
 	}
@@ -2995,13 +3002,15 @@ sub git_rss {
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-rev-list failed");
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
-	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
-	      "<rss version=\"2.0\" 
xmlns:content=\"http://purl.org/rss/1.0/modules/content/\">\n";
-	print "<channel>\n";
-	print "<title>$project</title>\n".
-	      "<link>" . esc_html("$my_url?p=$project;a=summary") . 
"</link>\n".
-	      "<description>$project log</description>\n".
-	      "<language>en</language>\n";
+	print <<XML;
+<?xml version="1.0" encoding="utf-8"?>
+<rss version="2.0" 
xmlns:content="http://purl.org/rss/1.0/modules/content/">
+<channel>
+<title>$project $my_uri $my_url</title>
+<link>${\esc_html("$my_url?p=$project;a=summary")}</link>
+<description>$project log</description>
+<language>en</language>
+XML
 
 	for (my $i = 0; $i <= $#revlist; $i++) {
 		my $commit = $revlist[$i];
@@ -3050,13 +3059,15 @@ sub git_opml {
 	my @list = git_get_projects_list();
 
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
-	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
-	      "<opml version=\"1.0\">\n".
-	      "<head>".
-	      "  <title>$site_name Git OPML Export</title>\n".
-	      "</head>\n".
-	      "<body>\n".
-	      "<outline text=\"git RSS feeds\">\n";
+	print <<XML;
+<?xml version="1.0" encoding="utf-8"?>
+<opml version="1.0">
+<head>
+  <title>$site_name Git OPML Export</title>
+</head>
+<body>
+<outline text="git RSS feeds">
+XML
 
 	foreach my $pr (@list) {
 		my %proj = %$pr;
@@ -3075,7 +3086,9 @@ sub git_opml {
 		my $html = "$my_url?p=$proj{'path'};a=summary";
 		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" 
xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
 	}
-	print "</outline>\n".
-	      "</body>\n".
-	      "</opml>\n";
+	print <<XML;
+</outline>
+</body>
+</opml>
+XML
 }
-- 
1.4.1.1
