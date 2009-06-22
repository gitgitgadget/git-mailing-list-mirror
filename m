From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 1/2] gitweb: refactor author name insertion
Date: Tue, 23 Jun 2009 00:49:58 +0200
Message-ID: <1245710999-17763-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 00:49:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIsK4-0006Y5-5Z
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 00:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbZFVWtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 18:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbZFVWs7
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 18:48:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:38633 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbZFVWs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 18:48:57 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1174459fgg.17
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=izPV0Ju+JHKix+BlXIj5MT5jWVNHxs55u+IIhIYfG1o=;
        b=OOmWb05Wyj/5Hc+aRFm2Hoktj/qPt1Fq8OMaERl/WtHktpIBQL9MRAMhzpgyyclV63
         8OZtPlk1yQCfIwY3OgXF7wy6zNDm/MTZxnwsHoL684C3y9y3rdjHNXmgm9wNEPS9wxax
         Usfz7g3x030o7mZRCIQVM1clyC7KZRJWbo/VM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HrIQFGH30aoqlxsNvp9QKlBjKp3g1MkNojw8nnuIW+qmioU0a3BSu0bf7eemidpBrp
         dKmD43kvVpVk4Xj+ASJVUb6IwSVkVnAI+1yzUBrLU1TiVvLrruCn8U8Xra5yWzV/dpk8
         x3LRqTodFRfWm3dy2sZfLFtD8aDEUnid8llWA=
Received: by 10.86.93.19 with SMTP id q19mr7317289fgb.55.1245710940240;
        Mon, 22 Jun 2009 15:49:00 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-34-214.clienti.tiscali.it [94.37.34.214])
        by mx.google.com with ESMTPS id l12sm2019529fgb.24.2009.06.22.15.48.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 15:48:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122065>

The refactoring allows easier customization of the output by means of
CSS and improves extensibility on the CGI side too.

Layout is preserved for all views except for 'commitdiff', which now
uses the same format as 'commit'.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    5 ++-
 gitweb/gitweb.perl |   79 +++++++++++++++++++++++++++++++---------------------
 2 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index a01eac8..68b22ff 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -132,11 +132,14 @@ div.list_head {
 	font-style: italic;
 }
 
+.author_date, .author {
+	font-style: italic;
+}
+
 div.author_date {
 	padding: 8px;
 	border: solid #d9d8d1;
 	border-width: 0px 0px 1px 0px;
-	font-style: italic;
 }
 
 a.list {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1e7e2d8..223648f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1469,6 +1469,14 @@ sub format_subject_html {
 	}
 }
 
+# format the author name with the given tag and optionally shortening it
+sub format_author_html {
+	my $tag = shift;
+	my $co = shift;
+	my $author = chop_and_escape_str($co->{'author_name'}, @_);
+	return "<$tag class=\"author\">" . $author . "</$tag>\n";
+}
+
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
 sub format_git_diff_header_line {
 	my $line = shift;
@@ -3214,11 +3222,13 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+# Outputs the author name and date in long form
 sub git_print_authorship {
 	my $co = shift;
+	my $tag = shift || 'div';
 
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
-	print "<div class=\"author_date\">" .
+	print "<$tag class=\"author_date\">" .
 	      esc_html($co->{'author_name'}) .
 	      " [$ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
@@ -3228,7 +3238,30 @@ sub git_print_authorship {
 		printf(" (%02d:%02d %s)",
 		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	}
-	print "]</div>\n";
+	print "]</$tag>\n";
+}
+
+# Outputs the author and commiter name and date in long form
+sub git_print_who {
+	my $co = shift;
+	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
+	my %cd = parse_date($co->{'committer_epoch'}, $co->{'committer_tz'});
+	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td></tr>\n".
+	      "<tr>" .
+	      "<td></td><td> $ad{'rfc2822'}";
+	if ($ad{'hour_local'} < 6) {
+		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
+		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+	} else {
+		printf(" (%02d:%02d %s)",
+		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+	}
+	print "</td>" .
+	      "</tr>\n";
+	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td></tr>\n";
+	print "<tr><td></td><td> $cd{'rfc2822'}" .
+	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
+	      "</td></tr>\n";
 }
 
 sub git_print_page_path {
@@ -4142,11 +4175,9 @@ sub git_shortlog_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		my $author = chop_and_escape_str($co{'author_name'}, 10);
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
-		      "<td>";
+			format_author_html('td', \%co, 10) . "<td>";
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
@@ -4193,11 +4224,9 @@ sub git_history_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-	# shortlog uses      chop_str($co{'author_name'}, 10)
-		my $author = chop_and_escape_str($co{'author_name'}, 15, 3);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
-		      "<td>";
+	# shortlog uses      format_author_html('td', \%co, 10)
+			format_author_html('td', \%co, 15, 3) . "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
@@ -4350,9 +4379,8 @@ sub git_search_grep_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
+		      format_author_html('td', \%co, 15, 5) .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
 		               -class => "list subject"},
@@ -5094,9 +5122,9 @@ sub git_log {
 		      " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
 		      "<br/>\n" .
-		      "</div>\n" .
-		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
 		      "</div>\n";
+		      git_print_authorship(\%co);
+		      print "<br/>\n</div>\n";
 
 		print "<div class=\"log_body\">\n";
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
@@ -5115,8 +5143,6 @@ sub git_commit {
 	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash)
 	    or die_error(404, "Unknown commit object");
-	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
-	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 	my $parent  = $co{'parent'};
 	my $parents = $co{'parents'}; # listref
@@ -5183,22 +5209,7 @@ sub git_commit {
 	}
 	print "<div class=\"title_text\">\n" .
 	      "<table class=\"object_header\">\n";
-	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td></tr>\n".
-	      "<tr>" .
-	      "<td></td><td> $ad{'rfc2822'}";
-	if ($ad{'hour_local'} < 6) {
-		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
-		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
-	} else {
-		printf(" (%02d:%02d %s)",
-		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
-	}
-	print "</td>" .
-	      "</tr>\n";
-	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
-	print "<tr><td></td><td> $cd{'rfc2822'}" .
-	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
-	      "</td></tr>\n";
+	git_print_who(\%co);
 	print "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
 	print "<tr>" .
 	      "<td>tree</td>" .
@@ -5579,7 +5590,11 @@ sub git_commitdiff {
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
-		git_print_authorship(\%co);
+		print "<div class=\"title_text\">\n" .
+		      "<table class=\"object_header\">\n";
+		git_print_who(\%co);
+		print "</table>".
+		      "</div>\n";
 		print "<div class=\"page_body\">\n";
 		if (@{$co{'comment'}} > 1) {
 			print "<div class=\"log\">\n";
-- 
1.6.3.rc1.192.gdbfcb
