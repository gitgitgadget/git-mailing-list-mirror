From: Florian Forster <octo@verplant.org>
Subject: [PATCH] gitweb: Adding a `blame' interface.
Date: Sun, 11 Jun 2006 17:45:19 +0200
Message-ID: <11500407193506-git-send-email-octo@verplant.org>
Reply-To: Florian Forster <octo@verplant.org>
Cc: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Sun Jun 11 17:45:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpS83-0002Ly-23
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 17:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWFKPpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 11:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWFKPpY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 11:45:24 -0400
Received: from verplant.org ([213.95.21.52]:42924 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1751054AbWFKPpX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 11:45:23 -0400
Received: from leeloo.lan.home.verplant.org ([2001:780:104:1:2e0:18ff:fead:37e4] ident=Debian-exim)
	by huhu.verplant.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FpS7s-00014A-Pu; Sun, 11 Jun 2006 17:45:21 +0200
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=octo)
	by leeloo.lan.home.verplant.org with esmtp (Exim 4.62)
	(envelope-from <octo@verplant.org>)
	id 1FpS7r-0002jq-AM; Sun, 11 Jun 2006 17:45:19 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21657>

This patch adds an interface for `git-blame' to `gitweb.cgi'. Links to it are
place in `git_blob'.
Internally the code uses `git-annotate' because `git-blame's output differs for
files that have been renamed in the past. However, I like the term `blame'
better.

Signed-off-by: Florian Forster <octo@verplant.org>


---

 gitweb/gitweb.cgi |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 107 insertions(+), 1 deletions(-)

b11522d270365b293197680e43e8feb87328a352
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index ea21fbe..91c075d 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -203,6 +203,9 @@ if (!defined $action || $action eq "summ
 } elsif ($action eq "tag") {
 	git_tag();
 	exit;
+} elsif ($action eq "blame") {
+	git_blame();
+	exit;
 } else {
 	undef $action;
 	die_error(undef, "Unknown action.");
@@ -1228,6 +1231,107 @@ sub git_tag {
 	git_footer_html();
 }
 
+sub git_blame {
+	my $fd;
+	die_error('404 Not Found', "What file will it be, master?") if (!$file_name);
+	$hash_base ||= git_read_head($project);
+	die_error(undef, "Reading commit failed.") unless ($hash_base);
+	my %co = git_read_commit($hash_base)
+		or die_error(undef, "Reading commit failed.");
+	if (!defined $hash) {
+		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
+			or die_error(undef, "Error lookup file.");
+	}
+	open ($fd, "-|", "$gitbin/git-annotate", '-l', '-t', '-r', $file_name, $hash_base)
+		or die_error(undef, "Open failed.");
+	git_header_html();
+	print "<div class=\"page_nav\">\n" .
+		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base")}, "commit") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") . "<br/>\n";
+	print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head") . "<br/>\n";
+	print "</div>\n".
+		"<div>" .
+		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
+		"</div>\n";
+	print "<div class=\"page_path\"><b>" . esc_html($file_name) . "</b></div>\n";
+	print "<div class=\"page_body\">\n";
+	print <<HTML;
+<table style="border-collapse: collapse;">
+  <tr>
+    <th>Commit</th>
+    <th>Age</th>
+    <th>Author</th>
+    <th>Line</th>
+    <th>Data</th>
+  </tr>
+HTML
+	my @line_class = (qw(light dark));
+	my $line_class_len = scalar (@line_class);
+	my $line_class_num = $#line_class;
+	while (my $line = <$fd>) {
+		my $long_rev;
+		my $short_rev;
+		my $author;
+		my $time;
+		my $lineno;
+		my $data;
+		my $age;
+		my $age_str;
+		my $age_style;
+
+		chomp $line;
+		$line_class_num = ($line_class_num + 1) % $line_class_len;
+
+		if ($line =~ m/^([0-9a-fA-F]{40})\t\(\s*([^\t]+)\t(\d+) \+\d\d\d\d\t(\d+)\)(.*)$/) {
+			$long_rev = $1;
+			$author   = $2;
+			$time     = $3;
+			$lineno   = $4;
+			$data     = $5;
+		} else {
+			print qq(  <tr><td colspan="5" style="color: red; background-color: yellow;">Unable to parse: $line</td></tr>\n);
+			next;
+		}
+		$short_rev  = substr ($long_rev, 0, 8);
+		$age        = time () - $time;
+		$age_str    = age_string ($age);
+		$age_str    =~ s/ /&nbsp;/g;
+		$age_style  = 'font-style: italic;';
+		$age_style .= ' color: #009900; background: transparent;' if ($age < 60*60*24*2);
+		$age_style .= ' font-weight: bold;' if ($age < 60*60*2);
+		$author     = esc_html ($author);
+		$author     =~ s/ /&nbsp;/g;
+		# escape tabs
+		while ((my $pos = index($data, "\t")) != -1) {
+			if (my $count = (8 - ($pos % 8))) {
+				my $spaces = ' ' x $count;
+				$data =~ s/\t/$spaces/;
+			}
+		}
+		$data = esc_html ($data);
+		$data =~ s/ /&nbsp;/g;
+
+		print <<HTML;
+  <tr class="$line_class[$line_class_num]">
+    <td style="font-family: monospace;"><a href="$my_uri?${\esc_param ("p=$project;a=commit;h=$long_rev")}" class="text">$short_rev..</a></td>
+    <td style="$age_style">$age_str</td>
+    <td>$author</td>
+    <td style="text-align: right;"><a id="$lineno" href="#$lineno" class="linenr">$lineno</a></td>
+    <td style="font-family: monospace;">$data</td>
+  </tr>
+HTML
+	} # while (my $line = <$fd>)
+	print "</table>\n\n";
+	close $fd or print "Reading blob failed.\n";
+	print "</div>";
+	git_footer_html();
+}
+
 sub git_tags {
 	my $head = git_read_head($project);
 	git_header_html();
@@ -1375,7 +1479,8 @@ sub git_blob {
 		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
 		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") . "<br/>\n";
 		if (defined $file_name) {
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash;f=$file_name")}, "plain") .
+			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$hash;hb=$hash_base;f=$file_name")}, "blame") .
+			" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash;f=$file_name")}, "plain") .
 			" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;hb=HEAD;f=$file_name")}, "head") . "<br/>\n";
 		} else {
 			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash")}, "plain") . "<br/>\n";
@@ -1496,6 +1601,7 @@ sub git_tree {
 			      "</td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$t_hash$base_key;f=$base$t_name")}, "blob") .
+#			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$t_hash$base_key;f=$base$t_name")}, "blame") .
 			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;h=$hash_base;f=$base$t_name")}, "history") .
 			      "</td>\n";
 		} elsif ($t_type eq "tree") {
-- 
1.3.3
