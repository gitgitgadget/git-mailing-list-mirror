From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Extra columns in blame
Date: Fri, 18 May 2007 21:17:25 +0200
Message-ID: <20070518191725.10460.83338.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp7xv-0000qN-4Q
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678AbXERTR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755579AbXERTR2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:17:28 -0400
Received: from rover.dkm.cz ([62.24.64.27]:52573 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755219AbXERTR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:17:27 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 833988B711;
	Fri, 18 May 2007 21:17:25 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47634>

This patch adds extra columns to blame output, containing
line author and creation date. These columns are by default hidden by
display: none but by clicking on the expansion "button" you can display
them (and hide again). I think seeing this information without tooltips
fishing can give much better overview of the content evolution.

This patch depends on the interactive blame patch (but can be factored out;
the common required parts are just the blame.js infrastructure).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/blame.js    |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |   23 +++++++++++++++++++----
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/gitweb/blame.js b/gitweb/blame.js
index 88b6499..438bc9c 100644
--- a/gitweb/blame.js
+++ b/gitweb/blame.js
@@ -1,4 +1,41 @@
 // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+// Copyright (C) 2007, Petr Baudis <pasky@suse.cz>
+
+
+// blame extra columns
+
+// I would like to note here that JavaScript is utterly stupid.
+function findStyleRule(styleName) {
+	for (i = 0; i < document.styleSheets.length; i++) { 
+		for (j = 0; j < document.styleSheets[i].cssRules.length; j++) {
+			var rule = document.styleSheets[i].cssRules[j];
+			if (rule.selectorText == styleName) {
+				return rule;
+			}
+		}     
+	}
+}
+var extra_column_rule;
+
+var extra_columns = 0;
+function extra_blame_columns() {
+	if (!extra_column_rule)
+		extra_column_rule = findStyleRule("th.extra_column, td.extra_column");
+
+	if (!extra_columns) {
+		document.getElementById("columns_expander").innerHTML = "[-]";
+		extra_column_rule.style.cssText = extra_column_rule.style.cssText.replace("none", "table-cell");
+		extra_columns = 1;
+	} else {
+		document.getElementById("columns_expander").innerHTML = "[+]";
+		extra_column_rule.style.cssText = extra_column_rule.style.cssText.replace("table-cell", "none");
+		extra_columns = 0;
+	}
+}
+
+
+// blame_interactive
+
 
 var DEBUG = 0;
 function debug(str)
@@ -72,14 +109,20 @@ function handleLine(commit)
             zeroPad(date.getUTCSeconds());
         tr.firstChild.title = commit.author + ', ' + dateStr + ' ' + timeStr;
         var shaAnchor = tr.firstChild.firstChild;
+	var authorField = tr.firstChild.nextSibling;
+	var dateField = tr.firstChild.nextSibling.nextSibling;
         if (i == 0) {
             shaAnchor.href = baseUrl + ';a=commit;h=' + commit.sha1;
             shaAnchor.innerHTML = commit.sha1.substr(0, 8);
+	    authorField.innerHTML = commit.author;
+	    dateField.innerHTML = dateStr + ' ' + timeStr;
         } else {
             shaAnchor.innerHTML = '';
+            authorField.innerHTML = '';
+            dateField.innerHTML = '';
         }
 
-        var lineAnchor = tr.firstChild.nextSibling.firstChild;
+        var lineAnchor = tr.firstChild.nextSibling.nextSibling.nextSibling.firstChild;
         lineAnchor.href = baseUrl + ';a=blame;hb=' + commit.sha1 +
             ';f=' + commit.filename + '#l' + commit.srcline;
         resline++;
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 9f0822f..b76e839 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -488,3 +488,8 @@ span.match {
 div.binary {
 	font-style: italic;
 }
+
+/* This selector is hardcoded in gitweb.perl */
+th.extra_column, td.extra_column {
+	display: none;
+}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cc671b1..2dc7be8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3671,9 +3671,14 @@ sub git_blame_incremental {
 	my $last_rev;
 	print "<script type=\"text/javascript\" src=\"$blamejs\"></script>\n";
 	print <<HTML;
+
 <div class="page_body">
 <table class="blame">
-<tr><th>Commit</th><th>Line</th><th>Data</th></tr>
+<tr><th>Commit&nbsp;<a href="javascript:extra_blame_columns()" id="columns_expander">[+]</a></th>
+<th class="extra_column">Author</th>
+<th class="extra_column">Date</th>
+<th>Line</th>
+<th>Data</th></tr>
 HTML
 	my %metainfo = ();
 	my $linenr = 0;
@@ -3682,6 +3687,8 @@ HTML
 		$linenr += 1;
 		print "<tr id=\"l$linenr\" class=\"light2\">";
 		print '<td class="sha1"><a href=""></a></td>';
+		print "<td class=\"extra_column\"></td>";
+		print "<td class=\"extra_column\"></td>";
 		print "<td class=\"linenr\"><a class=\"linenr\" href=\"\">$linenr</a></td><td class=\"pre\">" . esc_html($_) . "</td>\n";
 		print "</tr>\n"
 	}
@@ -3738,10 +3745,16 @@ sub git_blame2 {
 	my $num_colors = scalar(@rev_color);
 	my $current_color = 0;
 	my $last_rev;
+	print "<script type=\"text/javascript\" src=\"$blamejs\"></script>\n";
 	print <<HTML;
+
 <div class="page_body">
 <table class="blame">
-<tr><th>Commit</th><th>Line</th><th>Data</th></tr>
+<tr><th>Commit&nbsp;<a href="javascript:extra_blame_columns()" id="columns_expander">[+]</a></th>
+<th class="extra_column">Author</th>
+<th class="extra_column">Date</th>
+<th>Line</th>
+<th>Data</th></tr>
 HTML
 	my %metainfo = ();
 	while (1) {
@@ -3771,15 +3784,17 @@ HTML
 		}
 		print "<tr class=\"$rev_color[$current_color]\">\n";
 		if ($group_size) {
+			my $rowspan = $group_size > 1 ? " rowspan=\"$group_size\"" : "";
 			print "<td class=\"sha1\"";
 			print " title=\"". esc_html($author) . ", $date\"";
-			print " rowspan=\"$group_size\"" if ($group_size > 1);
-			print ">";
+			print "$rowspan>";
 			print $cgi->a({-href => href(action=>"commit",
 			                             hash=>$full_rev,
 			                             file_name=>$file_name)},
 			              esc_html($rev));
 			print "</td>\n";
+			print "<td class=\"extra_column\" $rowspan>". esc_html($author) . "</td>";
+			print "<td class=\"extra_column\" $rowspan>". $date . "</td>";
 		}
 		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
 			or die_error(undef, "Open git-rev-parse failed");
